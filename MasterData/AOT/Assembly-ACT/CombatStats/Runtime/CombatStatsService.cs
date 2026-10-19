using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ACT.Battle;
using ACT.Core;

namespace CombatStats.Runtime;

public sealed class CombatStatsService
{
	private readonly CombatSessionAggregate session;

	private readonly DamageRecordAdapter adapter;

	private readonly ISkillDisplayConfigProvider skillDisplayProvider;

	private readonly Func<float> nowProvider;

	public CombatSegmentService SegmentService { get; }

	public event Action<CombatSegmentDescriptor> OnCombatSegmentStarted;

	public event Action<CombatSegmentDescriptor, SegmentEndReason> OnCombatSegmentEnded;

	public event Action OnCombatStatsChanged;

	public CombatStatsService(DamageRecordAdapter adapter, ISkillDisplayConfigProvider skillDisplayProvider, Func<float> nowProvider)
	{
		this.adapter = adapter ?? throw new ArgumentNullException("adapter");
		this.skillDisplayProvider = skillDisplayProvider;
		this.nowProvider = nowProvider ?? throw new ArgumentNullException("nowProvider");
		session = new CombatSessionAggregate(nowProvider);
		SegmentService = new CombatSegmentService(session, nowProvider);
		SegmentService.OnCombatSegmentStarted += (CombatSegmentDescriptor descriptor) =>
		{
			OnCombatSegmentStarted?.Invoke(descriptor);
		};
		SegmentService.OnCombatSegmentEnded += (CombatSegmentDescriptor descriptor, SegmentEndReason reason) =>
		{
			OnCombatSegmentEnded?.Invoke(descriptor, reason);
		};
	}

	public void Reset()
	{
		session.Reset();
		OnCombatStatsChanged?.Invoke();
	}

	public CombatFloatingSnapshot BuildFloatingSnapshot(bool isCollapsed)
	{
		CombatFloatingSnapshot combatFloatingSnapshot = new CombatFloatingSnapshot
		{
			IsCollapsed = isCollapsed,
			HasActiveSegment = (session.ActiveSegment != null)
		};
		CombatSegmentAggregate activeSegment = session.ActiveSegment;
		if (activeSegment == null)
		{
			CombatSegmentAggregate combatSegmentAggregate = session.Segments.LastOrDefault();
			if (combatSegmentAggregate != null)
			{
				PopulateSegmentSnapshot(combatFloatingSnapshot, combatSegmentAggregate);
			}
			return combatFloatingSnapshot;
		}
		PopulateSegmentSnapshot(combatFloatingSnapshot, activeSegment);
		return combatFloatingSnapshot;
	}

	private void PopulateSegmentSnapshot(CombatFloatingSnapshot snapshot, CombatSegmentAggregate segment)
	{
		snapshot.SegmentId = segment.Descriptor.SegmentId;
		snapshot.Duration = segment.GetDuration();
		snapshot.TotalDamage = segment.TotalDamage;
		long num = Math.Max(1L, segment.TotalDamage);
		foreach (CharacterStatsAggregate item in segment.Characters.Values.OrderByDescending((CharacterStatsAggregate item) => item.TotalDamage).Take(3))
		{
			float characterFieldTime = segment.GetCharacterFieldTime(item.CharacterId);
			snapshot.TopCharacters.Add(new CharacterDamageRowSnapshot
			{
				CharacterId = item.CharacterId,
				CharacterNameId = GetCharacterNameLocalID(item.CharacterId),
				TotalDamage = item.TotalDamage,
				Dps = (float)item.TotalDamage / characterFieldTime,
				HitCount = item.HitCount,
				CritCount = item.CritCount,
				CritRate = ((item.HitCount <= 0) ? 0f : ((float)item.CritCount / (float)item.HitCount)),
				DamageShare = (float)item.TotalDamage / (float)num,
				DamageType = GetCharacterDamageType(item.CharacterId)
			});
		}
		long val = ((snapshot.TopCharacters.Count > 0) ? snapshot.TopCharacters[0].TotalDamage : 1);
		foreach (CharacterDamageRowSnapshot topCharacter in snapshot.TopCharacters)
		{
			topCharacter.DamageShareOfTop = (float)topCharacter.TotalDamage / (float)Math.Max(1L, val);
		}
	}

	public CombatOverviewSnapshot BuildOverviewSnapshot(int selectedSegmentId, CombatOverviewViewType viewType)
	{
		CombatOverviewSnapshot combatOverviewSnapshot = new CombatOverviewSnapshot
		{
			ViewType = viewType
		};
		int num = 0;
		Dictionary<int, CombatSegmentAggregate> dictionary = new Dictionary<int, CombatSegmentAggregate>();
		for (int i = 0; i < session.Segments.Count; i++)
		{
			CombatSegmentAggregate combatSegmentAggregate = session.Segments[i];
			float duration = combatSegmentAggregate.Descriptor.EndTime - combatSegmentAggregate.Descriptor.StartTime;
			dictionary[num] = combatSegmentAggregate;
			combatOverviewSnapshot.Segments.Add(new SegmentListItemSnapshot
			{
				SegmentId = num,
				SegmentType = GetSegmentTypeLabel(combatSegmentAggregate.Descriptor.StartReason),
				Duration = duration,
				TotalDamage = combatSegmentAggregate.TotalDamage,
				IsSelected = false
			});
			num++;
		}
		if (dictionary.Count == 0)
		{
			return combatOverviewSnapshot;
		}
		if (!dictionary.TryGetValue(selectedSegmentId, out var value))
		{
			selectedSegmentId = 0;
			value = dictionary[0];
		}
		foreach (SegmentListItemSnapshot segment in combatOverviewSnapshot.Segments)
		{
			if (segment.SegmentId == selectedSegmentId)
			{
				segment.IsSelected = true;
				break;
			}
		}
		combatOverviewSnapshot.SelectedSegmentId = selectedSegmentId;
		PopulateSingleSegment(combatOverviewSnapshot, value, viewType);
		return combatOverviewSnapshot;
	}

	private static string GetSegmentTypeLabel(SegmentStartReason reason)
	{
		return reason switch
		{
			SegmentStartReason.DungeonStart => "副本", 
			SegmentStartReason.TrainingCountdownFinish => "训练", 
			SegmentStartReason.BossFightStart => "Boss", 
			SegmentStartReason.Manual => "手动", 
			_ => "战斗", 
		};
	}

	public void TryConsumeAttackData(AttackData attackData)
	{
		if (session.ActiveSegment != null && adapter.TryCreateRecord(attackData, out var record))
		{
			session.ActiveSegment.Add(record);
			OnCombatStatsChanged?.Invoke();
		}
	}

	public void NotifyCharacterSwitch(int newCharacterId)
	{
		session.ActiveSegment?.NotifyCharacterSwitch(newCharacterId);
	}

	private void PopulateSingleSegment(CombatOverviewSnapshot snapshot, CombatSegmentAggregate segment, CombatOverviewViewType viewType)
	{
		switch (viewType)
		{
		case CombatOverviewViewType.Damage:
			snapshot.DamageRows.AddRange(BuildCharacterRows(segment));
			break;
		case CombatOverviewViewType.Skills:
			snapshot.SkillRows.AddRange(BuildSkillRows(segment));
			break;
		}
	}

	private List<CharacterDamageRowSnapshot> BuildCharacterRows(CombatSegmentAggregate segment)
	{
		long totalDamage = Math.Max(1L, segment.TotalDamage);
		float duration = Math.Max(1f, segment.GetDuration());
		List<CharacterDamageRowSnapshot> list = (from item in segment.Characters.Values
			orderby item.TotalDamage descending
			select new CharacterDamageRowSnapshot
			{
				CharacterId = item.CharacterId,
				CharacterNameId = GetCharacterNameLocalID(item.CharacterId),
				TotalDamage = item.TotalDamage,
				Dps = (float)item.TotalDamage / duration,
				HitCount = item.HitCount,
				CritCount = item.CritCount,
				CritRate = ((item.HitCount <= 0) ? 0f : ((float)item.CritCount / (float)item.HitCount)),
				DamageShare = (float)item.TotalDamage / (float)totalDamage,
				DamageType = GetCharacterDamageType(item.CharacterId)
			}).ToList();
		long val = ((list.Count > 0) ? list[0].TotalDamage : 1);
		foreach (CharacterDamageRowSnapshot item in list)
		{
			item.DamageShareOfTop = (float)item.TotalDamage / (float)Math.Max(1L, val);
		}
		return list;
	}

	private List<SkillDamageRowSnapshot> BuildSkillRows(CombatSegmentAggregate segment)
	{
		long segmentDamage = Math.Max(1L, segment.TotalDamage);
		List<SkillDamageRowSnapshot> list = new List<SkillDamageRowSnapshot>();
		foreach (CharacterStatsAggregate value in segment.Characters.Values)
		{
			int characterDamageType = GetCharacterDamageType(value.CharacterId);
			foreach (SkillStatsAggregate value2 in value.Skills.Values)
			{
				list.Add(CreateSkillRow(value.CharacterId, value2, segmentDamage, characterDamageType));
			}
		}
		List<SkillDamageRowSnapshot> list2 = (from item in list
			orderby item.TotalDamage descending, item.SkillDisplayName
			select item).ToList();
		long val = ((list2.Count > 0) ? list2[0].TotalDamage : 1);
		foreach (SkillDamageRowSnapshot item in list2)
		{
			item.DamageShareOfTop = (float)item.TotalDamage / (float)Math.Max(1L, val);
		}
		return list2;
	}

	private SkillDamageRowSnapshot CreateSkillRow(int characterId, SkillStatsAggregate aggregate, long segmentDamage, int damageType)
	{
		SkillDisplayInfo info = null;
		string skillDisplayName = ((skillDisplayProvider != null && skillDisplayProvider.TryGetSkillDisplay(characterId, aggregate.SkillId, out info)) ? info.DisplayName : aggregate.SkillId.ToString());
		return new SkillDamageRowSnapshot
		{
			CharacterId = characterId,
			SkillId = aggregate.SkillId,
			SkillDisplayName = skillDisplayName,
			TotalDamage = aggregate.TotalDamage,
			HitCount = aggregate.HitCount,
			CritCount = aggregate.CritCount,
			CritRate = ((aggregate.HitCount <= 0) ? 0f : ((float)aggregate.CritCount / (float)aggregate.HitCount)),
			DamageShare = (float)aggregate.TotalDamage / (float)Math.Max(1L, segmentDamage),
			DamageType = damageType
		};
	}

	private static object TryGetAttackData(object damageEvt)
	{
		PropertyInfo property = damageEvt.GetType().GetProperty("AttackData");
		if (property != null)
		{
			return property.GetValue(damageEvt);
		}
		return damageEvt.GetType().GetField("AttackData")?.GetValue(damageEvt);
	}

	private int GetCharacterNameLocalID(int id)
	{
		return RuntimeConfigs.data.entityDatas[id].nameLocal;
	}

	private int GetCharacterDamageType(int id)
	{
		if (RuntimeConfigs.data.entityCharacterDatas.TryGetValue(id, out var value))
		{
			return value.mannerType;
		}
		return 0;
	}
}

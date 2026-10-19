using System.Collections.Generic;
using System.IO;
using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace CombatStats.Runtime;

public sealed class CombatStatsBootstrap : MonoBehaviour, ISkillDisplayConfigProvider
{
	[SerializeField]
	private TextAsset skillNameCsv;

	private Dictionary<int, string> skillNameCache;

	public CombatStatsService Service { get; private set; }

	private void Awake()
	{
		Service = new CombatStatsService(new DamageRecordAdapter(new ReflectionAttackDataAccessor()), this, () => Time.unscaledTime);
	}

	public bool TryGetSkillDisplay(int characterId, int skillId, out SkillDisplayInfo info)
	{
		EnsureSkillNameCache();
		if (skillNameCache.TryGetValue(skillId, out var value))
		{
			info = new SkillDisplayInfo
			{
				SkillId = skillId,
				DisplayName = value
			};
			return true;
		}
		info = null;
		return false;
	}

	private void EnsureSkillNameCache()
	{
		if (skillNameCache != null)
		{
			return;
		}
		skillNameCache = new Dictionary<int, string>();
		if (skillNameCsv == null)
		{
			return;
		}
		using StringReader stringReader = new StringReader(skillNameCsv.text);
		stringReader.ReadLine();
		string text;
		while ((text = stringReader.ReadLine()) != null)
		{
			if (!string.IsNullOrWhiteSpace(text))
			{
				string[] array = text.Split(',');
				if (array.Length >= 2 && int.TryParse(array[0], out var result))
				{
					string text2 = array[1].Trim();
					skillNameCache[result] = (string.IsNullOrEmpty(text2) ? result.ToString() : text2);
				}
			}
		}
	}

	public void StartNewSegment()
	{
		Service?.SegmentService.NotifyManualSegmentStart();
		int mainEntityCharacterId = MonoECS.instance.MainEntityCharacterId;
		if (mainEntityCharacterId != int.MinValue)
		{
			Service?.NotifyCharacterSwitch(mainEntityCharacterId);
		}
	}

	public void OnEnable()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, TryConsumeDamageEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnCharacterChange);
	}

	public void OnDisable()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnDamage, TryConsumeDamageEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnCharacterChange);
	}

	public void NotifyDungeonStarted()
	{
		Service?.SegmentService.NotifyDungeonStarted();
	}

	public void NotifyTrainingCountdownFinished()
	{
		Service?.SegmentService.NotifyTrainingCountdownFinished();
	}

	public void NotifyBossFightStarted()
	{
		Service?.SegmentService.NotifyBossFightStarted();
	}

	public void NotifySegmentEnded(SegmentEndReason reason)
	{
		Service?.SegmentService.NotifySegmentEnded(reason);
	}

	public void TryConsumeDamageEvent(BaseEventContent obj)
	{
		if (obj is DamageEvt { AttackData: not null } damageEvt && damageEvt.AttackData.attacker.IsCharacter())
		{
			Service?.TryConsumeAttackData(damageEvt.AttackData);
		}
	}

	private void OnCharacterChange(BaseEventContent obj)
	{
		if (obj is BattleCharacterChangeEvt battleCharacterChangeEvt && battleCharacterChangeEvt.newEb.IsValid)
		{
			int newCharacterId = battleCharacterChangeEvt.newEb.GetCompCharacter().characterSource.Id();
			Service?.NotifyCharacterSwitch(newCharacterId);
		}
	}
}

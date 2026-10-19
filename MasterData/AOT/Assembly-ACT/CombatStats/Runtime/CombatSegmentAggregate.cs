using System;
using System.Collections.Generic;

namespace CombatStats.Runtime;

public sealed class CombatSegmentAggregate
{
	private readonly Func<float> nowProvider;

	private int currentFieldCharacterId;

	private float fieldStartTime;

	public CombatSegmentDescriptor Descriptor { get; }

	public Dictionary<int, CharacterStatsAggregate> Characters { get; } = new Dictionary<int, CharacterStatsAggregate>();

	public List<DamageRecord> Records { get; } = new List<DamageRecord>();

	public long TotalDamage { get; private set; }

	public float PeakDps { get; private set; }

	public CombatSegmentAggregate(CombatSegmentDescriptor descriptor, Func<float> nowProvider)
	{
		Descriptor = descriptor ?? throw new ArgumentNullException("descriptor");
		this.nowProvider = nowProvider ?? throw new ArgumentNullException("nowProvider");
	}

	public void Add(DamageRecord record)
	{
		Records.Add(record);
		TotalDamage += record.DamageValue;
		if (!Characters.TryGetValue(record.CharacterId, out var value))
		{
			value = new CharacterStatsAggregate(record.CharacterId);
			Characters.Add(record.CharacterId, value);
		}
		value.Add(record);
		PeakDps = Math.Max(PeakDps, CalculateInstantDps(record.Timestamp));
	}

	public void NotifyCharacterSwitch(int newCharacterId)
	{
		float num = nowProvider();
		if (currentFieldCharacterId != 0)
		{
			float num2 = num - fieldStartTime;
			if (num2 > 0f && Characters.TryGetValue(currentFieldCharacterId, out var value))
			{
				value.AddFieldTime(num2);
			}
		}
		currentFieldCharacterId = newCharacterId;
		fieldStartTime = num;
		if (!Characters.ContainsKey(newCharacterId))
		{
			Characters.Add(newCharacterId, new CharacterStatsAggregate(newCharacterId));
		}
	}

	public void FinalizeFieldTime(float endTime)
	{
		if (currentFieldCharacterId != 0)
		{
			float num = endTime - fieldStartTime;
			if (num > 0f && Characters.TryGetValue(currentFieldCharacterId, out var value))
			{
				value.AddFieldTime(num);
			}
			currentFieldCharacterId = 0;
		}
	}

	public float GetCharacterFieldTime(int characterId)
	{
		if (!Characters.TryGetValue(characterId, out var value))
		{
			return 0f;
		}
		float num = value.FieldTime;
		if (characterId == currentFieldCharacterId && Descriptor.IsActive)
		{
			num += nowProvider() - fieldStartTime;
		}
		return Math.Max(0.1f, num);
	}

	public float GetDuration()
	{
		float num = (Descriptor.IsActive ? nowProvider() : Descriptor.EndTime);
		return Math.Max(0f, num - Descriptor.StartTime);
	}

	private float CalculateInstantDps(float currentTime)
	{
		long num = 0L;
		for (int num2 = Records.Count - 1; num2 >= 0; num2--)
		{
			DamageRecord damageRecord = Records[num2];
			if (currentTime - damageRecord.Timestamp > 1f)
			{
				break;
			}
			num += damageRecord.DamageValue;
		}
		return (float)num / 1f;
	}
}

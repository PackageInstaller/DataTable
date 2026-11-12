using System.Collections.Generic;
using TrueSync;

[AdventureEffect(HotfixEnum.effectType.CD)]
public class SkillCDMaxAmend : AdventureEffectBase
{
	private FP value;

	private List<ActionKey> slots = new List<ActionKey>();

	public override void Execute()
	{
		base.Execute();
		if (effectValueConfig.EffectTypeSecondSubtype == 1 || !TryParseStringParamToFP(effectValueConfig.EffectTypeParam1, out value) || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue, allowEmpty: true))
		{
			return;
		}
		slots.Clear();
		switch (effectValueConfig.EffectTypeFirstSubtype)
		{
		case 1:
			slots.Add((ActionKey)intValue);
			break;
		case 5:
			slots.Add(ActionKey.A);
			slots.Add(ActionKey.B);
			slots.Add(ActionKey.D);
			break;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).actorInfo == null)
			{
				continue;
			}
			foreach (ActionKey slot in slots)
			{
				switch (slot)
				{
				case ActionKey.A:
					if (effectValueConfig.EffectTypeSecondSubtype == 3)
					{
						_targets.get_Item(i).actorInfo.dodgeCDMaxAmend += value;
					}
					else if (effectValueConfig.EffectTypeSecondSubtype == 2)
					{
						_targets.get_Item(i).actorInfo.dodgeCDMaxPercentAmend += value;
					}
					break;
				case ActionKey.B:
					if (effectValueConfig.EffectTypeSecondSubtype == 3)
					{
						_targets.get_Item(i).actorInfo.skillCDMaxAmend += value;
					}
					else if (effectValueConfig.EffectTypeSecondSubtype == 2)
					{
						_targets.get_Item(i).actorInfo.skillCDMaxPercentAmend += value;
					}
					break;
				case ActionKey.D:
					if (effectValueConfig.EffectTypeSecondSubtype == 3)
					{
						_targets.get_Item(i).actorInfo.ultraCDMaxAmend += value;
					}
					else if (effectValueConfig.EffectTypeSecondSubtype == 2)
					{
						_targets.get_Item(i).actorInfo.ultraCDMaxPercentAmend += value;
					}
					break;
				}
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).actorInfo == null)
			{
				continue;
			}
			foreach (ActionKey slot in slots)
			{
				switch (slot)
				{
				case ActionKey.A:
					if (effectValueConfig.EffectTypeSecondSubtype == 3)
					{
						_targets.get_Item(i).actorInfo.dodgeCDMaxAmend -= value;
					}
					else if (effectValueConfig.EffectTypeSecondSubtype == 2)
					{
						_targets.get_Item(i).actorInfo.dodgeCDMaxPercentAmend -= value;
					}
					break;
				case ActionKey.B:
					if (effectValueConfig.EffectTypeSecondSubtype == 3)
					{
						_targets.get_Item(i).actorInfo.skillCDMaxAmend -= value;
					}
					else if (effectValueConfig.EffectTypeSecondSubtype == 2)
					{
						_targets.get_Item(i).actorInfo.skillCDMaxPercentAmend -= value;
					}
					break;
				case ActionKey.D:
					if (effectValueConfig.EffectTypeSecondSubtype == 3)
					{
						_targets.get_Item(i).actorInfo.ultraCDMaxAmend -= value;
					}
					else if (effectValueConfig.EffectTypeSecondSubtype == 2)
					{
						_targets.get_Item(i).actorInfo.ultraCDMaxPercentAmend -= value;
					}
					break;
				}
			}
		}
		value = 0;
		slots.Clear();
	}
}

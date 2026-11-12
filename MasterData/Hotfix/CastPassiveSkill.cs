using System.Collections.Generic;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.PASSIVE_SKILL)]
public class CastPassiveSkill : AdventureEffectBase
{
	private readonly Dictionary<AdventureActor, List<AdventureSkill>> _skillDict = new Dictionary<AdventureActor, List<AdventureSkill>>();

	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue))
		{
			return;
		}
		if (Singleton<HotfixDataController>.Instance.GetSkill(intValue) == null)
		{
			Debug.LogError($"cast passive skill, can not find skill config, skillId:{intValue}");
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			AdventureActor adventureActor = _targets.get_Item(i);
			AdventureSkill adventureSkill = ModuleController<AdventureModuleController>.Instance.SpawnSkill(intValue);
			if (!(null == adventureSkill))
			{
				adventureSkill.name = adventureActor.name + "_passive_skill" + intValue;
				adventureSkill.InitSkill(intValue, adventureActor.gameObject, null, SkillLauncherType.Effect, isInterruptAttack: false, isBreakable: false, SkillPhaseFeatureFlag.None, SkillCountdownTiming.None);
				if (_skillDict.TryGetValue(adventureActor, out var value))
				{
					value.Add(adventureSkill);
					continue;
				}
				_skillDict.set_Item(adventureActor, new List<AdventureSkill> { adventureSkill });
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (_skillDict.Count <= 0)
		{
			return;
		}
		foreach (AdventureActor key in _skillDict.Keys)
		{
			foreach (AdventureSkill item in _skillDict.get_Item(key))
			{
				key.actorSkillManage.DestroyPassiveSkill(item);
			}
		}
		_skillDict.Clear();
	}
}

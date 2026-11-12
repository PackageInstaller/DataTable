using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_BuffJingLing_Fire : SkillSimpleBase
{
	private string areaEffectKey = "50111BuffJingLing_Area_Fire_TD";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SupportAttack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("AddBuff");
		ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, GetPosition(), default, (AreaEffectEntity entity) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = _actor;
			}
		});
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}

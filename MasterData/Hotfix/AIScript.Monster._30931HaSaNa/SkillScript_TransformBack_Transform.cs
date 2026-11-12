using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_TransformBack_Transform : SkillScript_TransformBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetLockToughnessEnable();
		RemoveBuffFromTarget(_actor, 990020140);
		ResetBlockPriority();
		SwitchCameraSetting(active: false, "ShaJuRenCamera");
		PlayEffect("fx_m30391_base_change_2");
		BeginAttack(1, "TransformBack", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		RemoveBuffFromTarget(_actor, 309310050);
		ChangeModelScale(setAbsValue: true, 1, 0);
		BeginLookAtByDir(TSVector2.down, 0.1, 9999);
		_actor.ActiveDefaultModelGroup();
		_actor.actorScaleInfo.colliderScale = _actor.actorScaleInfo.originColliderScale;
		_actor.ResumeAnimationGroup();
		OcclusionRendererOccluder[] componentsInChildren = _actor.GetComponentsInChildren<OcclusionRendererOccluder>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.SetActive(value: false);
		}
		SetLogicTagToggleValue(_actor, "IsShaJuRen", value: false);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptLockToughness();
	}
}

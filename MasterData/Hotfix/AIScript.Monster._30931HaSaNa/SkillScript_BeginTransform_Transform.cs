using System.Collections;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_BeginTransform_Transform : SkillScript_TransformBase
{
	private readonly string comboTag_Stage1 = "Burrow_Down";

	private readonly string eventName_Hide = "Hide";

	private readonly FP delayTime = 0.5;

	private readonly string comboTag_Stage2 = "Burrow_Up";

	private readonly string comboTag_Transfrom = "TransformToShaJuRen";

	private readonly string modelName = "shajuren";

	private readonly FP colliderScale = 3f;

	protected override IEnumerator DoMainLogic()
	{
		SetLockToughnessEnable();
		AddBuffToTarget(_actor, 990020140);
		SetBlockPriorityToStatic(autoDisableWhenSkillDisable: false);
		if (!GetLogicTagToggleValue(_actor, "IsMainline"))
		{
			yield return BeginLookAtByDir(TSVector2.down, 0.1, 9999);
			BeginAttack(1, comboTag_Stage1, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(0.5);
			Teleport(TSVector2.zero);
			SkillScript_BeginTransform_Transform skillScript_BeginTransform_Transform = this;
			TSVector2 position = GetPosition();
			skillScript_BeginTransform_Transform.PlayEffect("fx_m30391_base_Other_2", 1f, default, position);
			yield return WaitTime(delayTime);
			BeginLookAtByDir_NotWait(TSVector2.down, 0.1, 9999);
			BeginAttack(2, comboTag_Stage2, flushInputedKeys: true);
			SetUnparalleledDisable();
			SetHideModelDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			TriggerOpLisener("BB3");
		}
		BeginAttack(3, comboTag_Transfrom, flushInputedKeys: true);
		SwitchCameraSetting(active: true, "ShaJuRenCamera");
		yield return WaitTime(2);
		TransformToShaJuRen();
		CancelAttack();
		ChangeModelScale(setAbsValue: true, 1.4, 0.1);
		AddBuffToTarget(_actor, 309310050);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		InterruptLockToughness();
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (string.Equals(eventName, eventName_Hide))
		{
			SetUnparalleledEnable();
			SetHideModelEnable();
		}
	}

	private void TransformToShaJuRen()
	{
		_actor.ActiveVariantModelGroup(modelName);
		_actor.actorScaleInfo.colliderScale = colliderScale;
		ReplaceAnimationGroup();
		OcclusionRendererOccluder[] componentsInChildren = _actor.GetComponentsInChildren<OcclusionRendererOccluder>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].gameObject.SetActive(value: true);
		}
		SetLogicTagToggleValue(_actor, "IsShaJuRen", value: true);
	}
}

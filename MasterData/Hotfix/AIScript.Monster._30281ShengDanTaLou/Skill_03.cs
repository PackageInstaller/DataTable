using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_03 : SkillSimpleBase
{
	private string Attack = "Skill03";

	private long LeftHandFX;

	private long RightHandFX;

	private long LinkL;

	private long LinkR;

	private long LockArea;

	private long BoomArea;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopEffect(LeftHandFX);
		StopEffect(RightHandFX);
		StopEffect(LinkL);
		StopEffect(LinkR);
		StopAreaEffect(LockArea);
		StopAreaEffect(BoomArea);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		DispatchCustomEvent("ShengDanTaLouSkill03", isSelfEvent: false);
		yield return WaitCustomEvent("Start");
		StartCor(StartLink());
		yield return WaitTime(3);
		CancelAttack();
		yield return WaitCustomEvent("Shoot");
		StopLink();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator StartLink()
	{
		LeftHandFX = PlayEffect("Effect_Skill03_HandL");
		RightHandFX = PlayEffect("Effect_Skill03_HandR");
		LockArea = PlayAreaEffect("Area_30281_Skill03_LockEffect", GetEntityPosition(GetCurrentPlayer()));
		Skill_03 skill_ = this;
		Skill_03 skill_2 = this;
		LogicEntity areaEffect = GetAreaEffect(LockArea);
		skill_.LinkL = skill_2.PlayLinkEffect("Effect_Skill03_LineL", useCustomSource: false, null, default, default, areaEffect);
		Skill_03 skill_3 = this;
		Skill_03 skill_4 = this;
		areaEffect = GetAreaEffect(LockArea);
		skill_3.LinkR = skill_4.PlayLinkEffect("Effect_Skill03_LineR", useCustomSource: false, null, default, default, areaEffect);
		yield return WaitTime(2.5);
		TSVector2 position = GetAreaEffect(LockArea).tsTransform.Position;
		if (GetMonsterTagValue(_actor, 1) != "Lv1")
		{
			BoomArea = PlayAreaEffect("Area_30281_Skill03_Boom02", position);
		}
		else
		{
			BoomArea = PlayAreaEffect("Area_30281_Skill03_Boom01", position);
		}
	}

	private void StopLink()
	{
		StopEffect(LeftHandFX);
		StopEffect(RightHandFX);
		StopEffect(LinkL);
		StopEffect(LinkR);
	}
}

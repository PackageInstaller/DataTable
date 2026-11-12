#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_Jump_LD : SkillScript_Base
{
	private LogicEntity target;

	private TSVector2 TargetPOS;

	private readonly FP INTR01 = 0.3;

	private bool breakOff;

	private string WarningBullet = "50011XingXing_Earth_WarningBullet";

	private bool AlignShoot_WB = true;

	private readonly FP AlignShootDelay_WB = 0;

	private int BulletCount_WB = 1;

	private readonly FP Duration_WB = 0;

	private TSVector2 ShootPOS_WB;

	private readonly FP ShootPOSY_WB = 0;

	private TSVector2 MultishootDirectio_WB;

	private readonly FP BulletDirectionOffset_WB = 0;

	private FP Angle_WB = 0;

	private readonly FP Radius_WB = 0;

	private readonly FP InnerRadius_WB = 0;

	private List<long> _BulletIDList = new List<long>();

	private string WarningBulletArea = "WarningBulletArea";

	private List<long> _AreaEffectFx = new List<long>();

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "DropAttackSwitch", value: false);
		breakOff = true;
		NovaLogger.Debug("猩猩进入跳跃技能");
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "DropAttackSwitch", value: false);
		_BulletIDList.Clear();
		ClearShootBulletIdList();
		if (breakOff)
		{
			SetUnparalleledDisable();
			SetCloseBlockDisable();
			SetSearchedImmunityDisable();
		}
		if (_AreaEffectFx.Count > 0)
		{
			for (int i = 0; i < _AreaEffectFx.Count; i++)
			{
				StopAreaEffect(_AreaEffectFx.get_Item(i));
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetCurrentPlayer();
		BeginAttack(SkillScript_Base.DropIndex, SkillScript_Base.DropAttack);
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		SetSearchedImmunityEnable();
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		yield return WaitTime(0.5);
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(INTR01);
		StartCor(Warning());
		yield return StartCoroutine(Attack());
		NovaLogger.Debug("技能结束");
	}

	protected IEnumerator Attack()
	{
		for (int i = 0; i < 30; i++)
		{
			if (GetLogicTagToggleValue(_actor, "DropAttackSwitch"))
			{
				break;
			}
			if (i > 29)
			{
				break;
			}
			yield return WaitTime(0.1);
		}
		if (_BulletIDList != null && _BulletIDList.Count > 0)
		{
			TargetPOS = GetBulletPosition(_BulletIDList.get_Item(0));
		}
		else
		{
			TargetPOS = TSVector2.zero;
		}
		CancelAttack();
		Teleport(TargetPOS);
		SetHideModelDisable();
		BeginLookAt_NotWait(target, 0.1, 999);
		yield return WaitTime(0.25);
		SetUnparalleledDisable();
		SetSearchedImmunityDisable();
		SetCloseBlockDisable();
		breakOff = false;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Warning()
	{
		FP fP = 1;
		FP DropBegin = 1.5 - fP;
		ShootPOS_WB = GetEntityPositionObsoleted(target);
		MultishootDirectio_WB = GetEntityForward(target);
		FanMultipleShoot(WarningBullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot_WB, AlignShootDelay_WB, BulletCount_WB, Duration_WB, ShootPOS_WB, ShootPOSY_WB, MultishootDirectio_WB, BulletDirectionOffset_WB, AimType.Default, BulletDirectionType.ActorToBullet, Angle_WB, Radius_WB, InnerRadius_WB);
		_BulletIDList.AddRange(GetShootBulletIdList());
		yield return WaitTime(fP);
		_AreaEffectFx.Add(PlayAreaEffect(WarningBulletArea, new TSVector2(0, 0)));
		yield return WaitTime(DropBegin);
		SetLogicTagToggleValue(_actor, "DropAttackSwitch", value: true);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == SkillScript_Base.DropIndex && eventName == "GroundAttack")
		{
			CheckSkillcondition();
		}
	}
}

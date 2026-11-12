using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class SkillScript_Support_NormalAttack : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[0] = "Support",
		[4] = "Support_P21",
		[2] = "Support_P23",
		[1] = "Support_P21",
		[6] = "Support_P23",
		[5] = "Support_P21",
		[3] = "Support_P23",
		[7] = "Support"
	};

	private string evt_shoot = "SupSkill_ShuiJian";

	private string bullut_WaterArrow = "Bullet_11301_Skill_Supp_ShuiJian";

	private string bullut_WaterArrow_P23 = "Bullet_11301_Skill_Supp_ShuiJian_P23";

	private int shootMod = 10;

	private Dictionary<int, TSVector> dicShootPos = new Dictionary<int, TSVector>
	{
		[1] = new TSVector(-0.4, 2, 1.2),
		[2] = new TSVector(-0.2, 2, 1.2),
		[3] = new TSVector(0, 2, 1.2),
		[4] = new TSVector(0.2, 2, 1.2),
		[5] = new TSVector(0.4, 2, 1.2),
		[6] = new TSVector(0.4, 2, 1.2),
		[7] = new TSVector(0.2, 2, 1.2),
		[8] = new TSVector(0, 2, 1.2),
		[9] = new TSVector(-0.2, 2, 1.2),
		[0] = new TSVector(-0.4, 2, 1.2)
	};

	private Dictionary<int, TSVector> dicShootPos_P21 = new Dictionary<int, TSVector>
	{
		[1] = new TSVector(0, 2, 1.2),
		[2] = new TSVector(0, 2, 1.2),
		[3] = new TSVector(0, 2, 1.2),
		[4] = new TSVector(0, 2, 1.2),
		[5] = new TSVector(0, 2, 1.2),
		[6] = new TSVector(0, 2, 1.2),
		[7] = new TSVector(0, 2, 1.2),
		[8] = new TSVector(0, 2, 1.2),
		[9] = new TSVector(0, 2, 1.2),
		[0] = new TSVector(0, 2, 1.2)
	};

	private Dictionary<int, TSVector> dicShootPos_P23 = new Dictionary<int, TSVector>
	{
		[1] = new TSVector(0, 2, 1.2),
		[2] = new TSVector(0, 2, 1.2),
		[3] = new TSVector(0, 2, 1.2),
		[4] = new TSVector(0, 2, 1.2),
		[5] = new TSVector(0, 2, 1.2),
		[6] = new TSVector(0, 2, 1.2),
		[7] = new TSVector(0, 2, 1.2),
		[8] = new TSVector(0, 2, 1.2),
		[9] = new TSVector(0, 2, 1.2),
		[0] = new TSVector(0, 2, 1.2)
	};

	private string bullut_WaterArrowB = "Bullet_11301_Skill_Supp_ShuiJian_P21";

	private TSVector pos_B1 = new TSVector(0.5, 2, 0);

	private TSVector pos_B2 = new TSVector(-0.5, 2, 0);

	private int intervalCount = 3;

	private const int perkId_21 = 511321;

	private int perkId_22 = 511322;

	private int pro_22 = 50;

	private int buffId_22 = 11322011;

	private Dictionary<int, string> dicBullet_22 = new Dictionary<int, string>
	{
		[1] = "Bullet_11301_Skill_Support_WaterPill_1",
		[2] = "Bullet_11301_Skill_Support_WaterPill_2",
		[3] = "Bullet_11301_Skill_Support_WaterPill_3",
		[4] = "Bullet_11301_Skill_Support_WaterPill_4",
		[5] = "Bullet_11301_Skill_Support_WaterPill_5"
	};

	private FP offsetY_22 = 1.5f;

	private const int perkId_23 = 511323;

	private const int perkId_24 = 511324;

	private const int once_24 = 11324011;

	private FP cd_24 = 1.4;

	private CoroutineNode corMain;

	private PlayerAdventureActor mainCtrActor;

	private int curIndex;

	private FP curTime;

	private bool revert;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		curIndex = _actor.logicVariable.GetLogicTagValue("shootIndex").AsInt();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		curTime = 0;
		revert = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		_actor.CancelAiming();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void onFinish()
	{
		_actor.logicVariable.SetLogicTagValue("shootIndex", curIndex);
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		int num = (GetPerkLv(511321, out var lv) ? 4 : 0);
		int num2 = (GetPerkLv(511323, out lv) ? 2 : 0);
		int num3 = (GetPerkLv(511324, out lv) ? 1 : 0);
		int key = num | num2 | num3;
		string actionTag = dicKey.get_Item(key);
		SkillScript_Support_NormalAttack skillScript_Support_NormalAttack = this;
		Action onComboFinish = onFinish;
		Action onInterrupt = onFinish;
		Action<string> action = onCustomEvent;
		Action action2 = onComboLoop;
		skillScript_Support_NormalAttack.BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action, null, fadeOutAnim: false, action2);
		while (!CheckEnd())
		{
			yield return null;
		}
		comboAttack.InterruptAttack();
	}

	private void onComboLoop()
	{
		if (_actor.attackTarget != null)
		{
			_actor.CancelAiming();
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private bool CheckEnd()
	{
		FP fP = TSVector2.Distance(_actor.tsTransform.Position, mainCtrActor.tsTransform.Position);
		bool flag = _actor.attackTarget == null;
		bool logicTagToggle = _actor.logicVariable.GetLogicTagToggle("AIEnd");
		return (_actor.logicVariable.GetLogicTagToggle("InTrace") && fP > Config.trace_second) | flag | logicTagToggle;
	}

	private void onCustomEvent(string evt)
	{
		if (!evt.Equals(evt_shoot))
		{
			return;
		}
		bool flag = false;
		if (GetPerkLv(511324, out var lv) && (_actor.LogicTime - curTime > cd_24 || curTime <= 0))
		{
			flag = true;
			curTime = _actor.LogicTime;
		}
		curIndex++;
		int key = curIndex % shootMod;
		TSVector tSVector = dicShootPos.get_Item(key);
		string bulletAlias = bullut_WaterArrow;
		if (GetPerkLv(511321, out lv))
		{
			tSVector = dicShootPos_P21.get_Item(key);
			if (curIndex % intervalCount == 0)
			{
				TSVector2 point = (revert ? new TSVector2(pos_B1.x, pos_B1.z) : new TSVector2(pos_B2.x, pos_B2.z));
				FP positionY = (revert ? pos_B1.y : pos_B2.y);
				revert = !revert;
				TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(point);
				AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bullut_WaterArrowB, _actor, default, position, positionY, default, null, AimType.Forward);
				if (adventureBulletBase != null && adventureBulletBase is AdventureBullet adventureBullet && flag)
				{
					adventureBullet.AddAdditionalAttr(11324011);
				}
				ShootBezier();
			}
		}
		if (GetPerkLv(511323, out lv))
		{
			tSVector = dicShootPos_P23.get_Item(key);
			bulletAlias = bullut_WaterArrow_P23;
		}
		TSVector2 position2 = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(tSVector.x, tSVector.z));
		AdventureBulletBase adventureBulletBase2 = ILRuntimeAPI.Shoot(bulletAlias, _actor, default, position2, tSVector.y, default, null, AimType.Forward);
		if (adventureBulletBase2 != null && adventureBulletBase2 is AdventureBullet adventureBullet2)
		{
			if (GetPerkLv(511321, out lv))
			{
				adventureBullet2.SetDelayMove(0.1);
			}
			if (flag)
			{
				adventureBulletBase2.AddAdditionalAttr(11324011);
			}
		}
		ShootBezier();
	}

	private void ShootBezier()
	{
		if (GetPerkLv(perkId_22, out var _) && TSRandom.Range(0, 100) < pro_22)
		{
			LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
			if (assistantAttackTarget != null)
			{
				TSVector2 position = _actor.tsTransform.Position;
				int key = TSRandom.Range(1, 6);
				string bulletAlias = dicBullet_22.get_Item(key);
				AdventureActor actor = _actor;
				FP positionY = offsetY_22;
				LogicEntity target = assistantAttackTarget;
				ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, positionY, default, target, AimType.Target);
				_actor.buffComponent.AddBuff(buffId_22, _actor);
			}
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}

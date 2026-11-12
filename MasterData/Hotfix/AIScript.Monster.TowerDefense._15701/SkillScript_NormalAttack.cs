using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._15701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string comboTag = "Attack";

	private const string eventName_Shoot_NormalAttack = "157pugong";

	private const string bulletKey_NormalAttack = "Bullet_157_NrmAtk_1";

	private static readonly TSVector2 shootOffset_NormalAttack = new TSVector2(-0.3, 1);

	private static readonly FP shootPositionY_NormalAttack = 1.5;

	private int perkId_1 = 1570101;

	private const string bulletKey_P1 = "Bullet_157_NrmAtk_1_Num4";

	private const string eventName_Shoot_NormalAttack_P1 = "157diaoshe";

	private static readonly TSVector2 shootOffset_NormalAttack_P1 = new TSVector2(0, 1);

	private static readonly FP shootPositionY_NormalAttack_P1 = 1.5;

	private static readonly List<string> bulletKeyList_P1 = new List<string> { "Bullet_157_P3_DiaoShe1", "Bullet_157_P3_DiaoShe2", "Bullet_157_P3_DiaoShe3", "Bullet_157_P3_DiaoShe4" };

	public static readonly FP randomRadius_NormalAttack_P1 = 3;

	public static readonly FP offset_NoTarget_NormalAttack_P1 = 4;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private VisualSmooth smooth;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		smooth = _actor.GetLogicComponent<VisualSmooth>();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
		targetEntity = null;
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
				smooth?.SyncDeterministicTransform();
			}
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnFinish;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private bool isTagetMark()
	{
		if (_actor.attackTarget == null)
		{
			return false;
		}
		MonsterAdventureActor monsterAdventureActor = _actor.attackTarget as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			return monsterAdventureActor.buffComponent.CheckBuffByBuffID(801570050);
		}
		return false;
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "157pugong"))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset_NormalAttack.x + _actor.tsTransform.Forward * shootOffset_NormalAttack.y;
			string bulletAlias = "Bullet_157_NrmAtk_1";
			if (GetPerk(perkId_1) && isTagetMark())
			{
				bulletAlias = "Bullet_157_NrmAtk_1_Num4";
			}
			ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, default, _actor.tsTransform.Forward, position, shootPositionY_NormalAttack);
		}
		else if (string.Equals(eventName, "157diaoshe") && GetPerk(perkId_1) && isTagetMark())
		{
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = 0,
				radius = randomRadius_NormalAttack_P1,
				position = ((_actor.attackTarget != null) ? (_actor.tsTransform.Position + (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized * (TSVector2.Distance(_actor.tsTransform.Position, _actor.attackTarget.tsTransform.Position) - _actor.attackTarget.GetRadius())) : (_actor.tsTransform.Position + _actor.tsTransform.Forward * offset_NoTarget_NormalAttack_P1))
			};
			TSVector2 position2 = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset_NormalAttack_P1.x + _actor.tsTransform.Forward * shootOffset_NormalAttack_P1.y;
			for (int i = 0; i < bulletKeyList_P1.Count; i++)
			{
				ILRuntimeAPI.Shoot(bulletKeyList_P1.get_Item(i), targetPosition: ILRuntimeAPI.GetRandomPointInShape(_actor, shape, isReachable: false), actor: _actor, range: default, position: position2, positionY: shootPositionY_NormalAttack_P1, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
			}
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}
}

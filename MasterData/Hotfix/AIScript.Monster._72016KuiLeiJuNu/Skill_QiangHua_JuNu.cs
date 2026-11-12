using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_QiangHua_JuNu : SkillSimpleBase
{
	private enum TrapType
	{
		Explosion,
		Tangle
	}

	private int loopCount = 1;

	private FP warningFlightTime = 0.5f;

	private FP trapDuration = 12;

	private FP trapSpacing = 3.5;

	private FP enhanceDurationRatio = 1f;

	private const string warningAlias = "FX/Warning/fx_warning_circular_1";

	private const string bombCombo = "Skill1_B";

	private const string bombBulletAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/Bullet_72016RenOu_JuNu_Explosion_H";

	private const string bombChargeFxNamePart = "Explosion_xuli";

	private const string tangleCombo = "Skill1_C";

	private const string tangleBulletAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/Bullet_72016RenOu_JuNu_Entangle_H";

	private const string tangleChargeFxNamePart = "Entangle_xuli";

	private FP fireHeight = 1.5f;

	private TSVector2 fireOffset = new TSVector2(0, 1f);

	private TrapType _trapType;

	private int loopIndex;

	private bool warningLocked;

	private TSVector2 trapPos1;

	private TSVector2 trapPos2;

	private long warningFxId;

	private FP actualDuration;

	private string _combo;

	private string _bulletAlias;

	private string _chargeFxNamePart;

	private void OnSummonSpawned(IEvent evt)
	{
		if (evt is AdventurActorSpawned { sender: AdventureActor { dataID: 1900707 } sender })
		{
			SetLogicTagFpValue(sender, "TrapDuration", actualDuration);
		}
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_SPAWN", OnSummonSpawned);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_SPAWN", OnSummonSpawned);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget() ?? GetCurrentPlayer();
		if (!(target == null))
		{
			if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
			{
				MoveToPosition(GetEntityPosition(target), 12, AdventureActor.MovementMode.Run, 5);
				yield return WaitMoveStatus();
				StopMove();
			}
			_trapType = (TrapType)(long)GetLogicTagFpValue(_actor, "QiangHuaTrapType");
			if (_trapType == TrapType.Tangle)
			{
				_combo = "Skill1_C";
				_bulletAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/Bullet_72016RenOu_JuNu_Entangle_H";
				_chargeFxNamePart = "Entangle_xuli";
			}
			else
			{
				_combo = "Skill1_B";
				_bulletAlias = "Actor/Monster/72016RenOu_JuNu/Weapon/Bullet_72016RenOu_JuNu_Explosion_H";
				_chargeFxNamePart = "Explosion_xuli";
			}
			actualDuration = trapDuration * enhanceDurationRatio;
			trapPos1 = GetEntityPosition(target);
			loopIndex = 0;
			warningLocked = false;
			BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
			BeginAttack(1, _combo, flushInputedKeys: true);
			CoroutineNode warningCor = StartCor(TargetedWarningCor(target));
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return warningCor;
		}
	}

	protected override void OnComboLoop(int comboIndex)
	{
		loopIndex++;
		if (loopIndex >= loopCount)
		{
			warningLocked = true;
			trapPos1 = GetEntityPosition(GetAttackTarget() ?? GetCurrentPlayer());
			TSVector2 position = trapPos1;
			FP radius = trapSpacing;
			FP innerRadius = trapSpacing;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			trapPos2 = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			TSVector2 chargeFxFirePos = GetChargeFxFirePos(out var posY);
			string bulletAlias = _bulletAlias;
			FP positionY = posY;
			FP range = 0;
			TSVector2 targetPosition = trapPos1;
			Shoot(bulletAlias, chargeFxFirePos, positionY, range, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
			string bulletAlias2 = _bulletAlias;
			FP positionY2 = posY;
			FP range2 = 0;
			targetPosition = trapPos2;
			Shoot(bulletAlias2, chargeFxFirePos, positionY2, range2, default, AimType.Position, BulletDirectionType.BulletToTarget, targetPosition);
			StopLookAt();
			CancelAttack();
		}
	}

	private IEnumerator TargetedWarningCor(LogicEntity target)
	{
		Skill_QiangHua_JuNu skill_QiangHua_JuNu = this;
		Skill_QiangHua_JuNu skill_QiangHua_JuNu2 = this;
		float duration = (float)warningFlightTime + 2f;
		TSVector2 entityPosition = GetEntityPosition(target);
		skill_QiangHua_JuNu.warningFxId = skill_QiangHua_JuNu2.PlayEarlyWarningEffect("FX/Warning/fx_warning_circular_1", duration, default, entityPosition, default, 2f);
		while (!warningLocked)
		{
			trapPos1 = GetEntityPosition(target);
			ModifyEffectPosition(warningFxId, trapPos1);
			yield return WaitTime(0.05);
		}
		yield return WaitTime(warningFlightTime);
		CompleteEarlyWarningEffect(warningFxId);
		if (_trapType == TrapType.Tangle)
		{
			SpawnTangleTrap(trapPos1);
			SpawnTangleTrap(trapPos2);
		}
		else
		{
			SpawnExplosionTrap(trapPos1);
			SpawnExplosionTrap(trapPos2);
		}
	}

	private void SpawnExplosionTrap(TSVector2 pos)
	{
		SummonMonster(1900707, 0, pos, TSVector2.up);
	}

	private void SpawnTangleTrap(TSVector2 pos)
	{
	}

	private TSVector2 GetChargeFxFirePos(out FP posY)
	{
		Transform transform = FindChildByNameContains(_actor.transform, _chargeFxNamePart);
		if (transform != null)
		{
			Vector3 position = transform.position;
			posY = position.y;
			return new TSVector2(position.x, position.z);
		}
		posY = fireHeight;
		return TransLocalPosToWorldPos(GetPosition(), GetForward(), fireOffset);
	}

	private static Transform FindChildByNameContains(Transform root, string namePart)
	{
		for (int i = 0; i < root.childCount; i++)
		{
			Transform child = root.GetChild(i);
			if (child.name.Contains(namePart))
			{
				return child;
			}
			Transform transform = FindChildByNameContains(child, namePart);
			if (transform != null)
			{
				return transform;
			}
		}
		return null;
	}
}

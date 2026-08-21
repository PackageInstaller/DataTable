using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class MonsterEntity : BaseEntity, ITargetEntity
{
	private DRMonster _monsterTypeConfig;

	private DRMonsterAttr _monsterAttrConfig;

	private int _monsterAttackCtrlId;

	public bool IsBoss => _monsterTypeConfig.IsBoss;

	public DRMonster MonsterTypeConfig => _monsterTypeConfig;

	public DRMonsterAttr MonsterAttrConfig => _monsterAttrConfig;

	public override string AssetPath => _monsterTypeConfig.AssetPath;

	public override bool IsSyncEntity => true;

	public override bool IsSyncPhysicsEntity => true;

	public override bool ViewInitIsActive => MonsterTypeConfig?.IsBoss ?? true;

	public int GetBallisticsCategory()
	{
		return _monsterTypeConfig.BallisticsCategory;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[37]
		{
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(EntityBoneComponent),
			typeof(BaseBoneDamageComponent),
			typeof(HpComponent),
			typeof(EntityPartHitComponent),
			typeof(BuffComponent),
			typeof(StateComponent),
			typeof(AbnormalStateComponent),
			typeof(MonsterPhaseComponent),
			typeof(HitColliderComponent),
			typeof(HitComponent),
			typeof(MonsterHitEffectComponent),
			typeof(EntityRotationComponent),
			typeof(CurveMovementComponent),
			typeof(NormalMoveComponent),
			typeof(EntityFixedAngelMoveComponent),
			typeof(EntitySelfDegMoveComponent),
			typeof(PathfindingComponent),
			typeof(AttractionComponent),
			typeof(KinematicMoveComponent),
			typeof(WeaknessComponent),
			typeof(EntityWarningComponent),
			typeof(DataNodeComponent),
			typeof(KnockDownStateWeightComponent),
			typeof(TenacityComponent),
			typeof(EntityDefenceComponent),
			typeof(EntityPointMaterialComponent),
			typeof(EntityShakeComponent),
			typeof(EntityGoldBodyComponent),
			typeof(AIParadoxComponent),
			typeof(EffectControlComponent),
			typeof(TransformComponent),
			typeof(LogicEntityCollisionComponent),
			typeof(MonsterDestroyComponent),
			typeof(FMODBankComponent),
			typeof(SoundHostedComponent)
		};
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		if (userData is DRMonster dRMonster && userDataPam is DRMonsterAttr monsterAttrConfig)
		{
			_monsterTypeConfig = dRMonster;
			_monsterAttrConfig = monsterAttrConfig;
			property = BattleMonsterData.Create(this, _monsterTypeConfig, _monsterAttrConfig);
			property.InitProperty();
			SetData(AIParadoxComponent.AI_PARADOX_KEY, _monsterTypeConfig.AIParadoxId);
			SetData("HeadIcon", _monsterTypeConfig.Head);
			SetData("AppearLevel", _monsterTypeConfig.AppearLevel);
			SetData("HpBarType", _monsterTypeConfig.HpBarType);
			SetData("PrimitiveEnum", PrimitiveEnum.BoxPrimitive);
			SetData("HitColliderParam", new Vector3(1f, 2f, 1f));
			SetData("HitColliderColor", Color.magenta);
			SetData("CollisionLayer", collisionLayer);
			SetData("CollisionMass", collisionMass);
			_ = _monsterTypeConfig.CollisionId;
			DREntityCollision dataRow = GameEntry.DataTable.GetDataRow<DREntityCollision>(_monsterTypeConfig.CollisionId);
			SetData("CollisionData", dataRow);
			SetData("IsBoss", _monsterTypeConfig.IsBoss);
			SetData("MonsterIsChangeAngerState", _monsterTypeConfig.IsChangeState);
			SetData("MonsterConfig", _monsterTypeConfig);
			SetData("MonsterAttrConfig", _monsterAttrConfig);
			SetData("DeadStateId", dRMonster.DeadStateId);
			SetData("RebornStateId", dRMonster.RebornStateId);
			SetData("HitCollider", GameEntry.DataTable.GetDataRow<DRHitBox>(dRMonster.HitBoxId));
			SetData("ShakeMultiple", dRMonster.ShakeMultiple);
			SetData(FMODBankComponent.FMOD_BANK_GROUPS, dRMonster.BankGroups);
		}
		ChangeUpdateType(EntityUpdateType.Authority);
		if (_monsterTypeConfig.IsBoss)
		{
			SetDeadReleaseEffect(releaseEffect: true);
		}
		InitExternalParadoxTree();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		InitBornBuff();
		if (IsBoss && ((IEntityRoom)this).InLocalActorRoom())
		{
			this.GetSystem<BattleSystem>().UpdateBossBloodBarData((BattleMonsterData)property);
		}
	}

	private void InitBornBuff()
	{
		BuffSystem system = this.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		for (int i = 0; i < _monsterAttrConfig.BornBuff.Count; i++)
		{
			system.CheckAndAcquireBuff(this, this, _monsterAttrConfig.BornBuff[i]);
		}
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		if (copyData == null)
		{
			return;
		}
		foreach (int item in IsBoss ? copyData.GetBossBuff() : copyData.GetAllMonsterBuff())
		{
			system.CheckAndAcquireBuff(this, this, item);
		}
	}

	private void InitExternalParadoxTree()
	{
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		if (copyData != null)
		{
			List<int> value = ((!IsBoss) ? copyData.GetAllMonsterBT() : copyData.GetBossBT());
			SetData(AIParadoxComponent.EXTERNAL_PARADOX_KEY, value);
		}
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		this.GetSystem<MonsterAttackSystem>()?.ReleaseAttack(base.Id, GetMonsterAttackCtrlId());
		if (IsBoss)
		{
			this.GetSystem<VirtualCameraSystem>()?.OnMonsterRelease();
		}
	}

	public override Type GetEntityView()
	{
		return typeof(MonsterView);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.MONSTER;
	}

	protected override void OnEntityStandby()
	{
		GetComponent<EntityViewComponent>().HideEntityView();
		GetComponent<TransformComponent>().HideEntityView();
		GetComponent<HpComponent>().HideHpBar();
		this.GetSystem<MonsterAttackSystem>()?.ReleaseAttack(base.Id, GetMonsterAttackCtrlId());
	}

	protected override void OnReactivateEntity()
	{
		GetComponent<EntityViewComponent>().ShowEntityView();
		GetComponent<TransformComponent>().ShowEntityView();
	}

	public override string Name()
	{
		return _monsterAttrConfig.Name;
	}

	public override void OnResumeBefore()
	{
		base.OnResumeBefore();
		GetComponent<StateComponent>()?.RemoveState(4001);
	}

	public override void OnPauseBefore()
	{
		base.OnPauseBefore();
		GetComponent<StateComponent>()?.AddState(4001, base.Id);
	}

	public int MonsterType()
	{
		return _monsterAttrConfig.MonsterType;
	}

	public override int RandomInt(int minValue, int maxValue)
	{
		if (minValue == maxValue)
		{
			return minValue;
		}
		return world.RandomInt(minValue, maxValue);
	}

	public override float RandomFloat(float minValue, float maxValue)
	{
		return world.RandomFloat(minValue, maxValue);
	}

	public int GetMonsterAttackCtrlId()
	{
		if (_monsterAttackCtrlId == 0)
		{
			MonsterNode data = GetData<MonsterNode>(MonsterGroup.MONSTERNODE_KEY);
			if ((UnityEngine.Object)(object)data != null)
			{
				_monsterAttackCtrlId = data.monsterAttackCtrlId;
			}
		}
		return _monsterAttackCtrlId;
	}

	public void SetMonsterAttackCtrlId(int ctrId)
	{
		_monsterAttackCtrlId = ctrId;
	}

	public float GetMeatQuality()
	{
		return _monsterTypeConfig.MeatQuality;
	}

	public int GetMaterialType()
	{
		return _monsterTypeConfig.MaterialType;
	}
}

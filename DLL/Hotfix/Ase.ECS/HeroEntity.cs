#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase.ECS;

public class HeroEntity : BaseEntity, ITargetEntity
{
	private bool _isAi;

	private bool _isRobot;

	private const float robotActivateTime = 5f;

	private float _robotActivateTime = -1f;

	private BattleHeroData battleHeroData;

	private DRHero config;

	private ISubscription<StreamerModeMsg> _streamerModeChanged;

	public DRHero Config => config;

	public BattleHeroData BattleHeroData => battleHeroData;

	public override string AssetPath => config.AssetPath;

	public override bool IsSyncEntity => true;

	public override bool IsSyncPhysicsEntity => true;

	public bool IsAi => _isAi;

	public bool IsRobot => _isRobot;

	public int GetBallisticsCategory()
	{
		return config.BallisticsCategory;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[44]
		{
			typeof(EntityViewComponent),
			typeof(AnimatorComponent),
			typeof(StateComponent),
			typeof(AbnormalStateComponent),
			typeof(EntityBoneComponent),
			typeof(PathfindingComponent),
			typeof(AIParadoxComponent),
			typeof(MoveComponent),
			typeof(CurveMovementComponent),
			typeof(EntitySelfDegMoveComponent),
			typeof(NormalMoveComponent),
			typeof(EntityFixedAngelMoveComponent),
			typeof(EntityRotationComponent),
			typeof(AttractionComponent),
			typeof(KinematicMoveComponent),
			typeof(PseudoCritComponent),
			typeof(HpComponent),
			typeof(ParryComponent),
			typeof(BuffComponent),
			typeof(HeroAngerComponent),
			typeof(HitComponent),
			typeof(SkillComponent),
			typeof(HitColliderComponent),
			typeof(CoolingComponent),
			typeof(DataNodeComponent),
			typeof(EntityDefenceComponent),
			typeof(EntityWarningComponent),
			typeof(EntityDynamicAbnormalMaterialComponent),
			typeof(EntityPointMaterialComponent),
			typeof(EffectControlComponent),
			typeof(ReBornComponent),
			typeof(FmodListenerLinkComponent),
			typeof(ClimbMovementComponent),
			typeof(HeroInteractiveComponent),
			typeof(SummonedComponent),
			typeof(NearDeathRescueComponent),
			typeof(TransformComponent),
			typeof(LogicEntityCollisionComponent),
			typeof(HeroDestroyComponent),
			typeof(HeroIndicatorRingComponent),
			typeof(AutoFightCompment),
			typeof(EntityVoiceComponent),
			typeof(FMODBankComponent),
			typeof(SoundHostedComponent)
		};
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		if (userData is PeripheryHeroData peripheryHeroData)
		{
			DRHero dRHero = (config = GameEntry.DataTable.GetDataRow<DRHero>(peripheryHeroData.Id));
			property = BattleHeroData.Create(this, dRHero, peripheryHeroData);
			property.InitProperty();
			battleHeroData = (BattleHeroData)property;
			battleHeroData.SkillResouceInit();
			battleHeroData.CreateHeroIndenpentData(this);
			SetData(AIParadoxComponent.AI_PARADOX_KEY, config.AIParadoxId);
			SetData("PrimitiveEnum", PrimitiveEnum.BoxPrimitive);
			SetData("HitColliderParam", new Vector3(1f, 2f, 1f));
			SetData("HitColliderColor", Color.cyan);
			SetData("CollisionLayer", collisionLayer);
			SetData("CollisionMass", collisionMass);
			DREntityCollision dataRow = GameEntry.DataTable.GetDataRow<DREntityCollision>(config.CollisionId);
			SetData("CollisionData", dataRow);
			SetData("DeadStateId", dRHero.DeadStateId);
			SetData("RebornStateId", dRHero.RebornStateId);
			SetData("NearDeathStateId", dRHero.NearDeathStateId);
			SetData("HeroAngerMax", dRHero.HeroAngerMax);
			SetData("HeroAngerRatio", dRHero.HeroAngerRatio);
			SetData("HeroAngerReduceTime", dRHero.HeroAngerReduceTime);
			SetData("HeroAngerReduceSpeed", dRHero.HeroAngerReduceSpeed);
			SetData("HeroEnergyMax", dRHero.HeroEnergyMax);
			SetData("EnergyCellValue", dRHero.EnergyCellValue);
			SetData("HitCollider", GameEntry.DataTable.GetDataRow<DRHitBox>(dRHero.HitBoxId));
			InitExternalParadoxTree(peripheryHeroData);
			if (drHeroSkin != null && drHeroSkin.BankGroups != null && drHeroSkin.BankGroups.Count > 0)
			{
				SetData(FMODBankComponent.FMOD_BANK_GROUPS, drHeroSkin.BankGroups);
			}
			else
			{
				SetData(FMODBankComponent.FMOD_BANK_GROUPS, dRHero.BankGroups);
			}
			this.GetSystem<EntitySystem>().HeroRegisterTeam(this);
		}
		else
		{
			Log.Error("初始化英雄失败 : PeripheryHeroData = null...");
		}
		ChangeUpdateType(entityData.updateType);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		property?.StartProperty();
		GetComponent<AIParadoxComponent>().SetVariableValues("IsAi", _isAi);
		if (userData is PeripheryHeroData peripheryHeroData)
		{
			AddPeripheryBuff(peripheryHeroData.BuffList);
		}
		UpdateFmodListenerState();
		SendCreateMessage();
		GetComponent<EntityViewComponent>()?.GetHideEntityViewRoot();
	}

	private void InitExternalParadoxTree(PeripheryHeroData heroModel)
	{
		List<int> list = new List<int>(heroModel.BTList);
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		SetData(AIParadoxComponent.EXTERNAL_PARADOX_KEY, heroModel.BTList);
		if (copyData != null)
		{
			list.AddRange(copyData.GetAllHeroBT());
			SetData(AIParadoxComponent.EXTERNAL_PARADOX_KEY, list);
		}
	}

	private void AddPeripheryBuff(List<int> buffList)
	{
		BuffSystem system = this.GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		for (int i = 0; i < buffList.Count; i++)
		{
			system.CheckAndAcquireBuff(this, this, buffList[i]);
		}
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		if (copyData == null)
		{
			return;
		}
		foreach (int item in copyData.GetAllHeroBuff())
		{
			system.CheckAndAcquireBuff(this, this, item);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType type, float deltaTime)
	{
		if (base.InPause)
		{
			return;
		}
		base.OnFixedUpdate(type, deltaTime);
		if (type == WorldUpdateType.Authority || type == WorldUpdateType.All)
		{
			battleHeroData.OnFixedUpdate(deltaTime, world.IntervalTimer);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId(string.Format("实体耐力值 : {0}", GetProperty("Energy")), this);
			}
		}
		TryExecuteRobot(deltaTime);
	}

	protected override void OnEntityFrozen(float speed, bool frozen, bool isFrozenLogic = true)
	{
		base.OnEntityFrozen(speed, frozen, isFrozenLogic);
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

	public override void OnLevelFail()
	{
		base.OnLevelFail();
		GetComponent<StateComponent>()?.AddState(4002, base.Id);
	}

	public void SetAi(bool memberIsAi)
	{
		_isAi = memberIsAi;
		GetComponent<AIParadoxComponent>().SetVariableValues("IsAi", _isAi);
		UpdateFmodListenerState();
		GetComponent<MoveComponent>()?.SetAnimEnable(!memberIsAi);
	}

	public void SetRobot(bool robot)
	{
		_isRobot = robot;
		_robotActivateTime = 5f;
	}

	private void TryExecuteRobot(float deltaTime)
	{
		if (InFreedomBattleMode() || !_isRobot)
		{
			return;
		}
		if (_robotActivateTime > 0f)
		{
			_robotActivateTime -= deltaTime;
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("激活机器人", this);
		}
		GetComponent<AutoFightCompment>()?.SetFreedomBattleMode(_isRobot, changeAutoFightIcon: false);
		_robotActivateTime = -1f;
	}

	private void UpdateFmodListenerState()
	{
		EntityView entityView = GetComponent<EntityViewComponent>().EntityView;
		if (entityView != null)
		{
			GetComponent<FmodListenerLinkComponent>()?.ChangeLinkState(_isAi, entityView.transform);
			entityView.GetComponentInChildren<EntityFootstepPlayer>()?.ChangeAiControl(_isAi);
		}
	}

	private void SendCreateMessage()
	{
	}

	public bool CheckHeroTalentStarLevel(int layer, int star)
	{
		return BattleHeroData.CheckHeroTalentStarLevel(layer, star);
	}

	public override Type GetEntityView()
	{
		return typeof(HeroView);
	}

	public override CampType GetEntityCampType()
	{
		return CampType.Player;
	}

	public override EntityType GetEntityType()
	{
		return EntityType.HERO;
	}

	public override int RandomInt(int minValue, int maxValue)
	{
		if (minValue == maxValue)
		{
			return minValue;
		}
		int num = world.RandomInt(minValue, maxValue);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"RandomInt  {num}", this);
		}
		return num;
	}

	public override float RandomFloat(float minValue, float maxValue)
	{
		float num = world.RandomFloat(minValue, maxValue);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"RandomFloat  {num}", this);
		}
		return num;
	}

	public int GetHeroConfigId()
	{
		return config.Id;
	}

	public override WeaponMechanismBase GetWeaponMechanism()
	{
		return battleHeroData.WeaponMechanismBase;
	}

	public override void OnNearDeadStateUnderAttack(BaseEntity attackEntity)
	{
		GetComponent<NearDeathRescueComponent>().OnNearDeathAttacked(attackEntity?.GetProperty("Attack") ?? 0f);
	}

	protected override void InitEntitySkinConfig()
	{
		int skinConfigId = 0;
		if (userData is PeripheryHeroData { IsSkin: not false } peripheryHeroData)
		{
			drHeroSkin = GameEntry.DataTable.GetDataRow<DRHeroSkin>(peripheryHeroData.SkinConfigId);
			skinConfigId = peripheryHeroData.SkinConfigId;
			_streamerModeChanged = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<StreamerModeMsg>(OnStreamerModeChanged);
		}
		InitSkinAssociation(skinConfigId);
	}

	private void OnStreamerModeChanged(StreamerModeMsg msg)
	{
		if (base.IsActorEntity)
		{
			bool streamerMode = StreamerMode.GetStreamerMode();
			string castingPath = GetCastingPath(Config.CastingPath, streamerMode);
			world?.GetSystem<ParadoxTimelineSystem>()?.LoadCastingWindow(castingPath);
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_streamerModeChanged?.Dispose();
		_streamerModeChanged = null;
	}
}

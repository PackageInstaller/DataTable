using System;

public static class SimComponentsLookup
{
	public const int CommandsPending = 0;

	public const int EntityActionAbility = 1;

	public const int EntityActionAbilityDirection = 2;

	public const int EntityActionAbilityLogicInput = 3;

	public const int EntityActionAttack = 4;

	public const int EntityActionAvoidShadow = 5;

	public const int EntityActionBorn = 6;

	public const int EntityActionDeath = 7;

	public const int EntityActionIdle = 8;

	public const int EntityActionJump = 9;

	public const int EntityActionManualAIInput = 10;

	public const int EntityActionManualInput = 11;

	public const int EntityActionMelee = 12;

	public const int EntityActionModifyCombatScore = 13;

	public const int EntityActionModifyHP = 14;

	public const int EntityActionMove = 15;

	public const int EntityActionMoveDirection = 16;

	public const int EntityActionParrying = 17;

	public const int EntityActionSubJoystick = 18;

	public const int EntityActionTransfiguration = 19;

	public const int EntityActionWeaponEquip = 20;

	public const int EntityAIMovement = 21;

	public const int EntityAIThink = 22;

	public const int EntityBlackboard = 23;

	public const int EntityBoss = 24;

	public const int EntityBuff = 25;

	public const int EntityCameraView = 26;

	public const int EntityCamp = 27;

	public const int EntityCD = 28;

	public const int EntityCollisionInfo = 29;

	public const int EntityComboNumber = 30;

	public const int EntityCommander = 31;

	public const int EntityConfig = 32;

	public const int EntityDetectable = 33;

	public const int EntityEndurance = 34;

	public const int EntityExposedValue = 35;

	public const int EntityExposedValueBreak = 36;

	public const int EntityExposedValueCoverReducedValue = 37;

	public const int EntityHealth = 38;

	public const int EntityHide = 39;

	public const int EntityHitRecover = 40;

	public const int EntityID = 41;

	public const int EntityLocalPlayer = 42;

	public const int EntityMasterSkill = 43;

	public const int EntityMoveClamp = 44;

	public const int EntityPositon = 45;

	public const int EntityPostureValue = 46;

	public const int EntityPredicationPlayer = 47;

	public const int EntityPuppet = 48;

	public const int EntityPuppetHost = 49;

	public const int EntityQTE = 50;

	public const int EntityRecastCut = 51;

	public const int EntityRemotePlayer = 52;

	public const int EntityResistance = 53;

	public const int EntityRVO = 54;

	public const int EntityShape = 55;

	public const int EntitySkillEffect = 56;

	public const int EntitySourceSpace = 57;

	public const int EntityTestGoogle = 58;

	public const int EntityTimer = 59;

	public const int EntityTrigger = 60;

	public const int EntityUltimateAvoidCD = 61;

	public const int EntityUniqueSkillEnergy = 62;

	public const int EventHandler = 63;

	public const int LogicServices = 64;

	public const int Projectile = 65;

	public const int SEntityAABBTree = 66;

	public const int SEntityGameOver = 67;

	public const int SEntitySpatialTable = 68;

	public const int SEntityWorldState = 69;

	public const int SimStateFrameBuffer = 70;

	public const int SimStatus = 71;

	public const int SimTransform = 72;

	public const int SimulatorInterface = 73;

	public const int Unit = 74;

	public const int TotalComponents = 75;

	public static readonly string[] componentNames = new string[75]
	{
		"CommandsPending", "EntityActionAbility", "EntityActionAbilityDirection", "EntityActionAbilityLogicInput", "EntityActionAttack", "EntityActionAvoidShadow", "EntityActionBorn", "EntityActionDeath", "EntityActionIdle", "EntityActionJump",
		"EntityActionManualAIInput", "EntityActionManualInput", "EntityActionMelee", "EntityActionModifyCombatScore", "EntityActionModifyHP", "EntityActionMove", "EntityActionMoveDirection", "EntityActionParrying", "EntityActionSubJoystick", "EntityActionTransfiguration",
		"EntityActionWeaponEquip", "EntityAIMovement", "EntityAIThink", "EntityBlackboard", "EntityBoss", "EntityBuff", "EntityCameraView", "EntityCamp", "EntityCD", "EntityCollisionInfo",
		"EntityComboNumber", "EntityCommander", "EntityConfig", "EntityDetectable", "EntityEndurance", "EntityExposedValue", "EntityExposedValueBreak", "EntityExposedValueCoverReducedValue", "EntityHealth", "EntityHide",
		"EntityHitRecover", "EntityID", "EntityLocalPlayer", "EntityMasterSkill", "EntityMoveClamp", "EntityPositon", "EntityPostureValue", "EntityPredicationPlayer", "EntityPuppet", "EntityPuppetHost",
		"EntityQTE", "EntityRecastCut", "EntityRemotePlayer", "EntityResistance", "EntityRVO", "EntityShape", "EntitySkillEffect", "EntitySourceSpace", "EntityTestGoogle", "EntityTimer",
		"EntityTrigger", "EntityUltimateAvoidCD", "EntityUniqueSkillEnergy", "EventHandler", "LogicServices", "Projectile", "SEntityAABBTree", "SEntityGameOver", "SEntitySpatialTable", "SEntityWorldState",
		"SimStateFrameBuffer", "SimStatus", "SimTransform", "SimulatorInterface", "Unit"
	};

	public static readonly Type[] componentTypes = new Type[75]
	{
		typeof(CommandsPendingComponent),
		typeof(EntityActionAbility),
		typeof(EntityActionAbilityDirection),
		typeof(EntityActionAbilityLogicInput),
		typeof(EntityActionAttack),
		typeof(EntityActionAvoidShadow),
		typeof(EntityActionBorn),
		typeof(EntityActionDeath),
		typeof(EntityActionIdle),
		typeof(EntityActionJump),
		typeof(EntityActionManualAIInput),
		typeof(EntityActionManualInput),
		typeof(EntityActionMelee),
		typeof(EntityActionModifyCombatScore),
		typeof(EntityActionModifyHP),
		typeof(EntityActionMove),
		typeof(EntityActionMoveDirection),
		typeof(EntityActionParrying),
		typeof(EntityActionSubJoystick),
		typeof(EntityActionTransfiguration),
		typeof(EntityActionWeaponEquip),
		typeof(EntityAIMovement),
		typeof(EntityAIThink),
		typeof(EntityBlackboard),
		typeof(EntityBoss),
		typeof(EntityBuff),
		typeof(EntityCameraView),
		typeof(EntityCamp),
		typeof(EntityCD),
		typeof(EntityCollisionInfo),
		typeof(EntityComboNumber),
		typeof(EntityCommander),
		typeof(EntityConfig),
		typeof(EntityDetectable),
		typeof(EntityEndurance),
		typeof(EntityExposedValue),
		typeof(EntityExposedValueBreak),
		typeof(EntityExposedValueCoverReducedValue),
		typeof(EntityHealth),
		typeof(EntityHide),
		typeof(EntityHitRecover),
		typeof(EntityID),
		typeof(EntityLocalPlayer),
		typeof(EntityMasterSkill),
		typeof(EntityMoveClamp),
		typeof(EntityPositon),
		typeof(EntityPostureValue),
		typeof(EntityPredicationPlayer),
		typeof(EntityPuppet),
		typeof(EntityPuppetHost),
		typeof(EntityQTE),
		typeof(EntityRecastCut),
		typeof(EntityRemotePlayer),
		typeof(EntityResistance),
		typeof(EntityRVO),
		typeof(EntityShape),
		typeof(EntitySkillEffect),
		typeof(EntitySourceSpace),
		typeof(EntityTestGoogle),
		typeof(EntityTimer),
		typeof(EntityTrigger),
		typeof(EntityUltimateAvoidCD),
		typeof(EntityUniqueSkillEnergy),
		typeof(EventHandlerComponent),
		typeof(LogicServices),
		typeof(Projectile),
		typeof(SEntityAABBTree),
		typeof(SEntityGameOver),
		typeof(SEntitySpatialTable),
		typeof(SEntityWorldState),
		typeof(SimStateFrameBuffer),
		typeof(SimStatusComponent),
		typeof(SimTransform),
		typeof(SimulatorInterfaceComponent),
		typeof(Unit)
	};
}

using Entitas;

public sealed class SimMatcher
{
	private static IMatcher<SimEntity> _matcherSEntityGameOver;

	private static IMatcher<SimEntity> _matcherLogicServices;

	private static IMatcher<SimEntity> _matcherEntitySourceSpace;

	private static IMatcher<SimEntity> _matcherSEntityWorldState;

	private static IMatcher<SimEntity> _matcherSEntityAABBTree;

	private static IMatcher<SimEntity> _matcherSEntitySpatialTable;

	private static IMatcher<SimEntity> _matcherSimStatus;

	private static IMatcher<SimEntity> _matcherEventHandler;

	private static IMatcher<SimEntity> _matcherSimStateFrameBuffer;

	private static IMatcher<SimEntity> _matcherCommandsPending;

	private static IMatcher<SimEntity> _matcherSimulatorInterface;

	private static IMatcher<SimEntity> _matcherEntityMasterSkill;

	private static IMatcher<SimEntity> _matcherEntityMoveClamp;

	private static IMatcher<SimEntity> _matcherEntityActionParrying;

	private static IMatcher<SimEntity> _matcherEntityResistance;

	private static IMatcher<SimEntity> _matcherEntityUniqueSkillEnergy;

	private static IMatcher<SimEntity> _matcherEntityActionManualAIInput;

	private static IMatcher<SimEntity> _matcherEntityActionModifyCombatScore;

	private static IMatcher<SimEntity> _matcherEntityUltimateAvoidCD;

	private static IMatcher<SimEntity> _matcherEntityExposedValue;

	private static IMatcher<SimEntity> _matcherEntityExposedValueBreak;

	private static IMatcher<SimEntity> _matcherEntityExposedValueCoverReducedValue;

	private static IMatcher<SimEntity> _matcherEntityQTE;

	private static IMatcher<SimEntity> _matcherEntityActionAbilityLogicInput;

	private static IMatcher<SimEntity> _matcherEntityActionAvoidShadow;

	private static IMatcher<SimEntity> _matcherEntityActionSubJoystick;

	private static IMatcher<SimEntity> _matcherEntityEndurance;

	private static IMatcher<SimEntity> _matcherEntityPuppet;

	private static IMatcher<SimEntity> _matcherEntityPuppetHost;

	private static IMatcher<SimEntity> _matcherEntityActionTransfiguration;

	private static IMatcher<SimEntity> _matcherEntityCD;

	private static IMatcher<SimEntity> _matcherEntityCommander;

	private static IMatcher<SimEntity> _matcherEntityComboNumber;

	private static IMatcher<SimEntity> _matcherEntityTimer;

	private static IMatcher<SimEntity> _matcherEntityPostureValue;

	private static IMatcher<SimEntity> _matcherEntityBoss;

	private static IMatcher<SimEntity> _matcherEntityRecastCut;

	private static IMatcher<SimEntity> _matcherEntityCameraView;

	private static IMatcher<SimEntity> _matcherEntityAIMovement;

	private static IMatcher<SimEntity> _matcherEntityActionAbility;

	private static IMatcher<SimEntity> _matcherEntityHide;

	private static IMatcher<SimEntity> _matcherEntityPredicationPlayer;

	private static IMatcher<SimEntity> _matcherEntityRemotePlayer;

	private static IMatcher<SimEntity> _matcherEntityActionManualInput;

	private static IMatcher<SimEntity> _matcherEntityActionMoveDirection;

	private static IMatcher<SimEntity> _matcherEntityTestGoogle;

	private static IMatcher<SimEntity> _matcherEntityLocalPlayer;

	private static IMatcher<SimEntity> _matcherEntitySkillEffect;

	private static IMatcher<SimEntity> _matcherEntityBuff;

	private static IMatcher<SimEntity> _matcherEntityActionJump;

	private static IMatcher<SimEntity> _matcherEntityActionIdle;

	private static IMatcher<SimEntity> _matcherEntityID;

	private static IMatcher<SimEntity> _matcherEntityConfig;

	private static IMatcher<SimEntity> _matcherEntityHitRecover;

	private static IMatcher<SimEntity> _matcherEntityActionBorn;

	private static IMatcher<SimEntity> _matcherEntityActionMelee;

	private static IMatcher<SimEntity> _matcherEntityActionDeath;

	private static IMatcher<SimEntity> _matcherEntityActionModifyHP;

	private static IMatcher<SimEntity> _matcherEntityActionAttack;

	private static IMatcher<SimEntity> _matcherEntityActionMove;

	private static IMatcher<SimEntity> _matcherEntityActionWeaponEquip;

	private static IMatcher<SimEntity> _matcherEntityActionAbilityDirection;

	private static IMatcher<SimEntity> _matcherEntityBlackboard;

	private static IMatcher<SimEntity> _matcherEntityAIThink;

	private static IMatcher<SimEntity> _matcherEntityTrigger;

	private static IMatcher<SimEntity> _matcherEntityCamp;

	private static IMatcher<SimEntity> _matcherEntityCollisionInfo;

	private static IMatcher<SimEntity> _matcherEntityShape;

	private static IMatcher<SimEntity> _matcherUnit;

	private static IMatcher<SimEntity> _matcherEntityRVO;

	private static IMatcher<SimEntity> _matcherSimTransform;

	private static IMatcher<SimEntity> _matcherProjectile;

	private static IMatcher<SimEntity> _matcherEntityDetectable;

	private static IMatcher<SimEntity> _matcherEntityHealth;

	private static IMatcher<SimEntity> _matcherEntityPositon;

	private static IAllOfMatcher<SimEntity> mLocalMovement;

	private static IAllOfMatcher<SimEntity> mRemoteMovement;

	private static IAllOfMatcher<SimEntity> mAIWithCamp;

	private static IAllOfMatcher<SimEntity> mTriggerMatcher;

	private static IAllOfMatcher<SimEntity> mAIWithMovement;

	public static IMatcher<SimEntity> SEntityGameOver
	{
		get
		{
			if (_matcherSEntityGameOver == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(67);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSEntityGameOver = matcher;
			}
			return _matcherSEntityGameOver;
		}
	}

	public static IMatcher<SimEntity> LogicServices
	{
		get
		{
			if (_matcherLogicServices == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(64);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherLogicServices = matcher;
			}
			return _matcherLogicServices;
		}
	}

	public static IMatcher<SimEntity> EntitySourceSpace
	{
		get
		{
			if (_matcherEntitySourceSpace == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(57);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntitySourceSpace = matcher;
			}
			return _matcherEntitySourceSpace;
		}
	}

	public static IMatcher<SimEntity> SEntityWorldState
	{
		get
		{
			if (_matcherSEntityWorldState == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(69);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSEntityWorldState = matcher;
			}
			return _matcherSEntityWorldState;
		}
	}

	public static IMatcher<SimEntity> SEntityAABBTree
	{
		get
		{
			if (_matcherSEntityAABBTree == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(66);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSEntityAABBTree = matcher;
			}
			return _matcherSEntityAABBTree;
		}
	}

	public static IMatcher<SimEntity> SEntitySpatialTable
	{
		get
		{
			if (_matcherSEntitySpatialTable == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(68);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSEntitySpatialTable = matcher;
			}
			return _matcherSEntitySpatialTable;
		}
	}

	public static IMatcher<SimEntity> SimStatus
	{
		get
		{
			if (_matcherSimStatus == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(71);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSimStatus = matcher;
			}
			return _matcherSimStatus;
		}
	}

	public static IMatcher<SimEntity> EventHandler
	{
		get
		{
			if (_matcherEventHandler == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(63);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEventHandler = matcher;
			}
			return _matcherEventHandler;
		}
	}

	public static IMatcher<SimEntity> SimStateFrameBuffer
	{
		get
		{
			if (_matcherSimStateFrameBuffer == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(70);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSimStateFrameBuffer = matcher;
			}
			return _matcherSimStateFrameBuffer;
		}
	}

	public static IMatcher<SimEntity> CommandsPending
	{
		get
		{
			if (_matcherCommandsPending == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(default(int));
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherCommandsPending = matcher;
			}
			return _matcherCommandsPending;
		}
	}

	public static IMatcher<SimEntity> SimulatorInterface
	{
		get
		{
			if (_matcherSimulatorInterface == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(73);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSimulatorInterface = matcher;
			}
			return _matcherSimulatorInterface;
		}
	}

	public static IMatcher<SimEntity> EntityMasterSkill
	{
		get
		{
			if (_matcherEntityMasterSkill == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(43);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityMasterSkill = matcher;
			}
			return _matcherEntityMasterSkill;
		}
	}

	public static IMatcher<SimEntity> EntityMoveClamp
	{
		get
		{
			if (_matcherEntityMoveClamp == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(44);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityMoveClamp = matcher;
			}
			return _matcherEntityMoveClamp;
		}
	}

	public static IMatcher<SimEntity> EntityActionParrying
	{
		get
		{
			if (_matcherEntityActionParrying == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(17);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionParrying = matcher;
			}
			return _matcherEntityActionParrying;
		}
	}

	public static IMatcher<SimEntity> EntityResistance
	{
		get
		{
			if (_matcherEntityResistance == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(53);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityResistance = matcher;
			}
			return _matcherEntityResistance;
		}
	}

	public static IMatcher<SimEntity> EntityUniqueSkillEnergy
	{
		get
		{
			if (_matcherEntityUniqueSkillEnergy == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(62);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityUniqueSkillEnergy = matcher;
			}
			return _matcherEntityUniqueSkillEnergy;
		}
	}

	public static IMatcher<SimEntity> EntityActionManualAIInput
	{
		get
		{
			if (_matcherEntityActionManualAIInput == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(10);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionManualAIInput = matcher;
			}
			return _matcherEntityActionManualAIInput;
		}
	}

	public static IMatcher<SimEntity> EntityActionModifyCombatScore
	{
		get
		{
			if (_matcherEntityActionModifyCombatScore == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(13);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionModifyCombatScore = matcher;
			}
			return _matcherEntityActionModifyCombatScore;
		}
	}

	public static IMatcher<SimEntity> EntityUltimateAvoidCD
	{
		get
		{
			if (_matcherEntityUltimateAvoidCD == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(61);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityUltimateAvoidCD = matcher;
			}
			return _matcherEntityUltimateAvoidCD;
		}
	}

	public static IMatcher<SimEntity> EntityExposedValue
	{
		get
		{
			if (_matcherEntityExposedValue == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(35);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityExposedValue = matcher;
			}
			return _matcherEntityExposedValue;
		}
	}

	public static IMatcher<SimEntity> EntityExposedValueBreak
	{
		get
		{
			if (_matcherEntityExposedValueBreak == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(36);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityExposedValueBreak = matcher;
			}
			return _matcherEntityExposedValueBreak;
		}
	}

	public static IMatcher<SimEntity> EntityExposedValueCoverReducedValue
	{
		get
		{
			if (_matcherEntityExposedValueCoverReducedValue == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(37);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityExposedValueCoverReducedValue = matcher;
			}
			return _matcherEntityExposedValueCoverReducedValue;
		}
	}

	public static IMatcher<SimEntity> EntityQTE
	{
		get
		{
			if (_matcherEntityQTE == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(50);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityQTE = matcher;
			}
			return _matcherEntityQTE;
		}
	}

	public static IMatcher<SimEntity> EntityActionAbilityLogicInput
	{
		get
		{
			if (_matcherEntityActionAbilityLogicInput == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(3);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionAbilityLogicInput = matcher;
			}
			return _matcherEntityActionAbilityLogicInput;
		}
	}

	public static IMatcher<SimEntity> EntityActionAvoidShadow
	{
		get
		{
			if (_matcherEntityActionAvoidShadow == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(5);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionAvoidShadow = matcher;
			}
			return _matcherEntityActionAvoidShadow;
		}
	}

	public static IMatcher<SimEntity> EntityActionSubJoystick
	{
		get
		{
			if (_matcherEntityActionSubJoystick == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(18);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionSubJoystick = matcher;
			}
			return _matcherEntityActionSubJoystick;
		}
	}

	public static IMatcher<SimEntity> EntityEndurance
	{
		get
		{
			if (_matcherEntityEndurance == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(34);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityEndurance = matcher;
			}
			return _matcherEntityEndurance;
		}
	}

	public static IMatcher<SimEntity> EntityPuppet
	{
		get
		{
			if (_matcherEntityPuppet == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(48);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityPuppet = matcher;
			}
			return _matcherEntityPuppet;
		}
	}

	public static IMatcher<SimEntity> EntityPuppetHost
	{
		get
		{
			if (_matcherEntityPuppetHost == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(49);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityPuppetHost = matcher;
			}
			return _matcherEntityPuppetHost;
		}
	}

	public static IMatcher<SimEntity> EntityActionTransfiguration
	{
		get
		{
			if (_matcherEntityActionTransfiguration == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(19);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionTransfiguration = matcher;
			}
			return _matcherEntityActionTransfiguration;
		}
	}

	public static IMatcher<SimEntity> EntityCD
	{
		get
		{
			if (_matcherEntityCD == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(28);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityCD = matcher;
			}
			return _matcherEntityCD;
		}
	}

	public static IMatcher<SimEntity> EntityCommander
	{
		get
		{
			if (_matcherEntityCommander == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(31);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityCommander = matcher;
			}
			return _matcherEntityCommander;
		}
	}

	public static IMatcher<SimEntity> EntityComboNumber
	{
		get
		{
			if (_matcherEntityComboNumber == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(30);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityComboNumber = matcher;
			}
			return _matcherEntityComboNumber;
		}
	}

	public static IMatcher<SimEntity> EntityTimer
	{
		get
		{
			if (_matcherEntityTimer == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(59);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityTimer = matcher;
			}
			return _matcherEntityTimer;
		}
	}

	public static IMatcher<SimEntity> EntityPostureValue
	{
		get
		{
			if (_matcherEntityPostureValue == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(46);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityPostureValue = matcher;
			}
			return _matcherEntityPostureValue;
		}
	}

	public static IMatcher<SimEntity> EntityBoss
	{
		get
		{
			if (_matcherEntityBoss == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(24);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityBoss = matcher;
			}
			return _matcherEntityBoss;
		}
	}

	public static IMatcher<SimEntity> EntityRecastCut
	{
		get
		{
			if (_matcherEntityRecastCut == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(51);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityRecastCut = matcher;
			}
			return _matcherEntityRecastCut;
		}
	}

	public static IMatcher<SimEntity> EntityCameraView
	{
		get
		{
			if (_matcherEntityCameraView == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(26);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityCameraView = matcher;
			}
			return _matcherEntityCameraView;
		}
	}

	public static IMatcher<SimEntity> EntityAIMovement
	{
		get
		{
			if (_matcherEntityAIMovement == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(21);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityAIMovement = matcher;
			}
			return _matcherEntityAIMovement;
		}
	}

	public static IMatcher<SimEntity> EntityActionAbility
	{
		get
		{
			if (_matcherEntityActionAbility == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(1);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionAbility = matcher;
			}
			return _matcherEntityActionAbility;
		}
	}

	public static IMatcher<SimEntity> EntityHide
	{
		get
		{
			if (_matcherEntityHide == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(39);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityHide = matcher;
			}
			return _matcherEntityHide;
		}
	}

	public static IMatcher<SimEntity> EntityPredicationPlayer
	{
		get
		{
			if (_matcherEntityPredicationPlayer == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(47);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityPredicationPlayer = matcher;
			}
			return _matcherEntityPredicationPlayer;
		}
	}

	public static IMatcher<SimEntity> EntityRemotePlayer
	{
		get
		{
			if (_matcherEntityRemotePlayer == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(52);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityRemotePlayer = matcher;
			}
			return _matcherEntityRemotePlayer;
		}
	}

	public static IMatcher<SimEntity> EntityActionManualInput
	{
		get
		{
			if (_matcherEntityActionManualInput == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(11);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionManualInput = matcher;
			}
			return _matcherEntityActionManualInput;
		}
	}

	public static IMatcher<SimEntity> EntityActionMoveDirection
	{
		get
		{
			if (_matcherEntityActionMoveDirection == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(16);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionMoveDirection = matcher;
			}
			return _matcherEntityActionMoveDirection;
		}
	}

	public static IMatcher<SimEntity> EntityTestGoogle
	{
		get
		{
			if (_matcherEntityTestGoogle == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(58);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityTestGoogle = matcher;
			}
			return _matcherEntityTestGoogle;
		}
	}

	public static IMatcher<SimEntity> EntityLocalPlayer
	{
		get
		{
			if (_matcherEntityLocalPlayer == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(42);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityLocalPlayer = matcher;
			}
			return _matcherEntityLocalPlayer;
		}
	}

	public static IMatcher<SimEntity> EntitySkillEffect
	{
		get
		{
			if (_matcherEntitySkillEffect == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(56);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntitySkillEffect = matcher;
			}
			return _matcherEntitySkillEffect;
		}
	}

	public static IMatcher<SimEntity> EntityBuff
	{
		get
		{
			if (_matcherEntityBuff == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(25);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityBuff = matcher;
			}
			return _matcherEntityBuff;
		}
	}

	public static IMatcher<SimEntity> EntityActionJump
	{
		get
		{
			if (_matcherEntityActionJump == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(9);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionJump = matcher;
			}
			return _matcherEntityActionJump;
		}
	}

	public static IMatcher<SimEntity> EntityActionIdle
	{
		get
		{
			if (_matcherEntityActionIdle == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(8);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionIdle = matcher;
			}
			return _matcherEntityActionIdle;
		}
	}

	public static IMatcher<SimEntity> EntityID
	{
		get
		{
			if (_matcherEntityID == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(41);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityID = matcher;
			}
			return _matcherEntityID;
		}
	}

	public static IMatcher<SimEntity> EntityConfig
	{
		get
		{
			if (_matcherEntityConfig == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(32);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityConfig = matcher;
			}
			return _matcherEntityConfig;
		}
	}

	public static IMatcher<SimEntity> EntityHitRecover
	{
		get
		{
			if (_matcherEntityHitRecover == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(40);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityHitRecover = matcher;
			}
			return _matcherEntityHitRecover;
		}
	}

	public static IMatcher<SimEntity> EntityActionBorn
	{
		get
		{
			if (_matcherEntityActionBorn == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(6);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionBorn = matcher;
			}
			return _matcherEntityActionBorn;
		}
	}

	public static IMatcher<SimEntity> EntityActionMelee
	{
		get
		{
			if (_matcherEntityActionMelee == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(12);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionMelee = matcher;
			}
			return _matcherEntityActionMelee;
		}
	}

	public static IMatcher<SimEntity> EntityActionDeath
	{
		get
		{
			if (_matcherEntityActionDeath == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(7);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionDeath = matcher;
			}
			return _matcherEntityActionDeath;
		}
	}

	public static IMatcher<SimEntity> EntityActionModifyHP
	{
		get
		{
			if (_matcherEntityActionModifyHP == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(14);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionModifyHP = matcher;
			}
			return _matcherEntityActionModifyHP;
		}
	}

	public static IMatcher<SimEntity> EntityActionAttack
	{
		get
		{
			if (_matcherEntityActionAttack == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(4);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionAttack = matcher;
			}
			return _matcherEntityActionAttack;
		}
	}

	public static IMatcher<SimEntity> EntityActionMove
	{
		get
		{
			if (_matcherEntityActionMove == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(15);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionMove = matcher;
			}
			return _matcherEntityActionMove;
		}
	}

	public static IMatcher<SimEntity> EntityActionWeaponEquip
	{
		get
		{
			if (_matcherEntityActionWeaponEquip == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(20);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionWeaponEquip = matcher;
			}
			return _matcherEntityActionWeaponEquip;
		}
	}

	public static IMatcher<SimEntity> EntityActionAbilityDirection
	{
		get
		{
			if (_matcherEntityActionAbilityDirection == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(2);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityActionAbilityDirection = matcher;
			}
			return _matcherEntityActionAbilityDirection;
		}
	}

	public static IMatcher<SimEntity> EntityBlackboard
	{
		get
		{
			if (_matcherEntityBlackboard == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(23);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityBlackboard = matcher;
			}
			return _matcherEntityBlackboard;
		}
	}

	public static IMatcher<SimEntity> EntityAIThink
	{
		get
		{
			if (_matcherEntityAIThink == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(22);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityAIThink = matcher;
			}
			return _matcherEntityAIThink;
		}
	}

	public static IMatcher<SimEntity> EntityTrigger
	{
		get
		{
			if (_matcherEntityTrigger == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(60);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityTrigger = matcher;
			}
			return _matcherEntityTrigger;
		}
	}

	public static IMatcher<SimEntity> EntityCamp
	{
		get
		{
			if (_matcherEntityCamp == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(27);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityCamp = matcher;
			}
			return _matcherEntityCamp;
		}
	}

	public static IMatcher<SimEntity> EntityCollisionInfo
	{
		get
		{
			if (_matcherEntityCollisionInfo == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(29);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityCollisionInfo = matcher;
			}
			return _matcherEntityCollisionInfo;
		}
	}

	public static IMatcher<SimEntity> EntityShape
	{
		get
		{
			if (_matcherEntityShape == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(55);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityShape = matcher;
			}
			return _matcherEntityShape;
		}
	}

	public static IMatcher<SimEntity> Unit
	{
		get
		{
			if (_matcherUnit == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(74);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherUnit = matcher;
			}
			return _matcherUnit;
		}
	}

	public static IMatcher<SimEntity> EntityRVO
	{
		get
		{
			if (_matcherEntityRVO == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(54);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityRVO = matcher;
			}
			return _matcherEntityRVO;
		}
	}

	public static IMatcher<SimEntity> SimTransform
	{
		get
		{
			if (_matcherSimTransform == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(72);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherSimTransform = matcher;
			}
			return _matcherSimTransform;
		}
	}

	public static IMatcher<SimEntity> Projectile
	{
		get
		{
			if (_matcherProjectile == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(65);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherProjectile = matcher;
			}
			return _matcherProjectile;
		}
	}

	public static IMatcher<SimEntity> EntityDetectable
	{
		get
		{
			if (_matcherEntityDetectable == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(33);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityDetectable = matcher;
			}
			return _matcherEntityDetectable;
		}
	}

	public static IMatcher<SimEntity> EntityHealth
	{
		get
		{
			if (_matcherEntityHealth == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(38);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityHealth = matcher;
			}
			return _matcherEntityHealth;
		}
	}

	public static IMatcher<SimEntity> EntityPositon
	{
		get
		{
			if (_matcherEntityPositon == null)
			{
				Matcher<SimEntity> matcher = (Matcher<SimEntity>)Matcher<SimEntity>.AllOf(45);
				matcher.componentNames = SimComponentsLookup.componentNames;
				_matcherEntityPositon = matcher;
			}
			return _matcherEntityPositon;
		}
	}

	public static IMatcher<SimEntity> PredictionMovement
	{
		get
		{
			if (mLocalMovement == null)
			{
				mLocalMovement = AllOf(EntityLocalPlayer, EntityActionMoveDirection);
			}
			return mLocalMovement;
		}
	}

	public static IMatcher<SimEntity> RemoteMovement
	{
		get
		{
			if (mRemoteMovement == null)
			{
				mRemoteMovement = AllOf(EntityRemotePlayer, EntityActionMoveDirection);
			}
			return mRemoteMovement;
		}
	}

	public static IMatcher<SimEntity> AIWithCamp
	{
		get
		{
			if (mAIWithCamp == null)
			{
				mAIWithCamp = AllOf(EntityCamp);
			}
			return mAIWithCamp;
		}
	}

	public static IMatcher<SimEntity> TriggerWithCollision
	{
		get
		{
			if (mTriggerMatcher == null)
			{
				mTriggerMatcher = AllOf(EntityBlackboard, EntityCamp, EntityPositon, EntityShape, EntityCollisionInfo);
			}
			return mTriggerMatcher;
		}
	}

	public static IMatcher<SimEntity> AIWithMovement
	{
		get
		{
			if (mAIWithMovement == null)
			{
				mAIWithMovement = AllOf(EntityActionMove);
			}
			return mAIWithMovement;
		}
	}

	public static IAllOfMatcher<SimEntity> AllOf(params int[] indices)
	{
		return Matcher<SimEntity>.AllOf(indices);
	}

	public static IAllOfMatcher<SimEntity> AllOf(params IMatcher<SimEntity>[] matchers)
	{
		return Matcher<SimEntity>.AllOf(matchers);
	}

	public static IAnyOfMatcher<SimEntity> AnyOf(params int[] indices)
	{
		return Matcher<SimEntity>.AnyOf(indices);
	}

	public static IAnyOfMatcher<SimEntity> AnyOf(params IMatcher<SimEntity>[] matchers)
	{
		return Matcher<SimEntity>.AnyOf(matchers);
	}
}

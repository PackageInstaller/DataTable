using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class RoleConfig : IMessage<RoleConfig>, IMessage, IEquatable<RoleConfig>, IDeepCloneable<RoleConfig>
{
	private static readonly MessageParser<RoleConfig> _parser = new MessageParser<RoleConfig>(() => new RoleConfig());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int FlowCavansIDFieldNumber = 2;

	private int flowCavansID_;

	public const int AdditionalRoleIDsFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_additionalRoleIDs_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> additionalRoleIDs_ = new RepeatedField<int>();

	public const int SameDamageSourceRoleIDsFieldNumber = 4;

	private int sameDamageSourceRoleIDs_;

	public const int ArmourCategoryFieldNumber = 5;

	private ArmourCategory armourCategory_;

	public const int ShapePartTypesFieldNumber = 6;

	private static readonly FieldCodec<ShapePartType> _repeated_shapePartTypes_codec = FieldCodec.ForEnum(50u, (ShapePartType x) => (int)x, (int x) => (ShapePartType)x);

	private readonly RepeatedField<ShapePartType> shapePartTypes_ = new RepeatedField<ShapePartType>();

	public const int ShapePartAttachPointFieldNumber = 7;

	private static readonly FieldCodec<string> _repeated_shapePartAttachPoint_codec = FieldCodec.ForString(58u);

	private readonly RepeatedField<string> shapePartAttachPoint_ = new RepeatedField<string>();

	public const int RadiusFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_radius_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> radius_ = new RepeatedField<int>();

	public const int ShapePartCollectionFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_shapePartCollection_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> shapePartCollection_ = new RepeatedField<int>();

	public const int DestroyValChangeRuleFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_destroyValChangeRule_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> destroyValChangeRule_ = new RepeatedField<int>();

	public const int DestroyValLimitFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_destroyValLimit_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> destroyValLimit_ = new RepeatedField<int>();

	public const int DeathTimeFieldNumber = 12;

	private DeathTimeType deathTime_;

	public const int MeleesFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_melees_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> melees_ = new RepeatedField<int>();

	public const int AbilityFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_ability_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> ability_ = new RepeatedField<int>();

	public const int RageAbilityFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_rageAbility_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> rageAbility_ = new RepeatedField<int>();

	public const int AvoidAbilityFieldNumber = 16;

	private static readonly FieldCodec<int> _repeated_avoidAbility_codec = FieldCodec.ForInt32(130u);

	private readonly RepeatedField<int> avoidAbility_ = new RepeatedField<int>();

	public const int UseRunMoveCurveFieldNumber = 17;

	private bool useRunMoveCurve_;

	public const int SpeedFieldNumber = 18;

	private int speed_;

	public const int HitRecoverIDFieldNumber = 19;

	private static readonly FieldCodec<int> _repeated_hitRecoverID_codec = FieldCodec.ForInt32(154u);

	private readonly RepeatedField<int> hitRecoverID_ = new RepeatedField<int>();

	public const int RoleHitBackRecoverIDFieldNumber = 20;

	private int roleHitBackRecoverID_;

	public const int HitBackRecoverIDFieldNumber = 21;

	private int hitBackRecoverID_;

	public const int HitAirIDFieldNumber = 22;

	private static readonly FieldCodec<int> _repeated_hitAirID_codec = FieldCodec.ForInt32(178u);

	private readonly RepeatedField<int> hitAirID_ = new RepeatedField<int>();

	public const int HitUpIDFieldNumber = 23;

	private int hitUpID_;

	public const int HitDownIDFieldNumber = 24;

	private int hitDownID_;

	public const int HitFloorIDFieldNumber = 25;

	private int hitFloorID_;

	public const int GetUpIDFieldNumber = 26;

	private int getUpID_;

	public const int QuickRecoveryFieldNumber = 27;

	private int quickRecovery_;

	public const int RunFieldNumber = 28;

	private int run_;

	public const int IdleFieldNumber = 29;

	private int idle_;

	public const int WeightFieldNumber = 30;

	private int weight_;

	public const int RunLeftFieldNumber = 31;

	private int runLeft_;

	public const int RunRightFieldNumber = 32;

	private int runRight_;

	public const int DeathFieldNumber = 33;

	private int death_;

	public const int NoAnimationDeathFieldNumber = 34;

	private int noAnimationDeath_;

	public const int AirDeathFieldNumber = 35;

	private int airDeath_;

	public const int FallDownDeathFieldNumber = 36;

	private int fallDownDeath_;

	public const int AppearFieldNumber = 37;

	private int appear_;

	public const int MovementStopFieldNumber = 38;

	private int movementStop_;

	public const int CanHitBackFieldNumber = 39;

	private bool canHitBack_;

	public const int CanHitUpFieldNumber = 40;

	private bool canHitUp_;

	public const int RushIDFieldNumber = 41;

	private int rushID_;

	public const int RushStopIDFieldNumber = 42;

	private int rushStopID_;

	public const int RushSpeedFieldNumber = 43;

	private int rushSpeed_;

	public const int HitBackValidTimeFieldNumber = 44;

	private static readonly FieldCodec<int> _repeated_hitBackValidTime_codec = FieldCodec.ForInt32(354u);

	private readonly RepeatedField<int> hitBackValidTime_ = new RepeatedField<int>();

	public const int BalanceValueFieldNumber = 45;

	private int balanceValue_;

	public const int ExtendAbilitiesFieldNumber = 46;

	private static readonly FieldCodec<int> _repeated_extendAbilities_codec = FieldCodec.ForInt32(370u);

	private readonly RepeatedField<int> extendAbilities_ = new RepeatedField<int>();

	public const int RelaxIDFieldNumber = 47;

	private int relaxID_;

	public const int RunStartFieldNumber = 48;

	private int runStart_;

	public const int BattleIldeRecoverFieldNumber = 49;

	private int battleIldeRecover_;

	public const int BattleIdleFieldNumber = 50;

	private int battleIdle_;

	public const int NearStopFieldNumber = 51;

	private int nearStop_;

	public const int RotationSpeedFieldNumber = 52;

	private int rotationSpeed_;

	public const int LimitTurnAngleFieldNumber = 53;

	private int limitTurnAngle_;

	public const int AllSkillsFieldNumber = 54;

	private static readonly FieldCodec<int> _repeated_allSkills_codec = FieldCodec.ForInt32(434u);

	private readonly RepeatedField<int> allSkills_ = new RepeatedField<int>();

	public const int MainDamageTypeFieldNumber = 55;

	private SkillDamageType mainDamageType_;

	public const int CanBeGrabFieldNumber = 56;

	private bool canBeGrab_;

	public const int KeepForwardFieldNumber = 57;

	private bool keepForward_;

	public const int CanMoveFieldNumber = 58;

	private bool canMove_;

	[DebuggerNonUserCode]
	public static MessageParser<RoleConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[48];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FlowCavansID
	{
		get
		{
			return flowCavansID_;
		}
		set
		{
			flowCavansID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AdditionalRoleIDs => additionalRoleIDs_;

	[DebuggerNonUserCode]
	public int SameDamageSourceRoleIDs
	{
		get
		{
			return sameDamageSourceRoleIDs_;
		}
		set
		{
			sameDamageSourceRoleIDs_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ArmourCategory ArmourCategory
	{
		get
		{
			return armourCategory_;
		}
		set
		{
			armourCategory_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<ShapePartType> ShapePartTypes => shapePartTypes_;

	[DebuggerNonUserCode]
	public RepeatedField<string> ShapePartAttachPoint => shapePartAttachPoint_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Radius => radius_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ShapePartCollection => shapePartCollection_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DestroyValChangeRule => destroyValChangeRule_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DestroyValLimit => destroyValLimit_;

	[DebuggerNonUserCode]
	public DeathTimeType DeathTime
	{
		get
		{
			return deathTime_;
		}
		set
		{
			deathTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Melees => melees_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Ability => ability_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RageAbility => rageAbility_;

	[DebuggerNonUserCode]
	public RepeatedField<int> AvoidAbility => avoidAbility_;

	[DebuggerNonUserCode]
	public bool UseRunMoveCurve
	{
		get
		{
			return useRunMoveCurve_;
		}
		set
		{
			useRunMoveCurve_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Speed
	{
		get
		{
			return speed_;
		}
		set
		{
			speed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> HitRecoverID => hitRecoverID_;

	[DebuggerNonUserCode]
	public int RoleHitBackRecoverID
	{
		get
		{
			return roleHitBackRecoverID_;
		}
		set
		{
			roleHitBackRecoverID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitBackRecoverID
	{
		get
		{
			return hitBackRecoverID_;
		}
		set
		{
			hitBackRecoverID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> HitAirID => hitAirID_;

	[DebuggerNonUserCode]
	public int HitUpID
	{
		get
		{
			return hitUpID_;
		}
		set
		{
			hitUpID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitDownID
	{
		get
		{
			return hitDownID_;
		}
		set
		{
			hitDownID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitFloorID
	{
		get
		{
			return hitFloorID_;
		}
		set
		{
			hitFloorID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GetUpID
	{
		get
		{
			return getUpID_;
		}
		set
		{
			getUpID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QuickRecovery
	{
		get
		{
			return quickRecovery_;
		}
		set
		{
			quickRecovery_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Run
	{
		get
		{
			return run_;
		}
		set
		{
			run_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Idle
	{
		get
		{
			return idle_;
		}
		set
		{
			idle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunLeft
	{
		get
		{
			return runLeft_;
		}
		set
		{
			runLeft_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunRight
	{
		get
		{
			return runRight_;
		}
		set
		{
			runRight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Death
	{
		get
		{
			return death_;
		}
		set
		{
			death_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NoAnimationDeath
	{
		get
		{
			return noAnimationDeath_;
		}
		set
		{
			noAnimationDeath_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AirDeath
	{
		get
		{
			return airDeath_;
		}
		set
		{
			airDeath_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FallDownDeath
	{
		get
		{
			return fallDownDeath_;
		}
		set
		{
			fallDownDeath_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Appear
	{
		get
		{
			return appear_;
		}
		set
		{
			appear_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovementStop
	{
		get
		{
			return movementStop_;
		}
		set
		{
			movementStop_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CanHitBack
	{
		get
		{
			return canHitBack_;
		}
		set
		{
			canHitBack_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CanHitUp
	{
		get
		{
			return canHitUp_;
		}
		set
		{
			canHitUp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RushID
	{
		get
		{
			return rushID_;
		}
		set
		{
			rushID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RushStopID
	{
		get
		{
			return rushStopID_;
		}
		set
		{
			rushStopID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RushSpeed
	{
		get
		{
			return rushSpeed_;
		}
		set
		{
			rushSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> HitBackValidTime => hitBackValidTime_;

	[DebuggerNonUserCode]
	public int BalanceValue
	{
		get
		{
			return balanceValue_;
		}
		set
		{
			balanceValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ExtendAbilities => extendAbilities_;

	[DebuggerNonUserCode]
	public int RelaxID
	{
		get
		{
			return relaxID_;
		}
		set
		{
			relaxID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunStart
	{
		get
		{
			return runStart_;
		}
		set
		{
			runStart_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleIldeRecover
	{
		get
		{
			return battleIldeRecover_;
		}
		set
		{
			battleIldeRecover_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleIdle
	{
		get
		{
			return battleIdle_;
		}
		set
		{
			battleIdle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NearStop
	{
		get
		{
			return nearStop_;
		}
		set
		{
			nearStop_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotationSpeed
	{
		get
		{
			return rotationSpeed_;
		}
		set
		{
			rotationSpeed_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LimitTurnAngle
	{
		get
		{
			return limitTurnAngle_;
		}
		set
		{
			limitTurnAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AllSkills => allSkills_;

	[DebuggerNonUserCode]
	public SkillDamageType MainDamageType
	{
		get
		{
			return mainDamageType_;
		}
		set
		{
			mainDamageType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CanBeGrab
	{
		get
		{
			return canBeGrab_;
		}
		set
		{
			canBeGrab_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool KeepForward
	{
		get
		{
			return keepForward_;
		}
		set
		{
			keepForward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CanMove
	{
		get
		{
			return canMove_;
		}
		set
		{
			canMove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RoleConfig()
	{
	}

	[DebuggerNonUserCode]
	public RoleConfig(RoleConfig other)
		: this()
	{
		iD_ = other.iD_;
		flowCavansID_ = other.flowCavansID_;
		additionalRoleIDs_ = other.additionalRoleIDs_.Clone();
		sameDamageSourceRoleIDs_ = other.sameDamageSourceRoleIDs_;
		armourCategory_ = other.armourCategory_;
		shapePartTypes_ = other.shapePartTypes_.Clone();
		shapePartAttachPoint_ = other.shapePartAttachPoint_.Clone();
		radius_ = other.radius_.Clone();
		shapePartCollection_ = other.shapePartCollection_.Clone();
		destroyValChangeRule_ = other.destroyValChangeRule_.Clone();
		destroyValLimit_ = other.destroyValLimit_.Clone();
		deathTime_ = other.deathTime_;
		melees_ = other.melees_.Clone();
		ability_ = other.ability_.Clone();
		rageAbility_ = other.rageAbility_.Clone();
		avoidAbility_ = other.avoidAbility_.Clone();
		useRunMoveCurve_ = other.useRunMoveCurve_;
		speed_ = other.speed_;
		hitRecoverID_ = other.hitRecoverID_.Clone();
		roleHitBackRecoverID_ = other.roleHitBackRecoverID_;
		hitBackRecoverID_ = other.hitBackRecoverID_;
		hitAirID_ = other.hitAirID_.Clone();
		hitUpID_ = other.hitUpID_;
		hitDownID_ = other.hitDownID_;
		hitFloorID_ = other.hitFloorID_;
		getUpID_ = other.getUpID_;
		quickRecovery_ = other.quickRecovery_;
		run_ = other.run_;
		idle_ = other.idle_;
		weight_ = other.weight_;
		runLeft_ = other.runLeft_;
		runRight_ = other.runRight_;
		death_ = other.death_;
		noAnimationDeath_ = other.noAnimationDeath_;
		airDeath_ = other.airDeath_;
		fallDownDeath_ = other.fallDownDeath_;
		appear_ = other.appear_;
		movementStop_ = other.movementStop_;
		canHitBack_ = other.canHitBack_;
		canHitUp_ = other.canHitUp_;
		rushID_ = other.rushID_;
		rushStopID_ = other.rushStopID_;
		rushSpeed_ = other.rushSpeed_;
		hitBackValidTime_ = other.hitBackValidTime_.Clone();
		balanceValue_ = other.balanceValue_;
		extendAbilities_ = other.extendAbilities_.Clone();
		relaxID_ = other.relaxID_;
		runStart_ = other.runStart_;
		battleIldeRecover_ = other.battleIldeRecover_;
		battleIdle_ = other.battleIdle_;
		nearStop_ = other.nearStop_;
		rotationSpeed_ = other.rotationSpeed_;
		limitTurnAngle_ = other.limitTurnAngle_;
		allSkills_ = other.allSkills_.Clone();
		mainDamageType_ = other.mainDamageType_;
		canBeGrab_ = other.canBeGrab_;
		keepForward_ = other.keepForward_;
		canMove_ = other.canMove_;
	}

	[DebuggerNonUserCode]
	public RoleConfig Clone()
	{
		return new RoleConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RoleConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(RoleConfig other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (FlowCavansID != other.FlowCavansID)
		{
			return false;
		}
		if (!additionalRoleIDs_.Equals(other.additionalRoleIDs_))
		{
			return false;
		}
		if (SameDamageSourceRoleIDs != other.SameDamageSourceRoleIDs)
		{
			return false;
		}
		if (ArmourCategory != other.ArmourCategory)
		{
			return false;
		}
		if (!shapePartTypes_.Equals(other.shapePartTypes_))
		{
			return false;
		}
		if (!shapePartAttachPoint_.Equals(other.shapePartAttachPoint_))
		{
			return false;
		}
		if (!radius_.Equals(other.radius_))
		{
			return false;
		}
		if (!shapePartCollection_.Equals(other.shapePartCollection_))
		{
			return false;
		}
		if (!destroyValChangeRule_.Equals(other.destroyValChangeRule_))
		{
			return false;
		}
		if (!destroyValLimit_.Equals(other.destroyValLimit_))
		{
			return false;
		}
		if (DeathTime != other.DeathTime)
		{
			return false;
		}
		if (!melees_.Equals(other.melees_))
		{
			return false;
		}
		if (!ability_.Equals(other.ability_))
		{
			return false;
		}
		if (!rageAbility_.Equals(other.rageAbility_))
		{
			return false;
		}
		if (!avoidAbility_.Equals(other.avoidAbility_))
		{
			return false;
		}
		if (UseRunMoveCurve != other.UseRunMoveCurve)
		{
			return false;
		}
		if (Speed != other.Speed)
		{
			return false;
		}
		if (!hitRecoverID_.Equals(other.hitRecoverID_))
		{
			return false;
		}
		if (RoleHitBackRecoverID != other.RoleHitBackRecoverID)
		{
			return false;
		}
		if (HitBackRecoverID != other.HitBackRecoverID)
		{
			return false;
		}
		if (!hitAirID_.Equals(other.hitAirID_))
		{
			return false;
		}
		if (HitUpID != other.HitUpID)
		{
			return false;
		}
		if (HitDownID != other.HitDownID)
		{
			return false;
		}
		if (HitFloorID != other.HitFloorID)
		{
			return false;
		}
		if (GetUpID != other.GetUpID)
		{
			return false;
		}
		if (QuickRecovery != other.QuickRecovery)
		{
			return false;
		}
		if (Run != other.Run)
		{
			return false;
		}
		if (Idle != other.Idle)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (RunLeft != other.RunLeft)
		{
			return false;
		}
		if (RunRight != other.RunRight)
		{
			return false;
		}
		if (Death != other.Death)
		{
			return false;
		}
		if (NoAnimationDeath != other.NoAnimationDeath)
		{
			return false;
		}
		if (AirDeath != other.AirDeath)
		{
			return false;
		}
		if (FallDownDeath != other.FallDownDeath)
		{
			return false;
		}
		if (Appear != other.Appear)
		{
			return false;
		}
		if (MovementStop != other.MovementStop)
		{
			return false;
		}
		if (CanHitBack != other.CanHitBack)
		{
			return false;
		}
		if (CanHitUp != other.CanHitUp)
		{
			return false;
		}
		if (RushID != other.RushID)
		{
			return false;
		}
		if (RushStopID != other.RushStopID)
		{
			return false;
		}
		if (RushSpeed != other.RushSpeed)
		{
			return false;
		}
		if (!hitBackValidTime_.Equals(other.hitBackValidTime_))
		{
			return false;
		}
		if (BalanceValue != other.BalanceValue)
		{
			return false;
		}
		if (!extendAbilities_.Equals(other.extendAbilities_))
		{
			return false;
		}
		if (RelaxID != other.RelaxID)
		{
			return false;
		}
		if (RunStart != other.RunStart)
		{
			return false;
		}
		if (BattleIldeRecover != other.BattleIldeRecover)
		{
			return false;
		}
		if (BattleIdle != other.BattleIdle)
		{
			return false;
		}
		if (NearStop != other.NearStop)
		{
			return false;
		}
		if (RotationSpeed != other.RotationSpeed)
		{
			return false;
		}
		if (LimitTurnAngle != other.LimitTurnAngle)
		{
			return false;
		}
		if (!allSkills_.Equals(other.allSkills_))
		{
			return false;
		}
		if (MainDamageType != other.MainDamageType)
		{
			return false;
		}
		if (CanBeGrab != other.CanBeGrab)
		{
			return false;
		}
		if (KeepForward != other.KeepForward)
		{
			return false;
		}
		if (CanMove != other.CanMove)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (FlowCavansID != 0)
		{
			num ^= FlowCavansID.GetHashCode();
		}
		num ^= additionalRoleIDs_.GetHashCode();
		if (SameDamageSourceRoleIDs != 0)
		{
			num ^= SameDamageSourceRoleIDs.GetHashCode();
		}
		if (ArmourCategory != ArmourCategory.None)
		{
			num ^= ArmourCategory.GetHashCode();
		}
		num ^= shapePartTypes_.GetHashCode();
		num ^= shapePartAttachPoint_.GetHashCode();
		num ^= radius_.GetHashCode();
		num ^= shapePartCollection_.GetHashCode();
		num ^= destroyValChangeRule_.GetHashCode();
		num ^= destroyValLimit_.GetHashCode();
		if (DeathTime != DeathTimeType.ImmediatelyDeath)
		{
			num ^= DeathTime.GetHashCode();
		}
		num ^= melees_.GetHashCode();
		num ^= ability_.GetHashCode();
		num ^= rageAbility_.GetHashCode();
		num ^= avoidAbility_.GetHashCode();
		if (UseRunMoveCurve)
		{
			num ^= UseRunMoveCurve.GetHashCode();
		}
		if (Speed != 0)
		{
			num ^= Speed.GetHashCode();
		}
		num ^= hitRecoverID_.GetHashCode();
		if (RoleHitBackRecoverID != 0)
		{
			num ^= RoleHitBackRecoverID.GetHashCode();
		}
		if (HitBackRecoverID != 0)
		{
			num ^= HitBackRecoverID.GetHashCode();
		}
		num ^= hitAirID_.GetHashCode();
		if (HitUpID != 0)
		{
			num ^= HitUpID.GetHashCode();
		}
		if (HitDownID != 0)
		{
			num ^= HitDownID.GetHashCode();
		}
		if (HitFloorID != 0)
		{
			num ^= HitFloorID.GetHashCode();
		}
		if (GetUpID != 0)
		{
			num ^= GetUpID.GetHashCode();
		}
		if (QuickRecovery != 0)
		{
			num ^= QuickRecovery.GetHashCode();
		}
		if (Run != 0)
		{
			num ^= Run.GetHashCode();
		}
		if (Idle != 0)
		{
			num ^= Idle.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (RunLeft != 0)
		{
			num ^= RunLeft.GetHashCode();
		}
		if (RunRight != 0)
		{
			num ^= RunRight.GetHashCode();
		}
		if (Death != 0)
		{
			num ^= Death.GetHashCode();
		}
		if (NoAnimationDeath != 0)
		{
			num ^= NoAnimationDeath.GetHashCode();
		}
		if (AirDeath != 0)
		{
			num ^= AirDeath.GetHashCode();
		}
		if (FallDownDeath != 0)
		{
			num ^= FallDownDeath.GetHashCode();
		}
		if (Appear != 0)
		{
			num ^= Appear.GetHashCode();
		}
		if (MovementStop != 0)
		{
			num ^= MovementStop.GetHashCode();
		}
		if (CanHitBack)
		{
			num ^= CanHitBack.GetHashCode();
		}
		if (CanHitUp)
		{
			num ^= CanHitUp.GetHashCode();
		}
		if (RushID != 0)
		{
			num ^= RushID.GetHashCode();
		}
		if (RushStopID != 0)
		{
			num ^= RushStopID.GetHashCode();
		}
		if (RushSpeed != 0)
		{
			num ^= RushSpeed.GetHashCode();
		}
		num ^= hitBackValidTime_.GetHashCode();
		if (BalanceValue != 0)
		{
			num ^= BalanceValue.GetHashCode();
		}
		num ^= extendAbilities_.GetHashCode();
		if (RelaxID != 0)
		{
			num ^= RelaxID.GetHashCode();
		}
		if (RunStart != 0)
		{
			num ^= RunStart.GetHashCode();
		}
		if (BattleIldeRecover != 0)
		{
			num ^= BattleIldeRecover.GetHashCode();
		}
		if (BattleIdle != 0)
		{
			num ^= BattleIdle.GetHashCode();
		}
		if (NearStop != 0)
		{
			num ^= NearStop.GetHashCode();
		}
		if (RotationSpeed != 0)
		{
			num ^= RotationSpeed.GetHashCode();
		}
		if (LimitTurnAngle != 0)
		{
			num ^= LimitTurnAngle.GetHashCode();
		}
		num ^= allSkills_.GetHashCode();
		if (MainDamageType != SkillDamageType.Physics)
		{
			num ^= MainDamageType.GetHashCode();
		}
		if (CanBeGrab)
		{
			num ^= CanBeGrab.GetHashCode();
		}
		if (KeepForward)
		{
			num ^= KeepForward.GetHashCode();
		}
		if (CanMove)
		{
			num ^= CanMove.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (FlowCavansID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(FlowCavansID);
		}
		additionalRoleIDs_.WriteTo(output, _repeated_additionalRoleIDs_codec);
		if (SameDamageSourceRoleIDs != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SameDamageSourceRoleIDs);
		}
		if (ArmourCategory != ArmourCategory.None)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)ArmourCategory);
		}
		shapePartTypes_.WriteTo(output, _repeated_shapePartTypes_codec);
		shapePartAttachPoint_.WriteTo(output, _repeated_shapePartAttachPoint_codec);
		radius_.WriteTo(output, _repeated_radius_codec);
		shapePartCollection_.WriteTo(output, _repeated_shapePartCollection_codec);
		destroyValChangeRule_.WriteTo(output, _repeated_destroyValChangeRule_codec);
		destroyValLimit_.WriteTo(output, _repeated_destroyValLimit_codec);
		if (DeathTime != DeathTimeType.ImmediatelyDeath)
		{
			output.WriteRawTag(96);
			output.WriteEnum((int)DeathTime);
		}
		melees_.WriteTo(output, _repeated_melees_codec);
		ability_.WriteTo(output, _repeated_ability_codec);
		rageAbility_.WriteTo(output, _repeated_rageAbility_codec);
		avoidAbility_.WriteTo(output, _repeated_avoidAbility_codec);
		if (UseRunMoveCurve)
		{
			output.WriteRawTag(136, 1);
			output.WriteBool(UseRunMoveCurve);
		}
		if (Speed != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(Speed);
		}
		hitRecoverID_.WriteTo(output, _repeated_hitRecoverID_codec);
		if (RoleHitBackRecoverID != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(RoleHitBackRecoverID);
		}
		if (HitBackRecoverID != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(HitBackRecoverID);
		}
		hitAirID_.WriteTo(output, _repeated_hitAirID_codec);
		if (HitUpID != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(HitUpID);
		}
		if (HitDownID != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(HitDownID);
		}
		if (HitFloorID != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(HitFloorID);
		}
		if (GetUpID != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(GetUpID);
		}
		if (QuickRecovery != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(QuickRecovery);
		}
		if (Run != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(Run);
		}
		if (Idle != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(Idle);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(Weight);
		}
		if (RunLeft != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(RunLeft);
		}
		if (RunRight != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(RunRight);
		}
		if (Death != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(Death);
		}
		if (NoAnimationDeath != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(NoAnimationDeath);
		}
		if (AirDeath != 0)
		{
			output.WriteRawTag(152, 2);
			output.WriteInt32(AirDeath);
		}
		if (FallDownDeath != 0)
		{
			output.WriteRawTag(160, 2);
			output.WriteInt32(FallDownDeath);
		}
		if (Appear != 0)
		{
			output.WriteRawTag(168, 2);
			output.WriteInt32(Appear);
		}
		if (MovementStop != 0)
		{
			output.WriteRawTag(176, 2);
			output.WriteInt32(MovementStop);
		}
		if (CanHitBack)
		{
			output.WriteRawTag(184, 2);
			output.WriteBool(CanHitBack);
		}
		if (CanHitUp)
		{
			output.WriteRawTag(192, 2);
			output.WriteBool(CanHitUp);
		}
		if (RushID != 0)
		{
			output.WriteRawTag(200, 2);
			output.WriteInt32(RushID);
		}
		if (RushStopID != 0)
		{
			output.WriteRawTag(208, 2);
			output.WriteInt32(RushStopID);
		}
		if (RushSpeed != 0)
		{
			output.WriteRawTag(216, 2);
			output.WriteInt32(RushSpeed);
		}
		hitBackValidTime_.WriteTo(output, _repeated_hitBackValidTime_codec);
		if (BalanceValue != 0)
		{
			output.WriteRawTag(232, 2);
			output.WriteInt32(BalanceValue);
		}
		extendAbilities_.WriteTo(output, _repeated_extendAbilities_codec);
		if (RelaxID != 0)
		{
			output.WriteRawTag(248, 2);
			output.WriteInt32(RelaxID);
		}
		if (RunStart != 0)
		{
			output.WriteRawTag(128, 3);
			output.WriteInt32(RunStart);
		}
		if (BattleIldeRecover != 0)
		{
			output.WriteRawTag(136, 3);
			output.WriteInt32(BattleIldeRecover);
		}
		if (BattleIdle != 0)
		{
			output.WriteRawTag(144, 3);
			output.WriteInt32(BattleIdle);
		}
		if (NearStop != 0)
		{
			output.WriteRawTag(152, 3);
			output.WriteInt32(NearStop);
		}
		if (RotationSpeed != 0)
		{
			output.WriteRawTag(160, 3);
			output.WriteInt32(RotationSpeed);
		}
		if (LimitTurnAngle != 0)
		{
			output.WriteRawTag(168, 3);
			output.WriteInt32(LimitTurnAngle);
		}
		allSkills_.WriteTo(output, _repeated_allSkills_codec);
		if (MainDamageType != SkillDamageType.Physics)
		{
			output.WriteRawTag(184, 3);
			output.WriteEnum((int)MainDamageType);
		}
		if (CanBeGrab)
		{
			output.WriteRawTag(192, 3);
			output.WriteBool(CanBeGrab);
		}
		if (KeepForward)
		{
			output.WriteRawTag(200, 3);
			output.WriteBool(KeepForward);
		}
		if (CanMove)
		{
			output.WriteRawTag(208, 3);
			output.WriteBool(CanMove);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (FlowCavansID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FlowCavansID);
		}
		num += additionalRoleIDs_.CalculateSize(_repeated_additionalRoleIDs_codec);
		if (SameDamageSourceRoleIDs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SameDamageSourceRoleIDs);
		}
		if (ArmourCategory != ArmourCategory.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)ArmourCategory);
		}
		num += shapePartTypes_.CalculateSize(_repeated_shapePartTypes_codec);
		num += shapePartAttachPoint_.CalculateSize(_repeated_shapePartAttachPoint_codec);
		num += radius_.CalculateSize(_repeated_radius_codec);
		num += shapePartCollection_.CalculateSize(_repeated_shapePartCollection_codec);
		num += destroyValChangeRule_.CalculateSize(_repeated_destroyValChangeRule_codec);
		num += destroyValLimit_.CalculateSize(_repeated_destroyValLimit_codec);
		if (DeathTime != DeathTimeType.ImmediatelyDeath)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)DeathTime);
		}
		num += melees_.CalculateSize(_repeated_melees_codec);
		num += ability_.CalculateSize(_repeated_ability_codec);
		num += rageAbility_.CalculateSize(_repeated_rageAbility_codec);
		num += avoidAbility_.CalculateSize(_repeated_avoidAbility_codec);
		if (UseRunMoveCurve)
		{
			num += 3;
		}
		if (Speed != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Speed);
		}
		num += hitRecoverID_.CalculateSize(_repeated_hitRecoverID_codec);
		if (RoleHitBackRecoverID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RoleHitBackRecoverID);
		}
		if (HitBackRecoverID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitBackRecoverID);
		}
		num += hitAirID_.CalculateSize(_repeated_hitAirID_codec);
		if (HitUpID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitUpID);
		}
		if (HitDownID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitDownID);
		}
		if (HitFloorID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitFloorID);
		}
		if (GetUpID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GetUpID);
		}
		if (QuickRecovery != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(QuickRecovery);
		}
		if (Run != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Run);
		}
		if (Idle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Idle);
		}
		if (Weight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (RunLeft != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RunLeft);
		}
		if (RunRight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RunRight);
		}
		if (Death != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Death);
		}
		if (NoAnimationDeath != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NoAnimationDeath);
		}
		if (AirDeath != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AirDeath);
		}
		if (FallDownDeath != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FallDownDeath);
		}
		if (Appear != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Appear);
		}
		if (MovementStop != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MovementStop);
		}
		if (CanHitBack)
		{
			num += 3;
		}
		if (CanHitUp)
		{
			num += 3;
		}
		if (RushID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RushID);
		}
		if (RushStopID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RushStopID);
		}
		if (RushSpeed != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RushSpeed);
		}
		num += hitBackValidTime_.CalculateSize(_repeated_hitBackValidTime_codec);
		if (BalanceValue != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BalanceValue);
		}
		num += extendAbilities_.CalculateSize(_repeated_extendAbilities_codec);
		if (RelaxID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RelaxID);
		}
		if (RunStart != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RunStart);
		}
		if (BattleIldeRecover != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BattleIldeRecover);
		}
		if (BattleIdle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BattleIdle);
		}
		if (NearStop != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NearStop);
		}
		if (RotationSpeed != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotationSpeed);
		}
		if (LimitTurnAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LimitTurnAngle);
		}
		num += allSkills_.CalculateSize(_repeated_allSkills_codec);
		if (MainDamageType != SkillDamageType.Physics)
		{
			num += 2 + CodedOutputStream.ComputeEnumSize((int)MainDamageType);
		}
		if (CanBeGrab)
		{
			num += 3;
		}
		if (KeepForward)
		{
			num += 3;
		}
		if (CanMove)
		{
			num += 3;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RoleConfig other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.FlowCavansID != 0)
			{
				FlowCavansID = other.FlowCavansID;
			}
			additionalRoleIDs_.Add(other.additionalRoleIDs_);
			if (other.SameDamageSourceRoleIDs != 0)
			{
				SameDamageSourceRoleIDs = other.SameDamageSourceRoleIDs;
			}
			if (other.ArmourCategory != ArmourCategory.None)
			{
				ArmourCategory = other.ArmourCategory;
			}
			shapePartTypes_.Add(other.shapePartTypes_);
			shapePartAttachPoint_.Add(other.shapePartAttachPoint_);
			radius_.Add(other.radius_);
			shapePartCollection_.Add(other.shapePartCollection_);
			destroyValChangeRule_.Add(other.destroyValChangeRule_);
			destroyValLimit_.Add(other.destroyValLimit_);
			if (other.DeathTime != DeathTimeType.ImmediatelyDeath)
			{
				DeathTime = other.DeathTime;
			}
			melees_.Add(other.melees_);
			ability_.Add(other.ability_);
			rageAbility_.Add(other.rageAbility_);
			avoidAbility_.Add(other.avoidAbility_);
			if (other.UseRunMoveCurve)
			{
				UseRunMoveCurve = other.UseRunMoveCurve;
			}
			if (other.Speed != 0)
			{
				Speed = other.Speed;
			}
			hitRecoverID_.Add(other.hitRecoverID_);
			if (other.RoleHitBackRecoverID != 0)
			{
				RoleHitBackRecoverID = other.RoleHitBackRecoverID;
			}
			if (other.HitBackRecoverID != 0)
			{
				HitBackRecoverID = other.HitBackRecoverID;
			}
			hitAirID_.Add(other.hitAirID_);
			if (other.HitUpID != 0)
			{
				HitUpID = other.HitUpID;
			}
			if (other.HitDownID != 0)
			{
				HitDownID = other.HitDownID;
			}
			if (other.HitFloorID != 0)
			{
				HitFloorID = other.HitFloorID;
			}
			if (other.GetUpID != 0)
			{
				GetUpID = other.GetUpID;
			}
			if (other.QuickRecovery != 0)
			{
				QuickRecovery = other.QuickRecovery;
			}
			if (other.Run != 0)
			{
				Run = other.Run;
			}
			if (other.Idle != 0)
			{
				Idle = other.Idle;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.RunLeft != 0)
			{
				RunLeft = other.RunLeft;
			}
			if (other.RunRight != 0)
			{
				RunRight = other.RunRight;
			}
			if (other.Death != 0)
			{
				Death = other.Death;
			}
			if (other.NoAnimationDeath != 0)
			{
				NoAnimationDeath = other.NoAnimationDeath;
			}
			if (other.AirDeath != 0)
			{
				AirDeath = other.AirDeath;
			}
			if (other.FallDownDeath != 0)
			{
				FallDownDeath = other.FallDownDeath;
			}
			if (other.Appear != 0)
			{
				Appear = other.Appear;
			}
			if (other.MovementStop != 0)
			{
				MovementStop = other.MovementStop;
			}
			if (other.CanHitBack)
			{
				CanHitBack = other.CanHitBack;
			}
			if (other.CanHitUp)
			{
				CanHitUp = other.CanHitUp;
			}
			if (other.RushID != 0)
			{
				RushID = other.RushID;
			}
			if (other.RushStopID != 0)
			{
				RushStopID = other.RushStopID;
			}
			if (other.RushSpeed != 0)
			{
				RushSpeed = other.RushSpeed;
			}
			hitBackValidTime_.Add(other.hitBackValidTime_);
			if (other.BalanceValue != 0)
			{
				BalanceValue = other.BalanceValue;
			}
			extendAbilities_.Add(other.extendAbilities_);
			if (other.RelaxID != 0)
			{
				RelaxID = other.RelaxID;
			}
			if (other.RunStart != 0)
			{
				RunStart = other.RunStart;
			}
			if (other.BattleIldeRecover != 0)
			{
				BattleIldeRecover = other.BattleIldeRecover;
			}
			if (other.BattleIdle != 0)
			{
				BattleIdle = other.BattleIdle;
			}
			if (other.NearStop != 0)
			{
				NearStop = other.NearStop;
			}
			if (other.RotationSpeed != 0)
			{
				RotationSpeed = other.RotationSpeed;
			}
			if (other.LimitTurnAngle != 0)
			{
				LimitTurnAngle = other.LimitTurnAngle;
			}
			allSkills_.Add(other.allSkills_);
			if (other.MainDamageType != SkillDamageType.Physics)
			{
				MainDamageType = other.MainDamageType;
			}
			if (other.CanBeGrab)
			{
				CanBeGrab = other.CanBeGrab;
			}
			if (other.KeepForward)
			{
				KeepForward = other.KeepForward;
			}
			if (other.CanMove)
			{
				CanMove = other.CanMove;
			}
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				FlowCavansID = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				additionalRoleIDs_.AddEntriesFrom(input, _repeated_additionalRoleIDs_codec);
				break;
			case 32u:
				SameDamageSourceRoleIDs = input.ReadInt32();
				break;
			case 40u:
				armourCategory_ = (ArmourCategory)input.ReadEnum();
				break;
			case 48u:
			case 50u:
				shapePartTypes_.AddEntriesFrom(input, _repeated_shapePartTypes_codec);
				break;
			case 58u:
				shapePartAttachPoint_.AddEntriesFrom(input, _repeated_shapePartAttachPoint_codec);
				break;
			case 64u:
			case 66u:
				radius_.AddEntriesFrom(input, _repeated_radius_codec);
				break;
			case 72u:
			case 74u:
				shapePartCollection_.AddEntriesFrom(input, _repeated_shapePartCollection_codec);
				break;
			case 80u:
			case 82u:
				destroyValChangeRule_.AddEntriesFrom(input, _repeated_destroyValChangeRule_codec);
				break;
			case 88u:
			case 90u:
				destroyValLimit_.AddEntriesFrom(input, _repeated_destroyValLimit_codec);
				break;
			case 96u:
				deathTime_ = (DeathTimeType)input.ReadEnum();
				break;
			case 104u:
			case 106u:
				melees_.AddEntriesFrom(input, _repeated_melees_codec);
				break;
			case 112u:
			case 114u:
				ability_.AddEntriesFrom(input, _repeated_ability_codec);
				break;
			case 120u:
			case 122u:
				rageAbility_.AddEntriesFrom(input, _repeated_rageAbility_codec);
				break;
			case 128u:
			case 130u:
				avoidAbility_.AddEntriesFrom(input, _repeated_avoidAbility_codec);
				break;
			case 136u:
				UseRunMoveCurve = input.ReadBool();
				break;
			case 144u:
				Speed = input.ReadInt32();
				break;
			case 152u:
			case 154u:
				hitRecoverID_.AddEntriesFrom(input, _repeated_hitRecoverID_codec);
				break;
			case 160u:
				RoleHitBackRecoverID = input.ReadInt32();
				break;
			case 168u:
				HitBackRecoverID = input.ReadInt32();
				break;
			case 176u:
			case 178u:
				hitAirID_.AddEntriesFrom(input, _repeated_hitAirID_codec);
				break;
			case 184u:
				HitUpID = input.ReadInt32();
				break;
			case 192u:
				HitDownID = input.ReadInt32();
				break;
			case 200u:
				HitFloorID = input.ReadInt32();
				break;
			case 208u:
				GetUpID = input.ReadInt32();
				break;
			case 216u:
				QuickRecovery = input.ReadInt32();
				break;
			case 224u:
				Run = input.ReadInt32();
				break;
			case 232u:
				Idle = input.ReadInt32();
				break;
			case 240u:
				Weight = input.ReadInt32();
				break;
			case 248u:
				RunLeft = input.ReadInt32();
				break;
			case 256u:
				RunRight = input.ReadInt32();
				break;
			case 264u:
				Death = input.ReadInt32();
				break;
			case 272u:
				NoAnimationDeath = input.ReadInt32();
				break;
			case 280u:
				AirDeath = input.ReadInt32();
				break;
			case 288u:
				FallDownDeath = input.ReadInt32();
				break;
			case 296u:
				Appear = input.ReadInt32();
				break;
			case 304u:
				MovementStop = input.ReadInt32();
				break;
			case 312u:
				CanHitBack = input.ReadBool();
				break;
			case 320u:
				CanHitUp = input.ReadBool();
				break;
			case 328u:
				RushID = input.ReadInt32();
				break;
			case 336u:
				RushStopID = input.ReadInt32();
				break;
			case 344u:
				RushSpeed = input.ReadInt32();
				break;
			case 352u:
			case 354u:
				hitBackValidTime_.AddEntriesFrom(input, _repeated_hitBackValidTime_codec);
				break;
			case 360u:
				BalanceValue = input.ReadInt32();
				break;
			case 368u:
			case 370u:
				extendAbilities_.AddEntriesFrom(input, _repeated_extendAbilities_codec);
				break;
			case 376u:
				RelaxID = input.ReadInt32();
				break;
			case 384u:
				RunStart = input.ReadInt32();
				break;
			case 392u:
				BattleIldeRecover = input.ReadInt32();
				break;
			case 400u:
				BattleIdle = input.ReadInt32();
				break;
			case 408u:
				NearStop = input.ReadInt32();
				break;
			case 416u:
				RotationSpeed = input.ReadInt32();
				break;
			case 424u:
				LimitTurnAngle = input.ReadInt32();
				break;
			case 432u:
			case 434u:
				allSkills_.AddEntriesFrom(input, _repeated_allSkills_codec);
				break;
			case 440u:
				mainDamageType_ = (SkillDamageType)input.ReadEnum();
				break;
			case 448u:
				CanBeGrab = input.ReadBool();
				break;
			case 456u:
				KeepForward = input.ReadBool();
				break;
			case 464u:
				CanMove = input.ReadBool();
				break;
			}
		}
	}
}

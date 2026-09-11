using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Timeline : IMessage<Timeline>, IMessage, IEquatable<Timeline>, IDeepCloneable<Timeline>
{
	private static readonly MessageParser<Timeline> _parser = new MessageParser<Timeline>(() => new Timeline());

	public const int TICKINTERVALFieldNumber = 1;

	private int tICKINTERVAL_;

	public const int IDFieldNumber = 2;

	private int iD_;

	public const int IsLoopFieldNumber = 3;

	private bool isLoop_;

	public const int DurationFieldNumber = 4;

	private int duration_;

	public const int RecoverTimeFieldNumber = 5;

	private int recoverTime_;

	public const int ComboOverTimeFieldNumber = 6;

	private int comboOverTime_;

	public const int IsFinalActionFieldNumber = 7;

	private bool isFinalAction_;

	public const int IsNeedLockFieldNumber = 8;

	private bool isNeedLock_;

	public const int LockRootMotionXFieldNumber = 9;

	private bool lockRootMotionX_;

	public const int IsUseConfigYFieldNumber = 10;

	private bool isUseConfigY_;

	public const int IsUseConfigXFieldNumber = 11;

	private bool isUseConfigX_;

	public const int ThrownCollidGraphFieldNumber = 12;

	private bool thrownCollidGraph_;

	public const int ThrownCanOutRangeFieldNumber = 13;

	private bool thrownCanOutRange_;

	public const int ThrownOutRangeSpawnIDFieldNumber = 14;

	private int thrownOutRangeSpawnID_;

	public const int ThrownDestroyByObstacleFieldNumber = 15;

	private bool thrownDestroyByObstacle_;

	public const int ThrownSpawnChildIDFieldNumber = 16;

	private int thrownSpawnChildID_;

	public const int ArrivedCreateThrownTimelineIDFieldNumber = 17;

	private int arrivedCreateThrownTimelineID_;

	public const int IsDependCasterForThrownFieldNumber = 18;

	private bool isDependCasterForThrown_;

	public const int UseTangentMoveFieldNumber = 19;

	private bool useTangentMove_;

	public const int UseDefaultCameraFieldNumber = 20;

	private bool useDefaultCamera_;

	public const int UseCameraMoveFieldNumber = 21;

	private bool useCameraMove_;

	public const int TransformActionInfoFieldNumber = 22;

	private TransformActionInfo transformActionInfo_;

	public const int SwitchQTECameraTimeAsTeammateFieldNumber = 23;

	private int switchQTECameraTimeAsTeammate_;

	public const int IsCustomAttackPointFieldNumber = 24;

	private bool isCustomAttackPoint_;

	public const int CustomAttackPointDistanceFieldNumber = 25;

	private int customAttackPointDistance_;

	public const int CDCompensationListFieldNumber = 26;

	private static readonly FieldCodec<CDCompensationInfo> _repeated_cDCompensationList_codec = FieldCodec.ForMessage(210u, CDCompensationInfo.Parser);

	private readonly RepeatedField<CDCompensationInfo> cDCompensationList_ = new RepeatedField<CDCompensationInfo>();

	public const int PostSpwanThrownEventsFieldNumber = 27;

	private static readonly FieldCodec<PostSpwanThrownEventInfo> _repeated_postSpwanThrownEvents_codec = FieldCodec.ForMessage(218u, PostSpwanThrownEventInfo.Parser);

	private readonly RepeatedField<PostSpwanThrownEventInfo> postSpwanThrownEvents_ = new RepeatedField<PostSpwanThrownEventInfo>();

	public const int PostDespownThronEventsFieldNumber = 28;

	private static readonly FieldCodec<PostDespawnThrownEventInfo> _repeated_postDespownThronEvents_codec = FieldCodec.ForMessage(226u, PostDespawnThrownEventInfo.Parser);

	private readonly RepeatedField<PostDespawnThrownEventInfo> postDespownThronEvents_ = new RepeatedField<PostDespawnThrownEventInfo>();

	public const int HitTimeListFieldNumber = 29;

	private static readonly FieldCodec<HitCheckInfo> _repeated_hitTimeList_codec = FieldCodec.ForMessage(234u, HitCheckInfo.Parser);

	private readonly RepeatedField<HitCheckInfo> hitTimeList_ = new RepeatedField<HitCheckInfo>();

	public const int MoveActionTimelineNodeFieldNumber = 30;

	private MoveActionTimelineNode moveActionTimelineNode_;

	public const int InputActionTimelineNodeFieldNumber = 31;

	private InputActionTimelineNode inputActionTimelineNode_;

	public const int LockAcionListFieldNumber = 32;

	private static readonly FieldCodec<LockActionNode> _repeated_lockAcionList_codec = FieldCodec.ForMessage(258u, LockActionNode.Parser);

	private readonly RepeatedField<LockActionNode> lockAcionList_ = new RepeatedField<LockActionNode>();

	public const int ThrownCollisionCheckInfoListFieldNumber = 33;

	private static readonly FieldCodec<ThrownCollisionCheckInfo> _repeated_thrownCollisionCheckInfoList_codec = FieldCodec.ForMessage(266u, ThrownCollisionCheckInfo.Parser);

	private readonly RepeatedField<ThrownCollisionCheckInfo> thrownCollisionCheckInfoList_ = new RepeatedField<ThrownCollisionCheckInfo>();

	public const int ThrownLockActionInfoListFieldNumber = 34;

	private static readonly FieldCodec<ThrownLockActionInfo> _repeated_thrownLockActionInfoList_codec = FieldCodec.ForMessage(274u, ThrownLockActionInfo.Parser);

	private readonly RepeatedField<ThrownLockActionInfo> thrownLockActionInfoList_ = new RepeatedField<ThrownLockActionInfo>();

	public const int CameraTypeInfoListFieldNumber = 35;

	private static readonly FieldCodec<CameraTypeInfo> _repeated_cameraTypeInfoList_codec = FieldCodec.ForMessage(282u, CameraTypeInfo.Parser);

	private readonly RepeatedField<CameraTypeInfo> cameraTypeInfoList_ = new RepeatedField<CameraTypeInfo>();

	public const int ThrownBackActionInfoListFieldNumber = 36;

	private static readonly FieldCodec<ThrownBackActionInfo> _repeated_thrownBackActionInfoList_codec = FieldCodec.ForMessage(290u, ThrownBackActionInfo.Parser);

	private readonly RepeatedField<ThrownBackActionInfo> thrownBackActionInfoList_ = new RepeatedField<ThrownBackActionInfo>();

	public const int ShapeEnableInfoListFieldNumber = 37;

	private static readonly FieldCodec<ShapeEnableInfo> _repeated_shapeEnableInfoList_codec = FieldCodec.ForMessage(298u, ShapeEnableInfo.Parser);

	private readonly RepeatedField<ShapeEnableInfo> shapeEnableInfoList_ = new RepeatedField<ShapeEnableInfo>();

	public const int AbilityStateInfoListFieldNumber = 38;

	private static readonly FieldCodec<AbilityStateInfo> _repeated_abilityStateInfoList_codec = FieldCodec.ForMessage(306u, AbilityStateInfo.Parser);

	private readonly RepeatedField<AbilityStateInfo> abilityStateInfoList_ = new RepeatedField<AbilityStateInfo>();

	public const int AbilitySpeedInfoListFieldNumber = 39;

	private static readonly FieldCodec<AbilitySpeedInfo> _repeated_abilitySpeedInfoList_codec = FieldCodec.ForMessage(314u, AbilitySpeedInfo.Parser);

	private readonly RepeatedField<AbilitySpeedInfo> abilitySpeedInfoList_ = new RepeatedField<AbilitySpeedInfo>();

	public const int ShapeInfoListFieldNumber = 40;

	private static readonly FieldCodec<ShapeInfo> _repeated_shapeInfoList_codec = FieldCodec.ForMessage(322u, ShapeInfo.Parser);

	private readonly RepeatedField<ShapeInfo> shapeInfoList_ = new RepeatedField<ShapeInfo>();

	public const int AnimationKeyframeFieldNumber = 41;

	private RuntimelineAnimationCurve animationKeyframe_;

	public const int CharacterTurnInfosFieldNumber = 42;

	private static readonly FieldCodec<CharacterTurnInfo> _repeated_characterTurnInfos_codec = FieldCodec.ForMessage(338u, CharacterTurnInfo.Parser);

	private readonly RepeatedField<CharacterTurnInfo> characterTurnInfos_ = new RepeatedField<CharacterTurnInfo>();

	public const int AttackApproachInfosFieldNumber = 43;

	private static readonly FieldCodec<AttackApproachInfo> _repeated_attackApproachInfos_codec = FieldCodec.ForMessage(346u, AttackApproachInfo.Parser);

	private readonly RepeatedField<AttackApproachInfo> attackApproachInfos_ = new RepeatedField<AttackApproachInfo>();

	public const int UltimateAvoidInfoFieldNumber = 44;

	private UltimateAvoidInfo ultimateAvoidInfo_;

	public const int AbilityGrabInfoFieldNumber = 45;

	private AbilityGrabNodeInfo abilityGrabInfo_;

	public const int AbilityThrowInfoFieldNumber = 46;

	private AbilityThrowNodeInfo abilityThrowInfo_;

	public const int DangerRangeForAIInfoListFieldNumber = 47;

	private static readonly FieldCodec<DangerRangeForAIInfo> _repeated_dangerRangeForAIInfoList_codec = FieldCodec.ForMessage(378u, DangerRangeForAIInfo.Parser);

	private readonly RepeatedField<DangerRangeForAIInfo> dangerRangeForAIInfoList_ = new RepeatedField<DangerRangeForAIInfo>();

	public const int ParryActionInfoListFieldNumber = 48;

	private static readonly FieldCodec<ParryActionInfo> _repeated_parryActionInfoList_codec = FieldCodec.ForMessage(386u, ParryActionInfo.Parser);

	private readonly RepeatedField<ParryActionInfo> parryActionInfoList_ = new RepeatedField<ParryActionInfo>();

	public const int CantBreakStateInfoListFieldNumber = 49;

	private static readonly FieldCodec<CantBreakStateInfo> _repeated_cantBreakStateInfoList_codec = FieldCodec.ForMessage(394u, CantBreakStateInfo.Parser);

	private readonly RepeatedField<CantBreakStateInfo> cantBreakStateInfoList_ = new RepeatedField<CantBreakStateInfo>();

	public const int HitHeightInfoListFieldNumber = 50;

	private static readonly FieldCodec<HitHeightInfo> _repeated_hitHeightInfoList_codec = FieldCodec.ForMessage(402u, HitHeightInfo.Parser);

	private readonly RepeatedField<HitHeightInfo> hitHeightInfoList_ = new RepeatedField<HitHeightInfo>();

	public const int UseFixedCurveFieldNumber = 51;

	private bool useFixedCurve_;

	[DebuggerNonUserCode]
	public static MessageParser<Timeline> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[64];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int TICKINTERVAL
	{
		get
		{
			return tICKINTERVAL_;
		}
		set
		{
			tICKINTERVAL_ = value;
		}
	}

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
	public bool IsLoop
	{
		get
		{
			return isLoop_;
		}
		set
		{
			isLoop_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecoverTime
	{
		get
		{
			return recoverTime_;
		}
		set
		{
			recoverTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ComboOverTime
	{
		get
		{
			return comboOverTime_;
		}
		set
		{
			comboOverTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsFinalAction
	{
		get
		{
			return isFinalAction_;
		}
		set
		{
			isFinalAction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsNeedLock
	{
		get
		{
			return isNeedLock_;
		}
		set
		{
			isNeedLock_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool LockRootMotionX
	{
		get
		{
			return lockRootMotionX_;
		}
		set
		{
			lockRootMotionX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsUseConfigY
	{
		get
		{
			return isUseConfigY_;
		}
		set
		{
			isUseConfigY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsUseConfigX
	{
		get
		{
			return isUseConfigX_;
		}
		set
		{
			isUseConfigX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ThrownCollidGraph
	{
		get
		{
			return thrownCollidGraph_;
		}
		set
		{
			thrownCollidGraph_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ThrownCanOutRange
	{
		get
		{
			return thrownCanOutRange_;
		}
		set
		{
			thrownCanOutRange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThrownOutRangeSpawnID
	{
		get
		{
			return thrownOutRangeSpawnID_;
		}
		set
		{
			thrownOutRangeSpawnID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ThrownDestroyByObstacle
	{
		get
		{
			return thrownDestroyByObstacle_;
		}
		set
		{
			thrownDestroyByObstacle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThrownSpawnChildID
	{
		get
		{
			return thrownSpawnChildID_;
		}
		set
		{
			thrownSpawnChildID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ArrivedCreateThrownTimelineID
	{
		get
		{
			return arrivedCreateThrownTimelineID_;
		}
		set
		{
			arrivedCreateThrownTimelineID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsDependCasterForThrown
	{
		get
		{
			return isDependCasterForThrown_;
		}
		set
		{
			isDependCasterForThrown_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseTangentMove
	{
		get
		{
			return useTangentMove_;
		}
		set
		{
			useTangentMove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseDefaultCamera
	{
		get
		{
			return useDefaultCamera_;
		}
		set
		{
			useDefaultCamera_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool UseCameraMove
	{
		get
		{
			return useCameraMove_;
		}
		set
		{
			useCameraMove_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TransformActionInfo TransformActionInfo
	{
		get
		{
			return transformActionInfo_;
		}
		set
		{
			transformActionInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SwitchQTECameraTimeAsTeammate
	{
		get
		{
			return switchQTECameraTimeAsTeammate_;
		}
		set
		{
			switchQTECameraTimeAsTeammate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsCustomAttackPoint
	{
		get
		{
			return isCustomAttackPoint_;
		}
		set
		{
			isCustomAttackPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CustomAttackPointDistance
	{
		get
		{
			return customAttackPointDistance_;
		}
		set
		{
			customAttackPointDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<CDCompensationInfo> CDCompensationList => cDCompensationList_;

	[DebuggerNonUserCode]
	public RepeatedField<PostSpwanThrownEventInfo> PostSpwanThrownEvents => postSpwanThrownEvents_;

	[DebuggerNonUserCode]
	public RepeatedField<PostDespawnThrownEventInfo> PostDespownThronEvents => postDespownThronEvents_;

	[DebuggerNonUserCode]
	public RepeatedField<HitCheckInfo> HitTimeList => hitTimeList_;

	[DebuggerNonUserCode]
	public MoveActionTimelineNode MoveActionTimelineNode
	{
		get
		{
			return moveActionTimelineNode_;
		}
		set
		{
			moveActionTimelineNode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public InputActionTimelineNode InputActionTimelineNode
	{
		get
		{
			return inputActionTimelineNode_;
		}
		set
		{
			inputActionTimelineNode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<LockActionNode> LockAcionList => lockAcionList_;

	[DebuggerNonUserCode]
	public RepeatedField<ThrownCollisionCheckInfo> ThrownCollisionCheckInfoList => thrownCollisionCheckInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<ThrownLockActionInfo> ThrownLockActionInfoList => thrownLockActionInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<CameraTypeInfo> CameraTypeInfoList => cameraTypeInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<ThrownBackActionInfo> ThrownBackActionInfoList => thrownBackActionInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<ShapeEnableInfo> ShapeEnableInfoList => shapeEnableInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<AbilityStateInfo> AbilityStateInfoList => abilityStateInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<AbilitySpeedInfo> AbilitySpeedInfoList => abilitySpeedInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<ShapeInfo> ShapeInfoList => shapeInfoList_;

	[DebuggerNonUserCode]
	public RuntimelineAnimationCurve AnimationKeyframe
	{
		get
		{
			return animationKeyframe_;
		}
		set
		{
			animationKeyframe_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<CharacterTurnInfo> CharacterTurnInfos => characterTurnInfos_;

	[DebuggerNonUserCode]
	public RepeatedField<AttackApproachInfo> AttackApproachInfos => attackApproachInfos_;

	[DebuggerNonUserCode]
	public UltimateAvoidInfo UltimateAvoidInfo
	{
		get
		{
			return ultimateAvoidInfo_;
		}
		set
		{
			ultimateAvoidInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AbilityGrabNodeInfo AbilityGrabInfo
	{
		get
		{
			return abilityGrabInfo_;
		}
		set
		{
			abilityGrabInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AbilityThrowNodeInfo AbilityThrowInfo
	{
		get
		{
			return abilityThrowInfo_;
		}
		set
		{
			abilityThrowInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<DangerRangeForAIInfo> DangerRangeForAIInfoList => dangerRangeForAIInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<ParryActionInfo> ParryActionInfoList => parryActionInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<CantBreakStateInfo> CantBreakStateInfoList => cantBreakStateInfoList_;

	[DebuggerNonUserCode]
	public RepeatedField<HitHeightInfo> HitHeightInfoList => hitHeightInfoList_;

	[DebuggerNonUserCode]
	public bool UseFixedCurve
	{
		get
		{
			return useFixedCurve_;
		}
		set
		{
			useFixedCurve_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Timeline()
	{
	}

	[DebuggerNonUserCode]
	public Timeline(Timeline other)
		: this()
	{
		tICKINTERVAL_ = other.tICKINTERVAL_;
		iD_ = other.iD_;
		isLoop_ = other.isLoop_;
		duration_ = other.duration_;
		recoverTime_ = other.recoverTime_;
		comboOverTime_ = other.comboOverTime_;
		isFinalAction_ = other.isFinalAction_;
		isNeedLock_ = other.isNeedLock_;
		lockRootMotionX_ = other.lockRootMotionX_;
		isUseConfigY_ = other.isUseConfigY_;
		isUseConfigX_ = other.isUseConfigX_;
		thrownCollidGraph_ = other.thrownCollidGraph_;
		thrownCanOutRange_ = other.thrownCanOutRange_;
		thrownOutRangeSpawnID_ = other.thrownOutRangeSpawnID_;
		thrownDestroyByObstacle_ = other.thrownDestroyByObstacle_;
		thrownSpawnChildID_ = other.thrownSpawnChildID_;
		arrivedCreateThrownTimelineID_ = other.arrivedCreateThrownTimelineID_;
		isDependCasterForThrown_ = other.isDependCasterForThrown_;
		useTangentMove_ = other.useTangentMove_;
		useDefaultCamera_ = other.useDefaultCamera_;
		useCameraMove_ = other.useCameraMove_;
		TransformActionInfo = ((other.transformActionInfo_ != null) ? other.TransformActionInfo.Clone() : null);
		switchQTECameraTimeAsTeammate_ = other.switchQTECameraTimeAsTeammate_;
		isCustomAttackPoint_ = other.isCustomAttackPoint_;
		customAttackPointDistance_ = other.customAttackPointDistance_;
		cDCompensationList_ = other.cDCompensationList_.Clone();
		postSpwanThrownEvents_ = other.postSpwanThrownEvents_.Clone();
		postDespownThronEvents_ = other.postDespownThronEvents_.Clone();
		hitTimeList_ = other.hitTimeList_.Clone();
		MoveActionTimelineNode = ((other.moveActionTimelineNode_ != null) ? other.MoveActionTimelineNode.Clone() : null);
		InputActionTimelineNode = ((other.inputActionTimelineNode_ != null) ? other.InputActionTimelineNode.Clone() : null);
		lockAcionList_ = other.lockAcionList_.Clone();
		thrownCollisionCheckInfoList_ = other.thrownCollisionCheckInfoList_.Clone();
		thrownLockActionInfoList_ = other.thrownLockActionInfoList_.Clone();
		cameraTypeInfoList_ = other.cameraTypeInfoList_.Clone();
		thrownBackActionInfoList_ = other.thrownBackActionInfoList_.Clone();
		shapeEnableInfoList_ = other.shapeEnableInfoList_.Clone();
		abilityStateInfoList_ = other.abilityStateInfoList_.Clone();
		abilitySpeedInfoList_ = other.abilitySpeedInfoList_.Clone();
		shapeInfoList_ = other.shapeInfoList_.Clone();
		AnimationKeyframe = ((other.animationKeyframe_ != null) ? other.AnimationKeyframe.Clone() : null);
		characterTurnInfos_ = other.characterTurnInfos_.Clone();
		attackApproachInfos_ = other.attackApproachInfos_.Clone();
		UltimateAvoidInfo = ((other.ultimateAvoidInfo_ != null) ? other.UltimateAvoidInfo.Clone() : null);
		AbilityGrabInfo = ((other.abilityGrabInfo_ != null) ? other.AbilityGrabInfo.Clone() : null);
		AbilityThrowInfo = ((other.abilityThrowInfo_ != null) ? other.AbilityThrowInfo.Clone() : null);
		dangerRangeForAIInfoList_ = other.dangerRangeForAIInfoList_.Clone();
		parryActionInfoList_ = other.parryActionInfoList_.Clone();
		cantBreakStateInfoList_ = other.cantBreakStateInfoList_.Clone();
		hitHeightInfoList_ = other.hitHeightInfoList_.Clone();
		useFixedCurve_ = other.useFixedCurve_;
	}

	[DebuggerNonUserCode]
	public Timeline Clone()
	{
		return new Timeline(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Timeline);
	}

	[DebuggerNonUserCode]
	public bool Equals(Timeline other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TICKINTERVAL != other.TICKINTERVAL)
		{
			return false;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (IsLoop != other.IsLoop)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (RecoverTime != other.RecoverTime)
		{
			return false;
		}
		if (ComboOverTime != other.ComboOverTime)
		{
			return false;
		}
		if (IsFinalAction != other.IsFinalAction)
		{
			return false;
		}
		if (IsNeedLock != other.IsNeedLock)
		{
			return false;
		}
		if (LockRootMotionX != other.LockRootMotionX)
		{
			return false;
		}
		if (IsUseConfigY != other.IsUseConfigY)
		{
			return false;
		}
		if (IsUseConfigX != other.IsUseConfigX)
		{
			return false;
		}
		if (ThrownCollidGraph != other.ThrownCollidGraph)
		{
			return false;
		}
		if (ThrownCanOutRange != other.ThrownCanOutRange)
		{
			return false;
		}
		if (ThrownOutRangeSpawnID != other.ThrownOutRangeSpawnID)
		{
			return false;
		}
		if (ThrownDestroyByObstacle != other.ThrownDestroyByObstacle)
		{
			return false;
		}
		if (ThrownSpawnChildID != other.ThrownSpawnChildID)
		{
			return false;
		}
		if (ArrivedCreateThrownTimelineID != other.ArrivedCreateThrownTimelineID)
		{
			return false;
		}
		if (IsDependCasterForThrown != other.IsDependCasterForThrown)
		{
			return false;
		}
		if (UseTangentMove != other.UseTangentMove)
		{
			return false;
		}
		if (UseDefaultCamera != other.UseDefaultCamera)
		{
			return false;
		}
		if (UseCameraMove != other.UseCameraMove)
		{
			return false;
		}
		if (!object.Equals(TransformActionInfo, other.TransformActionInfo))
		{
			return false;
		}
		if (SwitchQTECameraTimeAsTeammate != other.SwitchQTECameraTimeAsTeammate)
		{
			return false;
		}
		if (IsCustomAttackPoint != other.IsCustomAttackPoint)
		{
			return false;
		}
		if (CustomAttackPointDistance != other.CustomAttackPointDistance)
		{
			return false;
		}
		if (!cDCompensationList_.Equals(other.cDCompensationList_))
		{
			return false;
		}
		if (!postSpwanThrownEvents_.Equals(other.postSpwanThrownEvents_))
		{
			return false;
		}
		if (!postDespownThronEvents_.Equals(other.postDespownThronEvents_))
		{
			return false;
		}
		if (!hitTimeList_.Equals(other.hitTimeList_))
		{
			return false;
		}
		if (!object.Equals(MoveActionTimelineNode, other.MoveActionTimelineNode))
		{
			return false;
		}
		if (!object.Equals(InputActionTimelineNode, other.InputActionTimelineNode))
		{
			return false;
		}
		if (!lockAcionList_.Equals(other.lockAcionList_))
		{
			return false;
		}
		if (!thrownCollisionCheckInfoList_.Equals(other.thrownCollisionCheckInfoList_))
		{
			return false;
		}
		if (!thrownLockActionInfoList_.Equals(other.thrownLockActionInfoList_))
		{
			return false;
		}
		if (!cameraTypeInfoList_.Equals(other.cameraTypeInfoList_))
		{
			return false;
		}
		if (!thrownBackActionInfoList_.Equals(other.thrownBackActionInfoList_))
		{
			return false;
		}
		if (!shapeEnableInfoList_.Equals(other.shapeEnableInfoList_))
		{
			return false;
		}
		if (!abilityStateInfoList_.Equals(other.abilityStateInfoList_))
		{
			return false;
		}
		if (!abilitySpeedInfoList_.Equals(other.abilitySpeedInfoList_))
		{
			return false;
		}
		if (!shapeInfoList_.Equals(other.shapeInfoList_))
		{
			return false;
		}
		if (!object.Equals(AnimationKeyframe, other.AnimationKeyframe))
		{
			return false;
		}
		if (!characterTurnInfos_.Equals(other.characterTurnInfos_))
		{
			return false;
		}
		if (!attackApproachInfos_.Equals(other.attackApproachInfos_))
		{
			return false;
		}
		if (!object.Equals(UltimateAvoidInfo, other.UltimateAvoidInfo))
		{
			return false;
		}
		if (!object.Equals(AbilityGrabInfo, other.AbilityGrabInfo))
		{
			return false;
		}
		if (!object.Equals(AbilityThrowInfo, other.AbilityThrowInfo))
		{
			return false;
		}
		if (!dangerRangeForAIInfoList_.Equals(other.dangerRangeForAIInfoList_))
		{
			return false;
		}
		if (!parryActionInfoList_.Equals(other.parryActionInfoList_))
		{
			return false;
		}
		if (!cantBreakStateInfoList_.Equals(other.cantBreakStateInfoList_))
		{
			return false;
		}
		if (!hitHeightInfoList_.Equals(other.hitHeightInfoList_))
		{
			return false;
		}
		if (UseFixedCurve != other.UseFixedCurve)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (TICKINTERVAL != 0)
		{
			num ^= TICKINTERVAL.GetHashCode();
		}
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (IsLoop)
		{
			num ^= IsLoop.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (RecoverTime != 0)
		{
			num ^= RecoverTime.GetHashCode();
		}
		if (ComboOverTime != 0)
		{
			num ^= ComboOverTime.GetHashCode();
		}
		if (IsFinalAction)
		{
			num ^= IsFinalAction.GetHashCode();
		}
		if (IsNeedLock)
		{
			num ^= IsNeedLock.GetHashCode();
		}
		if (LockRootMotionX)
		{
			num ^= LockRootMotionX.GetHashCode();
		}
		if (IsUseConfigY)
		{
			num ^= IsUseConfigY.GetHashCode();
		}
		if (IsUseConfigX)
		{
			num ^= IsUseConfigX.GetHashCode();
		}
		if (ThrownCollidGraph)
		{
			num ^= ThrownCollidGraph.GetHashCode();
		}
		if (ThrownCanOutRange)
		{
			num ^= ThrownCanOutRange.GetHashCode();
		}
		if (ThrownOutRangeSpawnID != 0)
		{
			num ^= ThrownOutRangeSpawnID.GetHashCode();
		}
		if (ThrownDestroyByObstacle)
		{
			num ^= ThrownDestroyByObstacle.GetHashCode();
		}
		if (ThrownSpawnChildID != 0)
		{
			num ^= ThrownSpawnChildID.GetHashCode();
		}
		if (ArrivedCreateThrownTimelineID != 0)
		{
			num ^= ArrivedCreateThrownTimelineID.GetHashCode();
		}
		if (IsDependCasterForThrown)
		{
			num ^= IsDependCasterForThrown.GetHashCode();
		}
		if (UseTangentMove)
		{
			num ^= UseTangentMove.GetHashCode();
		}
		if (UseDefaultCamera)
		{
			num ^= UseDefaultCamera.GetHashCode();
		}
		if (UseCameraMove)
		{
			num ^= UseCameraMove.GetHashCode();
		}
		if (transformActionInfo_ != null)
		{
			num ^= TransformActionInfo.GetHashCode();
		}
		if (SwitchQTECameraTimeAsTeammate != 0)
		{
			num ^= SwitchQTECameraTimeAsTeammate.GetHashCode();
		}
		if (IsCustomAttackPoint)
		{
			num ^= IsCustomAttackPoint.GetHashCode();
		}
		if (CustomAttackPointDistance != 0)
		{
			num ^= CustomAttackPointDistance.GetHashCode();
		}
		num ^= cDCompensationList_.GetHashCode();
		num ^= postSpwanThrownEvents_.GetHashCode();
		num ^= postDespownThronEvents_.GetHashCode();
		num ^= hitTimeList_.GetHashCode();
		if (moveActionTimelineNode_ != null)
		{
			num ^= MoveActionTimelineNode.GetHashCode();
		}
		if (inputActionTimelineNode_ != null)
		{
			num ^= InputActionTimelineNode.GetHashCode();
		}
		num ^= lockAcionList_.GetHashCode();
		num ^= thrownCollisionCheckInfoList_.GetHashCode();
		num ^= thrownLockActionInfoList_.GetHashCode();
		num ^= cameraTypeInfoList_.GetHashCode();
		num ^= thrownBackActionInfoList_.GetHashCode();
		num ^= shapeEnableInfoList_.GetHashCode();
		num ^= abilityStateInfoList_.GetHashCode();
		num ^= abilitySpeedInfoList_.GetHashCode();
		num ^= shapeInfoList_.GetHashCode();
		if (animationKeyframe_ != null)
		{
			num ^= AnimationKeyframe.GetHashCode();
		}
		num ^= characterTurnInfos_.GetHashCode();
		num ^= attackApproachInfos_.GetHashCode();
		if (ultimateAvoidInfo_ != null)
		{
			num ^= UltimateAvoidInfo.GetHashCode();
		}
		if (abilityGrabInfo_ != null)
		{
			num ^= AbilityGrabInfo.GetHashCode();
		}
		if (abilityThrowInfo_ != null)
		{
			num ^= AbilityThrowInfo.GetHashCode();
		}
		num ^= dangerRangeForAIInfoList_.GetHashCode();
		num ^= parryActionInfoList_.GetHashCode();
		num ^= cantBreakStateInfoList_.GetHashCode();
		num ^= hitHeightInfoList_.GetHashCode();
		if (UseFixedCurve)
		{
			num ^= UseFixedCurve.GetHashCode();
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
		if (TICKINTERVAL != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TICKINTERVAL);
		}
		if (ID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ID);
		}
		if (IsLoop)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsLoop);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Duration);
		}
		if (RecoverTime != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RecoverTime);
		}
		if (ComboOverTime != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ComboOverTime);
		}
		if (IsFinalAction)
		{
			output.WriteRawTag(56);
			output.WriteBool(IsFinalAction);
		}
		if (IsNeedLock)
		{
			output.WriteRawTag(64);
			output.WriteBool(IsNeedLock);
		}
		if (LockRootMotionX)
		{
			output.WriteRawTag(72);
			output.WriteBool(LockRootMotionX);
		}
		if (IsUseConfigY)
		{
			output.WriteRawTag(80);
			output.WriteBool(IsUseConfigY);
		}
		if (IsUseConfigX)
		{
			output.WriteRawTag(88);
			output.WriteBool(IsUseConfigX);
		}
		if (ThrownCollidGraph)
		{
			output.WriteRawTag(96);
			output.WriteBool(ThrownCollidGraph);
		}
		if (ThrownCanOutRange)
		{
			output.WriteRawTag(104);
			output.WriteBool(ThrownCanOutRange);
		}
		if (ThrownOutRangeSpawnID != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(ThrownOutRangeSpawnID);
		}
		if (ThrownDestroyByObstacle)
		{
			output.WriteRawTag(120);
			output.WriteBool(ThrownDestroyByObstacle);
		}
		if (ThrownSpawnChildID != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(ThrownSpawnChildID);
		}
		if (ArrivedCreateThrownTimelineID != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ArrivedCreateThrownTimelineID);
		}
		if (IsDependCasterForThrown)
		{
			output.WriteRawTag(144, 1);
			output.WriteBool(IsDependCasterForThrown);
		}
		if (UseTangentMove)
		{
			output.WriteRawTag(152, 1);
			output.WriteBool(UseTangentMove);
		}
		if (UseDefaultCamera)
		{
			output.WriteRawTag(160, 1);
			output.WriteBool(UseDefaultCamera);
		}
		if (UseCameraMove)
		{
			output.WriteRawTag(168, 1);
			output.WriteBool(UseCameraMove);
		}
		if (transformActionInfo_ != null)
		{
			output.WriteRawTag(178, 1);
			output.WriteMessage(TransformActionInfo);
		}
		if (SwitchQTECameraTimeAsTeammate != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(SwitchQTECameraTimeAsTeammate);
		}
		if (IsCustomAttackPoint)
		{
			output.WriteRawTag(192, 1);
			output.WriteBool(IsCustomAttackPoint);
		}
		if (CustomAttackPointDistance != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(CustomAttackPointDistance);
		}
		cDCompensationList_.WriteTo(output, _repeated_cDCompensationList_codec);
		postSpwanThrownEvents_.WriteTo(output, _repeated_postSpwanThrownEvents_codec);
		postDespownThronEvents_.WriteTo(output, _repeated_postDespownThronEvents_codec);
		hitTimeList_.WriteTo(output, _repeated_hitTimeList_codec);
		if (moveActionTimelineNode_ != null)
		{
			output.WriteRawTag(242, 1);
			output.WriteMessage(MoveActionTimelineNode);
		}
		if (inputActionTimelineNode_ != null)
		{
			output.WriteRawTag(250, 1);
			output.WriteMessage(InputActionTimelineNode);
		}
		lockAcionList_.WriteTo(output, _repeated_lockAcionList_codec);
		thrownCollisionCheckInfoList_.WriteTo(output, _repeated_thrownCollisionCheckInfoList_codec);
		thrownLockActionInfoList_.WriteTo(output, _repeated_thrownLockActionInfoList_codec);
		cameraTypeInfoList_.WriteTo(output, _repeated_cameraTypeInfoList_codec);
		thrownBackActionInfoList_.WriteTo(output, _repeated_thrownBackActionInfoList_codec);
		shapeEnableInfoList_.WriteTo(output, _repeated_shapeEnableInfoList_codec);
		abilityStateInfoList_.WriteTo(output, _repeated_abilityStateInfoList_codec);
		abilitySpeedInfoList_.WriteTo(output, _repeated_abilitySpeedInfoList_codec);
		shapeInfoList_.WriteTo(output, _repeated_shapeInfoList_codec);
		if (animationKeyframe_ != null)
		{
			output.WriteRawTag(202, 2);
			output.WriteMessage(AnimationKeyframe);
		}
		characterTurnInfos_.WriteTo(output, _repeated_characterTurnInfos_codec);
		attackApproachInfos_.WriteTo(output, _repeated_attackApproachInfos_codec);
		if (ultimateAvoidInfo_ != null)
		{
			output.WriteRawTag(226, 2);
			output.WriteMessage(UltimateAvoidInfo);
		}
		if (abilityGrabInfo_ != null)
		{
			output.WriteRawTag(234, 2);
			output.WriteMessage(AbilityGrabInfo);
		}
		if (abilityThrowInfo_ != null)
		{
			output.WriteRawTag(242, 2);
			output.WriteMessage(AbilityThrowInfo);
		}
		dangerRangeForAIInfoList_.WriteTo(output, _repeated_dangerRangeForAIInfoList_codec);
		parryActionInfoList_.WriteTo(output, _repeated_parryActionInfoList_codec);
		cantBreakStateInfoList_.WriteTo(output, _repeated_cantBreakStateInfoList_codec);
		hitHeightInfoList_.WriteTo(output, _repeated_hitHeightInfoList_codec);
		if (UseFixedCurve)
		{
			output.WriteRawTag(152, 3);
			output.WriteBool(UseFixedCurve);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (TICKINTERVAL != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TICKINTERVAL);
		}
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (IsLoop)
		{
			num += 2;
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (RecoverTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecoverTime);
		}
		if (ComboOverTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ComboOverTime);
		}
		if (IsFinalAction)
		{
			num += 2;
		}
		if (IsNeedLock)
		{
			num += 2;
		}
		if (LockRootMotionX)
		{
			num += 2;
		}
		if (IsUseConfigY)
		{
			num += 2;
		}
		if (IsUseConfigX)
		{
			num += 2;
		}
		if (ThrownCollidGraph)
		{
			num += 2;
		}
		if (ThrownCanOutRange)
		{
			num += 2;
		}
		if (ThrownOutRangeSpawnID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThrownOutRangeSpawnID);
		}
		if (ThrownDestroyByObstacle)
		{
			num += 2;
		}
		if (ThrownSpawnChildID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ThrownSpawnChildID);
		}
		if (ArrivedCreateThrownTimelineID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ArrivedCreateThrownTimelineID);
		}
		if (IsDependCasterForThrown)
		{
			num += 3;
		}
		if (UseTangentMove)
		{
			num += 3;
		}
		if (UseDefaultCamera)
		{
			num += 3;
		}
		if (UseCameraMove)
		{
			num += 3;
		}
		if (transformActionInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(TransformActionInfo);
		}
		if (SwitchQTECameraTimeAsTeammate != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SwitchQTECameraTimeAsTeammate);
		}
		if (IsCustomAttackPoint)
		{
			num += 3;
		}
		if (CustomAttackPointDistance != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CustomAttackPointDistance);
		}
		num += cDCompensationList_.CalculateSize(_repeated_cDCompensationList_codec);
		num += postSpwanThrownEvents_.CalculateSize(_repeated_postSpwanThrownEvents_codec);
		num += postDespownThronEvents_.CalculateSize(_repeated_postDespownThronEvents_codec);
		num += hitTimeList_.CalculateSize(_repeated_hitTimeList_codec);
		if (moveActionTimelineNode_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(MoveActionTimelineNode);
		}
		if (inputActionTimelineNode_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(InputActionTimelineNode);
		}
		num += lockAcionList_.CalculateSize(_repeated_lockAcionList_codec);
		num += thrownCollisionCheckInfoList_.CalculateSize(_repeated_thrownCollisionCheckInfoList_codec);
		num += thrownLockActionInfoList_.CalculateSize(_repeated_thrownLockActionInfoList_codec);
		num += cameraTypeInfoList_.CalculateSize(_repeated_cameraTypeInfoList_codec);
		num += thrownBackActionInfoList_.CalculateSize(_repeated_thrownBackActionInfoList_codec);
		num += shapeEnableInfoList_.CalculateSize(_repeated_shapeEnableInfoList_codec);
		num += abilityStateInfoList_.CalculateSize(_repeated_abilityStateInfoList_codec);
		num += abilitySpeedInfoList_.CalculateSize(_repeated_abilitySpeedInfoList_codec);
		num += shapeInfoList_.CalculateSize(_repeated_shapeInfoList_codec);
		if (animationKeyframe_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AnimationKeyframe);
		}
		num += characterTurnInfos_.CalculateSize(_repeated_characterTurnInfos_codec);
		num += attackApproachInfos_.CalculateSize(_repeated_attackApproachInfos_codec);
		if (ultimateAvoidInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(UltimateAvoidInfo);
		}
		if (abilityGrabInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AbilityGrabInfo);
		}
		if (abilityThrowInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AbilityThrowInfo);
		}
		num += dangerRangeForAIInfoList_.CalculateSize(_repeated_dangerRangeForAIInfoList_codec);
		num += parryActionInfoList_.CalculateSize(_repeated_parryActionInfoList_codec);
		num += cantBreakStateInfoList_.CalculateSize(_repeated_cantBreakStateInfoList_codec);
		num += hitHeightInfoList_.CalculateSize(_repeated_hitHeightInfoList_codec);
		if (UseFixedCurve)
		{
			num += 3;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Timeline other)
	{
		if (other == null)
		{
			return;
		}
		if (other.TICKINTERVAL != 0)
		{
			TICKINTERVAL = other.TICKINTERVAL;
		}
		if (other.ID != 0)
		{
			ID = other.ID;
		}
		if (other.IsLoop)
		{
			IsLoop = other.IsLoop;
		}
		if (other.Duration != 0)
		{
			Duration = other.Duration;
		}
		if (other.RecoverTime != 0)
		{
			RecoverTime = other.RecoverTime;
		}
		if (other.ComboOverTime != 0)
		{
			ComboOverTime = other.ComboOverTime;
		}
		if (other.IsFinalAction)
		{
			IsFinalAction = other.IsFinalAction;
		}
		if (other.IsNeedLock)
		{
			IsNeedLock = other.IsNeedLock;
		}
		if (other.LockRootMotionX)
		{
			LockRootMotionX = other.LockRootMotionX;
		}
		if (other.IsUseConfigY)
		{
			IsUseConfigY = other.IsUseConfigY;
		}
		if (other.IsUseConfigX)
		{
			IsUseConfigX = other.IsUseConfigX;
		}
		if (other.ThrownCollidGraph)
		{
			ThrownCollidGraph = other.ThrownCollidGraph;
		}
		if (other.ThrownCanOutRange)
		{
			ThrownCanOutRange = other.ThrownCanOutRange;
		}
		if (other.ThrownOutRangeSpawnID != 0)
		{
			ThrownOutRangeSpawnID = other.ThrownOutRangeSpawnID;
		}
		if (other.ThrownDestroyByObstacle)
		{
			ThrownDestroyByObstacle = other.ThrownDestroyByObstacle;
		}
		if (other.ThrownSpawnChildID != 0)
		{
			ThrownSpawnChildID = other.ThrownSpawnChildID;
		}
		if (other.ArrivedCreateThrownTimelineID != 0)
		{
			ArrivedCreateThrownTimelineID = other.ArrivedCreateThrownTimelineID;
		}
		if (other.IsDependCasterForThrown)
		{
			IsDependCasterForThrown = other.IsDependCasterForThrown;
		}
		if (other.UseTangentMove)
		{
			UseTangentMove = other.UseTangentMove;
		}
		if (other.UseDefaultCamera)
		{
			UseDefaultCamera = other.UseDefaultCamera;
		}
		if (other.UseCameraMove)
		{
			UseCameraMove = other.UseCameraMove;
		}
		if (other.transformActionInfo_ != null)
		{
			if (transformActionInfo_ == null)
			{
				transformActionInfo_ = new TransformActionInfo();
			}
			TransformActionInfo.MergeFrom(other.TransformActionInfo);
		}
		if (other.SwitchQTECameraTimeAsTeammate != 0)
		{
			SwitchQTECameraTimeAsTeammate = other.SwitchQTECameraTimeAsTeammate;
		}
		if (other.IsCustomAttackPoint)
		{
			IsCustomAttackPoint = other.IsCustomAttackPoint;
		}
		if (other.CustomAttackPointDistance != 0)
		{
			CustomAttackPointDistance = other.CustomAttackPointDistance;
		}
		cDCompensationList_.Add(other.cDCompensationList_);
		postSpwanThrownEvents_.Add(other.postSpwanThrownEvents_);
		postDespownThronEvents_.Add(other.postDespownThronEvents_);
		hitTimeList_.Add(other.hitTimeList_);
		if (other.moveActionTimelineNode_ != null)
		{
			if (moveActionTimelineNode_ == null)
			{
				moveActionTimelineNode_ = new MoveActionTimelineNode();
			}
			MoveActionTimelineNode.MergeFrom(other.MoveActionTimelineNode);
		}
		if (other.inputActionTimelineNode_ != null)
		{
			if (inputActionTimelineNode_ == null)
			{
				inputActionTimelineNode_ = new InputActionTimelineNode();
			}
			InputActionTimelineNode.MergeFrom(other.InputActionTimelineNode);
		}
		lockAcionList_.Add(other.lockAcionList_);
		thrownCollisionCheckInfoList_.Add(other.thrownCollisionCheckInfoList_);
		thrownLockActionInfoList_.Add(other.thrownLockActionInfoList_);
		cameraTypeInfoList_.Add(other.cameraTypeInfoList_);
		thrownBackActionInfoList_.Add(other.thrownBackActionInfoList_);
		shapeEnableInfoList_.Add(other.shapeEnableInfoList_);
		abilityStateInfoList_.Add(other.abilityStateInfoList_);
		abilitySpeedInfoList_.Add(other.abilitySpeedInfoList_);
		shapeInfoList_.Add(other.shapeInfoList_);
		if (other.animationKeyframe_ != null)
		{
			if (animationKeyframe_ == null)
			{
				animationKeyframe_ = new RuntimelineAnimationCurve();
			}
			AnimationKeyframe.MergeFrom(other.AnimationKeyframe);
		}
		characterTurnInfos_.Add(other.characterTurnInfos_);
		attackApproachInfos_.Add(other.attackApproachInfos_);
		if (other.ultimateAvoidInfo_ != null)
		{
			if (ultimateAvoidInfo_ == null)
			{
				ultimateAvoidInfo_ = new UltimateAvoidInfo();
			}
			UltimateAvoidInfo.MergeFrom(other.UltimateAvoidInfo);
		}
		if (other.abilityGrabInfo_ != null)
		{
			if (abilityGrabInfo_ == null)
			{
				abilityGrabInfo_ = new AbilityGrabNodeInfo();
			}
			AbilityGrabInfo.MergeFrom(other.AbilityGrabInfo);
		}
		if (other.abilityThrowInfo_ != null)
		{
			if (abilityThrowInfo_ == null)
			{
				abilityThrowInfo_ = new AbilityThrowNodeInfo();
			}
			AbilityThrowInfo.MergeFrom(other.AbilityThrowInfo);
		}
		dangerRangeForAIInfoList_.Add(other.dangerRangeForAIInfoList_);
		parryActionInfoList_.Add(other.parryActionInfoList_);
		cantBreakStateInfoList_.Add(other.cantBreakStateInfoList_);
		hitHeightInfoList_.Add(other.hitHeightInfoList_);
		if (other.UseFixedCurve)
		{
			UseFixedCurve = other.UseFixedCurve;
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
				TICKINTERVAL = input.ReadInt32();
				break;
			case 16u:
				ID = input.ReadInt32();
				break;
			case 24u:
				IsLoop = input.ReadBool();
				break;
			case 32u:
				Duration = input.ReadInt32();
				break;
			case 40u:
				RecoverTime = input.ReadInt32();
				break;
			case 48u:
				ComboOverTime = input.ReadInt32();
				break;
			case 56u:
				IsFinalAction = input.ReadBool();
				break;
			case 64u:
				IsNeedLock = input.ReadBool();
				break;
			case 72u:
				LockRootMotionX = input.ReadBool();
				break;
			case 80u:
				IsUseConfigY = input.ReadBool();
				break;
			case 88u:
				IsUseConfigX = input.ReadBool();
				break;
			case 96u:
				ThrownCollidGraph = input.ReadBool();
				break;
			case 104u:
				ThrownCanOutRange = input.ReadBool();
				break;
			case 112u:
				ThrownOutRangeSpawnID = input.ReadInt32();
				break;
			case 120u:
				ThrownDestroyByObstacle = input.ReadBool();
				break;
			case 128u:
				ThrownSpawnChildID = input.ReadInt32();
				break;
			case 136u:
				ArrivedCreateThrownTimelineID = input.ReadInt32();
				break;
			case 144u:
				IsDependCasterForThrown = input.ReadBool();
				break;
			case 152u:
				UseTangentMove = input.ReadBool();
				break;
			case 160u:
				UseDefaultCamera = input.ReadBool();
				break;
			case 168u:
				UseCameraMove = input.ReadBool();
				break;
			case 178u:
				if (transformActionInfo_ == null)
				{
					transformActionInfo_ = new TransformActionInfo();
				}
				input.ReadMessage(transformActionInfo_);
				break;
			case 184u:
				SwitchQTECameraTimeAsTeammate = input.ReadInt32();
				break;
			case 192u:
				IsCustomAttackPoint = input.ReadBool();
				break;
			case 200u:
				CustomAttackPointDistance = input.ReadInt32();
				break;
			case 210u:
				cDCompensationList_.AddEntriesFrom(input, _repeated_cDCompensationList_codec);
				break;
			case 218u:
				postSpwanThrownEvents_.AddEntriesFrom(input, _repeated_postSpwanThrownEvents_codec);
				break;
			case 226u:
				postDespownThronEvents_.AddEntriesFrom(input, _repeated_postDespownThronEvents_codec);
				break;
			case 234u:
				hitTimeList_.AddEntriesFrom(input, _repeated_hitTimeList_codec);
				break;
			case 242u:
				if (moveActionTimelineNode_ == null)
				{
					moveActionTimelineNode_ = new MoveActionTimelineNode();
				}
				input.ReadMessage(moveActionTimelineNode_);
				break;
			case 250u:
				if (inputActionTimelineNode_ == null)
				{
					inputActionTimelineNode_ = new InputActionTimelineNode();
				}
				input.ReadMessage(inputActionTimelineNode_);
				break;
			case 258u:
				lockAcionList_.AddEntriesFrom(input, _repeated_lockAcionList_codec);
				break;
			case 266u:
				thrownCollisionCheckInfoList_.AddEntriesFrom(input, _repeated_thrownCollisionCheckInfoList_codec);
				break;
			case 274u:
				thrownLockActionInfoList_.AddEntriesFrom(input, _repeated_thrownLockActionInfoList_codec);
				break;
			case 282u:
				cameraTypeInfoList_.AddEntriesFrom(input, _repeated_cameraTypeInfoList_codec);
				break;
			case 290u:
				thrownBackActionInfoList_.AddEntriesFrom(input, _repeated_thrownBackActionInfoList_codec);
				break;
			case 298u:
				shapeEnableInfoList_.AddEntriesFrom(input, _repeated_shapeEnableInfoList_codec);
				break;
			case 306u:
				abilityStateInfoList_.AddEntriesFrom(input, _repeated_abilityStateInfoList_codec);
				break;
			case 314u:
				abilitySpeedInfoList_.AddEntriesFrom(input, _repeated_abilitySpeedInfoList_codec);
				break;
			case 322u:
				shapeInfoList_.AddEntriesFrom(input, _repeated_shapeInfoList_codec);
				break;
			case 330u:
				if (animationKeyframe_ == null)
				{
					animationKeyframe_ = new RuntimelineAnimationCurve();
				}
				input.ReadMessage(animationKeyframe_);
				break;
			case 338u:
				characterTurnInfos_.AddEntriesFrom(input, _repeated_characterTurnInfos_codec);
				break;
			case 346u:
				attackApproachInfos_.AddEntriesFrom(input, _repeated_attackApproachInfos_codec);
				break;
			case 354u:
				if (ultimateAvoidInfo_ == null)
				{
					ultimateAvoidInfo_ = new UltimateAvoidInfo();
				}
				input.ReadMessage(ultimateAvoidInfo_);
				break;
			case 362u:
				if (abilityGrabInfo_ == null)
				{
					abilityGrabInfo_ = new AbilityGrabNodeInfo();
				}
				input.ReadMessage(abilityGrabInfo_);
				break;
			case 370u:
				if (abilityThrowInfo_ == null)
				{
					abilityThrowInfo_ = new AbilityThrowNodeInfo();
				}
				input.ReadMessage(abilityThrowInfo_);
				break;
			case 378u:
				dangerRangeForAIInfoList_.AddEntriesFrom(input, _repeated_dangerRangeForAIInfoList_codec);
				break;
			case 386u:
				parryActionInfoList_.AddEntriesFrom(input, _repeated_parryActionInfoList_codec);
				break;
			case 394u:
				cantBreakStateInfoList_.AddEntriesFrom(input, _repeated_cantBreakStateInfoList_codec);
				break;
			case 402u:
				hitHeightInfoList_.AddEntriesFrom(input, _repeated_hitHeightInfoList_codec);
				break;
			case 408u:
				UseFixedCurve = input.ReadBool();
				break;
			}
		}
	}
}

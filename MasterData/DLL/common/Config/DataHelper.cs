using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class DataHelper : IMessage<DataHelper>, IMessage, IEquatable<DataHelper>, IDeepCloneable<DataHelper>
{
	private static readonly MessageParser<DataHelper> _parser = new MessageParser<DataHelper>(() => new DataHelper());

	public const int MessageTypeFieldNumber = 1;

	private static readonly FieldCodec<string> _repeated_messageType_codec = FieldCodec.ForString(10u);

	private readonly RepeatedField<string> messageType_ = new RepeatedField<string>();

	public const int AbilityConfigDictFieldNumber = 2;

	private static readonly MapField<int, AbilityConfig>.Codec _map_abilityConfigDict_codec = new MapField<int, AbilityConfig>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AbilityConfig.Parser), 18u);

	private readonly MapField<int, AbilityConfig> abilityConfigDict_ = new MapField<int, AbilityConfig>();

	public const int AbilityGrabNodeInfoDictFieldNumber = 3;

	private static readonly MapField<int, AbilityGrabNodeInfo>.Codec _map_abilityGrabNodeInfoDict_codec = new MapField<int, AbilityGrabNodeInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AbilityGrabNodeInfo.Parser), 26u);

	private readonly MapField<int, AbilityGrabNodeInfo> abilityGrabNodeInfoDict_ = new MapField<int, AbilityGrabNodeInfo>();

	public const int AbilityRangeIndicatorDictFieldNumber = 4;

	private static readonly MapField<int, AbilityRangeIndicator>.Codec _map_abilityRangeIndicatorDict_codec = new MapField<int, AbilityRangeIndicator>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AbilityRangeIndicator.Parser), 34u);

	private readonly MapField<int, AbilityRangeIndicator> abilityRangeIndicatorDict_ = new MapField<int, AbilityRangeIndicator>();

	public const int AbilitySpeedInfoDictFieldNumber = 5;

	private static readonly MapField<int, AbilitySpeedInfo>.Codec _map_abilitySpeedInfoDict_codec = new MapField<int, AbilitySpeedInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AbilitySpeedInfo.Parser), 42u);

	private readonly MapField<int, AbilitySpeedInfo> abilitySpeedInfoDict_ = new MapField<int, AbilitySpeedInfo>();

	public const int AbilityStateInfoDictFieldNumber = 6;

	private static readonly MapField<int, AbilityStateInfo>.Codec _map_abilityStateInfoDict_codec = new MapField<int, AbilityStateInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AbilityStateInfo.Parser), 50u);

	private readonly MapField<int, AbilityStateInfo> abilityStateInfoDict_ = new MapField<int, AbilityStateInfo>();

	public const int AbilityThrowNodeInfoDictFieldNumber = 7;

	private static readonly MapField<int, AbilityThrowNodeInfo>.Codec _map_abilityThrowNodeInfoDict_codec = new MapField<int, AbilityThrowNodeInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AbilityThrowNodeInfo.Parser), 58u);

	private readonly MapField<int, AbilityThrowNodeInfo> abilityThrowNodeInfoDict_ = new MapField<int, AbilityThrowNodeInfo>();

	public const int ActivityStrikeSystemDictFieldNumber = 8;

	private static readonly MapField<int, ActivityStrikeSystem>.Codec _map_activityStrikeSystemDict_codec = new MapField<int, ActivityStrikeSystem>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ActivityStrikeSystem.Parser), 66u);

	private readonly MapField<int, ActivityStrikeSystem> activityStrikeSystemDict_ = new MapField<int, ActivityStrikeSystem>();

	public const int AttackApproachInfoDictFieldNumber = 9;

	private static readonly MapField<int, AttackApproachInfo>.Codec _map_attackApproachInfoDict_codec = new MapField<int, AttackApproachInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, AttackApproachInfo.Parser), 74u);

	private readonly MapField<int, AttackApproachInfo> attackApproachInfoDict_ = new MapField<int, AttackApproachInfo>();

	public const int AutoGenerateAbilityStateIndexDictFieldNumber = 10;

	private static readonly MapField<int, Auto_Generate_Ability_State_Index>.Codec _map_autoGenerateAbilityStateIndexDict_codec = new MapField<int, Auto_Generate_Ability_State_Index>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Auto_Generate_Ability_State_Index.Parser), 82u);

	private readonly MapField<int, Auto_Generate_Ability_State_Index> autoGenerateAbilityStateIndexDict_ = new MapField<int, Auto_Generate_Ability_State_Index>();

	public const int AutoGenerateInterruptOtherDictFieldNumber = 11;

	private static readonly MapField<int, Auto_Generate_Interrupt_Other>.Codec _map_autoGenerateInterruptOtherDict_codec = new MapField<int, Auto_Generate_Interrupt_Other>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Auto_Generate_Interrupt_Other.Parser), 90u);

	private readonly MapField<int, Auto_Generate_Interrupt_Other> autoGenerateInterruptOtherDict_ = new MapField<int, Auto_Generate_Interrupt_Other>();

	public const int AutoGenerateInterruptSelfDictFieldNumber = 12;

	private static readonly MapField<int, Auto_Generate_Interrupt_Self>.Codec _map_autoGenerateInterruptSelfDict_codec = new MapField<int, Auto_Generate_Interrupt_Self>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Auto_Generate_Interrupt_Self.Parser), 98u);

	private readonly MapField<int, Auto_Generate_Interrupt_Self> autoGenerateInterruptSelfDict_ = new MapField<int, Auto_Generate_Interrupt_Self>();

	public const int BattleTipsDictFieldNumber = 13;

	private static readonly MapField<int, BattleTips>.Codec _map_battleTipsDict_codec = new MapField<int, BattleTips>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, BattleTips.Parser), 106u);

	private readonly MapField<int, BattleTips> battleTipsDict_ = new MapField<int, BattleTips>();

	public const int BuffConfigDictFieldNumber = 14;

	private static readonly MapField<int, BuffConfig>.Codec _map_buffConfigDict_codec = new MapField<int, BuffConfig>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, BuffConfig.Parser), 114u);

	private readonly MapField<int, BuffConfig> buffConfigDict_ = new MapField<int, BuffConfig>();

	public const int BuffItemDictFieldNumber = 15;

	private static readonly MapField<int, BuffItem>.Codec _map_buffItemDict_codec = new MapField<int, BuffItem>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, BuffItem.Parser), 122u);

	private readonly MapField<int, BuffItem> buffItemDict_ = new MapField<int, BuffItem>();

	public const int CDCompensationInfoDictFieldNumber = 16;

	private static readonly MapField<int, CDCompensationInfo>.Codec _map_cDCompensationInfoDict_codec = new MapField<int, CDCompensationInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CDCompensationInfo.Parser), 130u);

	private readonly MapField<int, CDCompensationInfo> cDCompensationInfoDict_ = new MapField<int, CDCompensationInfo>();

	public const int CameraTypeInfoDictFieldNumber = 17;

	private static readonly MapField<int, CameraTypeInfo>.Codec _map_cameraTypeInfoDict_codec = new MapField<int, CameraTypeInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CameraTypeInfo.Parser), 138u);

	private readonly MapField<int, CameraTypeInfo> cameraTypeInfoDict_ = new MapField<int, CameraTypeInfo>();

	public const int CantBreakStateInfoDictFieldNumber = 18;

	private static readonly MapField<int, CantBreakStateInfo>.Codec _map_cantBreakStateInfoDict_codec = new MapField<int, CantBreakStateInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CantBreakStateInfo.Parser), 146u);

	private readonly MapField<int, CantBreakStateInfo> cantBreakStateInfoDict_ = new MapField<int, CantBreakStateInfo>();

	public const int CharacterTurnInfoDictFieldNumber = 19;

	private static readonly MapField<int, CharacterTurnInfo>.Codec _map_characterTurnInfoDict_codec = new MapField<int, CharacterTurnInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CharacterTurnInfo.Parser), 154u);

	private readonly MapField<int, CharacterTurnInfo> characterTurnInfoDict_ = new MapField<int, CharacterTurnInfo>();

	public const int CombatScoreDictFieldNumber = 20;

	private static readonly MapField<int, CombatScore>.Codec _map_combatScoreDict_codec = new MapField<int, CombatScore>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CombatScore.Parser), 162u);

	private readonly MapField<int, CombatScore> combatScoreDict_ = new MapField<int, CombatScore>();

	public const int CommonAudioDictFieldNumber = 21;

	private static readonly MapField<int, CommonAudio>.Codec _map_commonAudioDict_codec = new MapField<int, CommonAudio>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CommonAudio.Parser), 170u);

	private readonly MapField<int, CommonAudio> commonAudioDict_ = new MapField<int, CommonAudio>();

	public const int CommonEffectDictFieldNumber = 22;

	private static readonly MapField<int, CommonEffect>.Codec _map_commonEffectDict_codec = new MapField<int, CommonEffect>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CommonEffect.Parser), 178u);

	private readonly MapField<int, CommonEffect> commonEffectDict_ = new MapField<int, CommonEffect>();

	public const int CommonHitDictFieldNumber = 23;

	private static readonly MapField<int, CommonHit>.Codec _map_commonHitDict_codec = new MapField<int, CommonHit>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, CommonHit.Parser), 186u);

	private readonly MapField<int, CommonHit> commonHitDict_ = new MapField<int, CommonHit>();

	public const int DangerRangeForAIInfoDictFieldNumber = 24;

	private static readonly MapField<int, DangerRangeForAIInfo>.Codec _map_dangerRangeForAIInfoDict_codec = new MapField<int, DangerRangeForAIInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, DangerRangeForAIInfo.Parser), 194u);

	private readonly MapField<int, DangerRangeForAIInfo> dangerRangeForAIInfoDict_ = new MapField<int, DangerRangeForAIInfo>();

	public const int FollowCameraParamDictFieldNumber = 25;

	private static readonly MapField<int, FollowCameraParam>.Codec _map_followCameraParamDict_codec = new MapField<int, FollowCameraParam>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, FollowCameraParam.Parser), 202u);

	private readonly MapField<int, FollowCameraParam> followCameraParamDict_ = new MapField<int, FollowCameraParam>();

	public const int HitCheckInfoDictFieldNumber = 26;

	private static readonly MapField<int, HitCheckInfo>.Codec _map_hitCheckInfoDict_codec = new MapField<int, HitCheckInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, HitCheckInfo.Parser), 210u);

	private readonly MapField<int, HitCheckInfo> hitCheckInfoDict_ = new MapField<int, HitCheckInfo>();

	public const int HitFeedbackDictFieldNumber = 27;

	private static readonly MapField<int, HitFeedback>.Codec _map_hitFeedbackDict_codec = new MapField<int, HitFeedback>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, HitFeedback.Parser), 218u);

	private readonly MapField<int, HitFeedback> hitFeedbackDict_ = new MapField<int, HitFeedback>();

	public const int HitHeightInfoDictFieldNumber = 28;

	private static readonly MapField<int, HitHeightInfo>.Codec _map_hitHeightInfoDict_codec = new MapField<int, HitHeightInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, HitHeightInfo.Parser), 226u);

	private readonly MapField<int, HitHeightInfo> hitHeightInfoDict_ = new MapField<int, HitHeightInfo>();

	public const int InputActionTimelineNodeDictFieldNumber = 29;

	private static readonly MapField<int, InputActionTimelineNode>.Codec _map_inputActionTimelineNodeDict_codec = new MapField<int, InputActionTimelineNode>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, InputActionTimelineNode.Parser), 234u);

	private readonly MapField<int, InputActionTimelineNode> inputActionTimelineNodeDict_ = new MapField<int, InputActionTimelineNode>();

	public const int Int3DictFieldNumber = 30;

	private static readonly MapField<int, Int3>.Codec _map_int3Dict_codec = new MapField<int, Int3>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Int3.Parser), 242u);

	private readonly MapField<int, Int3> int3Dict_ = new MapField<int, Int3>();

	public const int InterestConfigDictFieldNumber = 31;

	private static readonly MapField<int, InterestConfig>.Codec _map_interestConfigDict_codec = new MapField<int, InterestConfig>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, InterestConfig.Parser), 250u);

	private readonly MapField<int, InterestConfig> interestConfigDict_ = new MapField<int, InterestConfig>();

	public const int ItemDictFieldNumber = 32;

	private static readonly MapField<int, Item>.Codec _map_itemDict_codec = new MapField<int, Item>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Item.Parser), 258u);

	private readonly MapField<int, Item> itemDict_ = new MapField<int, Item>();

	public const int KeyframeDictFieldNumber = 33;

	private static readonly MapField<int, Keyframe>.Codec _map_keyframeDict_codec = new MapField<int, Keyframe>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Keyframe.Parser), 266u);

	private readonly MapField<int, Keyframe> keyframeDict_ = new MapField<int, Keyframe>();

	public const int LinkFunctionDictFieldNumber = 34;

	private static readonly MapField<int, LinkFunction>.Codec _map_linkFunctionDict_codec = new MapField<int, LinkFunction>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, LinkFunction.Parser), 274u);

	private readonly MapField<int, LinkFunction> linkFunctionDict_ = new MapField<int, LinkFunction>();

	public const int LockActionNodeDictFieldNumber = 35;

	private static readonly MapField<int, LockActionNode>.Codec _map_lockActionNodeDict_codec = new MapField<int, LockActionNode>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, LockActionNode.Parser), 282u);

	private readonly MapField<int, LockActionNode> lockActionNodeDict_ = new MapField<int, LockActionNode>();

	public const int LockLimitParamDictFieldNumber = 36;

	private static readonly MapField<int, LockLimitParam>.Codec _map_lockLimitParamDict_codec = new MapField<int, LockLimitParam>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, LockLimitParam.Parser), 290u);

	private readonly MapField<int, LockLimitParam> lockLimitParamDict_ = new MapField<int, LockLimitParam>();

	public const int LockedCameraParamDictFieldNumber = 37;

	private static readonly MapField<int, LockedCameraParam>.Codec _map_lockedCameraParamDict_codec = new MapField<int, LockedCameraParam>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, LockedCameraParam.Parser), 298u);

	private readonly MapField<int, LockedCameraParam> lockedCameraParamDict_ = new MapField<int, LockedCameraParam>();

	public const int MonsterSpawnerConfigDictFieldNumber = 38;

	private static readonly MapField<int, MonsterSpawnerConfig>.Codec _map_monsterSpawnerConfigDict_codec = new MapField<int, MonsterSpawnerConfig>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, MonsterSpawnerConfig.Parser), 306u);

	private readonly MapField<int, MonsterSpawnerConfig> monsterSpawnerConfigDict_ = new MapField<int, MonsterSpawnerConfig>();

	public const int MonsterSpawnerLevelDictFieldNumber = 39;

	private static readonly MapField<int, MonsterSpawnerLevel>.Codec _map_monsterSpawnerLevelDict_codec = new MapField<int, MonsterSpawnerLevel>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, MonsterSpawnerLevel.Parser), 314u);

	private readonly MapField<int, MonsterSpawnerLevel> monsterSpawnerLevelDict_ = new MapField<int, MonsterSpawnerLevel>();

	public const int MoveActionTimelineNodeDictFieldNumber = 40;

	private static readonly MapField<int, MoveActionTimelineNode>.Codec _map_moveActionTimelineNodeDict_codec = new MapField<int, MoveActionTimelineNode>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, MoveActionTimelineNode.Parser), 322u);

	private readonly MapField<int, MoveActionTimelineNode> moveActionTimelineNodeDict_ = new MapField<int, MoveActionTimelineNode>();

	public const int ParryActionInfoDictFieldNumber = 41;

	private static readonly MapField<int, ParryActionInfo>.Codec _map_parryActionInfoDict_codec = new MapField<int, ParryActionInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ParryActionInfo.Parser), 330u);

	private readonly MapField<int, ParryActionInfo> parryActionInfoDict_ = new MapField<int, ParryActionInfo>();

	public const int PostDespawnThrownEventInfoDictFieldNumber = 42;

	private static readonly MapField<int, PostDespawnThrownEventInfo>.Codec _map_postDespawnThrownEventInfoDict_codec = new MapField<int, PostDespawnThrownEventInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, PostDespawnThrownEventInfo.Parser), 338u);

	private readonly MapField<int, PostDespawnThrownEventInfo> postDespawnThrownEventInfoDict_ = new MapField<int, PostDespawnThrownEventInfo>();

	public const int PostSpwanThrownEventInfoDictFieldNumber = 43;

	private static readonly MapField<int, PostSpwanThrownEventInfo>.Codec _map_postSpwanThrownEventInfoDict_codec = new MapField<int, PostSpwanThrownEventInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, PostSpwanThrownEventInfo.Parser), 346u);

	private readonly MapField<int, PostSpwanThrownEventInfo> postSpwanThrownEventInfoDict_ = new MapField<int, PostSpwanThrownEventInfo>();

	public const int RaceDictFieldNumber = 44;

	private static readonly MapField<int, Race>.Codec _map_raceDict_codec = new MapField<int, Race>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Race.Parser), 354u);

	private readonly MapField<int, Race> raceDict_ = new MapField<int, Race>();

	public const int RoleConfigDictFieldNumber = 45;

	private static readonly MapField<int, RoleConfig>.Codec _map_roleConfigDict_codec = new MapField<int, RoleConfig>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, RoleConfig.Parser), 362u);

	private readonly MapField<int, RoleConfig> roleConfigDict_ = new MapField<int, RoleConfig>();

	public const int RoleVoiceDictFieldNumber = 46;

	private static readonly MapField<int, RoleVoice>.Codec _map_roleVoiceDict_codec = new MapField<int, RoleVoice>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, RoleVoice.Parser), 370u);

	private readonly MapField<int, RoleVoice> roleVoiceDict_ = new MapField<int, RoleVoice>();

	public const int RuntimelineAnimationCurveDictFieldNumber = 47;

	private static readonly MapField<int, RuntimelineAnimationCurve>.Codec _map_runtimelineAnimationCurveDict_codec = new MapField<int, RuntimelineAnimationCurve>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, RuntimelineAnimationCurve.Parser), 378u);

	private readonly MapField<int, RuntimelineAnimationCurve> runtimelineAnimationCurveDict_ = new MapField<int, RuntimelineAnimationCurve>();

	public const int SceneBGMDictFieldNumber = 48;

	private static readonly MapField<int, SceneBGM>.Codec _map_sceneBGMDict_codec = new MapField<int, SceneBGM>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, SceneBGM.Parser), 386u);

	private readonly MapField<int, SceneBGM> sceneBGMDict_ = new MapField<int, SceneBGM>();

	public const int SceneMapDictFieldNumber = 49;

	private static readonly MapField<int, SceneMap>.Codec _map_sceneMapDict_codec = new MapField<int, SceneMap>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, SceneMap.Parser), 394u);

	private readonly MapField<int, SceneMap> sceneMapDict_ = new MapField<int, SceneMap>();

	public const int ShapeEnableInfoDictFieldNumber = 50;

	private static readonly MapField<int, ShapeEnableInfo>.Codec _map_shapeEnableInfoDict_codec = new MapField<int, ShapeEnableInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ShapeEnableInfo.Parser), 402u);

	private readonly MapField<int, ShapeEnableInfo> shapeEnableInfoDict_ = new MapField<int, ShapeEnableInfo>();

	public const int ShapeInfoDictFieldNumber = 51;

	private static readonly MapField<int, ShapeInfo>.Codec _map_shapeInfoDict_codec = new MapField<int, ShapeInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ShapeInfo.Parser), 410u);

	private readonly MapField<int, ShapeInfo> shapeInfoDict_ = new MapField<int, ShapeInfo>();

	public const int ShapeItemInfoDictFieldNumber = 52;

	private static readonly MapField<int, ShapeItemInfo>.Codec _map_shapeItemInfoDict_codec = new MapField<int, ShapeItemInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ShapeItemInfo.Parser), 418u);

	private readonly MapField<int, ShapeItemInfo> shapeItemInfoDict_ = new MapField<int, ShapeItemInfo>();

	public const int SkinDictFieldNumber = 53;

	private static readonly MapField<int, Skin>.Codec _map_skinDict_codec = new MapField<int, Skin>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Skin.Parser), 426u);

	private readonly MapField<int, Skin> skinDict_ = new MapField<int, Skin>();

	public const int SourceSpaceDictFieldNumber = 54;

	private static readonly MapField<int, SourceSpace>.Codec _map_sourceSpaceDict_codec = new MapField<int, SourceSpace>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, SourceSpace.Parser), 434u);

	private readonly MapField<int, SourceSpace> sourceSpaceDict_ = new MapField<int, SourceSpace>();

	public const int SpCharactorHitAudioDictFieldNumber = 55;

	private static readonly MapField<int, SpCharactorHitAudio>.Codec _map_spCharactorHitAudioDict_codec = new MapField<int, SpCharactorHitAudio>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, SpCharactorHitAudio.Parser), 442u);

	private readonly MapField<int, SpCharactorHitAudio> spCharactorHitAudioDict_ = new MapField<int, SpCharactorHitAudio>();

	public const int StoryDictFieldNumber = 56;

	private static readonly MapField<int, Story>.Codec _map_storyDict_codec = new MapField<int, Story>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Story.Parser), 450u);

	private readonly MapField<int, Story> storyDict_ = new MapField<int, Story>();

	public const int TalkContentDictFieldNumber = 57;

	private static readonly MapField<int, TalkContent>.Codec _map_talkContentDict_codec = new MapField<int, TalkContent>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, TalkContent.Parser), 458u);

	private readonly MapField<int, TalkContent> talkContentDict_ = new MapField<int, TalkContent>();

	public const int ThrownBackActionInfoDictFieldNumber = 58;

	private static readonly MapField<int, ThrownBackActionInfo>.Codec _map_thrownBackActionInfoDict_codec = new MapField<int, ThrownBackActionInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ThrownBackActionInfo.Parser), 466u);

	private readonly MapField<int, ThrownBackActionInfo> thrownBackActionInfoDict_ = new MapField<int, ThrownBackActionInfo>();

	public const int ThrownCollisionCheckInfoDictFieldNumber = 59;

	private static readonly MapField<int, ThrownCollisionCheckInfo>.Codec _map_thrownCollisionCheckInfoDict_codec = new MapField<int, ThrownCollisionCheckInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ThrownCollisionCheckInfo.Parser), 474u);

	private readonly MapField<int, ThrownCollisionCheckInfo> thrownCollisionCheckInfoDict_ = new MapField<int, ThrownCollisionCheckInfo>();

	public const int ThrownLockActionInfoDictFieldNumber = 60;

	private static readonly MapField<int, ThrownLockActionInfo>.Codec _map_thrownLockActionInfoDict_codec = new MapField<int, ThrownLockActionInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ThrownLockActionInfo.Parser), 482u);

	private readonly MapField<int, ThrownLockActionInfo> thrownLockActionInfoDict_ = new MapField<int, ThrownLockActionInfo>();

	public const int TimelineDictFieldNumber = 61;

	private static readonly MapField<int, Timeline>.Codec _map_timelineDict_codec = new MapField<int, Timeline>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, Timeline.Parser), 490u);

	private readonly MapField<int, Timeline> timelineDict_ = new MapField<int, Timeline>();

	public const int TimelineRootMotionConfigDictFieldNumber = 62;

	private static readonly MapField<int, TimelineRootMotionConfig>.Codec _map_timelineRootMotionConfigDict_codec = new MapField<int, TimelineRootMotionConfig>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, TimelineRootMotionConfig.Parser), 498u);

	private readonly MapField<int, TimelineRootMotionConfig> timelineRootMotionConfigDict_ = new MapField<int, TimelineRootMotionConfig>();

	public const int TransformActionInfoDictFieldNumber = 63;

	private static readonly MapField<int, TransformActionInfo>.Codec _map_transformActionInfoDict_codec = new MapField<int, TransformActionInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, TransformActionInfo.Parser), 506u);

	private readonly MapField<int, TransformActionInfo> transformActionInfoDict_ = new MapField<int, TransformActionInfo>();

	public const int UIAudioDictFieldNumber = 64;

	private static readonly MapField<int, UIAudio>.Codec _map_uIAudioDict_codec = new MapField<int, UIAudio>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, UIAudio.Parser), 514u);

	private readonly MapField<int, UIAudio> uIAudioDict_ = new MapField<int, UIAudio>();

	public const int UltimateAvoidInfoDictFieldNumber = 65;

	private static readonly MapField<int, UltimateAvoidInfo>.Codec _map_ultimateAvoidInfoDict_codec = new MapField<int, UltimateAvoidInfo>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, UltimateAvoidInfo.Parser), 522u);

	private readonly MapField<int, UltimateAvoidInfo> ultimateAvoidInfoDict_ = new MapField<int, UltimateAvoidInfo>();

	public const int UniqueSkillDictFieldNumber = 66;

	private static readonly MapField<int, UniqueSkill>.Codec _map_uniqueSkillDict_codec = new MapField<int, UniqueSkill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, UniqueSkill.Parser), 530u);

	private readonly MapField<int, UniqueSkill> uniqueSkillDict_ = new MapField<int, UniqueSkill>();

	public const int VectorInt3DictFieldNumber = 67;

	private static readonly MapField<int, VectorInt3>.Codec _map_vectorInt3Dict_codec = new MapField<int, VectorInt3>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, VectorInt3.Parser), 538u);

	private readonly MapField<int, VectorInt3> vectorInt3Dict_ = new MapField<int, VectorInt3>();

	public const int ActivityOnlineMatchDictFieldNumber = 68;

	private static readonly MapField<int, activity_online_match>.Codec _map_activityOnlineMatchDict_codec = new MapField<int, activity_online_match>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, activity_online_match.Parser), 546u);

	private readonly MapField<int, activity_online_match> activityOnlineMatchDict_ = new MapField<int, activity_online_match>();

	public const int ActivityOnlineTowerDictFieldNumber = 69;

	private static readonly MapField<int, activity_online_tower>.Codec _map_activityOnlineTowerDict_codec = new MapField<int, activity_online_tower>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, activity_online_tower.Parser), 554u);

	private readonly MapField<int, activity_online_tower> activityOnlineTowerDict_ = new MapField<int, activity_online_tower>();

	public const int ActivityReforgeSkillDictFieldNumber = 70;

	private static readonly MapField<int, activity_reforge_skill>.Codec _map_activityReforgeSkillDict_codec = new MapField<int, activity_reforge_skill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, activity_reforge_skill.Parser), 562u);

	private readonly MapField<int, activity_reforge_skill> activityReforgeSkillDict_ = new MapField<int, activity_reforge_skill>();

	public const int ActivityTowerDefensePointDictFieldNumber = 71;

	private static readonly MapField<int, activity_tower_defense_point>.Codec _map_activityTowerDefensePointDict_codec = new MapField<int, activity_tower_defense_point>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, activity_tower_defense_point.Parser), 570u);

	private readonly MapField<int, activity_tower_defense_point> activityTowerDefensePointDict_ = new MapField<int, activity_tower_defense_point>();

	public const int ActivityTowerDefenseTowerDictFieldNumber = 72;

	private static readonly MapField<int, activity_tower_defense_tower>.Codec _map_activityTowerDefenseTowerDict_codec = new MapField<int, activity_tower_defense_tower>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, activity_tower_defense_tower.Parser), 578u);

	private readonly MapField<int, activity_tower_defense_tower> activityTowerDefenseTowerDict_ = new MapField<int, activity_tower_defense_tower>();

	public const int AffixTypeDictFieldNumber = 73;

	private static readonly MapField<int, affix_type>.Codec _map_affixTypeDict_codec = new MapField<int, affix_type>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, affix_type.Parser), 586u);

	private readonly MapField<int, affix_type> affixTypeDict_ = new MapField<int, affix_type>();

	public const int AiChipDictFieldNumber = 74;

	private static readonly MapField<int, ai_chip>.Codec _map_aiChipDict_codec = new MapField<int, ai_chip>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, ai_chip.Parser), 594u);

	private readonly MapField<int, ai_chip> aiChipDict_ = new MapField<int, ai_chip>();

	public const int BattleAchievementDictFieldNumber = 75;

	private static readonly MapField<int, battle_achievement>.Codec _map_battleAchievementDict_codec = new MapField<int, battle_achievement>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, battle_achievement.Parser), 602u);

	private readonly MapField<int, battle_achievement> battleAchievementDict_ = new MapField<int, battle_achievement>();

	public const int BattleRecordDataTypeDictFieldNumber = 76;

	private static readonly MapField<int, battle_record_data_type>.Codec _map_battleRecordDataTypeDict_codec = new MapField<int, battle_record_data_type>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, battle_record_data_type.Parser), 610u);

	private readonly MapField<int, battle_record_data_type> battleRecordDataTypeDict_ = new MapField<int, battle_record_data_type>();

	public const int BossAppearUITextDictFieldNumber = 77;

	private static readonly MapField<int, boss_appear_UI_text>.Codec _map_bossAppearUITextDict_codec = new MapField<int, boss_appear_UI_text>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, boss_appear_UI_text.Parser), 618u);

	private readonly MapField<int, boss_appear_UI_text> bossAppearUITextDict_ = new MapField<int, boss_appear_UI_text>();

	public const int CharactorParamDictFieldNumber = 78;

	private static readonly MapField<int, charactor_param>.Codec _map_charactorParamDict_codec = new MapField<int, charactor_param>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, charactor_param.Parser), 626u);

	private readonly MapField<int, charactor_param> charactorParamDict_ = new MapField<int, charactor_param>();

	public const int CooperateUniqueSkillDictFieldNumber = 79;

	private static readonly MapField<int, cooperate_unique_skill>.Codec _map_cooperateUniqueSkillDict_codec = new MapField<int, cooperate_unique_skill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, cooperate_unique_skill.Parser), 634u);

	private readonly MapField<int, cooperate_unique_skill> cooperateUniqueSkillDict_ = new MapField<int, cooperate_unique_skill>();

	public const int DiffcultyDictFieldNumber = 80;

	private static readonly MapField<int, diffculty>.Codec _map_diffcultyDict_codec = new MapField<int, diffculty>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, diffculty.Parser), 642u);

	private readonly MapField<int, diffculty> diffcultyDict_ = new MapField<int, diffculty>();

	public const int EquipEffectDictFieldNumber = 81;

	private static readonly MapField<int, equip_effect>.Codec _map_equipEffectDict_codec = new MapField<int, equip_effect>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, equip_effect.Parser), 650u);

	private readonly MapField<int, equip_effect> equipEffectDict_ = new MapField<int, equip_effect>();

	public const int EquipSkillDictFieldNumber = 82;

	private static readonly MapField<int, equip_skill>.Codec _map_equipSkillDict_codec = new MapField<int, equip_skill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, equip_skill.Parser), 658u);

	private readonly MapField<int, equip_skill> equipSkillDict_ = new MapField<int, equip_skill>();

	public const int MonsterStandardDictFieldNumber = 83;

	private static readonly MapField<int, monster_standard>.Codec _map_monsterStandardDict_codec = new MapField<int, monster_standard>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, monster_standard.Parser), 666u);

	private readonly MapField<int, monster_standard> monsterStandardDict_ = new MapField<int, monster_standard>();

	public const int PublicAttribDictFieldNumber = 84;

	private static readonly MapField<int, public_attrib>.Codec _map_publicAttribDict_codec = new MapField<int, public_attrib>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, public_attrib.Parser), 674u);

	private readonly MapField<int, public_attrib> publicAttribDict_ = new MapField<int, public_attrib>();

	public const int PublicBuffDictFieldNumber = 85;

	private static readonly MapField<int, public_buff>.Codec _map_publicBuffDict_codec = new MapField<int, public_buff>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, public_buff.Parser), 682u);

	private readonly MapField<int, public_buff> publicBuffDict_ = new MapField<int, public_buff>();

	public const int PublicBuffRelationDictFieldNumber = 86;

	private static readonly MapField<int, public_buff_relation>.Codec _map_publicBuffRelationDict_codec = new MapField<int, public_buff_relation>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, public_buff_relation.Parser), 690u);

	private readonly MapField<int, public_buff_relation> publicBuffRelationDict_ = new MapField<int, public_buff_relation>();

	public const int PublicSkillDictFieldNumber = 87;

	private static readonly MapField<int, public_skill>.Codec _map_publicSkillDict_codec = new MapField<int, public_skill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, public_skill.Parser), 698u);

	private readonly MapField<int, public_skill> publicSkillDict_ = new MapField<int, public_skill>();

	public const int PublicStrengthenSkillDictFieldNumber = 88;

	private static readonly MapField<int, public_strengthen_skill>.Codec _map_publicStrengthenSkillDict_codec = new MapField<int, public_strengthen_skill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, public_strengthen_skill.Parser), 706u);

	private readonly MapField<int, public_strengthen_skill> publicStrengthenSkillDict_ = new MapField<int, public_strengthen_skill>();

	public const int SkillDictFieldNumber = 89;

	private static readonly MapField<int, skill>.Codec _map_skillDict_codec = new MapField<int, skill>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, skill.Parser), 714u);

	private readonly MapField<int, skill> skillDict_ = new MapField<int, skill>();

	public const int WeaponEffectDictFieldNumber = 90;

	private static readonly MapField<int, weapon_effect>.Codec _map_weaponEffectDict_codec = new MapField<int, weapon_effect>.Codec(FieldCodec.ForInt32(8u), FieldCodec.ForMessage(18u, weapon_effect.Parser), 722u);

	private readonly MapField<int, weapon_effect> weaponEffectDict_ = new MapField<int, weapon_effect>();

	[DebuggerNonUserCode]
	public static MessageParser<DataHelper> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[94];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<string> MessageType => messageType_;

	[DebuggerNonUserCode]
	public MapField<int, AbilityConfig> AbilityConfigDict => abilityConfigDict_;

	[DebuggerNonUserCode]
	public MapField<int, AbilityGrabNodeInfo> AbilityGrabNodeInfoDict => abilityGrabNodeInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, AbilityRangeIndicator> AbilityRangeIndicatorDict => abilityRangeIndicatorDict_;

	[DebuggerNonUserCode]
	public MapField<int, AbilitySpeedInfo> AbilitySpeedInfoDict => abilitySpeedInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, AbilityStateInfo> AbilityStateInfoDict => abilityStateInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, AbilityThrowNodeInfo> AbilityThrowNodeInfoDict => abilityThrowNodeInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, ActivityStrikeSystem> ActivityStrikeSystemDict => activityStrikeSystemDict_;

	[DebuggerNonUserCode]
	public MapField<int, AttackApproachInfo> AttackApproachInfoDict => attackApproachInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, Auto_Generate_Ability_State_Index> AutoGenerateAbilityStateIndexDict => autoGenerateAbilityStateIndexDict_;

	[DebuggerNonUserCode]
	public MapField<int, Auto_Generate_Interrupt_Other> AutoGenerateInterruptOtherDict => autoGenerateInterruptOtherDict_;

	[DebuggerNonUserCode]
	public MapField<int, Auto_Generate_Interrupt_Self> AutoGenerateInterruptSelfDict => autoGenerateInterruptSelfDict_;

	[DebuggerNonUserCode]
	public MapField<int, BattleTips> BattleTipsDict => battleTipsDict_;

	[DebuggerNonUserCode]
	public MapField<int, BuffConfig> BuffConfigDict => buffConfigDict_;

	[DebuggerNonUserCode]
	public MapField<int, BuffItem> BuffItemDict => buffItemDict_;

	[DebuggerNonUserCode]
	public MapField<int, CDCompensationInfo> CDCompensationInfoDict => cDCompensationInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, CameraTypeInfo> CameraTypeInfoDict => cameraTypeInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, CantBreakStateInfo> CantBreakStateInfoDict => cantBreakStateInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, CharacterTurnInfo> CharacterTurnInfoDict => characterTurnInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, CombatScore> CombatScoreDict => combatScoreDict_;

	[DebuggerNonUserCode]
	public MapField<int, CommonAudio> CommonAudioDict => commonAudioDict_;

	[DebuggerNonUserCode]
	public MapField<int, CommonEffect> CommonEffectDict => commonEffectDict_;

	[DebuggerNonUserCode]
	public MapField<int, CommonHit> CommonHitDict => commonHitDict_;

	[DebuggerNonUserCode]
	public MapField<int, DangerRangeForAIInfo> DangerRangeForAIInfoDict => dangerRangeForAIInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, FollowCameraParam> FollowCameraParamDict => followCameraParamDict_;

	[DebuggerNonUserCode]
	public MapField<int, HitCheckInfo> HitCheckInfoDict => hitCheckInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, HitFeedback> HitFeedbackDict => hitFeedbackDict_;

	[DebuggerNonUserCode]
	public MapField<int, HitHeightInfo> HitHeightInfoDict => hitHeightInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, InputActionTimelineNode> InputActionTimelineNodeDict => inputActionTimelineNodeDict_;

	[DebuggerNonUserCode]
	public MapField<int, Int3> Int3Dict => int3Dict_;

	[DebuggerNonUserCode]
	public MapField<int, InterestConfig> InterestConfigDict => interestConfigDict_;

	[DebuggerNonUserCode]
	public MapField<int, Item> ItemDict => itemDict_;

	[DebuggerNonUserCode]
	public MapField<int, Keyframe> KeyframeDict => keyframeDict_;

	[DebuggerNonUserCode]
	public MapField<int, LinkFunction> LinkFunctionDict => linkFunctionDict_;

	[DebuggerNonUserCode]
	public MapField<int, LockActionNode> LockActionNodeDict => lockActionNodeDict_;

	[DebuggerNonUserCode]
	public MapField<int, LockLimitParam> LockLimitParamDict => lockLimitParamDict_;

	[DebuggerNonUserCode]
	public MapField<int, LockedCameraParam> LockedCameraParamDict => lockedCameraParamDict_;

	[DebuggerNonUserCode]
	public MapField<int, MonsterSpawnerConfig> MonsterSpawnerConfigDict => monsterSpawnerConfigDict_;

	[DebuggerNonUserCode]
	public MapField<int, MonsterSpawnerLevel> MonsterSpawnerLevelDict => monsterSpawnerLevelDict_;

	[DebuggerNonUserCode]
	public MapField<int, MoveActionTimelineNode> MoveActionTimelineNodeDict => moveActionTimelineNodeDict_;

	[DebuggerNonUserCode]
	public MapField<int, ParryActionInfo> ParryActionInfoDict => parryActionInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, PostDespawnThrownEventInfo> PostDespawnThrownEventInfoDict => postDespawnThrownEventInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, PostSpwanThrownEventInfo> PostSpwanThrownEventInfoDict => postSpwanThrownEventInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, Race> RaceDict => raceDict_;

	[DebuggerNonUserCode]
	public MapField<int, RoleConfig> RoleConfigDict => roleConfigDict_;

	[DebuggerNonUserCode]
	public MapField<int, RoleVoice> RoleVoiceDict => roleVoiceDict_;

	[DebuggerNonUserCode]
	public MapField<int, RuntimelineAnimationCurve> RuntimelineAnimationCurveDict => runtimelineAnimationCurveDict_;

	[DebuggerNonUserCode]
	public MapField<int, SceneBGM> SceneBGMDict => sceneBGMDict_;

	[DebuggerNonUserCode]
	public MapField<int, SceneMap> SceneMapDict => sceneMapDict_;

	[DebuggerNonUserCode]
	public MapField<int, ShapeEnableInfo> ShapeEnableInfoDict => shapeEnableInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, ShapeInfo> ShapeInfoDict => shapeInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, ShapeItemInfo> ShapeItemInfoDict => shapeItemInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, Skin> SkinDict => skinDict_;

	[DebuggerNonUserCode]
	public MapField<int, SourceSpace> SourceSpaceDict => sourceSpaceDict_;

	[DebuggerNonUserCode]
	public MapField<int, SpCharactorHitAudio> SpCharactorHitAudioDict => spCharactorHitAudioDict_;

	[DebuggerNonUserCode]
	public MapField<int, Story> StoryDict => storyDict_;

	[DebuggerNonUserCode]
	public MapField<int, TalkContent> TalkContentDict => talkContentDict_;

	[DebuggerNonUserCode]
	public MapField<int, ThrownBackActionInfo> ThrownBackActionInfoDict => thrownBackActionInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, ThrownCollisionCheckInfo> ThrownCollisionCheckInfoDict => thrownCollisionCheckInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, ThrownLockActionInfo> ThrownLockActionInfoDict => thrownLockActionInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, Timeline> TimelineDict => timelineDict_;

	[DebuggerNonUserCode]
	public MapField<int, TimelineRootMotionConfig> TimelineRootMotionConfigDict => timelineRootMotionConfigDict_;

	[DebuggerNonUserCode]
	public MapField<int, TransformActionInfo> TransformActionInfoDict => transformActionInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, UIAudio> UIAudioDict => uIAudioDict_;

	[DebuggerNonUserCode]
	public MapField<int, UltimateAvoidInfo> UltimateAvoidInfoDict => ultimateAvoidInfoDict_;

	[DebuggerNonUserCode]
	public MapField<int, UniqueSkill> UniqueSkillDict => uniqueSkillDict_;

	[DebuggerNonUserCode]
	public MapField<int, VectorInt3> VectorInt3Dict => vectorInt3Dict_;

	[DebuggerNonUserCode]
	public MapField<int, activity_online_match> ActivityOnlineMatchDict => activityOnlineMatchDict_;

	[DebuggerNonUserCode]
	public MapField<int, activity_online_tower> ActivityOnlineTowerDict => activityOnlineTowerDict_;

	[DebuggerNonUserCode]
	public MapField<int, activity_reforge_skill> ActivityReforgeSkillDict => activityReforgeSkillDict_;

	[DebuggerNonUserCode]
	public MapField<int, activity_tower_defense_point> ActivityTowerDefensePointDict => activityTowerDefensePointDict_;

	[DebuggerNonUserCode]
	public MapField<int, activity_tower_defense_tower> ActivityTowerDefenseTowerDict => activityTowerDefenseTowerDict_;

	[DebuggerNonUserCode]
	public MapField<int, affix_type> AffixTypeDict => affixTypeDict_;

	[DebuggerNonUserCode]
	public MapField<int, ai_chip> AiChipDict => aiChipDict_;

	[DebuggerNonUserCode]
	public MapField<int, battle_achievement> BattleAchievementDict => battleAchievementDict_;

	[DebuggerNonUserCode]
	public MapField<int, battle_record_data_type> BattleRecordDataTypeDict => battleRecordDataTypeDict_;

	[DebuggerNonUserCode]
	public MapField<int, boss_appear_UI_text> BossAppearUITextDict => bossAppearUITextDict_;

	[DebuggerNonUserCode]
	public MapField<int, charactor_param> CharactorParamDict => charactorParamDict_;

	[DebuggerNonUserCode]
	public MapField<int, cooperate_unique_skill> CooperateUniqueSkillDict => cooperateUniqueSkillDict_;

	[DebuggerNonUserCode]
	public MapField<int, diffculty> DiffcultyDict => diffcultyDict_;

	[DebuggerNonUserCode]
	public MapField<int, equip_effect> EquipEffectDict => equipEffectDict_;

	[DebuggerNonUserCode]
	public MapField<int, equip_skill> EquipSkillDict => equipSkillDict_;

	[DebuggerNonUserCode]
	public MapField<int, monster_standard> MonsterStandardDict => monsterStandardDict_;

	[DebuggerNonUserCode]
	public MapField<int, public_attrib> PublicAttribDict => publicAttribDict_;

	[DebuggerNonUserCode]
	public MapField<int, public_buff> PublicBuffDict => publicBuffDict_;

	[DebuggerNonUserCode]
	public MapField<int, public_buff_relation> PublicBuffRelationDict => publicBuffRelationDict_;

	[DebuggerNonUserCode]
	public MapField<int, public_skill> PublicSkillDict => publicSkillDict_;

	[DebuggerNonUserCode]
	public MapField<int, public_strengthen_skill> PublicStrengthenSkillDict => publicStrengthenSkillDict_;

	[DebuggerNonUserCode]
	public MapField<int, skill> SkillDict => skillDict_;

	[DebuggerNonUserCode]
	public MapField<int, weapon_effect> WeaponEffectDict => weaponEffectDict_;

	[DebuggerNonUserCode]
	public DataHelper()
	{
	}

	[DebuggerNonUserCode]
	public DataHelper(DataHelper other)
		: this()
	{
		messageType_ = other.messageType_.Clone();
		abilityConfigDict_ = other.abilityConfigDict_.Clone();
		abilityGrabNodeInfoDict_ = other.abilityGrabNodeInfoDict_.Clone();
		abilityRangeIndicatorDict_ = other.abilityRangeIndicatorDict_.Clone();
		abilitySpeedInfoDict_ = other.abilitySpeedInfoDict_.Clone();
		abilityStateInfoDict_ = other.abilityStateInfoDict_.Clone();
		abilityThrowNodeInfoDict_ = other.abilityThrowNodeInfoDict_.Clone();
		activityStrikeSystemDict_ = other.activityStrikeSystemDict_.Clone();
		attackApproachInfoDict_ = other.attackApproachInfoDict_.Clone();
		autoGenerateAbilityStateIndexDict_ = other.autoGenerateAbilityStateIndexDict_.Clone();
		autoGenerateInterruptOtherDict_ = other.autoGenerateInterruptOtherDict_.Clone();
		autoGenerateInterruptSelfDict_ = other.autoGenerateInterruptSelfDict_.Clone();
		battleTipsDict_ = other.battleTipsDict_.Clone();
		buffConfigDict_ = other.buffConfigDict_.Clone();
		buffItemDict_ = other.buffItemDict_.Clone();
		cDCompensationInfoDict_ = other.cDCompensationInfoDict_.Clone();
		cameraTypeInfoDict_ = other.cameraTypeInfoDict_.Clone();
		cantBreakStateInfoDict_ = other.cantBreakStateInfoDict_.Clone();
		characterTurnInfoDict_ = other.characterTurnInfoDict_.Clone();
		combatScoreDict_ = other.combatScoreDict_.Clone();
		commonAudioDict_ = other.commonAudioDict_.Clone();
		commonEffectDict_ = other.commonEffectDict_.Clone();
		commonHitDict_ = other.commonHitDict_.Clone();
		dangerRangeForAIInfoDict_ = other.dangerRangeForAIInfoDict_.Clone();
		followCameraParamDict_ = other.followCameraParamDict_.Clone();
		hitCheckInfoDict_ = other.hitCheckInfoDict_.Clone();
		hitFeedbackDict_ = other.hitFeedbackDict_.Clone();
		hitHeightInfoDict_ = other.hitHeightInfoDict_.Clone();
		inputActionTimelineNodeDict_ = other.inputActionTimelineNodeDict_.Clone();
		int3Dict_ = other.int3Dict_.Clone();
		interestConfigDict_ = other.interestConfigDict_.Clone();
		itemDict_ = other.itemDict_.Clone();
		keyframeDict_ = other.keyframeDict_.Clone();
		linkFunctionDict_ = other.linkFunctionDict_.Clone();
		lockActionNodeDict_ = other.lockActionNodeDict_.Clone();
		lockLimitParamDict_ = other.lockLimitParamDict_.Clone();
		lockedCameraParamDict_ = other.lockedCameraParamDict_.Clone();
		monsterSpawnerConfigDict_ = other.monsterSpawnerConfigDict_.Clone();
		monsterSpawnerLevelDict_ = other.monsterSpawnerLevelDict_.Clone();
		moveActionTimelineNodeDict_ = other.moveActionTimelineNodeDict_.Clone();
		parryActionInfoDict_ = other.parryActionInfoDict_.Clone();
		postDespawnThrownEventInfoDict_ = other.postDespawnThrownEventInfoDict_.Clone();
		postSpwanThrownEventInfoDict_ = other.postSpwanThrownEventInfoDict_.Clone();
		raceDict_ = other.raceDict_.Clone();
		roleConfigDict_ = other.roleConfigDict_.Clone();
		roleVoiceDict_ = other.roleVoiceDict_.Clone();
		runtimelineAnimationCurveDict_ = other.runtimelineAnimationCurveDict_.Clone();
		sceneBGMDict_ = other.sceneBGMDict_.Clone();
		sceneMapDict_ = other.sceneMapDict_.Clone();
		shapeEnableInfoDict_ = other.shapeEnableInfoDict_.Clone();
		shapeInfoDict_ = other.shapeInfoDict_.Clone();
		shapeItemInfoDict_ = other.shapeItemInfoDict_.Clone();
		skinDict_ = other.skinDict_.Clone();
		sourceSpaceDict_ = other.sourceSpaceDict_.Clone();
		spCharactorHitAudioDict_ = other.spCharactorHitAudioDict_.Clone();
		storyDict_ = other.storyDict_.Clone();
		talkContentDict_ = other.talkContentDict_.Clone();
		thrownBackActionInfoDict_ = other.thrownBackActionInfoDict_.Clone();
		thrownCollisionCheckInfoDict_ = other.thrownCollisionCheckInfoDict_.Clone();
		thrownLockActionInfoDict_ = other.thrownLockActionInfoDict_.Clone();
		timelineDict_ = other.timelineDict_.Clone();
		timelineRootMotionConfigDict_ = other.timelineRootMotionConfigDict_.Clone();
		transformActionInfoDict_ = other.transformActionInfoDict_.Clone();
		uIAudioDict_ = other.uIAudioDict_.Clone();
		ultimateAvoidInfoDict_ = other.ultimateAvoidInfoDict_.Clone();
		uniqueSkillDict_ = other.uniqueSkillDict_.Clone();
		vectorInt3Dict_ = other.vectorInt3Dict_.Clone();
		activityOnlineMatchDict_ = other.activityOnlineMatchDict_.Clone();
		activityOnlineTowerDict_ = other.activityOnlineTowerDict_.Clone();
		activityReforgeSkillDict_ = other.activityReforgeSkillDict_.Clone();
		activityTowerDefensePointDict_ = other.activityTowerDefensePointDict_.Clone();
		activityTowerDefenseTowerDict_ = other.activityTowerDefenseTowerDict_.Clone();
		affixTypeDict_ = other.affixTypeDict_.Clone();
		aiChipDict_ = other.aiChipDict_.Clone();
		battleAchievementDict_ = other.battleAchievementDict_.Clone();
		battleRecordDataTypeDict_ = other.battleRecordDataTypeDict_.Clone();
		bossAppearUITextDict_ = other.bossAppearUITextDict_.Clone();
		charactorParamDict_ = other.charactorParamDict_.Clone();
		cooperateUniqueSkillDict_ = other.cooperateUniqueSkillDict_.Clone();
		diffcultyDict_ = other.diffcultyDict_.Clone();
		equipEffectDict_ = other.equipEffectDict_.Clone();
		equipSkillDict_ = other.equipSkillDict_.Clone();
		monsterStandardDict_ = other.monsterStandardDict_.Clone();
		publicAttribDict_ = other.publicAttribDict_.Clone();
		publicBuffDict_ = other.publicBuffDict_.Clone();
		publicBuffRelationDict_ = other.publicBuffRelationDict_.Clone();
		publicSkillDict_ = other.publicSkillDict_.Clone();
		publicStrengthenSkillDict_ = other.publicStrengthenSkillDict_.Clone();
		skillDict_ = other.skillDict_.Clone();
		weaponEffectDict_ = other.weaponEffectDict_.Clone();
	}

	[DebuggerNonUserCode]
	public DataHelper Clone()
	{
		return new DataHelper(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DataHelper);
	}

	[DebuggerNonUserCode]
	public bool Equals(DataHelper other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!messageType_.Equals(other.messageType_))
		{
			return false;
		}
		if (!AbilityConfigDict.Equals(other.AbilityConfigDict))
		{
			return false;
		}
		if (!AbilityGrabNodeInfoDict.Equals(other.AbilityGrabNodeInfoDict))
		{
			return false;
		}
		if (!AbilityRangeIndicatorDict.Equals(other.AbilityRangeIndicatorDict))
		{
			return false;
		}
		if (!AbilitySpeedInfoDict.Equals(other.AbilitySpeedInfoDict))
		{
			return false;
		}
		if (!AbilityStateInfoDict.Equals(other.AbilityStateInfoDict))
		{
			return false;
		}
		if (!AbilityThrowNodeInfoDict.Equals(other.AbilityThrowNodeInfoDict))
		{
			return false;
		}
		if (!ActivityStrikeSystemDict.Equals(other.ActivityStrikeSystemDict))
		{
			return false;
		}
		if (!AttackApproachInfoDict.Equals(other.AttackApproachInfoDict))
		{
			return false;
		}
		if (!AutoGenerateAbilityStateIndexDict.Equals(other.AutoGenerateAbilityStateIndexDict))
		{
			return false;
		}
		if (!AutoGenerateInterruptOtherDict.Equals(other.AutoGenerateInterruptOtherDict))
		{
			return false;
		}
		if (!AutoGenerateInterruptSelfDict.Equals(other.AutoGenerateInterruptSelfDict))
		{
			return false;
		}
		if (!BattleTipsDict.Equals(other.BattleTipsDict))
		{
			return false;
		}
		if (!BuffConfigDict.Equals(other.BuffConfigDict))
		{
			return false;
		}
		if (!BuffItemDict.Equals(other.BuffItemDict))
		{
			return false;
		}
		if (!CDCompensationInfoDict.Equals(other.CDCompensationInfoDict))
		{
			return false;
		}
		if (!CameraTypeInfoDict.Equals(other.CameraTypeInfoDict))
		{
			return false;
		}
		if (!CantBreakStateInfoDict.Equals(other.CantBreakStateInfoDict))
		{
			return false;
		}
		if (!CharacterTurnInfoDict.Equals(other.CharacterTurnInfoDict))
		{
			return false;
		}
		if (!CombatScoreDict.Equals(other.CombatScoreDict))
		{
			return false;
		}
		if (!CommonAudioDict.Equals(other.CommonAudioDict))
		{
			return false;
		}
		if (!CommonEffectDict.Equals(other.CommonEffectDict))
		{
			return false;
		}
		if (!CommonHitDict.Equals(other.CommonHitDict))
		{
			return false;
		}
		if (!DangerRangeForAIInfoDict.Equals(other.DangerRangeForAIInfoDict))
		{
			return false;
		}
		if (!FollowCameraParamDict.Equals(other.FollowCameraParamDict))
		{
			return false;
		}
		if (!HitCheckInfoDict.Equals(other.HitCheckInfoDict))
		{
			return false;
		}
		if (!HitFeedbackDict.Equals(other.HitFeedbackDict))
		{
			return false;
		}
		if (!HitHeightInfoDict.Equals(other.HitHeightInfoDict))
		{
			return false;
		}
		if (!InputActionTimelineNodeDict.Equals(other.InputActionTimelineNodeDict))
		{
			return false;
		}
		if (!Int3Dict.Equals(other.Int3Dict))
		{
			return false;
		}
		if (!InterestConfigDict.Equals(other.InterestConfigDict))
		{
			return false;
		}
		if (!ItemDict.Equals(other.ItemDict))
		{
			return false;
		}
		if (!KeyframeDict.Equals(other.KeyframeDict))
		{
			return false;
		}
		if (!LinkFunctionDict.Equals(other.LinkFunctionDict))
		{
			return false;
		}
		if (!LockActionNodeDict.Equals(other.LockActionNodeDict))
		{
			return false;
		}
		if (!LockLimitParamDict.Equals(other.LockLimitParamDict))
		{
			return false;
		}
		if (!LockedCameraParamDict.Equals(other.LockedCameraParamDict))
		{
			return false;
		}
		if (!MonsterSpawnerConfigDict.Equals(other.MonsterSpawnerConfigDict))
		{
			return false;
		}
		if (!MonsterSpawnerLevelDict.Equals(other.MonsterSpawnerLevelDict))
		{
			return false;
		}
		if (!MoveActionTimelineNodeDict.Equals(other.MoveActionTimelineNodeDict))
		{
			return false;
		}
		if (!ParryActionInfoDict.Equals(other.ParryActionInfoDict))
		{
			return false;
		}
		if (!PostDespawnThrownEventInfoDict.Equals(other.PostDespawnThrownEventInfoDict))
		{
			return false;
		}
		if (!PostSpwanThrownEventInfoDict.Equals(other.PostSpwanThrownEventInfoDict))
		{
			return false;
		}
		if (!RaceDict.Equals(other.RaceDict))
		{
			return false;
		}
		if (!RoleConfigDict.Equals(other.RoleConfigDict))
		{
			return false;
		}
		if (!RoleVoiceDict.Equals(other.RoleVoiceDict))
		{
			return false;
		}
		if (!RuntimelineAnimationCurveDict.Equals(other.RuntimelineAnimationCurveDict))
		{
			return false;
		}
		if (!SceneBGMDict.Equals(other.SceneBGMDict))
		{
			return false;
		}
		if (!SceneMapDict.Equals(other.SceneMapDict))
		{
			return false;
		}
		if (!ShapeEnableInfoDict.Equals(other.ShapeEnableInfoDict))
		{
			return false;
		}
		if (!ShapeInfoDict.Equals(other.ShapeInfoDict))
		{
			return false;
		}
		if (!ShapeItemInfoDict.Equals(other.ShapeItemInfoDict))
		{
			return false;
		}
		if (!SkinDict.Equals(other.SkinDict))
		{
			return false;
		}
		if (!SourceSpaceDict.Equals(other.SourceSpaceDict))
		{
			return false;
		}
		if (!SpCharactorHitAudioDict.Equals(other.SpCharactorHitAudioDict))
		{
			return false;
		}
		if (!StoryDict.Equals(other.StoryDict))
		{
			return false;
		}
		if (!TalkContentDict.Equals(other.TalkContentDict))
		{
			return false;
		}
		if (!ThrownBackActionInfoDict.Equals(other.ThrownBackActionInfoDict))
		{
			return false;
		}
		if (!ThrownCollisionCheckInfoDict.Equals(other.ThrownCollisionCheckInfoDict))
		{
			return false;
		}
		if (!ThrownLockActionInfoDict.Equals(other.ThrownLockActionInfoDict))
		{
			return false;
		}
		if (!TimelineDict.Equals(other.TimelineDict))
		{
			return false;
		}
		if (!TimelineRootMotionConfigDict.Equals(other.TimelineRootMotionConfigDict))
		{
			return false;
		}
		if (!TransformActionInfoDict.Equals(other.TransformActionInfoDict))
		{
			return false;
		}
		if (!UIAudioDict.Equals(other.UIAudioDict))
		{
			return false;
		}
		if (!UltimateAvoidInfoDict.Equals(other.UltimateAvoidInfoDict))
		{
			return false;
		}
		if (!UniqueSkillDict.Equals(other.UniqueSkillDict))
		{
			return false;
		}
		if (!VectorInt3Dict.Equals(other.VectorInt3Dict))
		{
			return false;
		}
		if (!ActivityOnlineMatchDict.Equals(other.ActivityOnlineMatchDict))
		{
			return false;
		}
		if (!ActivityOnlineTowerDict.Equals(other.ActivityOnlineTowerDict))
		{
			return false;
		}
		if (!ActivityReforgeSkillDict.Equals(other.ActivityReforgeSkillDict))
		{
			return false;
		}
		if (!ActivityTowerDefensePointDict.Equals(other.ActivityTowerDefensePointDict))
		{
			return false;
		}
		if (!ActivityTowerDefenseTowerDict.Equals(other.ActivityTowerDefenseTowerDict))
		{
			return false;
		}
		if (!AffixTypeDict.Equals(other.AffixTypeDict))
		{
			return false;
		}
		if (!AiChipDict.Equals(other.AiChipDict))
		{
			return false;
		}
		if (!BattleAchievementDict.Equals(other.BattleAchievementDict))
		{
			return false;
		}
		if (!BattleRecordDataTypeDict.Equals(other.BattleRecordDataTypeDict))
		{
			return false;
		}
		if (!BossAppearUITextDict.Equals(other.BossAppearUITextDict))
		{
			return false;
		}
		if (!CharactorParamDict.Equals(other.CharactorParamDict))
		{
			return false;
		}
		if (!CooperateUniqueSkillDict.Equals(other.CooperateUniqueSkillDict))
		{
			return false;
		}
		if (!DiffcultyDict.Equals(other.DiffcultyDict))
		{
			return false;
		}
		if (!EquipEffectDict.Equals(other.EquipEffectDict))
		{
			return false;
		}
		if (!EquipSkillDict.Equals(other.EquipSkillDict))
		{
			return false;
		}
		if (!MonsterStandardDict.Equals(other.MonsterStandardDict))
		{
			return false;
		}
		if (!PublicAttribDict.Equals(other.PublicAttribDict))
		{
			return false;
		}
		if (!PublicBuffDict.Equals(other.PublicBuffDict))
		{
			return false;
		}
		if (!PublicBuffRelationDict.Equals(other.PublicBuffRelationDict))
		{
			return false;
		}
		if (!PublicSkillDict.Equals(other.PublicSkillDict))
		{
			return false;
		}
		if (!PublicStrengthenSkillDict.Equals(other.PublicStrengthenSkillDict))
		{
			return false;
		}
		if (!SkillDict.Equals(other.SkillDict))
		{
			return false;
		}
		if (!WeaponEffectDict.Equals(other.WeaponEffectDict))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		num ^= messageType_.GetHashCode();
		num ^= AbilityConfigDict.GetHashCode();
		num ^= AbilityGrabNodeInfoDict.GetHashCode();
		num ^= AbilityRangeIndicatorDict.GetHashCode();
		num ^= AbilitySpeedInfoDict.GetHashCode();
		num ^= AbilityStateInfoDict.GetHashCode();
		num ^= AbilityThrowNodeInfoDict.GetHashCode();
		num ^= ActivityStrikeSystemDict.GetHashCode();
		num ^= AttackApproachInfoDict.GetHashCode();
		num ^= AutoGenerateAbilityStateIndexDict.GetHashCode();
		num ^= AutoGenerateInterruptOtherDict.GetHashCode();
		num ^= AutoGenerateInterruptSelfDict.GetHashCode();
		num ^= BattleTipsDict.GetHashCode();
		num ^= BuffConfigDict.GetHashCode();
		num ^= BuffItemDict.GetHashCode();
		num ^= CDCompensationInfoDict.GetHashCode();
		num ^= CameraTypeInfoDict.GetHashCode();
		num ^= CantBreakStateInfoDict.GetHashCode();
		num ^= CharacterTurnInfoDict.GetHashCode();
		num ^= CombatScoreDict.GetHashCode();
		num ^= CommonAudioDict.GetHashCode();
		num ^= CommonEffectDict.GetHashCode();
		num ^= CommonHitDict.GetHashCode();
		num ^= DangerRangeForAIInfoDict.GetHashCode();
		num ^= FollowCameraParamDict.GetHashCode();
		num ^= HitCheckInfoDict.GetHashCode();
		num ^= HitFeedbackDict.GetHashCode();
		num ^= HitHeightInfoDict.GetHashCode();
		num ^= InputActionTimelineNodeDict.GetHashCode();
		num ^= Int3Dict.GetHashCode();
		num ^= InterestConfigDict.GetHashCode();
		num ^= ItemDict.GetHashCode();
		num ^= KeyframeDict.GetHashCode();
		num ^= LinkFunctionDict.GetHashCode();
		num ^= LockActionNodeDict.GetHashCode();
		num ^= LockLimitParamDict.GetHashCode();
		num ^= LockedCameraParamDict.GetHashCode();
		num ^= MonsterSpawnerConfigDict.GetHashCode();
		num ^= MonsterSpawnerLevelDict.GetHashCode();
		num ^= MoveActionTimelineNodeDict.GetHashCode();
		num ^= ParryActionInfoDict.GetHashCode();
		num ^= PostDespawnThrownEventInfoDict.GetHashCode();
		num ^= PostSpwanThrownEventInfoDict.GetHashCode();
		num ^= RaceDict.GetHashCode();
		num ^= RoleConfigDict.GetHashCode();
		num ^= RoleVoiceDict.GetHashCode();
		num ^= RuntimelineAnimationCurveDict.GetHashCode();
		num ^= SceneBGMDict.GetHashCode();
		num ^= SceneMapDict.GetHashCode();
		num ^= ShapeEnableInfoDict.GetHashCode();
		num ^= ShapeInfoDict.GetHashCode();
		num ^= ShapeItemInfoDict.GetHashCode();
		num ^= SkinDict.GetHashCode();
		num ^= SourceSpaceDict.GetHashCode();
		num ^= SpCharactorHitAudioDict.GetHashCode();
		num ^= StoryDict.GetHashCode();
		num ^= TalkContentDict.GetHashCode();
		num ^= ThrownBackActionInfoDict.GetHashCode();
		num ^= ThrownCollisionCheckInfoDict.GetHashCode();
		num ^= ThrownLockActionInfoDict.GetHashCode();
		num ^= TimelineDict.GetHashCode();
		num ^= TimelineRootMotionConfigDict.GetHashCode();
		num ^= TransformActionInfoDict.GetHashCode();
		num ^= UIAudioDict.GetHashCode();
		num ^= UltimateAvoidInfoDict.GetHashCode();
		num ^= UniqueSkillDict.GetHashCode();
		num ^= VectorInt3Dict.GetHashCode();
		num ^= ActivityOnlineMatchDict.GetHashCode();
		num ^= ActivityOnlineTowerDict.GetHashCode();
		num ^= ActivityReforgeSkillDict.GetHashCode();
		num ^= ActivityTowerDefensePointDict.GetHashCode();
		num ^= ActivityTowerDefenseTowerDict.GetHashCode();
		num ^= AffixTypeDict.GetHashCode();
		num ^= AiChipDict.GetHashCode();
		num ^= BattleAchievementDict.GetHashCode();
		num ^= BattleRecordDataTypeDict.GetHashCode();
		num ^= BossAppearUITextDict.GetHashCode();
		num ^= CharactorParamDict.GetHashCode();
		num ^= CooperateUniqueSkillDict.GetHashCode();
		num ^= DiffcultyDict.GetHashCode();
		num ^= EquipEffectDict.GetHashCode();
		num ^= EquipSkillDict.GetHashCode();
		num ^= MonsterStandardDict.GetHashCode();
		num ^= PublicAttribDict.GetHashCode();
		num ^= PublicBuffDict.GetHashCode();
		num ^= PublicBuffRelationDict.GetHashCode();
		num ^= PublicSkillDict.GetHashCode();
		num ^= PublicStrengthenSkillDict.GetHashCode();
		num ^= SkillDict.GetHashCode();
		return num ^ WeaponEffectDict.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		messageType_.WriteTo(output, _repeated_messageType_codec);
		abilityConfigDict_.WriteTo(output, _map_abilityConfigDict_codec);
		abilityGrabNodeInfoDict_.WriteTo(output, _map_abilityGrabNodeInfoDict_codec);
		abilityRangeIndicatorDict_.WriteTo(output, _map_abilityRangeIndicatorDict_codec);
		abilitySpeedInfoDict_.WriteTo(output, _map_abilitySpeedInfoDict_codec);
		abilityStateInfoDict_.WriteTo(output, _map_abilityStateInfoDict_codec);
		abilityThrowNodeInfoDict_.WriteTo(output, _map_abilityThrowNodeInfoDict_codec);
		activityStrikeSystemDict_.WriteTo(output, _map_activityStrikeSystemDict_codec);
		attackApproachInfoDict_.WriteTo(output, _map_attackApproachInfoDict_codec);
		autoGenerateAbilityStateIndexDict_.WriteTo(output, _map_autoGenerateAbilityStateIndexDict_codec);
		autoGenerateInterruptOtherDict_.WriteTo(output, _map_autoGenerateInterruptOtherDict_codec);
		autoGenerateInterruptSelfDict_.WriteTo(output, _map_autoGenerateInterruptSelfDict_codec);
		battleTipsDict_.WriteTo(output, _map_battleTipsDict_codec);
		buffConfigDict_.WriteTo(output, _map_buffConfigDict_codec);
		buffItemDict_.WriteTo(output, _map_buffItemDict_codec);
		cDCompensationInfoDict_.WriteTo(output, _map_cDCompensationInfoDict_codec);
		cameraTypeInfoDict_.WriteTo(output, _map_cameraTypeInfoDict_codec);
		cantBreakStateInfoDict_.WriteTo(output, _map_cantBreakStateInfoDict_codec);
		characterTurnInfoDict_.WriteTo(output, _map_characterTurnInfoDict_codec);
		combatScoreDict_.WriteTo(output, _map_combatScoreDict_codec);
		commonAudioDict_.WriteTo(output, _map_commonAudioDict_codec);
		commonEffectDict_.WriteTo(output, _map_commonEffectDict_codec);
		commonHitDict_.WriteTo(output, _map_commonHitDict_codec);
		dangerRangeForAIInfoDict_.WriteTo(output, _map_dangerRangeForAIInfoDict_codec);
		followCameraParamDict_.WriteTo(output, _map_followCameraParamDict_codec);
		hitCheckInfoDict_.WriteTo(output, _map_hitCheckInfoDict_codec);
		hitFeedbackDict_.WriteTo(output, _map_hitFeedbackDict_codec);
		hitHeightInfoDict_.WriteTo(output, _map_hitHeightInfoDict_codec);
		inputActionTimelineNodeDict_.WriteTo(output, _map_inputActionTimelineNodeDict_codec);
		int3Dict_.WriteTo(output, _map_int3Dict_codec);
		interestConfigDict_.WriteTo(output, _map_interestConfigDict_codec);
		itemDict_.WriteTo(output, _map_itemDict_codec);
		keyframeDict_.WriteTo(output, _map_keyframeDict_codec);
		linkFunctionDict_.WriteTo(output, _map_linkFunctionDict_codec);
		lockActionNodeDict_.WriteTo(output, _map_lockActionNodeDict_codec);
		lockLimitParamDict_.WriteTo(output, _map_lockLimitParamDict_codec);
		lockedCameraParamDict_.WriteTo(output, _map_lockedCameraParamDict_codec);
		monsterSpawnerConfigDict_.WriteTo(output, _map_monsterSpawnerConfigDict_codec);
		monsterSpawnerLevelDict_.WriteTo(output, _map_monsterSpawnerLevelDict_codec);
		moveActionTimelineNodeDict_.WriteTo(output, _map_moveActionTimelineNodeDict_codec);
		parryActionInfoDict_.WriteTo(output, _map_parryActionInfoDict_codec);
		postDespawnThrownEventInfoDict_.WriteTo(output, _map_postDespawnThrownEventInfoDict_codec);
		postSpwanThrownEventInfoDict_.WriteTo(output, _map_postSpwanThrownEventInfoDict_codec);
		raceDict_.WriteTo(output, _map_raceDict_codec);
		roleConfigDict_.WriteTo(output, _map_roleConfigDict_codec);
		roleVoiceDict_.WriteTo(output, _map_roleVoiceDict_codec);
		runtimelineAnimationCurveDict_.WriteTo(output, _map_runtimelineAnimationCurveDict_codec);
		sceneBGMDict_.WriteTo(output, _map_sceneBGMDict_codec);
		sceneMapDict_.WriteTo(output, _map_sceneMapDict_codec);
		shapeEnableInfoDict_.WriteTo(output, _map_shapeEnableInfoDict_codec);
		shapeInfoDict_.WriteTo(output, _map_shapeInfoDict_codec);
		shapeItemInfoDict_.WriteTo(output, _map_shapeItemInfoDict_codec);
		skinDict_.WriteTo(output, _map_skinDict_codec);
		sourceSpaceDict_.WriteTo(output, _map_sourceSpaceDict_codec);
		spCharactorHitAudioDict_.WriteTo(output, _map_spCharactorHitAudioDict_codec);
		storyDict_.WriteTo(output, _map_storyDict_codec);
		talkContentDict_.WriteTo(output, _map_talkContentDict_codec);
		thrownBackActionInfoDict_.WriteTo(output, _map_thrownBackActionInfoDict_codec);
		thrownCollisionCheckInfoDict_.WriteTo(output, _map_thrownCollisionCheckInfoDict_codec);
		thrownLockActionInfoDict_.WriteTo(output, _map_thrownLockActionInfoDict_codec);
		timelineDict_.WriteTo(output, _map_timelineDict_codec);
		timelineRootMotionConfigDict_.WriteTo(output, _map_timelineRootMotionConfigDict_codec);
		transformActionInfoDict_.WriteTo(output, _map_transformActionInfoDict_codec);
		uIAudioDict_.WriteTo(output, _map_uIAudioDict_codec);
		ultimateAvoidInfoDict_.WriteTo(output, _map_ultimateAvoidInfoDict_codec);
		uniqueSkillDict_.WriteTo(output, _map_uniqueSkillDict_codec);
		vectorInt3Dict_.WriteTo(output, _map_vectorInt3Dict_codec);
		activityOnlineMatchDict_.WriteTo(output, _map_activityOnlineMatchDict_codec);
		activityOnlineTowerDict_.WriteTo(output, _map_activityOnlineTowerDict_codec);
		activityReforgeSkillDict_.WriteTo(output, _map_activityReforgeSkillDict_codec);
		activityTowerDefensePointDict_.WriteTo(output, _map_activityTowerDefensePointDict_codec);
		activityTowerDefenseTowerDict_.WriteTo(output, _map_activityTowerDefenseTowerDict_codec);
		affixTypeDict_.WriteTo(output, _map_affixTypeDict_codec);
		aiChipDict_.WriteTo(output, _map_aiChipDict_codec);
		battleAchievementDict_.WriteTo(output, _map_battleAchievementDict_codec);
		battleRecordDataTypeDict_.WriteTo(output, _map_battleRecordDataTypeDict_codec);
		bossAppearUITextDict_.WriteTo(output, _map_bossAppearUITextDict_codec);
		charactorParamDict_.WriteTo(output, _map_charactorParamDict_codec);
		cooperateUniqueSkillDict_.WriteTo(output, _map_cooperateUniqueSkillDict_codec);
		diffcultyDict_.WriteTo(output, _map_diffcultyDict_codec);
		equipEffectDict_.WriteTo(output, _map_equipEffectDict_codec);
		equipSkillDict_.WriteTo(output, _map_equipSkillDict_codec);
		monsterStandardDict_.WriteTo(output, _map_monsterStandardDict_codec);
		publicAttribDict_.WriteTo(output, _map_publicAttribDict_codec);
		publicBuffDict_.WriteTo(output, _map_publicBuffDict_codec);
		publicBuffRelationDict_.WriteTo(output, _map_publicBuffRelationDict_codec);
		publicSkillDict_.WriteTo(output, _map_publicSkillDict_codec);
		publicStrengthenSkillDict_.WriteTo(output, _map_publicStrengthenSkillDict_codec);
		skillDict_.WriteTo(output, _map_skillDict_codec);
		weaponEffectDict_.WriteTo(output, _map_weaponEffectDict_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		num += messageType_.CalculateSize(_repeated_messageType_codec);
		num += abilityConfigDict_.CalculateSize(_map_abilityConfigDict_codec);
		num += abilityGrabNodeInfoDict_.CalculateSize(_map_abilityGrabNodeInfoDict_codec);
		num += abilityRangeIndicatorDict_.CalculateSize(_map_abilityRangeIndicatorDict_codec);
		num += abilitySpeedInfoDict_.CalculateSize(_map_abilitySpeedInfoDict_codec);
		num += abilityStateInfoDict_.CalculateSize(_map_abilityStateInfoDict_codec);
		num += abilityThrowNodeInfoDict_.CalculateSize(_map_abilityThrowNodeInfoDict_codec);
		num += activityStrikeSystemDict_.CalculateSize(_map_activityStrikeSystemDict_codec);
		num += attackApproachInfoDict_.CalculateSize(_map_attackApproachInfoDict_codec);
		num += autoGenerateAbilityStateIndexDict_.CalculateSize(_map_autoGenerateAbilityStateIndexDict_codec);
		num += autoGenerateInterruptOtherDict_.CalculateSize(_map_autoGenerateInterruptOtherDict_codec);
		num += autoGenerateInterruptSelfDict_.CalculateSize(_map_autoGenerateInterruptSelfDict_codec);
		num += battleTipsDict_.CalculateSize(_map_battleTipsDict_codec);
		num += buffConfigDict_.CalculateSize(_map_buffConfigDict_codec);
		num += buffItemDict_.CalculateSize(_map_buffItemDict_codec);
		num += cDCompensationInfoDict_.CalculateSize(_map_cDCompensationInfoDict_codec);
		num += cameraTypeInfoDict_.CalculateSize(_map_cameraTypeInfoDict_codec);
		num += cantBreakStateInfoDict_.CalculateSize(_map_cantBreakStateInfoDict_codec);
		num += characterTurnInfoDict_.CalculateSize(_map_characterTurnInfoDict_codec);
		num += combatScoreDict_.CalculateSize(_map_combatScoreDict_codec);
		num += commonAudioDict_.CalculateSize(_map_commonAudioDict_codec);
		num += commonEffectDict_.CalculateSize(_map_commonEffectDict_codec);
		num += commonHitDict_.CalculateSize(_map_commonHitDict_codec);
		num += dangerRangeForAIInfoDict_.CalculateSize(_map_dangerRangeForAIInfoDict_codec);
		num += followCameraParamDict_.CalculateSize(_map_followCameraParamDict_codec);
		num += hitCheckInfoDict_.CalculateSize(_map_hitCheckInfoDict_codec);
		num += hitFeedbackDict_.CalculateSize(_map_hitFeedbackDict_codec);
		num += hitHeightInfoDict_.CalculateSize(_map_hitHeightInfoDict_codec);
		num += inputActionTimelineNodeDict_.CalculateSize(_map_inputActionTimelineNodeDict_codec);
		num += int3Dict_.CalculateSize(_map_int3Dict_codec);
		num += interestConfigDict_.CalculateSize(_map_interestConfigDict_codec);
		num += itemDict_.CalculateSize(_map_itemDict_codec);
		num += keyframeDict_.CalculateSize(_map_keyframeDict_codec);
		num += linkFunctionDict_.CalculateSize(_map_linkFunctionDict_codec);
		num += lockActionNodeDict_.CalculateSize(_map_lockActionNodeDict_codec);
		num += lockLimitParamDict_.CalculateSize(_map_lockLimitParamDict_codec);
		num += lockedCameraParamDict_.CalculateSize(_map_lockedCameraParamDict_codec);
		num += monsterSpawnerConfigDict_.CalculateSize(_map_monsterSpawnerConfigDict_codec);
		num += monsterSpawnerLevelDict_.CalculateSize(_map_monsterSpawnerLevelDict_codec);
		num += moveActionTimelineNodeDict_.CalculateSize(_map_moveActionTimelineNodeDict_codec);
		num += parryActionInfoDict_.CalculateSize(_map_parryActionInfoDict_codec);
		num += postDespawnThrownEventInfoDict_.CalculateSize(_map_postDespawnThrownEventInfoDict_codec);
		num += postSpwanThrownEventInfoDict_.CalculateSize(_map_postSpwanThrownEventInfoDict_codec);
		num += raceDict_.CalculateSize(_map_raceDict_codec);
		num += roleConfigDict_.CalculateSize(_map_roleConfigDict_codec);
		num += roleVoiceDict_.CalculateSize(_map_roleVoiceDict_codec);
		num += runtimelineAnimationCurveDict_.CalculateSize(_map_runtimelineAnimationCurveDict_codec);
		num += sceneBGMDict_.CalculateSize(_map_sceneBGMDict_codec);
		num += sceneMapDict_.CalculateSize(_map_sceneMapDict_codec);
		num += shapeEnableInfoDict_.CalculateSize(_map_shapeEnableInfoDict_codec);
		num += shapeInfoDict_.CalculateSize(_map_shapeInfoDict_codec);
		num += shapeItemInfoDict_.CalculateSize(_map_shapeItemInfoDict_codec);
		num += skinDict_.CalculateSize(_map_skinDict_codec);
		num += sourceSpaceDict_.CalculateSize(_map_sourceSpaceDict_codec);
		num += spCharactorHitAudioDict_.CalculateSize(_map_spCharactorHitAudioDict_codec);
		num += storyDict_.CalculateSize(_map_storyDict_codec);
		num += talkContentDict_.CalculateSize(_map_talkContentDict_codec);
		num += thrownBackActionInfoDict_.CalculateSize(_map_thrownBackActionInfoDict_codec);
		num += thrownCollisionCheckInfoDict_.CalculateSize(_map_thrownCollisionCheckInfoDict_codec);
		num += thrownLockActionInfoDict_.CalculateSize(_map_thrownLockActionInfoDict_codec);
		num += timelineDict_.CalculateSize(_map_timelineDict_codec);
		num += timelineRootMotionConfigDict_.CalculateSize(_map_timelineRootMotionConfigDict_codec);
		num += transformActionInfoDict_.CalculateSize(_map_transformActionInfoDict_codec);
		num += uIAudioDict_.CalculateSize(_map_uIAudioDict_codec);
		num += ultimateAvoidInfoDict_.CalculateSize(_map_ultimateAvoidInfoDict_codec);
		num += uniqueSkillDict_.CalculateSize(_map_uniqueSkillDict_codec);
		num += vectorInt3Dict_.CalculateSize(_map_vectorInt3Dict_codec);
		num += activityOnlineMatchDict_.CalculateSize(_map_activityOnlineMatchDict_codec);
		num += activityOnlineTowerDict_.CalculateSize(_map_activityOnlineTowerDict_codec);
		num += activityReforgeSkillDict_.CalculateSize(_map_activityReforgeSkillDict_codec);
		num += activityTowerDefensePointDict_.CalculateSize(_map_activityTowerDefensePointDict_codec);
		num += activityTowerDefenseTowerDict_.CalculateSize(_map_activityTowerDefenseTowerDict_codec);
		num += affixTypeDict_.CalculateSize(_map_affixTypeDict_codec);
		num += aiChipDict_.CalculateSize(_map_aiChipDict_codec);
		num += battleAchievementDict_.CalculateSize(_map_battleAchievementDict_codec);
		num += battleRecordDataTypeDict_.CalculateSize(_map_battleRecordDataTypeDict_codec);
		num += bossAppearUITextDict_.CalculateSize(_map_bossAppearUITextDict_codec);
		num += charactorParamDict_.CalculateSize(_map_charactorParamDict_codec);
		num += cooperateUniqueSkillDict_.CalculateSize(_map_cooperateUniqueSkillDict_codec);
		num += diffcultyDict_.CalculateSize(_map_diffcultyDict_codec);
		num += equipEffectDict_.CalculateSize(_map_equipEffectDict_codec);
		num += equipSkillDict_.CalculateSize(_map_equipSkillDict_codec);
		num += monsterStandardDict_.CalculateSize(_map_monsterStandardDict_codec);
		num += publicAttribDict_.CalculateSize(_map_publicAttribDict_codec);
		num += publicBuffDict_.CalculateSize(_map_publicBuffDict_codec);
		num += publicBuffRelationDict_.CalculateSize(_map_publicBuffRelationDict_codec);
		num += publicSkillDict_.CalculateSize(_map_publicSkillDict_codec);
		num += publicStrengthenSkillDict_.CalculateSize(_map_publicStrengthenSkillDict_codec);
		num += skillDict_.CalculateSize(_map_skillDict_codec);
		return num + weaponEffectDict_.CalculateSize(_map_weaponEffectDict_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DataHelper other)
	{
		if (other != null)
		{
			messageType_.Add(other.messageType_);
			abilityConfigDict_.Add(other.abilityConfigDict_);
			abilityGrabNodeInfoDict_.Add(other.abilityGrabNodeInfoDict_);
			abilityRangeIndicatorDict_.Add(other.abilityRangeIndicatorDict_);
			abilitySpeedInfoDict_.Add(other.abilitySpeedInfoDict_);
			abilityStateInfoDict_.Add(other.abilityStateInfoDict_);
			abilityThrowNodeInfoDict_.Add(other.abilityThrowNodeInfoDict_);
			activityStrikeSystemDict_.Add(other.activityStrikeSystemDict_);
			attackApproachInfoDict_.Add(other.attackApproachInfoDict_);
			autoGenerateAbilityStateIndexDict_.Add(other.autoGenerateAbilityStateIndexDict_);
			autoGenerateInterruptOtherDict_.Add(other.autoGenerateInterruptOtherDict_);
			autoGenerateInterruptSelfDict_.Add(other.autoGenerateInterruptSelfDict_);
			battleTipsDict_.Add(other.battleTipsDict_);
			buffConfigDict_.Add(other.buffConfigDict_);
			buffItemDict_.Add(other.buffItemDict_);
			cDCompensationInfoDict_.Add(other.cDCompensationInfoDict_);
			cameraTypeInfoDict_.Add(other.cameraTypeInfoDict_);
			cantBreakStateInfoDict_.Add(other.cantBreakStateInfoDict_);
			characterTurnInfoDict_.Add(other.characterTurnInfoDict_);
			combatScoreDict_.Add(other.combatScoreDict_);
			commonAudioDict_.Add(other.commonAudioDict_);
			commonEffectDict_.Add(other.commonEffectDict_);
			commonHitDict_.Add(other.commonHitDict_);
			dangerRangeForAIInfoDict_.Add(other.dangerRangeForAIInfoDict_);
			followCameraParamDict_.Add(other.followCameraParamDict_);
			hitCheckInfoDict_.Add(other.hitCheckInfoDict_);
			hitFeedbackDict_.Add(other.hitFeedbackDict_);
			hitHeightInfoDict_.Add(other.hitHeightInfoDict_);
			inputActionTimelineNodeDict_.Add(other.inputActionTimelineNodeDict_);
			int3Dict_.Add(other.int3Dict_);
			interestConfigDict_.Add(other.interestConfigDict_);
			itemDict_.Add(other.itemDict_);
			keyframeDict_.Add(other.keyframeDict_);
			linkFunctionDict_.Add(other.linkFunctionDict_);
			lockActionNodeDict_.Add(other.lockActionNodeDict_);
			lockLimitParamDict_.Add(other.lockLimitParamDict_);
			lockedCameraParamDict_.Add(other.lockedCameraParamDict_);
			monsterSpawnerConfigDict_.Add(other.monsterSpawnerConfigDict_);
			monsterSpawnerLevelDict_.Add(other.monsterSpawnerLevelDict_);
			moveActionTimelineNodeDict_.Add(other.moveActionTimelineNodeDict_);
			parryActionInfoDict_.Add(other.parryActionInfoDict_);
			postDespawnThrownEventInfoDict_.Add(other.postDespawnThrownEventInfoDict_);
			postSpwanThrownEventInfoDict_.Add(other.postSpwanThrownEventInfoDict_);
			raceDict_.Add(other.raceDict_);
			roleConfigDict_.Add(other.roleConfigDict_);
			roleVoiceDict_.Add(other.roleVoiceDict_);
			runtimelineAnimationCurveDict_.Add(other.runtimelineAnimationCurveDict_);
			sceneBGMDict_.Add(other.sceneBGMDict_);
			sceneMapDict_.Add(other.sceneMapDict_);
			shapeEnableInfoDict_.Add(other.shapeEnableInfoDict_);
			shapeInfoDict_.Add(other.shapeInfoDict_);
			shapeItemInfoDict_.Add(other.shapeItemInfoDict_);
			skinDict_.Add(other.skinDict_);
			sourceSpaceDict_.Add(other.sourceSpaceDict_);
			spCharactorHitAudioDict_.Add(other.spCharactorHitAudioDict_);
			storyDict_.Add(other.storyDict_);
			talkContentDict_.Add(other.talkContentDict_);
			thrownBackActionInfoDict_.Add(other.thrownBackActionInfoDict_);
			thrownCollisionCheckInfoDict_.Add(other.thrownCollisionCheckInfoDict_);
			thrownLockActionInfoDict_.Add(other.thrownLockActionInfoDict_);
			timelineDict_.Add(other.timelineDict_);
			timelineRootMotionConfigDict_.Add(other.timelineRootMotionConfigDict_);
			transformActionInfoDict_.Add(other.transformActionInfoDict_);
			uIAudioDict_.Add(other.uIAudioDict_);
			ultimateAvoidInfoDict_.Add(other.ultimateAvoidInfoDict_);
			uniqueSkillDict_.Add(other.uniqueSkillDict_);
			vectorInt3Dict_.Add(other.vectorInt3Dict_);
			activityOnlineMatchDict_.Add(other.activityOnlineMatchDict_);
			activityOnlineTowerDict_.Add(other.activityOnlineTowerDict_);
			activityReforgeSkillDict_.Add(other.activityReforgeSkillDict_);
			activityTowerDefensePointDict_.Add(other.activityTowerDefensePointDict_);
			activityTowerDefenseTowerDict_.Add(other.activityTowerDefenseTowerDict_);
			affixTypeDict_.Add(other.affixTypeDict_);
			aiChipDict_.Add(other.aiChipDict_);
			battleAchievementDict_.Add(other.battleAchievementDict_);
			battleRecordDataTypeDict_.Add(other.battleRecordDataTypeDict_);
			bossAppearUITextDict_.Add(other.bossAppearUITextDict_);
			charactorParamDict_.Add(other.charactorParamDict_);
			cooperateUniqueSkillDict_.Add(other.cooperateUniqueSkillDict_);
			diffcultyDict_.Add(other.diffcultyDict_);
			equipEffectDict_.Add(other.equipEffectDict_);
			equipSkillDict_.Add(other.equipSkillDict_);
			monsterStandardDict_.Add(other.monsterStandardDict_);
			publicAttribDict_.Add(other.publicAttribDict_);
			publicBuffDict_.Add(other.publicBuffDict_);
			publicBuffRelationDict_.Add(other.publicBuffRelationDict_);
			publicSkillDict_.Add(other.publicSkillDict_);
			publicStrengthenSkillDict_.Add(other.publicStrengthenSkillDict_);
			skillDict_.Add(other.skillDict_);
			weaponEffectDict_.Add(other.weaponEffectDict_);
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
			case 10u:
				messageType_.AddEntriesFrom(input, _repeated_messageType_codec);
				break;
			case 18u:
				abilityConfigDict_.AddEntriesFrom(input, _map_abilityConfigDict_codec);
				break;
			case 26u:
				abilityGrabNodeInfoDict_.AddEntriesFrom(input, _map_abilityGrabNodeInfoDict_codec);
				break;
			case 34u:
				abilityRangeIndicatorDict_.AddEntriesFrom(input, _map_abilityRangeIndicatorDict_codec);
				break;
			case 42u:
				abilitySpeedInfoDict_.AddEntriesFrom(input, _map_abilitySpeedInfoDict_codec);
				break;
			case 50u:
				abilityStateInfoDict_.AddEntriesFrom(input, _map_abilityStateInfoDict_codec);
				break;
			case 58u:
				abilityThrowNodeInfoDict_.AddEntriesFrom(input, _map_abilityThrowNodeInfoDict_codec);
				break;
			case 66u:
				activityStrikeSystemDict_.AddEntriesFrom(input, _map_activityStrikeSystemDict_codec);
				break;
			case 74u:
				attackApproachInfoDict_.AddEntriesFrom(input, _map_attackApproachInfoDict_codec);
				break;
			case 82u:
				autoGenerateAbilityStateIndexDict_.AddEntriesFrom(input, _map_autoGenerateAbilityStateIndexDict_codec);
				break;
			case 90u:
				autoGenerateInterruptOtherDict_.AddEntriesFrom(input, _map_autoGenerateInterruptOtherDict_codec);
				break;
			case 98u:
				autoGenerateInterruptSelfDict_.AddEntriesFrom(input, _map_autoGenerateInterruptSelfDict_codec);
				break;
			case 106u:
				battleTipsDict_.AddEntriesFrom(input, _map_battleTipsDict_codec);
				break;
			case 114u:
				buffConfigDict_.AddEntriesFrom(input, _map_buffConfigDict_codec);
				break;
			case 122u:
				buffItemDict_.AddEntriesFrom(input, _map_buffItemDict_codec);
				break;
			case 130u:
				cDCompensationInfoDict_.AddEntriesFrom(input, _map_cDCompensationInfoDict_codec);
				break;
			case 138u:
				cameraTypeInfoDict_.AddEntriesFrom(input, _map_cameraTypeInfoDict_codec);
				break;
			case 146u:
				cantBreakStateInfoDict_.AddEntriesFrom(input, _map_cantBreakStateInfoDict_codec);
				break;
			case 154u:
				characterTurnInfoDict_.AddEntriesFrom(input, _map_characterTurnInfoDict_codec);
				break;
			case 162u:
				combatScoreDict_.AddEntriesFrom(input, _map_combatScoreDict_codec);
				break;
			case 170u:
				commonAudioDict_.AddEntriesFrom(input, _map_commonAudioDict_codec);
				break;
			case 178u:
				commonEffectDict_.AddEntriesFrom(input, _map_commonEffectDict_codec);
				break;
			case 186u:
				commonHitDict_.AddEntriesFrom(input, _map_commonHitDict_codec);
				break;
			case 194u:
				dangerRangeForAIInfoDict_.AddEntriesFrom(input, _map_dangerRangeForAIInfoDict_codec);
				break;
			case 202u:
				followCameraParamDict_.AddEntriesFrom(input, _map_followCameraParamDict_codec);
				break;
			case 210u:
				hitCheckInfoDict_.AddEntriesFrom(input, _map_hitCheckInfoDict_codec);
				break;
			case 218u:
				hitFeedbackDict_.AddEntriesFrom(input, _map_hitFeedbackDict_codec);
				break;
			case 226u:
				hitHeightInfoDict_.AddEntriesFrom(input, _map_hitHeightInfoDict_codec);
				break;
			case 234u:
				inputActionTimelineNodeDict_.AddEntriesFrom(input, _map_inputActionTimelineNodeDict_codec);
				break;
			case 242u:
				int3Dict_.AddEntriesFrom(input, _map_int3Dict_codec);
				break;
			case 250u:
				interestConfigDict_.AddEntriesFrom(input, _map_interestConfigDict_codec);
				break;
			case 258u:
				itemDict_.AddEntriesFrom(input, _map_itemDict_codec);
				break;
			case 266u:
				keyframeDict_.AddEntriesFrom(input, _map_keyframeDict_codec);
				break;
			case 274u:
				linkFunctionDict_.AddEntriesFrom(input, _map_linkFunctionDict_codec);
				break;
			case 282u:
				lockActionNodeDict_.AddEntriesFrom(input, _map_lockActionNodeDict_codec);
				break;
			case 290u:
				lockLimitParamDict_.AddEntriesFrom(input, _map_lockLimitParamDict_codec);
				break;
			case 298u:
				lockedCameraParamDict_.AddEntriesFrom(input, _map_lockedCameraParamDict_codec);
				break;
			case 306u:
				monsterSpawnerConfigDict_.AddEntriesFrom(input, _map_monsterSpawnerConfigDict_codec);
				break;
			case 314u:
				monsterSpawnerLevelDict_.AddEntriesFrom(input, _map_monsterSpawnerLevelDict_codec);
				break;
			case 322u:
				moveActionTimelineNodeDict_.AddEntriesFrom(input, _map_moveActionTimelineNodeDict_codec);
				break;
			case 330u:
				parryActionInfoDict_.AddEntriesFrom(input, _map_parryActionInfoDict_codec);
				break;
			case 338u:
				postDespawnThrownEventInfoDict_.AddEntriesFrom(input, _map_postDespawnThrownEventInfoDict_codec);
				break;
			case 346u:
				postSpwanThrownEventInfoDict_.AddEntriesFrom(input, _map_postSpwanThrownEventInfoDict_codec);
				break;
			case 354u:
				raceDict_.AddEntriesFrom(input, _map_raceDict_codec);
				break;
			case 362u:
				roleConfigDict_.AddEntriesFrom(input, _map_roleConfigDict_codec);
				break;
			case 370u:
				roleVoiceDict_.AddEntriesFrom(input, _map_roleVoiceDict_codec);
				break;
			case 378u:
				runtimelineAnimationCurveDict_.AddEntriesFrom(input, _map_runtimelineAnimationCurveDict_codec);
				break;
			case 386u:
				sceneBGMDict_.AddEntriesFrom(input, _map_sceneBGMDict_codec);
				break;
			case 394u:
				sceneMapDict_.AddEntriesFrom(input, _map_sceneMapDict_codec);
				break;
			case 402u:
				shapeEnableInfoDict_.AddEntriesFrom(input, _map_shapeEnableInfoDict_codec);
				break;
			case 410u:
				shapeInfoDict_.AddEntriesFrom(input, _map_shapeInfoDict_codec);
				break;
			case 418u:
				shapeItemInfoDict_.AddEntriesFrom(input, _map_shapeItemInfoDict_codec);
				break;
			case 426u:
				skinDict_.AddEntriesFrom(input, _map_skinDict_codec);
				break;
			case 434u:
				sourceSpaceDict_.AddEntriesFrom(input, _map_sourceSpaceDict_codec);
				break;
			case 442u:
				spCharactorHitAudioDict_.AddEntriesFrom(input, _map_spCharactorHitAudioDict_codec);
				break;
			case 450u:
				storyDict_.AddEntriesFrom(input, _map_storyDict_codec);
				break;
			case 458u:
				talkContentDict_.AddEntriesFrom(input, _map_talkContentDict_codec);
				break;
			case 466u:
				thrownBackActionInfoDict_.AddEntriesFrom(input, _map_thrownBackActionInfoDict_codec);
				break;
			case 474u:
				thrownCollisionCheckInfoDict_.AddEntriesFrom(input, _map_thrownCollisionCheckInfoDict_codec);
				break;
			case 482u:
				thrownLockActionInfoDict_.AddEntriesFrom(input, _map_thrownLockActionInfoDict_codec);
				break;
			case 490u:
				timelineDict_.AddEntriesFrom(input, _map_timelineDict_codec);
				break;
			case 498u:
				timelineRootMotionConfigDict_.AddEntriesFrom(input, _map_timelineRootMotionConfigDict_codec);
				break;
			case 506u:
				transformActionInfoDict_.AddEntriesFrom(input, _map_transformActionInfoDict_codec);
				break;
			case 514u:
				uIAudioDict_.AddEntriesFrom(input, _map_uIAudioDict_codec);
				break;
			case 522u:
				ultimateAvoidInfoDict_.AddEntriesFrom(input, _map_ultimateAvoidInfoDict_codec);
				break;
			case 530u:
				uniqueSkillDict_.AddEntriesFrom(input, _map_uniqueSkillDict_codec);
				break;
			case 538u:
				vectorInt3Dict_.AddEntriesFrom(input, _map_vectorInt3Dict_codec);
				break;
			case 546u:
				activityOnlineMatchDict_.AddEntriesFrom(input, _map_activityOnlineMatchDict_codec);
				break;
			case 554u:
				activityOnlineTowerDict_.AddEntriesFrom(input, _map_activityOnlineTowerDict_codec);
				break;
			case 562u:
				activityReforgeSkillDict_.AddEntriesFrom(input, _map_activityReforgeSkillDict_codec);
				break;
			case 570u:
				activityTowerDefensePointDict_.AddEntriesFrom(input, _map_activityTowerDefensePointDict_codec);
				break;
			case 578u:
				activityTowerDefenseTowerDict_.AddEntriesFrom(input, _map_activityTowerDefenseTowerDict_codec);
				break;
			case 586u:
				affixTypeDict_.AddEntriesFrom(input, _map_affixTypeDict_codec);
				break;
			case 594u:
				aiChipDict_.AddEntriesFrom(input, _map_aiChipDict_codec);
				break;
			case 602u:
				battleAchievementDict_.AddEntriesFrom(input, _map_battleAchievementDict_codec);
				break;
			case 610u:
				battleRecordDataTypeDict_.AddEntriesFrom(input, _map_battleRecordDataTypeDict_codec);
				break;
			case 618u:
				bossAppearUITextDict_.AddEntriesFrom(input, _map_bossAppearUITextDict_codec);
				break;
			case 626u:
				charactorParamDict_.AddEntriesFrom(input, _map_charactorParamDict_codec);
				break;
			case 634u:
				cooperateUniqueSkillDict_.AddEntriesFrom(input, _map_cooperateUniqueSkillDict_codec);
				break;
			case 642u:
				diffcultyDict_.AddEntriesFrom(input, _map_diffcultyDict_codec);
				break;
			case 650u:
				equipEffectDict_.AddEntriesFrom(input, _map_equipEffectDict_codec);
				break;
			case 658u:
				equipSkillDict_.AddEntriesFrom(input, _map_equipSkillDict_codec);
				break;
			case 666u:
				monsterStandardDict_.AddEntriesFrom(input, _map_monsterStandardDict_codec);
				break;
			case 674u:
				publicAttribDict_.AddEntriesFrom(input, _map_publicAttribDict_codec);
				break;
			case 682u:
				publicBuffDict_.AddEntriesFrom(input, _map_publicBuffDict_codec);
				break;
			case 690u:
				publicBuffRelationDict_.AddEntriesFrom(input, _map_publicBuffRelationDict_codec);
				break;
			case 698u:
				publicSkillDict_.AddEntriesFrom(input, _map_publicSkillDict_codec);
				break;
			case 706u:
				publicStrengthenSkillDict_.AddEntriesFrom(input, _map_publicStrengthenSkillDict_codec);
				break;
			case 714u:
				skillDict_.AddEntriesFrom(input, _map_skillDict_codec);
				break;
			case 722u:
				weaponEffectDict_.AddEntriesFrom(input, _map_weaponEffectDict_codec);
				break;
			}
		}
	}
}

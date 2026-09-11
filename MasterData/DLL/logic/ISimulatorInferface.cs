using System;
using System.Collections.Generic;
using Config;
using Entitas.CodeGeneration.Attributes;

[Unique]
[IgnoreClone]
[CustomComponentName(new string[] { "SimulatorInterface" })]
[Sim]
public class ISimulatorInferface
{
	public Action<DamageEventParam, int, bool, bool> mUpdateAbilityInterruptLogicEvent;

	public Action<int, int, int, bool> mAbilityLogicInputInterruptEvent;

	public Action<int, ProtoEntityData> mLogicTriggerInitEvent;

	public Action<int, bool> mTriggerEnableEvent;

	public Action<int, int, int, int, int> mLogicTriggerParametersEvent;

	public Action<DamageEventParam, int, bool> mCanBeGrabExtensionEvent;

	public Action<int, bool> mCanBeTransferExtensionEvent;

	public Action<int, int> mChooseTargetEvent;

	public Action<int> mDestroyValLimitEvent;

	public Action<int, int, long, long> mDestroyValChangeEvent;

	public Action<int, int, int, int> mAbilitySlotsChangeEvent;

	public Action<int, EntityBreakEvent> mEntityBreakTriggerEvent;

	public Action<int> mButtonShootEvent;

	public Action<bool, int> mCooperateUniqueSkillStatusChangeEvent;

	public Action<int, int> mSignalExchangeEvent;

	public Action mUpdateLogicEvent { get; set; }

	public Action<int, int, int, int> mUpdateAbilityBeginLogicEvent { get; set; }

	public Action<int, int, int, int> mUpdateAbilityLogicEvent { get; set; }

	public Action<int, int, int, int> mUpdateAbilityEndLogicEvent { get; set; }

	public Action<int, int, int, int, int> mUpdateAbilityLogicTriggerEvent { get; set; }

	public Action<int, int, int> mAbilityFinishLogicEvent { get; set; }

	public Action<int, int, int> mAbilityAddedLogicEvent { get; set; }

	public Action<int, int> mUpdateAILogicEvent { get; set; }

	public Action<int, AICommand, int> mAICommandBeginEvent { get; set; }

	public Action<int, AICommand, int> mAICommandTimeoutEvent { get; set; }

	public Action<int, AICommand, int> mAICommandRunEvent { get; set; }

	public Action<int, AICommand, int> mAICommandEndEvent { get; set; }

	public Action<int, AICommand, int> mAICommandConditionEvent { get; set; }

	public Action<int, AIProcessor.AICommandStatus> mAICommandResetEvent { get; set; }

	public Action<int, AICommandSet, int> mAICommandSetConditionEvent { get; set; }

	public Action<int, AIProcessor.AICommandStatus> mAICommandMakeDecision { get; set; }

	public Action<int, int, int, EBuffLife, bool> mUpdateBuffLogicEvent { get; set; }

	public Action<int, int, int, int, EBuffLife, bool> mUpdateBuffLogicTriggerEvent { get; set; }

	public Action<int, int> mLogicInputEvent { get; set; }

	public Action<int, int, int> mLogicInputTriggerEvent { get; set; }

	public Action<int, HitTargetEvent> mHitTargetTriggerEvent { get; set; }

	public Action<int> mLogicTriggerEvent { get; set; }

	public Action<int, int, int> mBeforeHitTargetEvent { get; set; }

	public Action<DamageEventParam> mBeforeCalcDamageEvent { get; set; }

	public Action<DamageEventParam> mCalcDamageEvent { get; set; }

	public Action<int, DamageEventParam> mCalcDamageTriggerEvent { get; set; }

	public Action<DamageEventParam> mAfterCalcDamageEvent { get; set; }

	public Action<int, long, long, long, int, int, int, DamageType> mOnHPModify { get; set; }

	public Action<int, long, long, DamageType, int, int, int> mOnAfterHPModify { get; set; }

	public Action<int, int, int, int, int> mDoFinalActionEvent { get; set; }

	public Action<int> mPlayerAIAttackEvent { get; set; }

	public Action<int> mPostureBreakEvent { get; set; }

	public Action<int> mExposedValueBreakEvent { get; set; }

	public Action<int, int, int, int> mBuffFloorChangeEvent { get; set; }

	public Action<int> mComboTimeEvent { get; set; }

	public Action<int> mEnduranceUpdateEvent { get; set; }

	public Action<SpecialAIType, int, int, int> mSpecialAIEvent { get; set; }

	public Action<int, int, int, int> mHitCheckEvent { get; set; }

	public Action<int, int> mInitEnemyEvent { get; set; }

	public Action<int, bool> mResistanceEvent { get; set; }

	public Action<int, int, int, List<int>> mResistanceChangeEvent { get; set; }

	public Action<int, int> mPuppetEvent { get; set; }

	public Action<int, int, int> mPuppetHostDoAbilityEvent { get; set; }

	public Action<int, int, int, int> mPuppetHostAbilityOverEvent { get; set; }

	public Action<int> mInitEntityFinishedEvent { get; set; }

	public Action<int> mThrownProcessCustomSpawn { get; set; }

	public Action<int, int> mThrownProcessDirection { get; set; }

	public Action<int, int> mThrownProcessMovement { get; set; }

	public Action<int, int> mThrownProcessCollisionCheck { get; set; }

	public Action<int, int, int> mThrownUpdateAbilityLogicEvent { get; set; }

	public Action<int> mUpdateThrownTarget { get; set; }

	public Action<int, E_HitRecoverStatus> mUpdateHitRecover { get; set; }

	public Action<int> mUpdateBlackboardEvent { get; set; }

	public Action<int, int, int> mAddAffixEvent { get; set; }

	public Action<int, int, int, int, int, EnergyType> mOnPowerUpdate { get; set; }

	public Action<int> mCalculateCombatScoreLogic { get; set; }

	public Action<int, int> mOnAbilityInterruptBySelf { get; set; }

	public Action<int, StoryType, int> mOnEnterStory { get; set; }

	public Action<int, StoryType, int> mOnExitStory { get; set; }

	public Action<SourceSpaceEvent.E_SourceSpaceState, int, int> mSourceSpaceUpdateEvent { get; set; }

	public Action<int, AbilityCD> mCDEndEvent { get; set; }

	public Action<int, int, AbilityCD> mCDEndTriggerEvent { get; set; }

	public Action<int, AICommanderEventType> mCommanderCommandEvent { get; set; }

	public Action<int, int, int> mWillBeHitEvent { get; set; }

	public Action<int> mGSRecvBattleResultFinishEvent { get; set; }

	public Action<int, int> mManualAIInputEvent { get; set; }

	public Action<int, int, int, UltimateAvoidFrameEventType> mUltimateAvoidFrameEvent { get; set; }

	public Action<int, EntityActionStatus> mUniqueSkillPreparedStatus { get; set; }

	public Action<int> mUniqueSkillPrepared { get; set; }

	public Action mCooperateUniqueSkillPrepared { get; set; }

	public Action<int, int, int> mTransfigurationBeofreEvent { get; set; }

	public Action<int, int, int> mTransfigurationEvent { get; set; }

	public Action<int, int> mUniqueSkillEnergyAdditionalValueEvent { get; set; }

	public Action<int> mAIAddedLogicEvent { get; set; }

	public Action<int> mUpdateEntityMasterSkillEvent { get; set; }

	public Action<int> mEntityMasterSkillPreparedEvent { get; set; }
}

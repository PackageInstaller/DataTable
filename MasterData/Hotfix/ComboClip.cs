using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;
using UnityEngine.Serialization;

[CreateAssetMenu(fileName = "Combo Clip", menuName = "游戏/动作/连击动作配置")]
public class ComboClip : ScriptableObject
{
	public const float kDefaultFrameRate = 60f;

	public bool enableRootMotion;

	public FP rootMotionCheckDistance;

	public FP rootMotionCheckDistanceLimitUp;

	public TSAnimationCurve rootMotionSides = TSAnimationCurve.Linear(0f, 0f, 1f, 0f);

	public TSAnimationCurve rootMotionVertical = TSAnimationCurve.Linear(0f, 0f, 1f, 0f);

	public TSAnimationCurve rootMotionForward = TSAnimationCurve.Linear(0f, 0f, 1f, 0f);

	public TSVector rootMotionMultiplier = TSVector.one;

	public bool enableRootMotionRotate;

	public TSAnimationCurve rootMotionRotateQuaternionX = TSAnimationCurve.Linear(0f, 0f, 1f, 0f);

	public TSAnimationCurve rootMotionRotateQuaternionY = TSAnimationCurve.Linear(0f, 0f, 1f, 0f);

	public TSAnimationCurve rootMotionRotateQuaternionZ = TSAnimationCurve.Linear(0f, 0f, 1f, 0f);

	public TSAnimationCurve rootMotionRotateQuaternionW = TSAnimationCurve.Linear(0f, 1f, 1f, 1f);

	public AnimationClip animationClip;

	public HybirdAnimatorController.ActionAnimationType actionAnimType = HybirdAnimatorController.ActionAnimationType.ActionOverride;

	public FP transitionIn = 0.25f;

	public FP transitionOut = 0.25f;

	public FP animationLength = 1f;

	public FP playSpeed = 1f;

	[ComboClipFrameMinMaxSlider]
	public TSVector2 comboPhaseRange = new TSVector2(0.33f, 0.66f);

	public bool sendSkillTakeEffect;

	[ComboClipFrameSlider]
	public FP skillTakeEffectNormalizedTime = 0.5f;

	public bool sendSkillAllowOtherSkillExecute = true;

	[FormerlySerializedAs("skillAllowOtherSkillExccuteNormalizedTime")]
	[ComboClipFrameSlider]
	public FP skillAllowOtherSkillExecuteNormalizedTime = 0.5f;

	[FormerlySerializedAs("aimTargetCfgs")]
	public List<ChangeCurrentAttackTargetCfg> changeCurrentAttackTargetCfgs = new List<ChangeCurrentAttackTargetCfg>();

	public Dictionary<int, bool> changeCurrentAttackTargetTriggerDict = new Dictionary<int, bool>();

	[HideInInspector]
	public bool useExitTime;

	[ComboClipFrameSlider]
	[HideInInspector]
	public FP canExitNormalizedTime = 0.5f;

	public bool enableExtraEventGroup;

	public bool showEventUniqueID;

	public bool showEventPlayerSkinEventOverrideType;

	public Combo.EventSkin[] comboEventSkins;

	[NonSerialized]
	public List<Combo.Event> selectedComboEvents = new List<Combo.Event>();

	public Combo.EventGroup[] EventGroups;

	public Combo.FeaturePhase[] featurePhases;

	public void CalcRootMotion(FP time, out TSVector rootMotionTranslate, out TSQuaternion rootMotionRotate, out FP rootMotionRotateAngle)
	{
		rootMotionTranslate = TSVector.zero;
		rootMotionRotate = TSQuaternion.identity;
		rootMotionRotateAngle = FP.Zero;
		if (enableRootMotion)
		{
			FP x = rootMotionSides.Evaluate(time) * rootMotionMultiplier.x;
			FP y = rootMotionVertical.Evaluate(time) * rootMotionMultiplier.y;
			FP z = rootMotionForward.Evaluate(time) * rootMotionMultiplier.z;
			rootMotionTranslate = new TSVector(x, y, z);
		}
		if (enableRootMotionRotate)
		{
			rootMotionRotate.x = rootMotionRotateQuaternionX.Evaluate(time);
			rootMotionRotate.y = rootMotionRotateQuaternionY.Evaluate(time);
			rootMotionRotate.z = rootMotionRotateQuaternionZ.Evaluate(time);
			rootMotionRotate.w = rootMotionRotateQuaternionW.Evaluate(time);
			TSVector tSVector = rootMotionRotate * TSVector.forward;
			rootMotionRotateAngle = TSVector2.SignedAngle(b: new TSVector2(tSVector.x, tSVector.z), a: TSVector2.up);
		}
	}

	public Combo.Phase CalcComboPhase(FP normalizedTime)
	{
		if (normalizedTime < 0f || normalizedTime >= 1f)
		{
			return Combo.Phase.None;
		}
		if (normalizedTime >= comboPhaseRange.y)
		{
			return Combo.Phase.Recovery;
		}
		if (normalizedTime >= comboPhaseRange.x)
		{
			return Combo.Phase.Activation;
		}
		return Combo.Phase.Anticipation;
	}

	public FP GetComboPhaseAnimationLength(Combo.Phase phase)
	{
		switch (phase)
		{
		case Combo.Phase.Anticipation:
			return animationLength * comboPhaseRange.x;
		case Combo.Phase.Activation:
			return animationLength * comboPhaseRange.y;
		case Combo.Phase.Recovery:
			return animationLength;
		default:
			throw new ArgumentOutOfRangeException("phase", phase, null);
		case Combo.Phase.None:
		case Combo.Phase.All:
			return 0f;
		}
	}

	public FP GetComboPhaseAnimationDuration(Combo.Phase phase)
	{
		switch (phase)
		{
		case Combo.Phase.Anticipation:
			return animationLength * comboPhaseRange.x;
		case Combo.Phase.Activation:
			return animationLength * (comboPhaseRange.y - comboPhaseRange.x);
		case Combo.Phase.Recovery:
			return animationLength * (1f - comboPhaseRange.y);
		default:
			throw new ArgumentOutOfRangeException("phase", phase, null);
		case Combo.Phase.None:
		case Combo.Phase.All:
			return 0f;
		}
	}
}

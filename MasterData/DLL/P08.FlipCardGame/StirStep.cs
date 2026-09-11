using System;
using System.Collections.Generic;
using UnityEngine;

public class StirStep : MainStepBase
{
	[Serializable]
	public struct NormalizeVelocityZone
	{
		public float progressPerCent;

		public float startValueOfDial;
	}

	public enum GuideType
	{
		idle,
		velocity,
		overload
	}

	private StirGameManager gameManager;

	public float stirVelocityThreshold;

	public float stirMoveDistanceThreshold;

	public float maxVelocityOfDial;

	public float upAccelerateSpeed;

	public float downAccelerateSpeed;

	public float normalizeVelocityDelta;

	[SerializeField]
	public List<NormalizeVelocityZone> normalizeVelocityList = new List<NormalizeVelocityZone>();

	public float numOfProgressRising;

	public float maxNumOfProgression;

	public float imgKeepTime = 2f;

	public float lessStirAnimSpeedPercent;

	public float perfectStirAnimSpeedPercent;

	public float moreStirAnimSpeedPercent;

	public float successAnimDurationTime;

	public bool needBoilLoopAudio = true;

	public List<CookingGameConst.GuideConfig<GuideType>> guideConfigList = new List<CookingGameConst.GuideConfig<GuideType>>();

	private void Awake()
	{
		gameManager = GetComponent<StirGameManager>();
	}

	public override bool IsStepCompleted()
	{
		if (gameManager == null)
		{
			return false;
		}
		return gameManager.currentProgress >= maxNumOfProgression;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		int currentProgress = (IsStepCompleted() ? 1 : 0);
		return new CookingGameConst.ProgressData(config.stepDescription, currentProgress, 1);
	}

	public override float GetPopStepTriggerProgress()
	{
		return gameManager.currentProgress / maxNumOfProgression;
	}
}

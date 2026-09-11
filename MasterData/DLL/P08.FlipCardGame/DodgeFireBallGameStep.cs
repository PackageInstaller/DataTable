using System;
using System.Collections.Generic;
using UnityEngine;

public class DodgeFireBallGameStep : PopStepBase
{
	[Serializable]
	public struct FireBallDropEventConfig
	{
		public float invokeTime;

		public TablePos pos;

		public float yellowFireDurationTime;
	}

	public class GuideStatus
	{
		public bool isTriggered;

		public float delayTime;

		public bool isPlayed;

		public bool needShowGuide;

		public GuideConfig guideConfig;

		public GuideStatus(GuideConfig guideConfig)
		{
			Reset();
			this.guideConfig = guideConfig;
		}

		public void Reset()
		{
			isTriggered = false;
			delayTime = 0f;
			isPlayed = false;
			needShowGuide = false;
		}

		public void Trigger()
		{
			isTriggered = true;
		}
	}

	[Serializable]
	public class GuideConfig
	{
		public GuideType type;

		public float delayTime;

		public string guideTextKey;
	}

	public enum GuideType
	{
		firstGamePad,
		firstWarning,
		firstBurn,
		firstWarm
	}

	[NonSerialized]
	private DodgeFireBallGameManager gameManager;

	public string enterTalkTips;

	public float maxProgress = 100f;

	public float progressRisingRate = 5f;

	public int bloodCount = 2;

	public float invincibleTime = 2f;

	public TablePos foodInitPos;

	public Sprite normalSprite;

	public Sprite completedSprite;

	public Sprite charredSprite;

	public float warningDurationTime;

	public float redFireDurationTime;

	public List<FireBallDropEventConfig> fireBallDropEventList = new List<FireBallDropEventConfig>();

	public bool needGuide;

	public bool alwaysNeedGuideInEditor = true;

	public List<GuideConfig> guideConfigList = new List<GuideConfig>();

	private void Awake()
	{
		gameManager = GetComponent<DodgeFireBallGameManager>();
	}

	public override bool IsStepCompleted()
	{
		if (gameManager == null)
		{
			return false;
		}
		return gameManager.curProgress >= maxProgress;
	}

	public override float GetProgress()
	{
		return gameManager.curProgress / 1f;
	}
}

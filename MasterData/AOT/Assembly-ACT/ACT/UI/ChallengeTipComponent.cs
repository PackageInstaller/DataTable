using System;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ChallengeTipComponent : BaseUIComponent, IBattleMainComponent
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	private bool _active;

	public void Show(ChallengeTipComponentData data, Action openFail)
	{
		try
		{
			onClose = () =>
			{
				Model<BattleMainModel>.Interface.HudPositionUIDequeue(UIPosition.UpperMiddle);
			};
			gameObject.SetActive(value: true);
			_active = true;
			if (data.challengeTipShowType == ChallengeTipShowType.Success)
			{
				_betterAnimation.GetSequence("ChallengeSuccess").OnComplete((AnimationBuilder a) =>
				{
					UnInit();
				}).Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Success");
			}
			else
			{
				_betterAnimation.GetSequence("ChallengeFailed").OnComplete((AnimationBuilder a) =>
				{
					UnInit();
				}).Play();
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Challenge_Fail");
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"大世界挑战提示打开失败：{arg}");
			}
			openFail?.Invoke();
			gameObject.SetActive(value: false);
			_active = false;
		}
	}

	private void UnInit()
	{
		onClose?.Invoke();
		onClose = null;
		gameObject.SetActive(value: false);
		_active = false;
	}

	public void Initialize(MonoBattleMainBaseView view)
	{
	}

	public void UnInitialize()
	{
		if (_active)
		{
			UnInit();
		}
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}

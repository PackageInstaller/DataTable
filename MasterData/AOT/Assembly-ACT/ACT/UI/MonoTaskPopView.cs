using System.Threading;
using ACT.Battle;
using ACT.MissionSystem;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MonoTaskPopView : BaseUIView<TaskPopInputController>
{
	public class TaskPopPara
	{
		public int mainMissionId;

		public bool isOpen;
	}

	public ActButton btnClose;

	public GameObject normalTip;

	public GameObject gamepadTip;

	public new BetterAnimation betterAnimation;

	public CanvasGroup canvasGroup;

	public TaskPopUnit main;

	public TaskPopUnit legend;

	public string hideAnimationName = "Hide";

	private void Awake()
	{
		btnClose.SetBtnClick(OnBtnCloseClick);
	}

	private void OnBtnCloseClick()
	{
		Close();
	}

	protected override void Init()
	{
		main.gameObject.SetActive(value: false);
		legend.gameObject.SetActive(value: false);
		RefreshTip(MonoECS.instance?.InputMode ?? DeviceInputMode.TouchScreen);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		RefreshTip(type);
	}

	private void RefreshTip(DeviceInputMode type)
	{
		normalTip?.SetActive(value: false);
		gamepadTip?.SetActive(value: false);
		switch (type)
		{
		case DeviceInputMode.TouchScreen:
		case DeviceInputMode.KeyboardAndMouse:
			normalTip?.SetActive(value: true);
			gamepadTip?.SetActive(value: false);
			break;
		case DeviceInputMode.Gamepad:
			normalTip?.SetActive(value: false);
			gamepadTip?.SetActive(value: true);
			break;
		}
	}

	protected override async UniTask WaitShowCompleteAsync(CancellationToken token)
	{
		await PlayAnimation();
	}

	protected override async UniTask WaitHideCompleteAsync(CancellationToken token)
	{
		if ((bool)betterAnimation)
		{
			AnimationBuilder sequence = betterAnimation.GetSequence(hideAnimationName);
			if (sequence != null)
			{
				await sequence.Play().AwaitComplete();
			}
		}
	}

	private async UniTask PlayAnimation()
	{
		TaskPopPara taskPopPara = (TaskPopPara)uiViewData;
		MissionType missionTypeEnum = Singleton<MissionManager>.instance.GetMissionData(taskPopPara.mainMissionId).Config.MissionTypeEnum;
		canvasGroup.alpha = 1f;
		main.gameObject.SetActive(value: false);
		legend.gameObject.SetActive(value: false);
		switch (missionTypeEnum)
		{
		case MissionType.Main:
		case MissionType.MainActivity:
			main.gameObject.SetActive(value: true);
			await main.PlayAnimation(taskPopPara.mainMissionId, taskPopPara.isOpen).SuppressCancellationThrow();
			break;
		case MissionType.Legend:
			legend.gameObject.SetActive(value: true);
			await legend.PlayAnimation(taskPopPara.mainMissionId, taskPopPara.isOpen).SuppressCancellationThrow();
			break;
		default:
			await UniTask.WaitForSeconds(0.5f);
			break;
		}
	}
}

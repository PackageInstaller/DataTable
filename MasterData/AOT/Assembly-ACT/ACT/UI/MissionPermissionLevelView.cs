using System.Threading;
using ACT.Battle;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MissionPermissionLevelView : BaseUIView<MissionPermissionLevelInputController>
{
	public LocalizeStringEvent missionName;

	public LocalizeStringEvent description;

	public ActButton btnClose;

	public GameObject normalTip;

	public GameObject gamepadTip;

	public string showName = "Show";

	public string hideName = "Hide";

	private void Awake()
	{
		btnClose.SetBtnClick(OnBtnCloseClick);
	}

	protected override void Init()
	{
		if (uiViewData is MissionPermissionLevelViewData missionPermissionLevelViewData)
		{
			description.StringReference.GetVariable<string>("0").Value = missionPermissionLevelViewData.permissionLevel.ToString();
			missionName.StringReference.TableReference = "shortcommon";
			missionName.StringReference.TableEntryReference = missionPermissionLevelViewData.missionName;
		}
		OnInputDeviceChange(MonoECS.instance.InputMode);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		normalTip.SetActive(value: false);
		gamepadTip.SetActive(value: false);
		switch (type)
		{
		case DeviceInputMode.TouchScreen:
		case DeviceInputMode.KeyboardAndMouse:
			normalTip.SetActive(value: true);
			gamepadTip.SetActive(value: false);
			break;
		case DeviceInputMode.Gamepad:
			normalTip.SetActive(value: false);
			gamepadTip.SetActive(value: true);
			break;
		}
	}

	protected override async UniTask WaitShowCompleteAsync(CancellationToken token)
	{
		await PlayAnimation();
	}

	private async UniTask PlayAnimation()
	{
		if (uiViewData is MissionPermissionLevelViewData missionPermissionLevelViewData)
		{
			description.StringReference.GetVariable<string>("0").Value = missionPermissionLevelViewData.permissionLevel.ToString();
		}
		if ((bool)betterAnimation)
		{
			AnimationBuilder sequence = betterAnimation.GetSequence(showName);
			if (sequence != null)
			{
				await sequence.Play().AwaitComplete();
			}
		}
	}

	protected override async UniTask WaitHideCompleteAsync(CancellationToken token)
	{
		if ((bool)betterAnimation)
		{
			AnimationBuilder sequence = betterAnimation.GetSequence(hideName);
			if (sequence != null)
			{
				await sequence.Play().AwaitComplete();
			}
		}
	}

	private void OnBtnCloseClick()
	{
		Close();
	}
}

using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.UI.InputController;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupSystemUnlockView : BaseUIView<PopupSystemUnlockViewInputController>
{
	public BImage icon;

	public LocalizeStringEvent systemName;

	public LocalizeStringEvent systemDes;

	private PopupSystemUnlockViewData m_data;

	[SerializeField]
	private ActButton _maskBtn;

	[SerializeField]
	private CanvasGroup _bottomInfo;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public void ConfirmByGamePad()
	{
		ConfirmAction();
	}

	public void CloseByGamePad()
	{
		CloseAction();
	}

	private void CloseAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	private void ConfirmAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as PopupSystemUnlockViewData;
		_maskBtn.SetBtnClick(ConfirmAction);
	}

	protected override void Init()
	{
		base.Init();
		if (m_data != null)
		{
			SystemOpen data = CoreUtils.GetData(m_data.systemId, RuntimeConfigs.data.systemOpens);
			Station.LoadImage(109, data.iconId, icon);
			systemName.StringReference.TableEntryReference = data.localNameId;
			systemDes.StringReference.TableEntryReference = data.descriptionAfter;
			SetBottomInfoActive(MonoECS.instance.InputMode != DeviceInputMode.Gamepad);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		SetBottomInfoActive(type != DeviceInputMode.Gamepad);
	}

	private void SetBottomInfoActive(bool active)
	{
		_bottomInfo.alpha = (active ? 1 : 0);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play().OnComplete((AnimationBuilder x) =>
		{
			OpenEffectFinishNew();
		});
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").Play().OnComplete((AnimationBuilder x) =>
		{
			Singleton<SystemUnlockManager>.instance.SystemUnlockUiEvt.Dequeue();
			Singleton<SystemUnlockManager>.instance.SendReadSystemUnLockReq(m_data.systemId);
			CloseEffectFinishNew();
		});
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}

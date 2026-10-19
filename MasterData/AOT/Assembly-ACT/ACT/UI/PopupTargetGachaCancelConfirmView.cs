using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Pb;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupTargetGachaCancelConfirmView : BaseUIView<PopupTargetGachaCancelConfirmViewInputController>
{
	[SerializeField]
	private ActButton closeButton;

	[SerializeField]
	private ActButton confirmButton;

	[SerializeField]
	private ActButton cancelButton;

	[SerializeField]
	private LocalizeStringEvent chargeValueText;

	[SerializeField]
	public ViewControlRoot viewControlRoot;

	[SerializeField]
	public ViewControlLayer viewControlLayer;

	private PopupTargetGachaCancelConfirmViewData m_data;

	private bool isCommunicating;

	public override async UniTask PreInit()
	{
		m_data = uiViewData as PopupTargetGachaCancelConfirmViewData;
		closeButton?.SetBtnClick(Close, "event:/UI/Common/Popup_Close");
		confirmButton?.SetBtnClick(ConfirmCancelTarget);
		cancelButton?.SetBtnClick(Close);
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		isCommunicating = false;
		confirmButton?.Interactable(active: true);
		cancelButton?.Interactable(active: true);
		RefreshChargeValue();
	}

	protected override void UnInit()
	{
		m_data = null;
		isCommunicating = false;
		base.UnInit();
	}

	private void RefreshChargeValue()
	{
		if (!(chargeValueText == null) && m_data != null && RuntimeConfigs.data != null)
		{
			GachaPoolUniqueData gachaPoolUniqueData = Model<CardDrawModel>.Interface.GetGachaPoolUniqueData(m_data.GachaId);
			Gacha data = CoreUtils.GetData(m_data.GachaId, RuntimeConfigs.data.gachas);
			chargeValueText.SetTable("Common");
			chargeValueText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.ChargeValueText;
			chargeValueText.GetVariable<int>("0").Value = gachaPoolUniqueData?.TargetPoint ?? 0;
			chargeValueText.GetVariable<int>("1").Value = data?.maxTargetPoint ?? 0;
		}
	}

	private void ConfirmCancelTarget()
	{
		if (isCommunicating || m_data == null)
		{
			return;
		}
		isCommunicating = true;
		confirmButton?.Interactable(active: false);
		cancelButton?.Interactable(active: false);
		Model<CardDrawModel>.Interface.SendGachaTargetCancel(m_data.GachaId, (GachaTargetCancelAck ack) =>
		{
			if (!(this == null) && m_data != null)
			{
				if (!isActiveAndEnabled)
				{
					isCommunicating = false;
				}
				else
				{
					isCommunicating = false;
					if (ack?.PoolUnique == null)
					{
						confirmButton?.Interactable(active: true);
						cancelButton?.Interactable(active: true);
					}
					else
					{
						Close();
					}
				}
			}
		});
	}

	public override void Close()
	{
		if (!isCommunicating)
		{
			base.Close();
		}
	}

	public void HandleGamepadSubmit()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	public void HandleGamepadCancel()
	{
		Close();
	}
}

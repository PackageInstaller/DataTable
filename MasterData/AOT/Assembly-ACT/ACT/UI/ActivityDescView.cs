using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class ActivityDescView : BaseUIView
{
	[SerializeField]
	private LocalizeStringEvent _titleDes;

	[SerializeField]
	private LocalizeStringEvent txtDialog;

	[SerializeField]
	private GamePadTipsComp gamePadTipsComp;

	[SerializeField]
	private ScrollRect descScrollRect;

	[SerializeField]
	private BImage _icon;

	private ActivityDescViewData m_data;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		ActivityDescViewData activityDescViewData = (ActivityDescViewData)uiViewData;
		if (activityDescViewData != null)
		{
			if (activityDescViewData.titleTextId != 0)
			{
				string table = (string.IsNullOrEmpty(activityDescViewData.titleStringType) ? "shortcommon" : activityDescViewData.titleStringType);
				_titleDes.SetTable(table);
				_titleDes.StringReference.TableEntryReference = activityDescViewData.titleTextId;
			}
			if (activityDescViewData.descTextId != 0)
			{
				string table2 = (string.IsNullOrEmpty(activityDescViewData.localizedStringType) ? "longcommon" : activityDescViewData.localizedStringType);
				txtDialog.SetTable(table2);
				txtDialog.StringReference.TableEntryReference = activityDescViewData.descTextId;
			}
			if (activityDescViewData.iconId != 0)
			{
				GetComponentInParent<IBaseUIView>().Station.LoadImage(109, activityDescViewData.iconId, _icon);
			}
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		if (descScrollRect != null)
		{
			descScrollRect.verticalNormalizedPosition = 1f;
		}
		OnControllerStatusChange(MonoECS.instance.InputMode);
		MonoECS.instance.onInputModeChange.AddListener(OnControllerStatusChange);
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (uiViewData is ActivityDescViewData { closeAction: { } closeAction })
		{
			closeAction();
		}
		MonoECS.instance.onInputModeChange.RemoveListener(OnControllerStatusChange);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void OnControllerStatusChange(DeviceInputMode deviceInputMode)
	{
		gamePadTipsComp.ClearAllPrompts();
		if (deviceInputMode == DeviceInputMode.Gamepad)
		{
			List<GamePadTipsAction> list = new List<GamePadTipsAction>();
			list.Add(new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			});
			list.Add(new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			});
			gamePadTipsComp.RegisterInputActions(list);
		}
	}
}

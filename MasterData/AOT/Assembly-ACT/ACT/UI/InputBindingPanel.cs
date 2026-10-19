using System;
using System.Collections.Generic;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI;

public class InputBindingPanel : BaseUIView<InputBindingPanelInputViewInputController>
{
	public class InputBindingPanelData
	{
		public List<(string, string, string)> Changes = new List<(string, string, string)>();

		public Action OnConfirm;

		public Action OnCancel;

		public bool ModifierMode;
	}

	public Animation Animation;

	public ActButton BtnConfirm;

	public ActButton BtnCancel;

	public InputBindingChangeNotice LineA;

	public InputBindingChangeNotice LineB;

	public ViewControlLayer viewControlLayer;

	private InputBindingPanelData data;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	protected override void Init()
	{
		base.Init();
		BtnConfirm.OnClick.AddListener(OnBtnConfirmClick);
		BtnCancel.OnClick.AddListener(OnBtnCancelClick);
		if (uiViewData is InputBindingPanelData panelData)
		{
			Show(panelData);
		}
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	protected override void UnInit()
	{
		BtnConfirm.OnClick.RemoveListener(OnBtnConfirmClick);
		BtnCancel.OnClick.RemoveListener(OnBtnCancelClick);
		base.UnInit();
	}

	public void OnBtnConfirmClick()
	{
		if (data != null)
		{
			data.OnConfirm?.Invoke();
			data = null;
			Hide();
		}
	}

	public void PlaySound()
	{
	}

	public void OnBtnCancelClick()
	{
		if (data != null)
		{
			data.OnCancel?.Invoke();
			data = null;
			Hide();
		}
	}

	public void Show(InputBindingPanelData panelData)
	{
		data = panelData;
		if (data.Changes.Count > 0)
		{
			LineA.SetActive(active: true);
			LineA.ResetData(data.ModifierMode, data.Changes[0].Item1, data.Changes[0].Item2, data.Changes[0].Item3);
		}
		else
		{
			LineA.SetActive(active: false);
		}
		if (data.Changes.Count > 1)
		{
			LineB.gameObject.SetActive(value: true);
			LineB.ResetData(data.ModifierMode, data.Changes[1].Item1, data.Changes[1].Item2, data.Changes[1].Item3);
		}
		else
		{
			LineB.gameObject.SetActive(value: false);
		}
		gameObject.SetActive(value: true);
		Animation.Play("Show");
		EventSystemHelper.SetSelectedGameObject(BtnCancel.gameObject);
	}

	public void Hide()
	{
		Animation.Play("Hide");
	}

	public new void CloseEffectFinishNew()
	{
		Close();
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}

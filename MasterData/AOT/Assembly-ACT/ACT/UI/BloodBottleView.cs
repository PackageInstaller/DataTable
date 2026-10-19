using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.UI.Controller.BloodBottleViewController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BloodBottleView : BaseUIView<BloodBottleViewInputController>
{
	public enum SubPanelType
	{
		None = -1,
		MainShow,
		ChangeMaterial,
		LevelUp
	}

	private BloodBottleViewData m_data;

	private BloodBottleModel _model;

	private BloodBottleHandler _handler;

	private int _curPageIndex = -1;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	[SerializeField]
	private List<BaseUIComponent> _subPanels;

	[SerializeField]
	private ActButton closeBtn;

	[SerializeField]
	private LocalizeStringEvent _backBtnDes;

	public ViewControlRoot viewControlRoot;

	public GamePadTipsComp bottomBtnPrompt;

	public bool animFinish { get; set; } = true;

	public BloodBottleViewData data => m_data;

	public int lastPageIndex { get; set; }

	public int curPageIndex => _curPageIndex;

	public async UniTaskVoid ChangePanelPage(int index)
	{
		if (index == _curPageIndex)
		{
			return;
		}
		if (_curPageIndex != -1)
		{
			await UniTask.WaitUntil(() => animFinish);
			(_subPanels[_curPageIndex] as IBottleSubPanelBase)?.UnInit();
		}
		else if (!animFinish)
		{
			animFinish = true;
		}
		await UniTask.WaitUntil(() => animFinish);
		for (int num = 0; num < _subPanels.Count; num++)
		{
			if (index == num)
			{
				_curPageIndex = index;
				(_subPanels[num] as IBottleSubPanelBase)?.Refresh();
				break;
			}
		}
		RefreshBottomBtnPrompt();
	}

	public void CloseEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		if (_curPageIndex == 1 || _curPageIndex == 2)
		{
			ChangePanelPage(0).Forget();
			return;
		}
		if (_curPageIndex >= 0 && _curPageIndex < _subPanels.Count)
		{
			(_subPanels[_curPageIndex] as IBottleSubPanelBase)?.UnInit();
		}
		_curPageIndex = -1;
		Close();
	}

	protected override void AddEventListener()
	{
		closeBtn.SetBtnClick(CloseEvent);
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as BloodBottleViewData;
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_tipsActions = new List<GamePadTipsAction>();
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/SwitchPageUp"] = new GamePadTipsAction
		{
			inputAction = "UI/SwitchPageUp"
		};
		_allInputPrompt["UI/SwitchPageDown"] = new GamePadTipsAction
		{
			inputAction = "UI/SwitchPageDown",
			localizeKey = 2671,
			localizeTable = "Common"
		};
	}

	protected override void Init()
	{
		_model = Model<BloodBottleModel>.Interface;
		if (!_model.CurSceneCanCultivation())
		{
			Close();
			return;
		}
		foreach (BaseUIComponent subPanel in _subPanels)
		{
			(subPanel as IBottleSubPanelBase)?.Init();
		}
		ResetPanelAnimState();
		ChangePanelPage(0).Forget();
		base.Init();
	}

	protected override void ReInit()
	{
		base.ReInit();
		m_data = uiViewData as BloodBottleViewData;
		foreach (BaseUIComponent subPanel in _subPanels)
		{
			(subPanel as IBottleSubPanelBase)?.Refresh();
		}
		ChangePanelPage(0).Forget();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_allInputPrompt?.Clear();
		_tipsActions?.Clear();
		if (_model.curOperationBottle != null)
		{
			_model.SetOperationBottle(null);
		}
		foreach (BaseUIComponent subPanel in _subPanels)
		{
			(subPanel as IBottleSubPanelBase)?.OnParentViewClose();
		}
		ResetPanelAnimState();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		animFinish = false;
		betterAnimation?.GetSequence("MainHide").Goto(0f).OnComplete((AnimationBuilder _) =>
		{
			animFinish = true;
		})
			.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	public bool CheckSubPanelIsReadyForGuide(SubPanelType type)
	{
		bool flag = _model.curOperationBottle != null && _model.curOperationBottle.uid == _model.guideDefaultSelectBottleId;
		return (_curPageIndex == (int)type && animFinish) & flag;
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (UIController.State == UIState.Opened)
		{
			RefreshBottomBtnPrompt();
		}
	}

	public void RefreshBottomBtnPrompt()
	{
		bottomBtnPrompt?.ClearAllPrompts();
		_tipsActions?.Clear();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && curPageIndex != -1)
		{
			_tipsActions?.Add(_allInputPrompt["UI/Back"]);
			switch ((SubPanelType)curPageIndex)
			{
			case SubPanelType.ChangeMaterial:
				_tipsActions?.Add(_allInputPrompt["UI/SwitchPageUp"]);
				_tipsActions?.Add(_allInputPrompt["UI/SwitchPageDown"]);
				break;
			}
			bottomBtnPrompt?.RegisterInputActions(_tipsActions);
		}
	}

	private void ResetPanelAnimState()
	{
		_curPageIndex = -1;
		animFinish = true;
	}
}

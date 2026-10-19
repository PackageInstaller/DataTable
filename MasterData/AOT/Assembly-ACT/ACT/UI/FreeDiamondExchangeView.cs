using ACT.Game;
using ACT.Net;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.UI.InputController.JumpToFreeDiamondViewInputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class FreeDiamondExchangeView : BaseUIView<FreeDiamondExchangeViewInputController>
{
	public TMP_InputField inputField;

	public ActButton reduce1Btn;

	public ActButton reduce100Btn;

	public ActButton add1Btn;

	public ActButton add100Btn;

	public ActButton maxBtn;

	public CommonCoinComponent costDiamond;

	public ActButton closeBtn;

	public ActButton exchangeBtn;

	public ViewControlLayer viewControlLayer;

	public GamePadTipsComp gamePadTipsComp;

	public CommonCoinGroup commonCoinGroup;

	private FreeDiamondExchangeViewData m_data;

	private int _currentExchangeNum;

	private int CostDiamondNum => G.localPlayer.GetCountById(98);

	private int MaxExchangeNum => Mathf.Max(1, CostDiamondNum);

	private void Awake()
	{
		if ((bool)closeBtn)
		{
			closeBtn.SetBtnClick(ClickCloseBtn);
		}
		if ((bool)exchangeBtn)
		{
			exchangeBtn.SetBtnClick(ClickExchangeBtn);
		}
		if ((bool)reduce1Btn)
		{
			reduce1Btn.SetBtnClick(ClickReduceBtn);
		}
		if ((bool)reduce100Btn)
		{
			reduce100Btn.SetBtnClick(ClickReduce100Btn);
		}
		if ((bool)add1Btn)
		{
			add1Btn.SetBtnClick(ClickAddBtn);
		}
		if ((bool)add100Btn)
		{
			add100Btn.SetBtnClick(ClickAdd100Btn);
		}
		if ((bool)maxBtn)
		{
			maxBtn.SetBtnClick(ClickMaxBtn);
		}
		if ((bool)inputField)
		{
			inputField.contentType = TMP_InputField.ContentType.IntegerNumber;
			inputField.onValueChanged.AddListener(OnInputValueChanged);
			inputField.onEndEdit.AddListener(OnInputEndEdit);
		}
	}

	protected override void Init()
	{
		base.Init();
		_currentExchangeNum = 1;
		UpdateCostDiamond();
		UpdateInputField();
		UpdateButtons();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation?.GetSequence("Show")?.Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation?.GetSequence("Hide")?.Play();
	}

	private void UpdateInputField()
	{
		_currentExchangeNum = Mathf.Clamp(_currentExchangeNum, 1, MaxExchangeNum);
		inputField.text = _currentExchangeNum.FastToString();
		UpdateCostDiamond();
	}

	private void UpdateCostDiamond()
	{
		costDiamond.AttributeMode = AttributeMode.PlayerAttribute;
		costDiamond.itemId = PlayerAttribute.COST_DIAMOND;
		costDiamond.Init(_currentExchangeNum);
	}

	private void UpdateButtons()
	{
		reduce1Btn.Interactable(_currentExchangeNum > 1);
		reduce100Btn.Interactable(_currentExchangeNum > 1);
		add1Btn.Interactable(_currentExchangeNum < MaxExchangeNum);
		add100Btn.Interactable(_currentExchangeNum < MaxExchangeNum);
		maxBtn.Interactable(_currentExchangeNum < MaxExchangeNum);
		exchangeBtn.Interactable(_currentExchangeNum > 0 && CostDiamondNum >= _currentExchangeNum);
	}

	private void AddExchangeNum(int delta)
	{
		_currentExchangeNum += delta;
		UpdateInputField();
		UpdateButtons();
	}

	public void ClickReduceBtn()
	{
		if (reduce1Btn.IsInteractable())
		{
			AddExchangeNum(-1);
		}
	}

	public void ClickReduce100Btn()
	{
		if (reduce100Btn.IsInteractable())
		{
			AddExchangeNum(-100);
		}
	}

	public void ClickAddBtn()
	{
		if (add1Btn.IsInteractable())
		{
			AddExchangeNum(1);
		}
	}

	public void ClickAdd100Btn()
	{
		if (add100Btn.IsInteractable())
		{
			AddExchangeNum(100);
		}
	}

	public void ClickMaxBtn()
	{
		if (maxBtn.IsInteractable())
		{
			_currentExchangeNum = MaxExchangeNum;
			UpdateInputField();
			UpdateButtons();
		}
	}

	public void ClickCloseBtn()
	{
		Close();
	}

	private void OnInputValueChanged(string value)
	{
		if (!string.IsNullOrEmpty(value) && int.TryParse(value, out var result) && result > MaxExchangeNum)
		{
			_currentExchangeNum = MaxExchangeNum;
			UpdateInputField();
		}
	}

	private void OnInputEndEdit(string value)
	{
		if (string.IsNullOrEmpty(value) || !int.TryParse(value, out var result) || result < 1)
		{
			_currentExchangeNum = 1;
		}
		else if (result > MaxExchangeNum)
		{
			_currentExchangeNum = MaxExchangeNum;
		}
		else
		{
			_currentExchangeNum = result;
		}
		UpdateInputField();
		UpdateButtons();
	}

	public void ClickExchangeBtn()
	{
		if (!exchangeBtn.IsInteractable())
		{
			return;
		}
		G.service.ExchangeFreeDiamond(_currentExchangeNum, (bool success) =>
		{
			if (success)
			{
				Close();
			}
		});
	}
}

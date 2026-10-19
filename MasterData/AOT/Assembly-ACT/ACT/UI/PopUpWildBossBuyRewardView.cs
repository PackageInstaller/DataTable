using ACT.Battle;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class PopUpWildBossBuyRewardView : BaseUIView<PopUpWildBossBuyRewardViewInputController>
{
	private PopUpWildBossBuyRewardViewData m_data;

	[SerializeField]
	[Header("右上角货币组件")]
	private CommonCoinComponent _coinComponent;

	[SerializeField]
	[Header("剩余购买次数")]
	private TextMeshProUGUI _remainBuyCountText;

	[SerializeField]
	[Header("购买数量")]
	private TextMeshProUGUI _buyCountText;

	[SerializeField]
	[Header("关闭按钮")]
	private ActButton _closeBtn;

	[SerializeField]
	[Header("减少数量按钮")]
	private ActButton _reduceBtn;

	[SerializeField]
	[Header("增加数量按钮")]
	private ActButton _addBtn;

	[SerializeField]
	[Header("MAX按钮")]
	private ActButton _maxBtn;

	[SerializeField]
	[Header("购买按钮")]
	private ActButton _buyBtn;

	[SerializeField]
	[Header("取消按钮")]
	private ActButton _cancelBtn;

	[SerializeField]
	[Header("滑动条")]
	private LimitedSlider _limitedSlider;

	[SerializeField]
	[Header("消耗钻石显示组件")]
	private CommonCoinComponent _costCoinComponent;

	[SerializeField]
	[Header("可购买等级最小值文本")]
	private TextMeshProUGUI _minValueText;

	[SerializeField]
	[Header("可购买等级最大值文本")]
	private TextMeshProUGUI _maxValueText;

	[SerializeField]
	private GameObject[] _hideInGamePadModeObjects;

	private int _buyCount;

	private const int MinValue = 1;

	private const string Show = "Show";

	private const string Hide = "Hide";

	public ACT.ViewControl.SelectableEx BuyBtnSelectableEx => _buyBtn.GetComponent<ACT.ViewControl.SelectableEx>();

	public ACT.ViewControl.SelectableEx CancelBtnSelectableEx => _cancelBtn.GetComponent<ACT.ViewControl.SelectableEx>();

	public bool IsBuyBtnInteractable => _buyBtn.IsInteractable();

	public int BuyCount
	{
		get
		{
			return _buyCount;
		}
		set
		{
			if (_buyCount != value)
			{
				_buyCount = value;
				OnRefresh(value);
			}
		}
	}

	private void Awake()
	{
		_closeBtn.SetBtnClick(CloseViewAction);
		_cancelBtn.SetBtnClick(CancelAction);
		_buyBtn.SetBtnClick(BuyAction);
		_reduceBtn.SetBtnClick(ReduceAction);
		_addBtn.SetBtnClick(AddAction);
		_maxBtn.SetBtnClick(MaxAction);
		_limitedSlider.onValueChanged.AddListener(OnSliderValueChanged);
	}

	private void OnDestroy()
	{
		_closeBtn.OnClick.RemoveAllListeners();
		_cancelBtn.OnClick.RemoveAllListeners();
		_buyBtn.OnClick.RemoveAllListeners();
		_reduceBtn.OnClick.RemoveAllListeners();
		_addBtn.OnClick.RemoveAllListeners();
		_maxBtn.OnClick.RemoveAllListeners();
		_limitedSlider.onValueChanged.RemoveAllListeners();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamePadModeHiddenObjects(type == DeviceInputMode.Gamepad);
	}

	private void RefreshGamePadModeHiddenObjects(bool isGamePadMode)
	{
		if (_hideInGamePadModeObjects == null)
		{
			return;
		}
		GameObject[] hideInGamePadModeObjects = _hideInGamePadModeObjects;
		foreach (GameObject gameObject in hideInGamePadModeObjects)
		{
			if (!(gameObject == null))
			{
				gameObject.SetActive(!isGamePadMode);
			}
		}
	}

	private void CloseViewAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	private void CancelAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	private void BuyAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		G.service.WildBossRewardBoughtReq(_buyCount, (bool success) =>
		{
			if (success)
			{
				m_data.OnBuySuccessAction?.Invoke();
			}
		});
	}

	private void ReduceAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Number");
		if (_buyCount > 1)
		{
			BuyCount--;
		}
	}

	private void AddAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Number");
		if (_buyCount < Model<WildBossModel>.Interface.CanBuyMaxCount)
		{
			BuyCount++;
		}
	}

	private void MaxAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/Number");
		BuyCount = Model<WildBossModel>.Interface.CanBuyMaxCount;
	}

	internal void AddBuyCountByGamePad()
	{
		AddAction();
	}

	internal void ReduceBuyCountByGamePad()
	{
		ReduceAction();
	}

	internal void SetBuyCountToMaxByGamePad()
	{
		MaxAction();
	}

	internal void CloseByGamePad()
	{
		CloseViewAction();
	}

	private void OnSliderValueChanged(float value)
	{
		int num = (int)value;
		if (_buyCount != num)
		{
			BuyCount = num;
		}
	}

	internal void ShowDetailPanelByGamePad()
	{
		_coinComponent.OnClick?.Invoke();
	}

	private void OnRefresh(int buyCount)
	{
		int canBuyMaxCount = Model<WildBossModel>.Interface.CanBuyMaxCount;
		int num = buyCount * Model<WildBossModel>.Interface.PerCostPrice;
		bool flag = _buyBtn.IsInteractable();
		bool flag2 = G.TryGetAttribute(97) >= num;
		_buyBtn.Interactable(flag2);
		if (flag != flag2)
		{
			GetController()?.RefreshDefaultSelect();
		}
		_limitedSlider.SetValueWithoutNotify(buyCount);
		_minValueText.SetText("{0:0}", 1f);
		_maxValueText.SetText("{0:0}", canBuyMaxCount);
		_buyCountText.SetText("{0:0}", buyCount);
		_addBtn.Interactable(buyCount < canBuyMaxCount);
		_reduceBtn.Interactable(buyCount > 1);
		_maxBtn.Interactable(buyCount != canBuyMaxCount);
		_costCoinComponent.Init(num);
	}

	public override UniTask PreInit()
	{
		m_data = uiViewData as PopUpWildBossBuyRewardViewData;
		_limitedSlider.minValue = 1f;
		int canBuyMaxCount = Model<WildBossModel>.Interface.CanBuyMaxCount;
		_limitedSlider.maxValue = canBuyMaxCount;
		_limitedSlider.limit = canBuyMaxCount;
		BuyCount = 1;
		_remainBuyCountText.SetText("{0:0}", canBuyMaxCount);
		RefreshGamePadModeHiddenObjects(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		return base.PreInit();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}
}

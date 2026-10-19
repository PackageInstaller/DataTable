using ACT.Battle;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.UI;

public class PopUpWildBossGetRewardView : BaseUIView<PopUpWildBossGetRewardViewInputController>
{
	private PopUpWildBossGetRewardViewData m_data;

	[SerializeField]
	private CommonNumberComponent _commonNumberComponent;

	[SerializeField]
	[Header("购买奖励次数按钮")]
	private ActButton _buyRewardCountBtn;

	[SerializeField]
	[Header("取消按钮")]
	private ActButton _cancelBtn;

	[SerializeField]
	[Header("确认按钮")]
	private ActButton _comfirmBtn;

	[SerializeField]
	[Header("右上角关闭按钮")]
	private ActButton _closeBtn;

	private const string Show = "Show";

	private const string Hide = "Hide";

	public ACT.ViewControl.SelectableEx ConfirmSelectableEx => _comfirmBtn.GetComponent<ACT.ViewControl.SelectableEx>();

	public ACT.ViewControl.SelectableEx CancelSelectableEx => _cancelBtn.GetComponent<ACT.ViewControl.SelectableEx>();

	private void Awake()
	{
		_buyRewardCountBtn.SetBtnClick(BuyRewardCountAction);
		_cancelBtn.SetBtnClick(CancelAction);
		_comfirmBtn.SetBtnClick(TakeRewardAction);
		_closeBtn.SetBtnClick(CloseViewAction);
	}

	private void OnDestroy()
	{
		_buyRewardCountBtn.OnClick.RemoveAllListeners();
		_cancelBtn.OnClick.RemoveAllListeners();
		_comfirmBtn.OnClick.RemoveAllListeners();
		_closeBtn.OnClick.RemoveAllListeners();
	}

	public void CloseViewAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	public void CancelAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	private void BuyRewardCountAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		if (Model<WildBossModel>.Interface.CanBuyMaxCount <= 0)
		{
			GameUtility.OpenToolTip(LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.WildBossRewardMax));
			return;
		}
		Close();
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWILDBOSSBUYREWARD, new PopUpWildBossBuyRewardViewData
		{
			OnBuySuccessAction = OnBuySuccessAction
		});
	}

	private void OnBuySuccessAction()
	{
		Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPWILDBOSSBUYREWARD);
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPWILDBOSSGETREWARD, new PopUpWildBossGetRewardViewData
		{
			wildBossCollectionUid = Model<WildBossModel>.Interface.CurCollectionUid,
			TakeRewardSuccessAction = TakeRewardSuccessAction
		});
	}

	private void TakeRewardSuccessAction()
	{
		MonoECS.instance.ruleManager.SharedChangeState(Model<WildBossModel>.Interface.CurCollectionUid, 1);
	}

	private void TakeRewardAction()
	{
		G.service.WildBossTakeRewardReq(m_data.wildBossCollectionUid, (bool success, RepeatedField<UniversalItem> rewardItems) =>
		{
			if (success)
			{
				Close();
				GameUtility.OpenPopReward(rewardItems);
				m_data.TakeRewardSuccessAction?.Invoke();
			}
		});
	}

	public override UniTask PreInit()
	{
		m_data = uiViewData as PopUpWildBossGetRewardViewData;
		Model<WildBossModel>.Interface.CacheData(m_data.wildBossCollectionUid);
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		int canTakeRewardCount = Model<WildBossModel>.Interface.CanTakeRewardCount;
		int baseTakeRewardCount = Model<WildBossModel>.Interface.BaseTakeRewardCount;
		_commonNumberComponent.UpdateNumber(canTakeRewardCount, baseTakeRewardCount);
		_comfirmBtn.Interactable(canTakeRewardCount > 0);
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

	public void BuyRewardByGamePad()
	{
		BuyRewardCountAction();
	}

	public void CancelByGamePad()
	{
		CancelAction();
	}

	public void CloseByGamePad()
	{
		CloseViewAction();
	}
}

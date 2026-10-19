using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonthCardRewardView : BaseUIView<MonthCardRewardViewInputController>
{
	public ActButton BtnClose;

	public LocalizeStringEvent Time;

	public Transform TfReward;

	public GameObject RewardItemPrefab;

	public GamePadTipsComp gamePadTipsComp;

	private MonthCardRewardViewData m_data;

	private MonthlyPass _monthlyPass;

	private readonly FacePushViewLifecycle _facePushLifecycle = new FacePushViewLifecycle();

	public override UniTask PreInit()
	{
		m_data = uiViewData as MonthCardRewardViewData;
		_facePushLifecycle.Bind(m_data);
		BtnClose.SetBtnClick(() =>
		{
			Close();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/MonthlyCard_1_Close");
		});
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
		SendMonthlyPassRecordPopReq();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/MonthlyCard_1");
	}

	protected override void OpenEffectCallback()
	{
		betterAnimation.GetSequence("Loop").SetLoops(-1).Play();
	}

	private void SendMonthlyPassRecordPopReq()
	{
		Model<ShopModel>.Interface.SendMonthlyPassRecordPopReq(m_data.monthlyPassId, TimeManager.ServerTime.NowTimestampSecond);
	}

	private void InitPanel()
	{
		_monthlyPass = CoreUtils.GetData(m_data.monthlyPassId, RuntimeConfigs.data.monthlyPasss);
		if (_monthlyPass != null)
		{
			CreateRewardItem();
			long num = Model<ShopModel>.Interface.MonthlyPassLeftTime(_monthlyPass.id);
			int num2 = (int)((num > 0) ? ((num - 1) / 86400) : 0);
			Time.GetComponent<TextMeshProUGUI>().SetText("{0:0}", num2);
		}
	}

	private void CreateRewardItem()
	{
		if (TfReward.childCount > 0)
		{
			TfReward.DestroyChildren();
		}
		for (int i = 0; i < _monthlyPass.itemdaily.Count; i++)
		{
			UIUtility.AddWidget<MonthCardRewardItem>(TfReward, RewardItemPrefab).Init(_monthlyPass.itemdaily[i].id, _monthlyPass.itemdaily[i].count, Station);
		}
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

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void CloseComplete()
	{
		base.CloseComplete();
		_facePushLifecycle.NotifyOnCloseComplete();
	}
}

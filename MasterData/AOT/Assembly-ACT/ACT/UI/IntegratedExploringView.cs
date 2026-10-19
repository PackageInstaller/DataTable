using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class IntegratedExploringView : BaseUIView
{
	[SerializeField]
	private Button BtnChallenge;

	[SerializeField]
	private Button BtnShop;

	[SerializeField]
	private Button BtnDesc;

	[SerializeField]
	private LocalizeStringEvent TxtIntro;

	[SerializeField]
	private TextMeshProUGUI TxtLeftTime;

	[SerializeField]
	private Transform EnableTR;

	[SerializeField]
	private Transform DisableTR;

	[SerializeField]
	private TextMeshProUGUI TxtShopCoin;

	[SerializeField]
	private LocalizeStringEvent TxtShopTitle;

	[SerializeField]
	private LocalizeStringEvent TxtChallengeTitle;

	private IntegratedExploringViewData m_data;

	private void OnChallenge()
	{
		OnJumpChallenge().Forget();
	}

	public async UniTask OnJumpChallenge()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INTEGRATEDEXPLORINGCHALLENGEVIEW).Forget();
	}

	private void OnShop()
	{
		ShopData shopData = RuntimeConfigs.data.shopDatas[6];
		if (TimeManager.IsInTimeRange(shopData.shopStartTs, shopData.shopEndTs))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SHOP, new ShopViewData
			{
				FirstTabID = 6
			}).Forget();
		}
		else
		{
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				localizeId = 1845,
				tableName = LocalizationUtility.localizeTableName_Common
			});
		}
	}

	private void OnDesc()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
		{
			descTextId = ActivityExploreChallengeModel.GetDesc()
		}).Forget();
	}

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
		BtnChallenge.SetBtnClick(OnChallenge, "event:/UI/Interface/Plan/Select");
		BtnShop.SetBtnClick(OnShop, "event:/UI/Interface/Plan/Select");
		BtnDesc.SetBtnClick(OnDesc, "event:/UI/Interface/Plan/Click");
	}

	protected override void Init()
	{
		base.Init();
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(3002);
		TxtIntro.StringReference.TableEntryReference = ActivityExploreChallengeModel.GetIntroduction();
		int shopCoinId = Model<ActivityExploreChallengeModel>.Interface.GetShopCoinId();
		if (RuntimeConfigs.data.itemDatas[shopCoinId].type == 999 && G.detailUserInfo.Attributes.ContainsKey(shopCoinId))
		{
			TxtShopCoin.text = G.detailUserInfo.Attributes[shopCoinId].ToString();
		}
		else if (RuntimeConfigs.data.itemDatas[shopCoinId].type != 999 && G.localPlayer.Inventory.GetItemInfo(shopCoinId) != null)
		{
			TxtShopCoin.SetText("{0:0}", G.localPlayer.Inventory.GetItemInfo(shopCoinId).Count);
		}
		else
		{
			TxtShopCoin.text = "0";
		}
		TxtShopTitle.StringReference.TableEntryReference = 1744L;
		TxtChallengeTitle.StringReference.TableEntryReference = 1743L;
		ActivityClick evt = EventTrackSolver.Instance.GetEvt<ActivityClick>();
		evt.activityId = 1005;
		evt.status = 1;
		evt.challengeGroupId = 0;
		evt.challengeId = 0;
		evt.isPopup = false;
		EventTrackSolver.Instance.Dispatch(evt);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Plan/Open");
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
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

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
	}

	private void RefrehChallengeOpen()
	{
		if (Model<ActivityExploreChallengeModel>.Interface == null)
		{
			EnableTR.gameObject.SetActive(value: false);
			DisableTR.gameObject.SetActive(value: true);
			return;
		}
		long num = Model<ActivityExploreChallengeModel>.Interface.EndTimeStamp - TimeManager.ServerTime.NowTimestamp;
		bool flag = num > 0;
		if (flag)
		{
			TxtLeftTime.text = TimeManager.GetTimeSpanString(num, ETimeSpanFormatType.Type_DHM);
		}
		else if (!DisableTR.gameObject.activeSelf)
		{
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				localizeId = 1742,
				tableName = LocalizationUtility.localizeTableName_Common
			});
		}
		EnableTR.gameObject.SetActive(flag);
		DisableTR.gameObject.SetActive(!flag);
	}

	public void Update()
	{
		RefrehChallengeOpen();
	}
}

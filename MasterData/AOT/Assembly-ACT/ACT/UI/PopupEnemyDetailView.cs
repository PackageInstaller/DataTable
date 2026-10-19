using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupEnemyDetailView : BaseUIView
{
	public LoopVerticalScrollRect scrollRect;

	public LocalizeStringEvent ruledesc;

	[Header("UI节点")]
	public GameObject ruleUI;

	public GameObject enemyDetailUI;

	private PopupEnemyDetailViewData m_data;

	public ItemKv GetEnemyInfo(int index)
	{
		return m_data.enemyShowList[index];
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
	}

	protected override void Init()
	{
		base.Init();
		m_data = (PopupEnemyDetailViewData)uiViewData;
		SetData();
	}

	public async void SetData()
	{
		ruleUI.SetActive(m_data.isShowRule);
		enemyDetailUI.SetActive(m_data.isShowEnemyDetail);
		MonoRaidView raidview = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_RAID) as MonoRaidView;
		scrollRect.totalCount = m_data.enemyShowList.Count;
		await UniTask.DelayFrame(1);
		scrollRect.RefillCells();
		if (raidview != null && m_data.isShowRule)
		{
			ruledesc.StringReference.TableEntryReference = CoreUtils.GetData(raidview.curSelectRaidId, RuntimeConfigs.data.raids).ruleDescId;
		}
	}

	protected override void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("CommonWinShow").OnComplete((AnimationBuilder _) =>
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
	}

	protected override void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("CommonWinHide").OnComplete((AnimationBuilder _) =>
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
}

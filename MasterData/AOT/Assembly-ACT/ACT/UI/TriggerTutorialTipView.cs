using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class TriggerTutorialTipView : BaseUIView
{
	private TriggerTutorialTipViewData m_data;

	[SerializeField]
	private ActButton _btn;

	[Space]
	public TutorialInfoTip info;

	protected override void AddEventListener()
	{
		_btn.SetBtnClick(OpenGraphicGuideView);
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

	protected override async void Init()
	{
		base.Init();
		m_data = uiViewData as TriggerTutorialTipViewData;
		if (m_data != null)
		{
			GuideTutorial data = CoreUtils.GetData(m_data.guideTutorialId, RuntimeConfigs.data.guideTutorials);
			if (data != null)
			{
				info.Init(data, Station);
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder builder) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override async void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		info.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder builder) =>
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

	public void OpenGraphicGuideView()
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Tutorial))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_GRAPHICGUIDE).Forget();
			return;
		}
		ItemKv itemKv = CoreUtils.GetData(1019, RuntimeConfigs.data.systemOpens).preconditionParam[0];
		int desId = CoreUtils.GetData(itemKv.id, RuntimeConfigs.data.preconditions).desId;
		TipManager instance = Singleton<TipManager>.instance;
		CommonTipData commonTipData = new CommonTipData
		{
			tableName = LocalizationUtility.localizeTableName_longcommon,
			localizeId = desId
		};
		List<string> list = new List<string>();
		int count = itemKv.count;
		list.Add(count.ToString());
		commonTipData.variableList = list;
		instance.GetTip(TIP_TYPE.TIP_COMMONTIP, commonTipData);
	}
}

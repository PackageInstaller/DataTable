using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupGetNewBloodView : BaseUIView
{
	public LocalizeStringEvent content;

	public BImage icon;

	private PopupGetNewBloodViewData m_data;

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
		m_data = ((uiViewData != null) ? (uiViewData as PopupGetNewBloodViewData) : m_data);
		if (m_data != null)
		{
			content.StringReference.TableEntryReference = m_data.localizeId;
			ItemData data = CoreUtils.GetData(m_data.bottleItemId, RuntimeConfigs.data.itemDatas);
			Station.LoadItemIconAsync(data.iconAddress, icon).Forget();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("PopupGetNewBloodViewShow").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
			Close();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		Singleton<UIAtlasManager>.instance.UnloadSprite(GameLoader.meta.itemAtlasNameAssetID);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("PopupGetNewBloodViewHide").OnComplete((AnimationBuilder _) =>
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

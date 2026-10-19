using System;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ScenicSpotView : BaseUIView<ScenicSpotViewInputController>
{
	public BImage image;

	private ScenicSpotViewData m_data;

	[SerializeField]
	private ActButton _maskBtn;

	[SerializeField]
	private LocalizeStringEvent _titleNameLocalize;

	[SerializeField]
	private LocalizeStringEvent _desLocalize;

	[SerializeField]
	private TextMeshProUGUI _getTimeText;

	private bool _loadComplete;

	private const string ScenicSpotShow = "ScenicSpotShow";

	private const string ScenicSpotHide = "ScenicSpotHide";

	public void ConfirmByGamePad()
	{
		ConfirmAction();
	}

	public void CloseByGamePad()
	{
		CloseAction();
	}

	private void CloseAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		Close();
	}

	private void ConfirmAction()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		Close();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		_maskBtn.SetBtnClick(ConfirmAction);
		m_data = uiViewData as ScenicSpotViewData;
		TextLibraryContent data = CoreUtils.GetData(m_data.id, RuntimeConfigs.data.textLibraryContents);
		if (data != null)
		{
			_titleNameLocalize.SetTable(LocalizationUtility.localizeTableName_shortcommon);
			_titleNameLocalize.StringReference.TableEntryReference = data.titleName;
			_desLocalize.SetTable(LocalizationUtility.localizeTableName_longcommon);
			_desLocalize.StringReference.TableEntryReference = data.content;
		}
		_getTimeText.text = TimeManager.GetDateTimeString(TimeManager.ServerTime.Now);
		_loadComplete = false;
		try
		{
			await Station.LoadImageAsync(133, m_data.id, image);
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
		}
		_loadComplete = true;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("ScenicSpotShow").Play().OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		});
	}

	protected override void UnInit()
	{
		RefreshBattleMainRefreshCanvasGroup evt = Singleton<EventManager>.instance.GetEvt<RefreshBattleMainRefreshCanvasGroup>();
		evt.isActive = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.BattleMainRefreshCanvasGroup, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		_maskBtn.OnClick.RemoveAllListeners();
		m_data?.onCloseCallback?.Invoke();
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("ScenicSpotHide").Play().OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		});
	}

	public override void Close()
	{
		if (_loadComplete)
		{
			base.Close();
		}
		else
		{
			_ = LuminApplication.LogEnabled;
		}
	}
}

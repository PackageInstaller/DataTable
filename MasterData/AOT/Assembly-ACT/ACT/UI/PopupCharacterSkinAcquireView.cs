using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopupCharacterSkinAcquireView : BaseUIView<PopupCharacterSkinAcquireViewInputController>
{
	public BImage SkinIcon;

	public LocalizeStringEvent TextName;

	public LocalizeStringEvent TextUnLockDescription;

	public BImage ImageExtraRewardIcon;

	public ActButton BtnJump;

	public ActButton BtnClose;

	[Header("按键提示相关")]
	public ViewControlLayer btnGroupLayer;

	public GamePadTipsComp gamePadTipsComp;

	private PopupCharacterSkinAcquireViewData m_data;

	private Skin m_skinData;

	public override UniTask PreInit()
	{
		BtnClose.SetBtnClick(Close);
		m_data = uiViewData as PopupCharacterSkinAcquireViewData;
		BtnJump.SetBtnClick(OnJump);
		return base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		InitPanel();
		CosmeticClickEvent evt = EventTrackSolver.Instance.GetEvt<CosmeticClickEvent>();
		evt.cosmeticId = m_data.SkinId;
		evt.quality = m_skinData.skinQuality;
		evt.status = 1;
		evt.cosmeticType = 0;
		evt.characterId = m_skinData.roleid;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Store/NewSkin");
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

	private void OnJump()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTERSKIN, new CharacterSkinViewData
		{
			SkinId = m_skinData.id,
			RoleId = m_skinData.roleid
		});
		Close();
	}

	public void InitPanel()
	{
		m_skinData = CoreUtils.GetData(m_data.SkinId, RuntimeConfigs.data.Skins);
		EntityData data = CoreUtils.GetData(m_skinData.roleid, RuntimeConfigs.data.entityDatas);
		Station.LoadImage(215, m_skinData.id, ImageExtraRewardIcon);
		TextName.StringReference.TableEntryReference = m_skinData.skinname;
		IList<object> list = new List<object>();
		list.Add(LocalizationUtility.GetLocalizeString("shortcommon", data.nameLocal));
		TextUnLockDescription.GetComponent<TextMeshProUGUI>().text = LocalizationUtility.GetLocalizeString("Common", 2655, list);
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	public override void Close()
	{
		Action action = m_data?.CallBack;
		if (m_data != null)
		{
			m_data.CallBack = null;
		}
		base.Close();
		action?.Invoke();
	}
}

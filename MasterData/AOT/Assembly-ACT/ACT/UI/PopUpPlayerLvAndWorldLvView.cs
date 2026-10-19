using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class PopUpPlayerLvAndWorldLvView : BaseUIView<PopUpPlayerLvAndWorldLvViewInputController>
{
	private PopUpPlayerLvAndWorldLvViewData m_data;

	public LocalizeStringEvent oneTitle;

	public LocalizeStringEvent twoTitle;

	public LocalizeStringEvent thirdTitle;

	public LocalizeStringEvent oneDesc;

	public LocalizeStringEvent twoDesc;

	public LocalizeStringEvent thirdDesc;

	public ActButton leftBtn;

	public ActButton rightBtn;

	public RectTransform sVRect;

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
		m_data = uiViewData as PopUpPlayerLvAndWorldLvViewData;
		base.Init();
		Refresh();
	}

	private void Refresh()
	{
		oneTitle.StringReference.TableEntryReference = 2178L;
		oneDesc.StringReference.TableEntryReference = 2179L;
		twoTitle.StringReference.TableEntryReference = 2180L;
		twoDesc.StringReference.TableEntryReference = 2181L;
		thirdTitle.StringReference.TableEntryReference = 2182L;
		thirdDesc.StringReference.TableEntryReference = 2183L;
		leftBtn.SetBtnClick(OnClickLeft);
		rightBtn.SetBtnClick(OnClickRight);
		RefreshBtnList();
	}

	private void RefreshBtnList()
	{
		leftBtn.gameObject.SetActive(m_data.showBtnList);
		rightBtn.gameObject.SetActive(m_data.showBtnList);
	}

	private void RefreshSVHeight()
	{
		if (m_data.showBtnList)
		{
			sVRect.anchoredPosition = new Vector2(0f, 24f);
			sVRect.sizeDelta = new Vector2(1252.5f, 539f);
		}
		else
		{
			sVRect.anchoredPosition = new Vector2(0f, -20f);
			sVRect.sizeDelta = new Vector2(1252.5f, 628f);
		}
	}

	private void OnClickRight()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, new MonoJourneyTracesViewData
		{
			tabIndex = 0
		}).Forget();
	}

	private void OnClickLeft()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.HandBook))
		{
			GameUtility.OpenToolTip(LocalizationCommonData.CommonString.SystemLock);
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_HANDBOOK).Forget();
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.Play();
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
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
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

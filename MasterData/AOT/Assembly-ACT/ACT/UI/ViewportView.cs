using System.Collections;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ViewportView : BaseUIView<ViewportViewInputController>
{
	private ImageAssetStation _imageStation;

	private ViewportViewData m_data;

	[SerializeField]
	private GameObject switchGroup;

	[SerializeField]
	private ActButton switchLeft;

	[SerializeField]
	private ActButton switchRight;

	[SerializeField]
	private BImage Image;

	[SerializeField]
	private TextMeshProUGUI viewPortName;

	[SerializeField]
	private TextMeshProUGUI viewPortArea;

	[SerializeField]
	private TextMeshProUGUI viewPortDes;

	[SerializeField]
	private TextMeshProUGUI dateTxt;

	[SerializeField]
	private LayoutGroup titleLayoutGroup;

	private string _redDotPath = string.Empty;

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
		m_data = (ViewportViewData)uiViewData;
		_imageStation = ImageManager.instance.GetAssetStation();
		InitPanel();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("ScenicSpotShow").Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		if (m_data != null && m_data.isFirstCatch)
		{
			HudPropPickTextLibrary evt = Singleton<EventManager>.instance.GetEvt<HudPropPickTextLibrary>();
			evt.unlockTextId = new List<int> { m_data.viewportId };
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_PropPickTextLibraryOnHud, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("ScenicSpotHide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void InitPanel()
	{
		if (m_data.isFirstCatch)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Camera/Catch");
		}
		if (m_data.isInGame)
		{
			switchGroup.SetActive(value: false);
		}
		else
		{
			switchGroup.SetActive(value: true);
			switchLeft.SetBtnClick(SwitchLeft);
			switchRight.SetBtnClick(SwitchRight);
		}
		RefreshPanel();
	}

	private void RefreshPanel()
	{
		ItemData data = CoreUtils.GetData(m_data.viewportId, RuntimeConfigs.data.itemDatas);
		MapArea data2 = CoreUtils.GetData(CoreUtils.GetData(m_data.viewportId, RuntimeConfigs.data.itemTreasureDatas).mapArea, RuntimeConfigs.data.mapAreas);
		viewPortArea.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data2.name);
		viewPortName.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.nameLocal);
		viewPortDes.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_longcommon, data.descLocal);
		StartCoroutine(DelayRefresh());
		_imageStation.LoadImage(133, m_data.viewportId, Image);
		int gainTime = Model<TreasureModel>.Interface.GetTreasure(m_data.viewportId).GainTime;
		IList<object> list = new List<object>();
		list.Add(TimeManager.GetDateTimeString(gainTime));
		dateTxt.text = LocalizationUtility.GetLocalizeString("Common", 2068, list);
	}

	public void SwitchLeft()
	{
		for (int i = 0; i < m_data.viewportItems.Count; i++)
		{
			if (m_data.viewportId == m_data.viewportItems[i] && i - 1 >= 0)
			{
				m_data.viewportId = m_data.viewportItems[i - 1];
				RefreshPanel();
				break;
			}
		}
	}

	public void SwitchRight()
	{
		for (int i = 0; i < m_data.viewportItems.Count; i++)
		{
			if (m_data.viewportId == m_data.viewportItems[i] && i + 1 < m_data.viewportItems.Count)
			{
				m_data.viewportId = m_data.viewportItems[i + 1];
				RefreshPanel();
				break;
			}
		}
	}

	private IEnumerator DelayRefresh()
	{
		yield return 0;
		if (gameObject.activeInHierarchy)
		{
			titleLayoutGroup.enabled = false;
			titleLayoutGroup.enabled = true;
		}
	}
}

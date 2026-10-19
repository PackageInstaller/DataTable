using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ViewComponent.EquipBuildView;

public class AreaEquipSuitItem : BaseUIComponent, ILoopScrollDataSource
{
	[SerializeField]
	private BImage m_AreaIcon;

	[SerializeField]
	private LocalizeStringEvent m_AreaName;

	[SerializeField]
	private SuitTemplate m_SuitTemplate;

	[SerializeField]
	private RectTransform m_SuitRootTransform;

	public CanvasGroup canvasGroup;

	public LayoutElement layoutElement;

	private List<EquipSuitData> m_Suits;

	private static ObjectPool<Stack<SuitTemplate>> m_StackPool = new ObjectPool<Stack<SuitTemplate>>();

	private Stack<SuitTemplate> m_Pool;

	private bool m_HeightMetricsReady;

	private float m_NonSuitHeight;

	private float m_SuitRowHeight;

	private float m_SuitRowSpacing;

	private float m_SuitRootPadding;

	public int Index { get; set; }

	private void Awake()
	{
		m_Pool = m_StackPool.Get();
	}

	private void OnDestroy()
	{
		m_Pool.Clear();
		m_StackPool.Release(m_Pool);
		m_Pool = null;
	}

	public void Init(int areaId, List<EquipSuitData> suits)
	{
		m_Suits = suits;
		MapArea data = CoreUtils.GetData(areaId, RuntimeConfigs.data.mapAreas);
		Station.LoadImageAsync(156, areaId, m_AreaIcon).Forget();
		m_AreaName.StringReference.TableEntryReference = data.name;
		GenerateSuitRow();
		SetVisible();
	}

	public float EstimateHeight(int suitCount)
	{
		EnsureHeightMetrics();
		if (suitCount <= 0)
		{
			return m_NonSuitHeight;
		}
		return m_NonSuitHeight + m_SuitRootPadding + (float)suitCount * m_SuitRowHeight + (float)Mathf.Max(suitCount - 1, 0) * m_SuitRowSpacing;
	}

	private void EnsureHeightMetrics()
	{
		if (m_HeightMetricsReady)
		{
			return;
		}
		m_HeightMetricsReady = true;
		VerticalLayoutGroup component = GetComponent<VerticalLayoutGroup>();
		float num = 0f;
		if (component != null)
		{
			num += (float)(component.padding.top + component.padding.bottom);
		}
		int num2 = 0;
		for (int i = 0; i < transform.childCount; i++)
		{
			RectTransform rectTransform = transform.GetChild(i) as RectTransform;
			if (!(rectTransform == null))
			{
				LayoutElement component2 = rectTransform.GetComponent<LayoutElement>();
				if ((!(component2 != null) || !component2.ignoreLayout) && (!(m_SuitRootTransform != null) || !(rectTransform == m_SuitRootTransform)))
				{
					num += LayoutUtility.GetPreferredHeight(rectTransform);
					num2++;
				}
			}
		}
		if (m_SuitRootTransform != null)
		{
			num2++;
		}
		if (component != null && num2 > 1)
		{
			num += component.spacing * (float)(num2 - 1);
		}
		m_NonSuitHeight = num;
		m_SuitRowHeight = GetSuitRowHeight();
		VerticalLayoutGroup verticalLayoutGroup = ((m_SuitRootTransform != null) ? m_SuitRootTransform.GetComponent<VerticalLayoutGroup>() : null);
		m_SuitRowSpacing = ((verticalLayoutGroup != null) ? verticalLayoutGroup.spacing : 0f);
		m_SuitRootPadding = ((verticalLayoutGroup != null) ? ((float)(verticalLayoutGroup.padding.top + verticalLayoutGroup.padding.bottom)) : 0f);
	}

	private float GetSuitRowHeight()
	{
		if (m_SuitTemplate == null)
		{
			return 0f;
		}
		if (m_SuitTemplate.layoutElement != null && m_SuitTemplate.layoutElement.preferredHeight > 0f)
		{
			return m_SuitTemplate.layoutElement.preferredHeight;
		}
		RectTransform rectTransform = m_SuitTemplate.transform as RectTransform;
		if (rectTransform == null)
		{
			return 0f;
		}
		float preferredHeight = LayoutUtility.GetPreferredHeight(rectTransform);
		if (preferredHeight > 0f)
		{
			return preferredHeight;
		}
		if (rectTransform.rect.height > 0f)
		{
			return rectTransform.rect.height;
		}
		return Mathf.Abs(rectTransform.sizeDelta.y);
	}

	private void SetVisible()
	{
		for (int num = m_SuitRootTransform.transform.childCount - 1; num >= 0; num--)
		{
			LayoutElement component = m_SuitRootTransform.transform.GetChild(num).GetComponent<LayoutElement>();
			if (!component || !component.ignoreLayout)
			{
				component.GetComponent<SuitTemplate>().betterAnimation?.GetSequence("Show")?.Complete();
			}
		}
	}

	private void GenerateSuitRow()
	{
		if (!(m_SuitRootTransform == null) && m_Suits != null)
		{
			List<SuitTemplate> list = ListPool<SuitTemplate>.Get();
			CollectExistingSuitTemplates(list);
			for (int i = 0; i < list.Count; i++)
			{
				HideSuitTemplate(list[i]);
			}
			m_Pool?.Clear();
			for (int num = list.Count - 1; num >= 0; num--)
			{
				m_Pool?.Push(list[num]);
			}
			for (int j = 0; j < m_Suits.Count; j++)
			{
				SuitTemplate suitTemplate = ((m_Pool == null || m_Pool.Count <= 0) ? Object.Instantiate(m_SuitTemplate) : m_Pool.Pop());
				suitTemplate.Station = Station;
				suitTemplate.Context = Context;
				suitTemplate.gameObject.SetActive(value: true);
				suitTemplate.transform.SetParent(m_SuitRootTransform, worldPositionStays: false);
				suitTemplate.canvasGroup.alpha = 1f;
				suitTemplate.canvasGroup.interactable = true;
				suitTemplate.canvasGroup.blocksRaycasts = true;
				suitTemplate.layoutElement.ignoreLayout = false;
				suitTemplate.index = j;
				suitTemplate.Init(m_Suits[j]);
				suitTemplate.SetItemSelectableInteractable(interactable: true);
			}
			ListPool<SuitTemplate>.Release(list);
		}
	}

	private void CollectExistingSuitTemplates(List<SuitTemplate> templates)
	{
		templates.Clear();
		for (int i = 0; i < m_SuitRootTransform.childCount; i++)
		{
			SuitTemplate component = m_SuitRootTransform.GetChild(i).GetComponent<SuitTemplate>();
			if (component != null)
			{
				templates.Add(component);
			}
		}
	}

	private void HideSuitTemplate(SuitTemplate comp)
	{
		if (!(comp == null))
		{
			comp.UnbindChosenChanged();
			comp.SetItemSelectableInteractable(interactable: false);
			if ((bool)comp.canvasGroup)
			{
				comp.canvasGroup.alpha = 0f;
				comp.canvasGroup.interactable = false;
				comp.canvasGroup.blocksRaycasts = false;
			}
			if ((bool)comp.layoutElement)
			{
				comp.layoutElement.ignoreLayout = true;
			}
			comp.betterAnimation?.GetSequence("Show")?.Goto(0f);
			comp.gameObject.SetActive(value: false);
		}
	}

	public void ScrollCellIndex(int idx)
	{
		Index = idx;
	}

	public void OnLoad(int idx)
	{
	}

	public void OnShow()
	{
		if ((bool)layoutElement)
		{
			layoutElement.ignoreLayout = false;
			layoutElement.minHeight = -1f;
			layoutElement.preferredHeight = -1f;
			layoutElement.flexibleHeight = -1f;
		}
		if ((bool)canvasGroup)
		{
			canvasGroup.alpha = 1f;
			canvasGroup.interactable = true;
			canvasGroup.blocksRaycasts = true;
			SetSuitItemSelectableInteractable(interactable: true);
		}
		else
		{
			gameObject.SetActive(value: true);
			SetSuitItemSelectableInteractable(interactable: true);
		}
	}

	public void OnHide()
	{
		RecycleAllSuits();
		if ((bool)layoutElement)
		{
			layoutElement.ignoreLayout = true;
			layoutElement.minHeight = 0f;
			layoutElement.preferredHeight = 0f;
			layoutElement.flexibleHeight = 0f;
		}
		if ((bool)canvasGroup)
		{
			canvasGroup.alpha = 0f;
			canvasGroup.interactable = false;
			canvasGroup.blocksRaycasts = false;
			SetSuitItemSelectableInteractable(interactable: false);
		}
		else
		{
			SetSuitItemSelectableInteractable(interactable: false);
			gameObject.SetActive(value: false);
		}
	}

	private void RecycleAllSuits()
	{
		if (m_SuitRootTransform == null)
		{
			return;
		}
		for (int num = m_SuitRootTransform.childCount - 1; num >= 0; num--)
		{
			SuitTemplate component = m_SuitRootTransform.GetChild(num).GetComponent<SuitTemplate>();
			if (!(component == null))
			{
				HideSuitTemplate(component);
			}
		}
		m_Pool?.Clear();
		m_Suits = null;
	}

	public void OnUnLoad()
	{
	}

	public void PlayCustomAnimation(float delaySecond)
	{
		List<BetterAnimation> list = ListPool<BetterAnimation>.Get();
		for (int i = 0; i < m_SuitRootTransform.transform.childCount; i++)
		{
			SuitTemplate component = m_SuitRootTransform.transform.GetChild(i).GetComponent<SuitTemplate>();
			if ((bool)component && !component.layoutElement.ignoreLayout)
			{
				list.Add(component.betterAnimation);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			list[j]?.GetSequence("Show")?.Goto(0f).SetDelay(delaySecond + (float)j * 0.05f).Play();
		}
		ListPool<BetterAnimation>.Release(list);
	}

	public int GetIndex()
	{
		return Index;
	}

	private void SetSuitItemSelectableInteractable(bool interactable)
	{
		for (int i = 0; i < m_SuitRootTransform.childCount; i++)
		{
			SuitTemplate component = m_SuitRootTransform.GetChild(i).GetComponent<SuitTemplate>();
			if (component != null)
			{
				component.SetItemSelectableInteractable(interactable && !component.layoutElement.ignoreLayout);
			}
		}
	}
}

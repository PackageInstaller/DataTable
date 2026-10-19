using System;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Tables;
using UnityEngine.UI;

namespace ACT.UI.ViewComponent.EquipBuildView;

public class AreaTab : BaseUIComponent, ILoopScrollDataSource
{
	[SerializeField]
	private ActToggle m_Toggle;

	[Header("正常态")]
	[SerializeField]
	private LocalizeStringEvent m_AreaName;

	[SerializeField]
	private BImage m_AreaIcon;

	[Header("选中态")]
	[SerializeField]
	private LocalizeStringEvent m_AreaName_Selected;

	[SerializeField]
	private BImage m_AreaIcon_Selected;

	[Header("禁用态")]
	[SerializeField]
	private GameObject m_NoneEquip;

	public Action<int> OnSelected;

	public new ImageAssetStation Station { get; set; }

	public int Index { get; private set; }

	public ActToggle Toggle => m_Toggle;

	public bool HasEquip { get; private set; } = true;

	public void Init(int areaId, bool isSelected, bool hasEquip = true)
	{
		gameObject.SetActive(value: true);
		HasEquip = hasEquip;
		MapArea data = CoreUtils.GetData(areaId, RuntimeConfigs.data.mapAreas);
		if (data != null)
		{
			LocalizedString stringReference = m_AreaName.StringReference;
			TableEntryReference tableEntryReference = (m_AreaName_Selected.StringReference.TableEntryReference = data.name);
			stringReference.TableEntryReference = tableEntryReference;
			Station.LoadImageAsync(156, areaId, m_AreaIcon).Forget();
			Station.LoadImageAsync(156, areaId, m_AreaIcon_Selected).Forget();
			m_Toggle.onToggleOn.RemoveListener(OnToggleSelected);
			m_Toggle.Interactable(hasEquip);
			if (!hasEquip)
			{
				isSelected = false;
			}
			m_Toggle.SetIsOnWithoutNotify(isSelected);
			m_Toggle.onToggleOn.AddListener(OnToggleSelected);
			SetEmptyState(!hasEquip);
		}
	}

	private void OnToggleSelected()
	{
		if (HasEquip)
		{
			OnSelected?.Invoke(Index);
		}
	}

	public void SetEmptyState(bool isEmpty)
	{
		if (m_NoneEquip != null)
		{
			m_NoneEquip.SetActive(isEmpty);
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
	}

	public void OnHide()
	{
	}

	public void OnUnLoad()
	{
	}

	public void PlayCustomAnimation(float delaySecond)
	{
	}

	public int GetIndex()
	{
		return Index;
	}
}

using System.Collections.Generic;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class AreaMapVagueSelectList : MonoBehaviour, ILifeCycleUIComponent
{
	public LargeMapView view;

	public RectTransform cellRoot;

	private CommonUILifeCycle lifeCycle;

	private List<LargeMapIcon> nearIcon;

	public bool IsOperating
	{
		get
		{
			CommonUILifeCycle commonUILifeCycle = lifeCycle;
			return commonUILifeCycle == CommonUILifeCycle.Opening || commonUILifeCycle == CommonUILifeCycle.Closing;
		}
	}

	public bool IsOpening => lifeCycle == CommonUILifeCycle.Opening;

	public bool IsClosing => lifeCycle == CommonUILifeCycle.Closing;

	public bool IsNormal => lifeCycle == CommonUILifeCycle.Normal;

	public bool IsHidden => lifeCycle == CommonUILifeCycle.Hidden;

	public void SetNearIcon(List<LargeMapIcon> nearIcon)
	{
		this.nearIcon = nearIcon;
	}

	public void Show()
	{
		if (IsHidden)
		{
			CreateCell();
			PlayShowAnimation();
		}
	}

	public void PlayShowAnimation()
	{
		gameObject.SetActive(value: true);
		lifeCycle = CommonUILifeCycle.Opening;
		lifeCycle = CommonUILifeCycle.Normal;
	}

	public void Hide()
	{
		if (IsNormal)
		{
			DestroyCell();
			PlayHideAnimation();
		}
	}

	public void PlayHideAnimation()
	{
		lifeCycle = CommonUILifeCycle.Closing;
		lifeCycle = CommonUILifeCycle.Hidden;
		gameObject.SetActive(value: false);
	}

	public void HideImmediately()
	{
		DestroyCell();
		gameObject.SetActive(value: false);
		lifeCycle = CommonUILifeCycle.Hidden;
	}

	private void CreateCell()
	{
		if (nearIcon == null || nearIcon.Count == 0)
		{
			return;
		}
		foreach (LargeMapIcon item in nearIcon)
		{
			Object.Instantiate(MapUtility.mapConfig.vagueSelectCellPrefab, cellRoot).GetComponent<VagueSelectCell>().Init(item, view.AccurateSelectIconFormVagueSelectList, view.Station);
		}
		view.ViewControlLayers[SubControllerType.selectedPoint].SetTargetTransform(cellRoot.transform);
	}

	private void DestroyCell()
	{
		for (int num = cellRoot.childCount - 1; num >= 0; num--)
		{
			Object.Destroy(cellRoot.GetChild(num).gameObject);
		}
	}

	void ILifeCycleUIComponent.ShowStart()
	{
		lifeCycle = CommonUILifeCycle.Opening;
	}

	void ILifeCycleUIComponent.ShowEnd()
	{
		lifeCycle = CommonUILifeCycle.Normal;
	}

	void ILifeCycleUIComponent.HideStart()
	{
		lifeCycle = CommonUILifeCycle.Closing;
	}

	void ILifeCycleUIComponent.HideEnd()
	{
		lifeCycle = CommonUILifeCycle.Hidden;
		gameObject.SetActive(value: false);
	}
}

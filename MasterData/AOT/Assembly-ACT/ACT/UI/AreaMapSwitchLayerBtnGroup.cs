using System.Collections.Generic;
using ACT.Model;
using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class AreaMapSwitchLayerBtnGroup : MonoBehaviour
{
	public LargeMapView view;

	public Animator animator;

	public List<AreaMapSwitchLayerBtn> switchMapLayerBtnList;

	public void Init(MapLayer curShowLayer, List<MapLayer> allCanSwitchLayer)
	{
		if (allCanSwitchLayer.Count > 1)
		{
			gameObject.SetActive(value: true);
			UpdateCanSwitchLayer(allCanSwitchLayer);
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
		foreach (AreaMapSwitchLayerBtn switchMapLayerBtn in switchMapLayerBtnList)
		{
			switchMapLayerBtn.UnInit();
		}
	}

	private void UpdateCanSwitchLayer(List<MapLayer> allCanSwitchLayer)
	{
		for (int i = 0; i < switchMapLayerBtnList.Count; i++)
		{
			switchMapLayerBtnList[i].gameObject.SetActive(i < allCanSwitchLayer.Count);
		}
		animator.Rebind();
		animator.Play("SwitchShow");
		for (int j = 0; j < allCanSwitchLayer.Count; j++)
		{
			switchMapLayerBtnList[j].Init(allCanSwitchLayer[j]);
			switchMapLayerBtnList[j].Show(allCanSwitchLayer[j] == view.CurShowLayer);
		}
		if (!view.SameArea)
		{
			return;
		}
		if (view.CurShowLayer != MapUtility.playerMapLayer)
		{
			switchMapLayerBtnList.Find((AreaMapSwitchLayerBtn _) => _.layer == MapUtility.playerMapLayer).SetPlayerIconActive(active: true);
		}
		if (!view.templeOpen)
		{
			UpdateBtnMissionIcn();
		}
	}

	public void SwitchLayer(MapLayer toLayer)
	{
		if (view.CurShowLayer != toLayer)
		{
			view.SwitchToLayer(toLayer);
			UpdateBtnStateOnSwitchLayer(toLayer);
		}
	}

	private void UpdateBtnStateOnSwitchLayer(MapLayer toLayer)
	{
		switchMapLayerBtnList.Find((AreaMapSwitchLayerBtn _) => _.layer == toLayer).SetSelect(isSelect: true);
		foreach (AreaMapSwitchLayerBtn item in switchMapLayerBtnList.FindAll((AreaMapSwitchLayerBtn _) => _.layer != toLayer))
		{
			item.SetSelect(isSelect: false);
		}
		if (!view.SameArea)
		{
			return;
		}
		if (toLayer != MapUtility.playerMapLayer)
		{
			switchMapLayerBtnList.Find((AreaMapSwitchLayerBtn _) => _.layer == MapUtility.playerMapLayer).SetPlayerIconActive(active: true);
		}
		else
		{
			switchMapLayerBtnList.Find((AreaMapSwitchLayerBtn _) => _.layer == MapUtility.playerMapLayer).SetPlayerIconActive(active: false);
		}
		if (!view.templeOpen)
		{
			UpdateBtnMissionIcn();
		}
	}

	private void UpdateBtnMissionIcn()
	{
		foreach (AreaMapSwitchLayerBtn switchMapLayerBtn in switchMapLayerBtnList)
		{
			if (Model<MapModel>.Interface.AreaLayerHasMissionPointData(view.CurShowArea, switchMapLayerBtn.layer) && switchMapLayerBtn.layer != view.CurShowLayer)
			{
				switchMapLayerBtn.SetMissionIconActive(active: true);
			}
			else
			{
				switchMapLayerBtn.SetMissionIconActive(active: false);
			}
		}
	}
}

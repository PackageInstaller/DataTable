using System.Collections.Generic;
using ACT.Config;
using ACT.Game;
using ACT.Model;
using ACT.ViewControl;
using ACT.World;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class ExploreAreaRewardGroup : MonoBehaviour
{
	public GameObject StageCell;

	public ExploreRewardStageCell lastRewardStageCell;

	public Image percentSlider;

	public TextMeshProUGUI explorePercent;

	public Transform stageContent;

	public DailyRewardPanel previewRewardPanel;

	public Transform gamePadControlRoot;

	private int _areaType;

	private int _subAreaId;

	private ACT.World.MapArea _mapArea;

	private LargeMapView _parentView;

	public void SetParentView(LargeMapView parentView)
	{
		_parentView = parentView;
	}

	public void Init(ACT.World.MapArea mapArea, int areaType, int areaId = 0)
	{
		percentSlider.fillAmount = 0f;
		explorePercent.text = "0%";
		_areaType = areaType;
		_subAreaId = areaId;
		_mapArea = mapArea;
		InitData(mapArea, areaType, areaId);
	}

	public void Refresh(ACT.World.MapArea mapArea, int areaType, int areaId = 0)
	{
		InitData(mapArea, areaType, areaId, refresh: true);
	}

	public void InitData(ACT.World.MapArea mapArea, int areaType, int areaId = 0, bool refresh = false)
	{
		AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData(mapArea);
		if (areaGroupExploreData == null)
		{
			return;
		}
		if (areaType == 2)
		{
			if (areaGroupExploreData.GetSubAreaData().TryGetValue(areaId, out var value))
			{
				explorePercent.SetText("{0:0}%", Mathf.FloorToInt(value.GetAreaExploreRatio()));
				percentSlider.fillAmount = value.GetAreaExploreRatio() / 100f;
				List<ExplorationReward> explorationRewards = value.GetExplorationRewards();
				lastRewardStageCell.gameObject.SetActive(explorationRewards != null);
				if (explorationRewards != null)
				{
					lastRewardStageCell.Init(mapArea, explorationRewards[explorationRewards.Count - 1].id, (int)value.GetAreaExploreRatio(), ActivePreviewReward);
					explorationRewards.Sort((ExplorationReward a, ExplorationReward b) =>
					{
						int id = a.id;
						return id.CompareTo(b.id);
					});
					int count = explorationRewards.Count;
					for (int num = 0; num < count - 1; num++)
					{
						(refresh ? stageContent.GetChild(num + 1).GetComponent<ExploreRewardStageCell>() : Object.Instantiate(StageCell, stageContent).GetComponent<ExploreRewardStageCell>()).Init(mapArea, explorationRewards[num].id, (int)value.GetAreaExploreRatio(), ActivePreviewReward);
					}
				}
			}
		}
		else
		{
			explorePercent.SetText("{0:0}%", Mathf.FloorToInt(areaGroupExploreData.GetAreaExploreRatio()));
			percentSlider.fillAmount = areaGroupExploreData.GetAreaExploreRatio() / 100f;
			List<ExplorationReward> explorationRewards2 = areaGroupExploreData.GetExplorationRewards();
			lastRewardStageCell.gameObject.SetActive(explorationRewards2 != null);
			if (explorationRewards2 != null)
			{
				lastRewardStageCell.Init(mapArea, explorationRewards2[explorationRewards2.Count - 1].id, (int)areaGroupExploreData.GetAreaExploreRatio(), ActivePreviewReward);
				explorationRewards2.Sort((ExplorationReward a, ExplorationReward b) =>
				{
					int id = a.id;
					return id.CompareTo(b.id);
				});
				int count2 = explorationRewards2.Count;
				for (int num2 = 0; num2 < count2 - 1; num2++)
				{
					(refresh ? stageContent.GetChild(num2 + 1).GetComponent<ExploreRewardStageCell>() : Object.Instantiate(StageCell, stageContent).GetComponent<ExploreRewardStageCell>()).Init(mapArea, explorationRewards2[num2].id, (int)areaGroupExploreData.GetAreaExploreRatio(), ActivePreviewReward);
				}
			}
		}
		previewRewardPanel.OnClose -= OnClosePanel;
		previewRewardPanel.OnClose += OnClosePanel;
	}

	private void OnClosePanel()
	{
		_parentView.ChangeToGamePadInputState(SubControllerType.mapCollection, needReFocusLayer: true);
		_parentView.ViewControlLayers[SubControllerType.rewardWindow].SetDefaultSelect(null);
	}

	public void ActivePreviewReward(ExploreRewardStageCell cell)
	{
		if (cell.canReward.activeSelf)
		{
			AreaExploreData areaGroupExploreData = Model<MapModel>.Interface.GetAreaGroupExploreData(_mapArea);
			if (_areaType == 2)
			{
				if (areaGroupExploreData.GetSubAreaData().TryGetValue(_subAreaId, out var value) && value.CheckHaveReward())
				{
					G.service.MapAreaExploreReward(_subAreaId, _areaType);
					return;
				}
			}
			else if (areaGroupExploreData.CheckHaveReward())
			{
				G.service.MapAreaExploreReward((int)_mapArea, _areaType);
				return;
			}
		}
		previewRewardPanel.CollectionID = cell.CollectionId;
		RectTransform component = cell.previewButton.GetComponent<RectTransform>();
		Vector3[] array = new Vector3[4];
		component.GetWorldCorners(array);
		previewRewardPanel.Position = (array[1] + array[2]) / 2f;
		previewRewardPanel.IsComplete = cell.rewarded.activeSelf;
		_parentView.ViewControlLayers[SubControllerType.rewardWindow].SetDefaultSelect(cell.previewButton.GetComponent<ACT.ViewControl.SelectableEx>());
		_parentView.ChangeToGamePadInputState(SubControllerType.rewardWindow);
	}

	public void UnInit()
	{
		DestroyStageGroup();
		previewRewardPanel.OnClose -= OnClosePanel;
		previewRewardPanel?.ClosePanel();
	}

	public void CloseRewardPreview()
	{
		previewRewardPanel?.ClosePanel();
	}

	private void DestroyStageGroup()
	{
		for (int num = stageContent.childCount - 1; num >= 0; num--)
		{
			GameObject gameObject = stageContent.GetChild(num).gameObject;
			ExploreRewardStageCell component = gameObject.GetComponent<ExploreRewardStageCell>();
			if (component != null)
			{
				component.previewButton.OnClick.RemoveAllListeners();
				Object.Destroy(gameObject);
			}
		}
	}

	protected void OnDestroy()
	{
		DestroyStageGroup();
	}
}

using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaskPointItem : InteractivePoint
{
	[SerializeField]
	private RectTransform taskRangeRect;

	[SerializeField]
	private RectTransform taskRange;

	[SerializeField]
	private GameObject track;

	private TaskPointItemData _viewModel;

	private Vector3[] areaCorners;

	private float[] guideAngles;

	public void Init(TaskPointItemData data, Vector3[] areaCorners, float[] guideAngles)
	{
		base.Init(data);
		_viewModel = data;
		this.areaCorners = areaCorners;
		this.guideAngles = guideAngles;
		BindingSet<TaskPointItem, TaskPointItemData> bindingSet = this.CreateBindingSet(data);
		bindingSet.Bind(taskRange).For((RectTransform v) => v.localScale).To((TaskPointItemData vm) => vm.TaskRange);
		bindingSet.Bind(taskRangeRect).For((RectTransform v) => v.localScale).To((TaskPointItemData vm) => vm.RangeScale);
		bindingSet.Bind(track).For((GameObject v) => v.activeSelf).To((TaskPointItemData vm) => vm.TaskViewModel.TrackState);
		bindingSet.Build();
	}

	public void RefreshData(TaskDataViewModel taskData, Vector2 mapSize, Vector2 configPos, float configRange, bool active)
	{
		float sceneRatio = 0f;
		Vector2 posOffset = Vector2.zero;
		if (taskData.CaveId > 0)
		{
			DRCavern dataRow = GameEntry.DataTable.GetDataRow<DRCavern>(taskData.CaveId);
			if (dataRow != null)
			{
				sceneRatio = dataRow.MapSenceScale;
				posOffset = new Vector3((dataRow.Cavernpoint.Count > 0) ? dataRow.Cavernpoint[0] : 0f, (dataRow.Cavernpoint.Count > 1) ? dataRow.Cavernpoint[1] : 0f);
			}
		}
		else
		{
			DRMap dataRow2 = GameEntry.DataTable.GetDataRow<DRMap>(taskData.LevelMapId);
			if (dataRow2 != null)
			{
				posOffset = new Vector2((dataRow2.WorldPosOffset.Count > 0) ? dataRow2.WorldPosOffset[0] : 0f, (dataRow2.WorldPosOffset.Count > 1) ? dataRow2.WorldPosOffset[1] : 0f);
			}
		}
		_viewModel.RefreshData(taskData, configPos, posOffset, configRange, mapSize, sceneRatio);
		UpdateVisualData();
		base.gameObject.name = $"taskPoint{taskData.TaskId}";
		base.gameObject.SetActive(active);
	}

	public MapGuidePointData UpdateVisualData()
	{
		if (!Visibility)
		{
			return null;
		}
		if (!_viewModel.TaskViewModel.TrackState)
		{
			return null;
		}
		return InteractivePoint.UpdatePointVisualDataWithRectangle(areaCorners, guideAngles, RectTransform, base.transform.parent.GetComponent<RectTransform>(), _viewModel.PointInfo);
	}

	public void ItemScale(float scale)
	{
		_viewModel.SetScale(scale);
	}
}

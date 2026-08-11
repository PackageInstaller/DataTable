using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class CavePointItemData : InteractivePointData
{
	private DRCavernPoint _drCavernPoint;

	private string cavePointIndex;

	private bool isInCave;

	private bool btnEnable = true;

	private int bubbleCount;

	private string bubbleIcon1 = "";

	private string bubbleIcon2 = "";

	private bool isHighlight;

	private bool showPointIndex;

	private TaskDataViewModel task1;

	private TaskDataViewModel task2;

	private bool playerIn;

	private bool taskBtnEnable;

	private CavePointItem item;

	private List<InteractivePoint.PointType> _bubbleIcons = new List<InteractivePoint.PointType>();

	public DRCavernPoint DrCavernPoint => _drCavernPoint;

	public bool PlayerIn => playerIn;

	public bool TaskBtnEnable
	{
		get
		{
			return taskBtnEnable;
		}
		set
		{
			Set(ref taskBtnEnable, value, "TaskBtnEnable");
		}
	}

	public TaskDataViewModel Task1
	{
		get
		{
			return task1;
		}
		private set
		{
			Set(ref task1, value, "Task1");
		}
	}

	public TaskDataViewModel Task2
	{
		get
		{
			return task2;
		}
		private set
		{
			Set(ref task2, value, "Task2");
		}
	}

	public bool IsHighlight
	{
		get
		{
			return isHighlight;
		}
		set
		{
			Set(ref isHighlight, value, "IsHighlight");
		}
	}

	public string CavePointIndex
	{
		get
		{
			return cavePointIndex;
		}
		set
		{
			Set(ref cavePointIndex, value, "CavePointIndex");
		}
	}

	public int BubbleCount
	{
		get
		{
			return bubbleCount;
		}
		set
		{
			Set(ref bubbleCount, value, "BubbleCount");
		}
	}

	public string BubbleIcon1
	{
		get
		{
			return bubbleIcon1;
		}
		set
		{
			Set(ref bubbleIcon1, value, "BubbleIcon1");
		}
	}

	public string BubbleIcon2
	{
		get
		{
			return bubbleIcon2;
		}
		set
		{
			Set(ref bubbleIcon2, value, "BubbleIcon2");
		}
	}

	public bool ShowPointIndex
	{
		get
		{
			return showPointIndex;
		}
		set
		{
			Set(ref showPointIndex, value, "ShowPointIndex");
		}
	}

	public bool BtnEnable
	{
		get
		{
			return btnEnable;
		}
		set
		{
			Set(ref btnEnable, value, "BtnEnable");
		}
	}

	public CavePointItemData(OptionBase parent, DRCavernPoint drData, bool isInCave, Vector2 mapSize)
	{
		base.parent = parent;
		this.isInCave = isInCave;
		BtnEnable = !isInCave;
		Task1 = TaskDataViewModel.CreateEmpty();
		Task2 = TaskDataViewModel.CreateEmpty();
		RefreshData(drData, mapSize);
	}

	public void SetItem(CavePointItem item)
	{
		this.item = item;
		this.item.RefreshRoot();
	}

	public void RefreshData(DRCavernPoint drData, Vector2 mapSize)
	{
		if (drData == null)
		{
			return;
		}
		DRCavern dataRow = GameEntry.DataTable.GetDataRow<DRCavern>(drData.CavernlId);
		if (dataRow == null)
		{
			return;
		}
		_drCavernPoint = drData;
		DRMap dataRow2 = GameEntry.DataTable.GetDataRow<DRMap>(dataRow.LevelId);
		if (dataRow2 == null)
		{
			return;
		}
		Vector2 vector = new Vector2((dataRow.Cavernpoint.Count > 0) ? dataRow.Cavernpoint[0] : 0f, (dataRow.Cavernpoint.Count > 1) ? dataRow.Cavernpoint[1] : 0f);
		Vector2 vector2 = new Vector2((dataRow2.WorldPosOffset.Count > 0) ? dataRow2.WorldPosOffset[0] : 0f, (dataRow2.WorldPosOffset.Count > 1) ? dataRow2.WorldPosOffset[1] : 0f);
		List<float> list = (isInCave ? _drCavernPoint.CavernOut : _drCavernPoint.CavernIn);
		Vector2 worldPos = new Vector2((list.Count > 0) ? list[0] : 0f, (list.Count > 1) ? list[1] : 0f);
		Vector2 posOffset = (isInCave ? vector : vector2);
		float sceneToUiRatio = (isInCave ? dataRow.MapSenceScale : 0f);
		base.PointInfo = new InteractivePoint.PointInfo(InteractivePoint.PointType.CavePoint, _drCavernPoint.Id, _drCavernPoint.CavernName, worldPos, posOffset, mapSize, sceneToUiRatio);
		base.Pos = base.PointInfo.Pos;
		List<DRCavernPoint> list2 = GameEntry.DataTable.GetDataRows((DRCavernPoint p) => p.CavernlId == drData.CavernlId).ToList();
		if (list2 == null)
		{
			CavePointIndex = TextHelper.IntToRoman(1);
			return;
		}
		list2.Sort((DRCavernPoint a, DRCavernPoint b) => a.Id.CompareTo(b.Id));
		int num = list2.FindIndex((DRCavernPoint p) => p.Id == drData.Id);
		num = ((num >= 0) ? num : 0);
		CavePointIndex = TextHelper.IntToRoman(num + 1);
	}

	public void RefreshState(bool active)
	{
		base.IsLock = !active;
	}

	public void SetCavernState(bool state)
	{
		IsHighlight = state;
		ShowPointIndex = state;
	}

	public void AddTask(TaskDataViewModel task)
	{
		if (task == null || task.Empty || (Task1 != null && Task1.TaskId == task.TaskId) || (Task2 != null && Task2.TaskId == task.TaskId))
		{
			return;
		}
		List<TaskDataViewModel> list = new List<TaskDataViewModel> { task };
		if (Task1 != null)
		{
			list.Add(Task1);
		}
		if (Task2 != null)
		{
			list.Add(Task2);
		}
		if (list.Count > 1)
		{
			list.Sort(delegate(TaskDataViewModel a, TaskDataViewModel b)
			{
				int num = ((!a.TrackState) ? 1 : (-1));
				int value = ((!b.TrackState) ? 1 : (-1));
				int pointIconPriority = InteractivePoint.GetPointIconPriority(InteractivePoint.GetTaskPointType(a.TaskType));
				int pointIconPriority2 = InteractivePoint.GetPointIconPriority(InteractivePoint.GetTaskPointType(b.TaskType));
				return num.CompareTo(value) * 100 - pointIconPriority.CompareTo(pointIconPriority2) * 10 + a.TaskId.CompareTo(b.TaskId);
			});
		}
		Task1 = ((list.Count > 0) ? list[0] : TaskDataViewModel.CreateEmpty());
		Task2 = ((list.Count > 1) ? list[1] : TaskDataViewModel.CreateEmpty());
		OnBubbleIconDataChanged();
	}

	public void AddPlayer()
	{
		playerIn = true;
		OnBubbleIconDataChanged();
	}

	public void ResetTaskBubbles()
	{
		task1 = null;
		task2 = null;
		OnBubbleIconDataChanged();
	}

	public void ResetAllBubbles()
	{
		task1 = null;
		task2 = null;
		playerIn = false;
		OnBubbleIconDataChanged();
	}

	private void OnBubbleIconDataChanged()
	{
		_bubbleIcons.Clear();
		if (Task1 != null && !Task1.Empty)
		{
			_bubbleIcons.Add(InteractivePoint.GetTaskPointType(Task1.TaskType));
			TaskBtnEnable = true;
		}
		else
		{
			TaskBtnEnable = false;
		}
		if (playerIn)
		{
			Task2 = TaskDataViewModel.CreateEmpty();
			_bubbleIcons.Add(InteractivePoint.PointType.Player);
		}
		if (Task2 != null && !Task2.Empty)
		{
			_bubbleIcons.Add(InteractivePoint.GetTaskPointType(Task2.TaskType));
		}
		BubbleCount = _bubbleIcons.Count;
		BubbleIcon1 = ((_bubbleIcons.Count > 0) ? InteractivePoint.GetPointIcon(_bubbleIcons[0]) : "");
		BubbleIcon2 = ((_bubbleIcons.Count > 1) ? InteractivePoint.GetPointIcon(_bubbleIcons[1]) : "");
		if (item != null)
		{
			item.RefreshRoot();
		}
	}

	public void OnBubbleBtnClick()
	{
		if (Task1 != null && !Task1.Empty)
		{
			parent?.ItemOnClick(new OptionArg(new InteractivePointData(null, new InteractivePoint.PointInfo(InteractivePoint.GetTaskPointType(Task1.TaskType), Task1.TaskId, Vector2.zero)), "OpenMapInfoView"));
		}
	}
}

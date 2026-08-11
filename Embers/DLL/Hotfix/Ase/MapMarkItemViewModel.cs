using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MapMarkItemViewModel : ItemOptionBase
{
	public enum MarkTypeEnum
	{
		Hero,
		Task,
		TpPoint,
		BossMonster,
		MapItem,
		CavePoint
	}

	public enum MarkLayer
	{
		Normal,
		Overlay
	}

	private int id;

	protected MarkTypeEnum markType;

	private MarkLayer layer;

	private string icon = "";

	private bool iconPathValid = true;

	private bool showIcon = true;

	protected Vector2 posOri;

	protected Vector2 pos;

	private Vector2 posOffset;

	private Quaternion rotation = Quaternion.identity;

	private bool showTaskEffect;

	private bool showBonfireEffect;

	private Vector2 markRange;

	private bool showMarkRange;

	protected int markState;

	protected int bubbleCount;

	protected string bubbleIcon1 = "";

	protected bool isOutside;

	protected string outsideIcon = "";

	private Vector2 markItemSize;

	private Vector2 mapSizeDelta;

	private float sceneToUiRatio;

	private InteractionRequest changeMarkLayerRst = new InteractionRequest();

	public int Id => id;

	public string Icon
	{
		get
		{
			return icon;
		}
		private set
		{
			Set(ref icon, value, "Icon");
			IconPathValid = !string.IsNullOrEmpty(value);
		}
	}

	public MarkLayer Layer
	{
		get
		{
			return layer;
		}
		set
		{
			if (layer != value)
			{
				Set(ref layer, value, "Layer");
				changeMarkLayerRst.Raise();
			}
		}
	}

	public bool ShowIcon
	{
		get
		{
			return showIcon;
		}
		private set
		{
			Set(ref showIcon, value, "ShowIcon");
		}
	}

	private bool IconPathValid
	{
		get
		{
			return iconPathValid;
		}
		set
		{
			Set(ref iconPathValid, value, "IconPathValid");
			ShowIcon = IconPathValid && !ShowMarkRange;
		}
	}

	public Vector2 MarkRange
	{
		get
		{
			return markRange;
		}
		private set
		{
			Set(ref markRange, value, "MarkRange");
		}
	}

	public bool ShowMarkRange
	{
		get
		{
			return showMarkRange;
		}
		set
		{
			Set(ref showMarkRange, value, "ShowMarkRange");
			ShowIcon = IconPathValid && !value;
		}
	}

	public Vector2 Pos
	{
		get
		{
			return pos;
		}
		set
		{
			if (!(pos == value))
			{
				Set(ref pos, value, "Pos");
			}
		}
	}

	public MarkTypeEnum MarkType
	{
		get
		{
			return markType;
		}
		private set
		{
			Set(ref markType, value, "MarkType");
		}
	}

	public int MarkState
	{
		get
		{
			return markState;
		}
		private set
		{
			Set(ref markState, value, "MarkState");
		}
	}

	public Quaternion Rotation
	{
		get
		{
			return rotation;
		}
		private set
		{
			Set(ref rotation, value, "Rotation");
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

	public bool IsOutside
	{
		get
		{
			return isOutside;
		}
		set
		{
			Set(ref isOutside, value, "IsOutside");
		}
	}

	public string OutsideIcon
	{
		get
		{
			return outsideIcon;
		}
		set
		{
			Set(ref outsideIcon, value, "OutsideIcon");
		}
	}

	public bool ShowTaskEffect
	{
		get
		{
			return showTaskEffect;
		}
		set
		{
			Set(ref showTaskEffect, value, "ShowTaskEffect");
		}
	}

	public bool ShowBonfireEffect
	{
		get
		{
			return showBonfireEffect;
		}
		set
		{
			Set(ref showBonfireEffect, value, "ShowBonfireEffect");
		}
	}

	public InteractionRequest ChangeMarkLayerRst => changeMarkLayerRst;

	public static MapMarkItemViewModel CreateHero(OptionBase parent, Vector2 mapSizeDelta, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel mapMarkItemViewModel = new MapMarkItemViewModel();
		mapMarkItemViewModel.MarkType = MarkTypeEnum.Hero;
		mapMarkItemViewModel.Layer = MarkLayer.Normal;
		mapMarkItemViewModel.SetParent(parent);
		mapMarkItemViewModel.SetMapUIParam(mapSizeDelta, sceneToUiRatio, posOffset);
		return mapMarkItemViewModel;
	}

	public static MapMarkItemViewModel CreateTask(TaskDataViewModel task, Vector2 worldPos, Vector2 range, Vector2 mapSizeDelta, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel obj = new MapMarkItemViewModel
		{
			MarkType = MarkTypeEnum.Task,
			Layer = MarkLayer.Normal,
			id = task.TaskId,
			Icon = $"task_mark_{task.TaskType}",
			ShowTaskEffect = task.TrackState,
			posOri = InteractivePoint.PointPosWorldToLocal(new Vector2(worldPos.x, worldPos.y) - posOffset, mapSizeDelta, sceneToUiRatio)
		};
		obj.Pos = obj.posOri;
		obj.SetMapUIParam(mapSizeDelta, sceneToUiRatio, posOffset);
		obj.MarkState = 1;
		obj.MarkRange = range;
		return obj;
	}

	public static MapMarkItemViewModel CreateTpPoint(DRTransferPoint drTpPoint, Vector2 mapSize, float sceneToUiRatio, Vector2 posOffset, MiniMapViewModel parent)
	{
		MapMarkItemViewModel mapMarkItemViewModel = new MapMarkItemViewModel();
		mapMarkItemViewModel.MarkType = MarkTypeEnum.TpPoint;
		mapMarkItemViewModel.Layer = MarkLayer.Normal;
		mapMarkItemViewModel.SetParent(parent);
		mapMarkItemViewModel.id = drTpPoint.Id;
		int num = (parent.ActiveBonfires.Contains(drTpPoint.Id) ? 1 : 0);
		mapMarkItemViewModel.Icon = $"map_mark_{drTpPoint.PointType + 1}_{num}";
		mapMarkItemViewModel.ShowBonfireEffect = false;
		Vector2 vector = new Vector2((drTpPoint.TransferPointPos.Count > 0) ? drTpPoint.TransferPointPos[0] : 0f, (drTpPoint.TransferPointPos.Count > 1) ? drTpPoint.TransferPointPos[1] : 0f);
		mapMarkItemViewModel.posOri = InteractivePoint.PointPosWorldToLocal(vector - posOffset, mapSize, sceneToUiRatio);
		mapMarkItemViewModel.Pos = mapMarkItemViewModel.posOri;
		mapMarkItemViewModel.SetMapUIParam(mapSize, sceneToUiRatio, posOffset);
		mapMarkItemViewModel.MarkState = num;
		return mapMarkItemViewModel;
	}

	public static MapMarkItemViewModel CreateBossMonster(int monsterId, Vector2 worldPos, Vector2 mapSize, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel obj = new MapMarkItemViewModel
		{
			MarkType = MarkTypeEnum.BossMonster,
			Layer = MarkLayer.Normal,
			id = monsterId,
			Icon = $"drawing_icon_{monsterId}",
			posOri = InteractivePoint.PointPosWorldToLocal(worldPos - posOffset, mapSize, sceneToUiRatio)
		};
		obj.Pos = obj.posOri;
		obj.SetMapUIParam(mapSize, sceneToUiRatio, posOffset);
		return obj;
	}

	public static MapMarkItemViewModel CreateMapItem(DRMapItemType drMapItemType, string icon, Vector2 worldPos, Vector2 mapSize, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel obj = new MapMarkItemViewModel
		{
			MarkType = MarkTypeEnum.MapItem,
			Layer = MarkLayer.Normal,
			id = drMapItemType.Id,
			Icon = (string.IsNullOrEmpty(icon) ? "" : icon),
			posOri = InteractivePoint.PointPosWorldToLocal(worldPos - posOffset, mapSize, sceneToUiRatio)
		};
		obj.Pos = obj.posOri;
		obj.SetMapUIParam(mapSize, sceneToUiRatio, posOffset);
		return obj;
	}

	public static MapMarkItemViewModel CreateCavePoint(DRCavernPoint drCavernPoint, string icon, bool active, Vector2 configPos, Vector2 mapSize, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel obj = new MapMarkItemViewModel
		{
			MarkType = MarkTypeEnum.CavePoint,
			Layer = MarkLayer.Normal,
			id = drCavernPoint.Id,
			Icon = (string.IsNullOrEmpty(icon) ? "" : icon),
			posOri = InteractivePoint.PointPosWorldToLocal(configPos - posOffset, mapSize, sceneToUiRatio)
		};
		obj.Pos = obj.posOri;
		obj.SetMapUIParam(mapSize, sceneToUiRatio, posOffset);
		obj.MarkState = (active ? 1 : 0);
		return obj;
	}

	public static MapMarkItemViewModel CreateTrack(TaskDataViewModel task, Vector2 worldPos, Vector2 range, Vector2 mapSizeDelta, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel mapMarkItemViewModel = new MapMarkItemViewModel();
		mapMarkItemViewModel.MarkType = MarkTypeEnum.Task;
		mapMarkItemViewModel.Layer = MarkLayer.Overlay;
		mapMarkItemViewModel.id = task.TaskId;
		mapMarkItemViewModel.Icon = $"task_mark_{task.TaskType}";
		mapMarkItemViewModel.ShowTaskEffect = task.TrackState;
		mapMarkItemViewModel.posOri = InteractivePoint.PointPosWorldToLocal(new Vector2(worldPos.x, worldPos.y) - posOffset, mapSizeDelta, sceneToUiRatio);
		mapMarkItemViewModel.MarkState = 1;
		mapMarkItemViewModel.MarkRange = range;
		mapMarkItemViewModel.SetMapUIParam(mapSizeDelta, sceneToUiRatio, posOffset);
		return mapMarkItemViewModel;
	}

	public static MapMarkItemViewModel CreateTrack(DRCavernPoint drCavernPoint, string icon, bool active, string outsideIcon, Vector2 configPos, Vector2 mapSize, float sceneToUiRatio, Vector2 posOffset)
	{
		MapMarkItemViewModel obj = new MapMarkItemViewModel
		{
			MarkType = MarkTypeEnum.CavePoint,
			Layer = MarkLayer.Overlay,
			id = drCavernPoint.Id,
			Icon = (string.IsNullOrEmpty(icon) ? "" : icon),
			posOri = InteractivePoint.PointPosWorldToLocal(configPos - posOffset, mapSize, sceneToUiRatio)
		};
		obj.Pos = obj.posOri;
		obj.MarkState = (active ? 1 : 0);
		obj.OutsideIcon = outsideIcon;
		obj.ShowTaskEffect = true;
		obj.SetMapUIParam(mapSize, sceneToUiRatio, posOffset);
		return obj;
	}

	public void UpdateIcon(string iconPath)
	{
		Icon = (string.IsNullOrEmpty(iconPath) ? "" : iconPath);
	}

	public void UpdateWorldPos(Vector3 worldPos)
	{
		posOri = InteractivePoint.PointPosWorldToLocal(new Vector2(worldPos.x, worldPos.z) - posOffset, mapSizeDelta, sceneToUiRatio);
		Pos = posOri;
	}

	public void UpdateMarkRange(Vector2 markRange)
	{
		MarkRange = markRange;
	}

	private bool CheckIsOutside(float range, Vector2 v1, Vector2 v2)
	{
		float num = v1.x - v2.x;
		float num2 = v1.y - v2.y;
		return num * num + num2 * num2 > range * range;
	}

	public virtual void UpdateMarkFollowPos(Vector2 center, Vector2 scrollRectSizeRadis, Vector2 localScale)
	{
		Vector2 vector = posOri * localScale;
		bool num = MarkRange.x > 0f && MarkRange.y > 0f;
		IsOutside = false;
		if (CheckIsOutside(scrollRectSizeRadis.x, vector, center))
		{
			IsOutside = true;
			vector = center + (vector - center).normalized * scrollRectSizeRadis.x;
		}
		if (num)
		{
			ShowMarkRange = !IsOutside;
			Layer = (IsOutside ? MarkLayer.Overlay : MarkLayer.Normal);
		}
		else
		{
			ShowMarkRange = false;
		}
		Pos = vector / localScale;
	}

	public void SetMarkState(int newState)
	{
		int num = MarkState;
		MarkState = newState;
		if (markType == MarkTypeEnum.TpPoint)
		{
			Icon = $"{Icon.Substring(0, Icon.LastIndexOf('_'))}_{newState}";
			if (num == 0 && newState == 1)
			{
				ShowBonfireEffect = false;
				ShowBonfireEffect = true;
			}
		}
	}

	public void SetMapUIParam(Vector2 mapSizeDelta, float sceneToUiRatio, Vector2 posOffset)
	{
		this.mapSizeDelta = mapSizeDelta;
		this.sceneToUiRatio = sceneToUiRatio;
		this.posOffset = posOffset;
	}

	public void SetMarkItemSize(Vector2 itemSize)
	{
		markItemSize = itemSize;
	}
}

using System;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class InteractivePoint : UGuiView
{
	public enum AnimationType
	{
		Enter,
		Out
	}

	public enum PointType
	{
		NormalTp,
		SpecialTp,
		MainTask,
		SideTask,
		DailyTask,
		MonsterTask,
		Player,
		BossMonster,
		MapItem,
		CavePoint,
		None
	}

	public class PointInfo
	{
		public PointType PointType;

		public int Id;

		public string Name;

		public Vector2 Pos;

		public string Icon = "";

		public float SceneToUiRatio;

		public PointInfo(PointType type, int id, Vector2 uiPos)
		{
			PointType = type;
			Id = id;
			Pos = uiPos;
		}

		public PointInfo(PointType type, int id, string name, Vector2 uiPos)
		{
			PointType = type;
			Id = id;
			Name = name;
			Pos = uiPos;
		}

		public PointInfo(PointType type, int id, string name, Vector2 worldPos, Vector2 posOffset, Vector2 mapSize, float sceneToUiRatio = 0f)
		{
			PointType = type;
			Id = id;
			Name = name;
			SceneToUiRatio = ((sceneToUiRatio > 0f) ? sceneToUiRatio : GameEntry.Base.GameConfig.minimap_UISceneRatio);
			Pos = PointPosWorldToLocal(worldPos - posOffset, mapSize, SceneToUiRatio);
		}

		public PointInfo(PointType type, string icon, Vector2 worldPos, Vector2 posOffset, Vector2 mapSize, float sceneToUiRatio = 0f)
		{
			PointType = type;
			Icon = icon;
			SceneToUiRatio = ((sceneToUiRatio > 0f) ? sceneToUiRatio : GameEntry.Base.GameConfig.minimap_UISceneRatio);
			Pos = PointPosWorldToLocal(worldPos - posOffset, mapSize, SceneToUiRatio);
		}

		public bool Equal(PointInfo info)
		{
			if (PointType == info.PointType && Id == info.Id)
			{
				return Pos == info.Pos;
			}
			return false;
		}
	}

	[SerializeField]
	protected RectTransform pointRect;

	[SerializeField]
	protected GameObject iconBg;

	[SerializeField]
	protected Image icon;

	[SerializeField]
	protected Button btn;

	private InteractivePointData _viewModel;

	public virtual void Init(InteractivePointData data)
	{
		_viewModel = data;
		BindingSet<InteractivePoint, InteractivePointData> bindingSet = this.CreateBindingSet(data);
		if (pointRect != null)
		{
			bindingSet.Bind(pointRect).For((RectTransform v) => v.anchoredPosition).To((InteractivePointData vm) => vm.Pos);
			bindingSet.Bind(pointRect).For((RectTransform v) => v.localScale).To((InteractivePointData vm) => vm.Scale);
		}
		if (icon != null)
		{
			bindingSet.Bind(icon).For((Image v) => v.sprite).To((InteractivePointData vm) => vm.Icon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(icon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((InteractivePointData vm) => !string.IsNullOrEmpty(vm.Icon));
		}
		if (iconBg != null)
		{
			bindingSet.Bind(iconBg).For((GameObject v) => v.activeSelf).ToExpression((InteractivePointData vm) => !string.IsNullOrEmpty(vm.Icon));
		}
		if (btn != null)
		{
			bindingSet.Bind(btn).For((Button v) => v.onClick).To((InteractivePointData vm) => vm.OnClick);
		}
		bindingSet.Bind().For((InteractivePoint v) => v.PlayShowAnimation).To((InteractivePointData vm) => vm.PlayShowAnimation);
		bindingSet.Bind().For((InteractivePoint v) => v.PlayHideAnimation).To((InteractivePointData vm) => vm.PlayHideAnimation);
		bindingSet.Build();
	}

	public void RefreshData(InteractivePointData data)
	{
		_viewModel = data;
		this.SetDataContext(data);
	}

	public InteractivePointData GetPointData()
	{
		return _viewModel;
	}

	public virtual void PlayShowAnimation(object sender, InteractionEventArgs e)
	{
		Action action = e.Callback;
		EnterAnimation?.OnEnd(delegate
		{
			action?.Invoke();
		}).Play();
	}

	public virtual void PlayHideAnimation(object sender, InteractionEventArgs e)
	{
		Action action = e.Callback;
		ExitAnimation?.OnEnd(delegate
		{
			action?.Invoke();
		}).Play();
	}

	public static string GetPointIcon(PointInfo pointInfo)
	{
		return pointInfo.PointType switch
		{
			PointType.Player => GetPointIcon(pointInfo.PointType), 
			PointType.NormalTp => GetPointIcon(pointInfo.PointType), 
			PointType.SpecialTp => GetPointIcon(pointInfo.PointType), 
			PointType.MainTask => GetPointIcon(pointInfo.PointType), 
			PointType.SideTask => GetPointIcon(pointInfo.PointType), 
			PointType.DailyTask => GetPointIcon(pointInfo.PointType), 
			PointType.BossMonster => $"drawing_icon_{pointInfo.Id}", 
			PointType.MapItem => pointInfo.Icon, 
			PointType.CavePoint => "cave_point_normal", 
			_ => "", 
		};
	}

	public static string GetPointIcon(PointType pointType)
	{
		return pointType switch
		{
			PointType.Player => "player_mark", 
			PointType.NormalTp => "map_mark_2_1", 
			PointType.SpecialTp => "map_mark_3_1", 
			PointType.MainTask => "task_mark_1", 
			PointType.SideTask => "task_mark_2", 
			PointType.DailyTask => "task_mark_3", 
			_ => "", 
		};
	}

	public static PointType GetTaskPointType(int taskType)
	{
		return taskType switch
		{
			1 => PointType.MainTask, 
			2 => PointType.SideTask, 
			3 => PointType.DailyTask, 
			4 => PointType.MonsterTask, 
			_ => PointType.None, 
		};
	}

	public static int GetPointIconPriority(PointType pointType)
	{
		return pointType switch
		{
			PointType.Player => 10, 
			PointType.MainTask => 9, 
			PointType.SideTask => 8, 
			PointType.DailyTask => 7, 
			_ => 0, 
		};
	}

	public static Vector2 PointPosWorldToLocal(Vector2 worldPos, Vector2 mapSize, float customRatio)
	{
		customRatio = ((customRatio > 0f) ? customRatio : GameEntry.Base.GameConfig.minimap_UISceneRatio);
		Vector2 vector = worldPos * customRatio;
		return new Vector2(vector.x, vector.y - mapSize.y / 2f);
	}

	public static MapGuidePointData UpdatePointVisualDataWithRectangle(Vector3[] areaCorners1, float[] partitionAngles, RectTransform point, RectTransform parentRect, PointInfo info)
	{
		if (areaCorners1.Length < 4 || partitionAngles.Length < 4)
		{
			return null;
		}
		float num = UIUtilly.GetCanvasSize().y / (float)Screen.height;
		Vector3[] array = new Vector3[4]
		{
			areaCorners1[0] * num,
			areaCorners1[1] * num,
			areaCorners1[2] * num,
			areaCorners1[3] * num
		};
		bool flag = true;
		Vector2 zero = Vector2.zero;
		float num2 = (array[2].x - array[1].x) / 2f;
		float num3 = (array[1].y - array[0].y) / 2f;
		Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), point.position) * num;
		Vector2 vector2 = new Vector2(UIUtilly.GetCanvasSize().x / 2f, UIUtilly.GetCanvasSize().y / 2f);
		Vector2 vector3 = vector - vector2;
		float num4 = Vector2.Angle(Vector2.up, vector3);
		if (Vector3.Cross(Vector2.up, vector3).z < 0f)
		{
			num4 = 360f - num4;
		}
		if (num4 < partitionAngles[0] && num4 > partitionAngles[1])
		{
			if (vector.x <= array[0].x)
			{
				flag = false;
				Vector2 vector4 = new Vector2(array[0].x, num2 / (vector2.x - vector.x) * (vector.y - vector2.y) + vector2.y) / num;
				RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, vector4, UIUtilly.GetUICamera(), ref zero);
			}
		}
		else if (num4 > partitionAngles[3] && num4 < partitionAngles[2])
		{
			if (vector.x >= array[2].x)
			{
				flag = false;
				Vector2 vector5 = new Vector2(array[2].x, num2 / (vector.x - vector2.x) * (vector.y - vector2.y) + vector2.y) / num;
				RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, vector5, UIUtilly.GetUICamera(), ref zero);
			}
		}
		else if (num4 <= partitionAngles[1] || num4 >= partitionAngles[2])
		{
			if (vector.y >= array[1].y)
			{
				flag = false;
				Vector2 vector6 = new Vector2(num3 / (vector.y - vector2.y) * (vector.x - vector2.x) + vector2.x, array[1].y) / num;
				RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, vector6, UIUtilly.GetUICamera(), ref zero);
			}
		}
		else if (num4 >= partitionAngles[0] && num4 <= partitionAngles[3] && vector.y <= array[0].y)
		{
			flag = false;
			Vector2 vector7 = new Vector2(num3 / (vector2.y - vector.y) * (vector.x - vector2.x) + vector2.x, array[0].y) / num;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(parentRect, vector7, UIUtilly.GetUICamera(), ref zero);
		}
		if (flag)
		{
			return null;
		}
		return new MapGuidePointData(info, num4, zero, vector3.magnitude);
	}
}

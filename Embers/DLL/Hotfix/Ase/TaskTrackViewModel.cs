using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class TaskTrackViewModel : ItemOptionBase
{
	private Vector2 taskPos;

	private int taskType;

	private bool isShow;

	private Vector3 uiPos = Vector3.zero;

	private Quaternion rotZ;

	private Quaternion rotZIcon;

	private InteractionRequest fixIconPosRequest;

	public bool IsShow
	{
		get
		{
			return isShow;
		}
		set
		{
			Set(ref isShow, value, "IsShow");
		}
	}

	public Vector2 TaskPos
	{
		get
		{
			return taskPos;
		}
		private set
		{
			Set(ref taskPos, value, "TaskPos");
		}
	}

	public int TaskType
	{
		get
		{
			return taskType;
		}
		private set
		{
			Set(ref taskType, value, "TaskType");
		}
	}

	public Vector3 UiPos
	{
		get
		{
			return uiPos;
		}
		private set
		{
			Set(ref uiPos, value, "UiPos");
		}
	}

	public Quaternion RotZ
	{
		get
		{
			return rotZ;
		}
		private set
		{
			Set(ref rotZ, value, "RotZ");
		}
	}

	public Quaternion RotZIcon
	{
		get
		{
			return rotZIcon;
		}
		private set
		{
			Set(ref rotZIcon, value, "RotZIcon");
		}
	}

	public IInteractionRequest FixIconPosRequest => fixIconPosRequest;

	public TaskTrackViewModel(OptionBase parent, Vector2 taskPos, int taskType)
	{
		base.parent = parent;
		this.taskPos = taskPos;
		this.taskType = taskType;
		isShow = true;
		fixIconPosRequest = new InteractionRequest();
	}

	public void UpdateTask(Vector2 taskPos, int taskType)
	{
		TaskPos = taskPos;
		TaskType = taskType;
	}

	public void UpdateItemPos(Vector3 pos)
	{
	}
}

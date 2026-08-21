using System;
using Ase.ECS;
using UnityEngine;

[Serializable]
public abstract class TaskClip : ScriptableObject
{
	[VariableName("节点名字")]
	public string taskName;

	[VariableName("节点开始的帧号")]
	public int taskStartID;

	[VariableName("节点时间长度")]
	public int taskDuration;

	protected PlayableStateEnum StateEnum = PlayableStateEnum.Exit;

	public PlayableStateEnum State => StateEnum;

	public virtual void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		StateEnum = PlayableStateEnum.Running;
	}

	public virtual void EditorEnter(GameObject context, int fps, int currentFrameID)
	{
		StateEnum = PlayableStateEnum.Running;
	}

	public virtual void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
	}

	public virtual void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
	}

	public virtual void OnRunTimeExit(BaseEntity context, int fps, int currentFrameID)
	{
		StateEnum = PlayableStateEnum.Exit;
	}

	public virtual void EditorExit(GameObject context, int fps, int currentFrameID)
	{
		StateEnum = PlayableStateEnum.Exit;
	}

	public virtual void OnTimelineEnd(BaseEntity context, int fps, int currentFrameID)
	{
		if (StateEnum != PlayableStateEnum.Exit)
		{
			OnRunTimeExit(context, fps, currentFrameID);
		}
	}
}

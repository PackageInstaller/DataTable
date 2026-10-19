using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

[Serializable]
[CreateAssetMenu(fileName = "NewNpcBehaviorTree", menuName = "NPC/NpcBehaviorTree", order = 0)]
public class NpcBehaviorTree : ExternalBehaviorTree
{
	protected const float NodeSpacingX = 50f;

	protected const float NodeSpacingY = 100f;

	public virtual void GenerateTree()
	{
		Debug.Log("[" + GetType().Name + "] GenerateTree - base (no-op)");
	}

	protected static void RecalculateLayout(Task rootTask, Vector2 rootPosition, float spacingX = 50f, float spacingY = 100f)
	{
		if (rootTask != null)
		{
			Dictionary<Task, float> dictionary = new Dictionary<Task, float>();
			CalcSubtreeWidth(rootTask, spacingX, dictionary);
			AssignPositions(rootTask, rootPosition, spacingX, spacingY, dictionary);
		}
	}

	protected void RecalculateLayoutAll(float spacingX = 50f, float spacingY = 100f)
	{
		Task task = BehaviorSource?.RootTask;
		if (task != null)
		{
			ReassignTaskIDs();
			Task entryTask = BehaviorSource.EntryTask;
			if (entryTask != null)
			{
				EnsureNodeData(entryTask).Offset = Vector2.zero;
			}
			RecalculateLayout(task, new Vector2(0f, spacingY), spacingX, spacingY);
		}
	}

	protected void ReassignTaskIDs()
	{
		int nextId = 0;
		Task entryTask = BehaviorSource.EntryTask;
		if (entryTask != null)
		{
			AssignIDsRecursive(entryTask, ref nextId);
		}
		Task rootTask = BehaviorSource.RootTask;
		if (rootTask != null)
		{
			AssignIDsRecursive(rootTask, ref nextId);
		}
		List<Task> detachedTasks = BehaviorSource.DetachedTasks;
		if (detachedTasks == null)
		{
			return;
		}
		foreach (Task item in detachedTasks)
		{
			if (item != null)
			{
				AssignIDsRecursive(item, ref nextId);
			}
		}
	}

	private static void AssignIDsRecursive(Task task, ref int nextId)
	{
		task.ID = nextId++;
		if (!(task is ParentTask { Children: not null } parentTask))
		{
			return;
		}
		foreach (Task child in parentTask.Children)
		{
			AssignIDsRecursive(child, ref nextId);
		}
	}

	private static float CalcSubtreeWidth(Task task, float spacingX, Dictionary<Task, float> cache)
	{
		if (task is ParentTask { Children: not null } parentTask && parentTask.Children.Count > 0)
		{
			float num = 0f;
			foreach (Task child in parentTask.Children)
			{
				num += CalcSubtreeWidth(child, spacingX, cache);
			}
			cache[task] = num;
			return num;
		}
		cache[task] = spacingX;
		return spacingX;
	}

	private static void AssignPositions(Task task, Vector2 position, float spacingX, float spacingY, Dictionary<Task, float> widthCache)
	{
		EnsureNodeData(task).Offset = position;
		if (!(task is ParentTask { Children: not null } parentTask) || parentTask.Children.Count == 0)
		{
			return;
		}
		float num = widthCache[task];
		float y = position.y + spacingY;
		float num2 = position.x - num * 0.5f;
		foreach (Task child in parentTask.Children)
		{
			float num3 = widthCache[child];
			float x = num2 + num3 * 0.5f;
			AssignPositions(child, new Vector2(x, y), spacingX, spacingY, widthCache);
			num2 += num3;
		}
	}

	private static NodeData EnsureNodeData(Task task)
	{
		if (task.NodeData == null)
		{
			task.NodeData = new NodeData();
		}
		return task.NodeData;
	}

	protected static Task FindTask(Task task, string name)
	{
		if (task == null)
		{
			return null;
		}
		if (task.FriendlyName == name || (task.NodeData != null && task.NodeData.Comment == name))
		{
			return task;
		}
		if (task is ParentTask { Children: not null } parentTask)
		{
			foreach (Task child in parentTask.Children)
			{
				Task task2 = FindTask(child, name);
				if (task2 != null)
				{
					return task2;
				}
			}
		}
		return null;
	}

	protected static T CreateNewTask<T>(string nodeName = "") where T : Task, new()
	{
		T val = new T();
		if (!string.IsNullOrEmpty(nodeName))
		{
			val.FriendlyName = nodeName;
		}
		val.NodeData = new NodeData();
		return val;
	}
}

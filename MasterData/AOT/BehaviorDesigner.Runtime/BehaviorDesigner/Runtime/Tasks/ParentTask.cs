using System.Collections.Generic;
using UnityEngine;

namespace BehaviorDesigner.Runtime.Tasks;

public abstract class ParentTask : Task
{
	[SerializeField]
	protected List<Task> children;

	public List<Task> Children
	{
		get
		{
			return children;
		}
		private set
		{
			children = value;
		}
	}

	public virtual int MaxChildren()
	{
		return int.MaxValue;
	}

	public virtual bool CanRunParallelChildren()
	{
		return false;
	}

	public virtual int CurrentChildIndex()
	{
		return 0;
	}

	public virtual bool CanExecute()
	{
		return true;
	}

	public virtual TaskStatus Decorate(TaskStatus status)
	{
		return status;
	}

	public virtual bool CanReevaluate()
	{
		return false;
	}

	public virtual void OnChildExecuted(TaskStatus childStatus)
	{
	}

	public virtual void OnChildExecuted(int childIndex, TaskStatus childStatus)
	{
	}

	public virtual void OnChildStarted()
	{
	}

	public virtual void OnChildStarted(int childIndex)
	{
	}

	public virtual TaskStatus OverrideStatus(TaskStatus status)
	{
		return status;
	}

	public virtual TaskStatus OverrideStatus()
	{
		return TaskStatus.Running;
	}

	public virtual void OnConditionalAbort(int childIndex)
	{
	}

	public override float GetUtility()
	{
		float num = 0f;
		if (children != null)
		{
			for (int i = 0; i < children.Count; i++)
			{
				if (children[i] != null && !children[i].Disabled)
				{
					num += children[i].GetUtility();
				}
			}
		}
		return num;
	}

	public override void OnDrawGizmos()
	{
		if (children == null)
		{
			return;
		}
		for (int i = 0; i < children.Count; i++)
		{
			if (children[i] != null && !children[i].Disabled)
			{
				children[i].OnDrawGizmos();
			}
		}
	}

	public void AddChild(Task child, int index)
	{
		if (children == null)
		{
			children = new List<Task>();
		}
		children.Insert(index, child);
	}

	public void ReplaceAddChild(Task child, int index)
	{
		if (children != null && index < children.Count)
		{
			children[index] = child;
		}
		else
		{
			AddChild(child, index);
		}
	}
}

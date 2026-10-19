using System;
using System.Collections.Generic;
using System.Reflection;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public class NodeData
{
	[SerializeField]
	private object nodeDesigner;

	[SerializeField]
	private Vector2 offset;

	[SerializeField]
	private string friendlyName = "";

	[SerializeField]
	private string comment = "";

	[SerializeField]
	private bool isBreakpoint;

	[SerializeField]
	private Texture icon;

	[SerializeField]
	private bool collapsed;

	[SerializeField]
	private int colorIndex;

	[SerializeField]
	private List<string> watchedFieldNames;

	private List<FieldInfo> watchedFields;

	private float pushTime = -1f;

	private float popTime = -1f;

	private float interruptTime = -1f;

	private bool isReevaluating;

	private TaskStatus executionStatus;

	public object NodeDesigner
	{
		get
		{
			return nodeDesigner;
		}
		set
		{
			nodeDesigner = value;
		}
	}

	public Vector2 Offset
	{
		get
		{
			return offset;
		}
		set
		{
			offset = value;
		}
	}

	public string FriendlyName
	{
		get
		{
			return friendlyName;
		}
		set
		{
			friendlyName = value;
		}
	}

	public string Comment
	{
		get
		{
			return comment;
		}
		set
		{
			comment = value;
		}
	}

	public bool IsBreakpoint
	{
		get
		{
			return isBreakpoint;
		}
		set
		{
			isBreakpoint = value;
		}
	}

	public Texture Icon
	{
		get
		{
			return icon;
		}
		set
		{
			icon = value;
		}
	}

	public bool Collapsed
	{
		get
		{
			return collapsed;
		}
		set
		{
			collapsed = value;
		}
	}

	public int ColorIndex
	{
		get
		{
			return colorIndex;
		}
		set
		{
			colorIndex = value;
		}
	}

	public List<string> WatchedFieldNames
	{
		get
		{
			return watchedFieldNames;
		}
		set
		{
			watchedFieldNames = value;
		}
	}

	public List<FieldInfo> WatchedFields
	{
		get
		{
			return watchedFields;
		}
		set
		{
			watchedFields = value;
		}
	}

	public float PushTime
	{
		get
		{
			return pushTime;
		}
		set
		{
			pushTime = value;
		}
	}

	public float PopTime
	{
		get
		{
			return popTime;
		}
		set
		{
			popTime = value;
		}
	}

	public float InterruptTime
	{
		get
		{
			return interruptTime;
		}
		set
		{
			interruptTime = value;
		}
	}

	public bool IsReevaluating
	{
		get
		{
			return isReevaluating;
		}
		set
		{
			isReevaluating = value;
		}
	}

	public TaskStatus ExecutionStatus
	{
		get
		{
			return executionStatus;
		}
		set
		{
			executionStatus = value;
		}
	}

	public void InitWatchedFields(Task task)
	{
		if (watchedFieldNames == null || watchedFieldNames.Count <= 0)
		{
			return;
		}
		watchedFields = new List<FieldInfo>();
		for (int i = 0; i < watchedFieldNames.Count; i++)
		{
			FieldInfo field = task.GetType().GetField(watchedFieldNames[i], BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			if (field != null)
			{
				watchedFields.Add(field);
			}
		}
	}

	public void CopyFrom(NodeData nodeData, Task task)
	{
		nodeDesigner = nodeData.NodeDesigner;
		offset = nodeData.Offset;
		comment = nodeData.Comment;
		isBreakpoint = nodeData.IsBreakpoint;
		collapsed = nodeData.Collapsed;
		if (nodeData.WatchedFields == null || nodeData.WatchedFields.Count <= 0)
		{
			return;
		}
		watchedFields = new List<FieldInfo>();
		watchedFieldNames = new List<string>();
		for (int i = 0; i < nodeData.watchedFields.Count; i++)
		{
			FieldInfo field = task.GetType().GetField(nodeData.WatchedFields[i].Name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			if (field != null)
			{
				watchedFields.Add(field);
				watchedFieldNames.Add(field.Name);
			}
		}
	}

	public int GetWatchedFieldIndex(FieldInfo field)
	{
		if (watchedFields == null)
		{
			return -1;
		}
		for (int i = 0; i < watchedFields.Count; i++)
		{
			if (!(watchedFields[i] == null) && watchedFields[i].FieldType == field.FieldType && watchedFields[i].Name == field.Name)
			{
				return i;
			}
		}
		return -1;
	}

	public void AddWatchedField(FieldInfo field)
	{
		if (watchedFields == null)
		{
			watchedFields = new List<FieldInfo>();
			watchedFieldNames = new List<string>();
		}
		if (GetWatchedFieldIndex(field) == -1)
		{
			watchedFields.Add(field);
			watchedFieldNames.Add(field.Name);
		}
	}

	public void RemoveWatchedField(FieldInfo field)
	{
		int watchedFieldIndex = GetWatchedFieldIndex(field);
		if (watchedFieldIndex != -1)
		{
			watchedFields.RemoveAt(watchedFieldIndex);
			watchedFieldNames.RemoveAt(watchedFieldIndex);
		}
	}

	private static Vector2 StringToVector2(string vector2String)
	{
		string[] array = vector2String.Substring(1, vector2String.Length - 2).Split(',');
		return new Vector3(float.Parse(array[0]), float.Parse(array[1]));
	}
}

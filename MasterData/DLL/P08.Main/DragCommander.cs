using System;
using System.Collections.Generic;
using UnityEngine;

public class DragCommander : MonoBehaviour
{
	public enum DragType
	{
		acceptDragX,
		acceptDragY,
		acceptDragXY
	}

	[Serializable]
	public class DragField
	{
		public GameObject go;

		public DragType type;
	}

	[Header("设置传递事件间隔，若为null则自动生成")]
	public GameObject mask;

	[Header("设置传递事件限制")]
	public bool isPassEvent;

	public bool isPassClick = true;

	public bool isPassDrag = true;

	public bool isPassClickInDrag;

	public List<DragField> dragList = new List<DragField>();

	private List<int> cloneID = new List<int>();

	public UnityEngine.Object[] GetDragValues()
	{
		return GetDragValuesByList(dragList);
	}

	private UnityEngine.Object[] GetDragValuesByList(List<DragField> list)
	{
		UnityEngine.Object[] array = new UnityEngine.Object[list.Count];
		for (int i = 1; i < list.Count; i++)
		{
			DragField dragField = list[i];
			DragType type = dragField.type;
			if (dragField.go == null)
			{
				array[i] = null;
				continue;
			}
			switch (type)
			{
			case DragType.acceptDragX:
				array[i] = dragField.go;
				break;
			case DragType.acceptDragY:
				array[i] = dragField.go;
				break;
			case DragType.acceptDragXY:
				array[i] = dragField.go;
				break;
			}
		}
		return array;
	}
}

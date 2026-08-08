using UnityEngine;

public class DragHelper : MonoBehaviour
{
	[HideInInspector]
	public bool acceptDragX = true;

	[HideInInspector]
	public bool acceptDragY = true;

	public bool AcceptDragX
	{
		get
		{
			return acceptDragX;
		}
		set
		{
			acceptDragX = value;
		}
	}

	public bool AcceptDragY
	{
		get
		{
			return acceptDragY;
		}
		set
		{
			acceptDragY = value;
		}
	}
}

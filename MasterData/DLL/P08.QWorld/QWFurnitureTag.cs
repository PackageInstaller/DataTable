using Dorm;
using UnityEngine;

public class QWFurnitureTag : FurnitureTag
{
	public InteractAction exitAction;

	public bool dontNeedMoveExit;

	public bool needForceExit;

	public Transform forceExitPoint;

	public string idleAnim;

	public bool needFocus;

	public Transform focusPoint;

	public Transform hudPivot;

	private bool IsShowForceExit()
	{
		return dontNeedMoveExit;
	}
}

using UnityEngine;

public class NewChessCameraCtrlGameLogic : IChessCameraCtrlGameLogic
{
	public void UpdateLogic(Vector2 dragDelta)
	{
		if (dragDelta.magnitude > 0f)
		{
			LuaHelper.CallFunction("OnNewChessCameraMove");
			NewHexCameraManager.Instance.MoveGameplayCamera(-1f * dragDelta);
		}
	}
}

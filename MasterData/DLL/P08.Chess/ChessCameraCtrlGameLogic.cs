using UnityEngine;

public class ChessCameraCtrlGameLogic : IChessCameraCtrlGameLogic
{
	public void UpdateLogic(Vector2 dragDelta)
	{
		if (dragDelta.magnitude > 0f)
		{
			LuaHelper.CallFunction("OnCameraMove");
			HexCameraManager.Instance.MoveGameplayCamera(-1f * dragDelta);
		}
	}
}

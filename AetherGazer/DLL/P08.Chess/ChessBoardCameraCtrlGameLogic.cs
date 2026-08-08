using ChessBoard;
using UnityEngine;

public class ChessBoardCameraCtrlGameLogic : IChessCameraCtrlGameLogic
{
	public void UpdateLogic(Vector2 dragDelta)
	{
		if (dragDelta.magnitude > 0f)
		{
			LuaHelper.CallFunction("OnChessBoardCameraMove");
			ChessBoardCameraManager.Instance.MoveGameplayCamera(-1f * dragDelta);
		}
	}
}

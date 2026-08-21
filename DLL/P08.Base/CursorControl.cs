using UnityEngine;

public static class CursorControl
{
	private static ICursorControl _cursorControl;

	static CursorControl()
	{
		_cursorControl = new CursorControlWindows();
	}

	public static void MoveLocalCursorPos(Vector2 pos)
	{
		_cursorControl?.MoveLocalCursorPos(pos);
	}
}

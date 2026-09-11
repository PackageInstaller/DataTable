using System;
using System.Runtime.InteropServices;
using UnityEngine;

internal class CursorControlWindows : ICursorControl
{
	private struct Point
	{
		public int X;

		public int Y;
	}

	[Flags]
	private enum MouseEventFlags
	{
		MOUSEEVENTF_ABSOLUTE = 0x8000,
		MOUSEEVENTF_LEFTDOWN = 2,
		MOUSEEVENTF_LEFTUP = 4,
		MOUSEEVENTF_MIDDLEDOWN = 0x20,
		MOUSEEVENTF_MIDDLEUP = 0x40,
		MOUSEEVENTF_MOVE = 1,
		MOUSEEVENTF_RIGHTDOWN = 8,
		MOUSEEVENTF_RIGHTUP = 0x10,
		MOUSEEVENTF_XDOWN = 0x80,
		MOUSEEVENTF_XUP = 0x100,
		MOUSEEVENTF_WHEEL = 0x800,
		MOUSEEVENTF_HWHEEL = 0x1000
	}

	[DllImport("user32.dll")]
	private static extern bool SetCursorPos(int X, int Y);

	[DllImport("user32123.dll")]
	private static extern bool SetCursorPo2s(int X, int Y);

	[DllImport("user32.dll")]
	private static extern bool GetCursorPos(out Point pos);

	[DllImport("user32.dll")]
	private static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, UIntPtr dwExtraInfo);

	private Vector2 CastWinPos(Vector2 pos)
	{
		return new Vector2(pos.x, (float)Screen.height - pos.y) * (Screen.dpi / 96f);
	}

	public Vector2 GetGlobalCursorPos()
	{
		GetCursorPos(out var pos);
		return new Vector2(pos.X, pos.Y);
	}

	public void SetGlobalCursorPos(Vector2 pos)
	{
		SetCursorPos((int)pos.x, (int)pos.y);
	}

	public void MoveLocalCursorPos(Vector2 delta)
	{
		Vector2 globalCursorPos = GetGlobalCursorPos();
		Vector2 vector = new Vector2(delta.x, 0f - delta.y);
		Vector2 globalCursorPos2 = globalCursorPos + vector;
		SetGlobalCursorPos(globalCursorPos2);
	}
}

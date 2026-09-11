using UnityEngine;

public class LuaForCursor
{
	public static void UseSystemCursor(bool val)
	{
	}

	public static void SwitchCursor(bool val)
	{
		PCCursor.SwtichCursor(val);
	}

	public static void SetCanMove(bool val)
	{
		PCCursor.SetCanMove(val);
	}

	public static void SetFullscreenScrollObject(GameObject go)
	{
		PCCursor.SetFullscreenScrollObject(go);
	}

	public static void SetKeyboardAutoHide(bool val)
	{
		PCCursor.SetKeyboardAutoHide(val);
	}

	public static bool GetKeyboardAutoHide()
	{
		return PCCursor.GetKeyboardAutoHide();
	}

	public static void SetBattleShowCursor(bool val)
	{
		PCCursor.SetBattleShowCursor(val);
	}

	public static bool GetBattleShowCursor()
	{
		return PCCursor.GetBattleShowCursor();
	}

	public static bool ResizeCursor(float percent)
	{
		return PCCursor.ResizeCursor(percent);
	}
}

using UnityEngine;

public class QWorldTestEntryBtn : MonoBehaviour
{
	private bool isEnter;

	public void Enter()
	{
		LuaHelper.CallFunction("DestroyLua");
		NScene.Load<QWorldScene>();
	}

	public static void LauncherQWorld()
	{
		LuaHelper.CallFunction("DestroyLua");
		NScene.Load<QWorldScene>();
	}

	private void OnGUI()
	{
		if (GUILayout.Button("test qworld") && !isEnter)
		{
			Enter();
			isEnter = true;
		}
	}
}

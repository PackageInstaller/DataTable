using UnityEngine;

public class UIAnimationEvent : MonoBehaviour
{
	public void PostEvent(string key)
	{
		LuaHelper.CallFunction("AnimtionEvnetAction.OnAnimtionEvent", key);
	}
}

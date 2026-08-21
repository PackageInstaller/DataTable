using System;
using System.Collections;
using UnityEngine;

public class WaitRenderFrame : MonoBehaviour
{
	private Action _callback;

	public void StartWait(Action func)
	{
		_callback = func;
		StartCoroutine(WaitFrame());
	}

	private IEnumerator WaitFrame()
	{
		bool cursorVisible = Cursor.visible;
		if (cursorVisible)
		{
			Cursor.visible = false;
		}
		yield return new WaitForEndOfFrame();
		if (cursorVisible)
		{
			Cursor.visible = true;
		}
		if (_callback != null)
		{
			_callback();
		}
	}
}

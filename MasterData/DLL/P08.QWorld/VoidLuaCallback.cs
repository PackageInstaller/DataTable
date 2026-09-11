using System;

public class VoidLuaCallback
{
	public Action callback;

	public void Invoke()
	{
		callback?.Invoke();
	}
}

using LuaInterface;
using UnityEngine;

internal class PicLoader
{
	public WWW www;

	private bool _isDown;

	private bool _isDispose;

	public bool IsDown => www.isDone;

	public bool IsDispose => _isDispose;

	public PicLoader(string url)
	{
		www = new WWW(url);
	}

	public void Destroy()
	{
		Debugger.Log("unload pic : " + www.url);
		www.Dispose();
		www = null;
		_isDispose = true;
	}
}

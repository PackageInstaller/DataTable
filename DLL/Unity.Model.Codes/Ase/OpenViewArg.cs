using System;

namespace Ase;

public class OpenViewArg
{
	private string viewName;

	private object userData;

	private bool isOpenWindow;

	private string uiGroupName;

	private Action callBack;

	private string path;

	private string entrance;

	public string ViewName => viewName;

	public object UserData => userData;

	public bool IsOpenWindow => isOpenWindow;

	public string UiGroupName => uiGroupName;

	public Action CallBack => callBack;

	public string Path => path;

	public string Entrance => entrance;

	public OpenViewArg(Type viewType, object userData, string entrance = "Default", bool isOpenWindow = true, string uiGroupName = "DEFAULT", Action callback = null)
	{
		viewName = viewType.FullName;
		this.userData = userData;
		this.isOpenWindow = isOpenWindow;
		this.uiGroupName = uiGroupName;
		callBack = callback;
		this.entrance = entrance;
	}

	public OpenViewArg(string path, object userData, string entrance = "Default", bool isOpenWindow = true, string uiGroupName = "DEFAULT", Action callback = null)
	{
		this.path = path;
		this.userData = userData;
		this.isOpenWindow = isOpenWindow;
		this.uiGroupName = uiGroupName;
		callBack = callback;
		this.entrance = entrance;
	}

	public OpenViewArg(Type viewType, object userData, Action callback, bool isOpenWindow = true)
	{
		viewName = viewType.FullName;
		this.userData = userData;
		this.isOpenWindow = isOpenWindow;
		uiGroupName = "DEFAULT";
		callBack = callback;
		entrance = "Default";
	}

	public OpenViewArg()
	{
	}
}

using System;

namespace Ase;

public class OpenViewArgTemp
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

	public OpenViewArgTemp(Type viewType, string path, object userData, Action callback = null, bool isOpenWindow = true)
	{
		viewName = viewType.FullName;
		this.userData = userData;
		this.isOpenWindow = isOpenWindow;
		uiGroupName = "DEFAULT";
		callBack = callback;
		entrance = "Default";
		this.path = path;
	}
}

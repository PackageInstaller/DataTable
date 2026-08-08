using System.Collections.Generic;

public class ViewAnimationManager
{
	private static ViewAnimationManager s_Instance;

	private bool s_ReturnFromBattle;

	private Dictionary<string, bool> returnFromBattle = new Dictionary<string, bool>();

	private Dictionary<string, bool> returnFromSubView = new Dictionary<string, bool>();

	private Dictionary<string, bool> firstEnter = new Dictionary<string, bool>();

	public static ViewAnimationManager instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new ViewAnimationManager();
			}
			return s_Instance;
		}
	}

	public static bool isReturnFromBattle
	{
		get
		{
			return instance.s_ReturnFromBattle;
		}
		set
		{
			instance.s_ReturnFromBattle = value;
		}
	}

	protected ViewAnimationManager()
	{
	}

	public static void Register(string viewName)
	{
		if (!instance.firstEnter.ContainsKey(viewName))
		{
			instance.firstEnter.Add(viewName, value: true);
			instance.returnFromBattle.Add(viewName, value: false);
			instance.returnFromSubView.Add(viewName, value: false);
		}
	}

	public static bool GetIsFirstEnter(string viewName)
	{
		bool value = false;
		if (instance.firstEnter.TryGetValue(viewName, out value) && value)
		{
			instance.firstEnter[viewName] = false;
		}
		return value;
	}

	public static bool GetIsReturnFromBattle(string viewName)
	{
		bool value = false;
		if (instance.returnFromBattle.TryGetValue(viewName, out value) && value)
		{
			instance.returnFromBattle[viewName] = false;
		}
		return value;
	}

	public static void SetIsReturnFromBattle(string viewName, bool value)
	{
		if (instance.returnFromBattle.ContainsKey(viewName))
		{
			instance.s_ReturnFromBattle = false;
			instance.returnFromBattle[viewName] = value;
		}
	}

	public static bool GetIsReturnFromSubView(string viewName)
	{
		bool value = false;
		if (instance.returnFromSubView.TryGetValue(viewName, out value) && value)
		{
			instance.returnFromSubView[viewName] = false;
		}
		return value;
	}

	public static void SetIsReturnFromSubView(string viewName, bool value)
	{
		if (instance.returnFromSubView.ContainsKey(viewName))
		{
			instance.returnFromSubView[viewName] = value;
		}
	}
}

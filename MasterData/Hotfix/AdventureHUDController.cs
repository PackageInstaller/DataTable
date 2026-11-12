using System.Collections.Generic;
using UnityEngine;

public class AdventureHUDController : SceneSingleton<AdventureHUDController>
{
	private int hudElement_1 = -10000;

	private int hudElement_2 = -10000;

	private int hudElement_3 = -10000;

	public Dictionary<long, float> hudDotLastXPos = new Dictionary<long, float>();

	protected int _hideRC;

	protected LogManager.Logger _logger;

	public List<IAdventureHUD> huds { get; protected set; } = new List<IAdventureHUD>();

	public bool useUnscaledTime { get; set; }

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure");
	}

	public void DriveLateUpdate()
	{
		float num = (useUnscaledTime ? Time.unscaledDeltaTime : Time.deltaTime);
		if (num > float.Epsilon)
		{
			for (int num2 = huds.Count - 1; num2 >= 0; num2--)
			{
				huds.get_Item(num2).HUDUpdate(num);
			}
		}
	}

	public void AddHud(IAdventureHUD hud)
	{
		huds.Add(hud);
	}

	public void RemoveHud(IAdventureHUD hud)
	{
		huds.Remove(hud);
	}

	public bool isHiddenAllHUD()
	{
		return _hideRC > 0;
	}

	public void HideAllHUD()
	{
		if (!SceneSingleton<PerformManager>.Instance.InPerform)
		{
			_hideRC++;
			_ = _hideRC;
			_ = 1;
			MonoSingleton<LuaManager>.Instance.FireEvent("AllHudShow", a1: false);
			SceneSingleton<AdventureIndicatorController>.Instance?.ShowHighlightBlob(show: false);
		}
	}

	public void ShowAllHUD()
	{
		if (!SceneSingleton<PerformManager>.Instance.InPerform)
		{
			_hideRC--;
			_ = _hideRC;
			MonoSingleton<LuaManager>.Instance.FireEvent("AllHudShow", a1: true);
			SceneSingleton<AdventureIndicatorController>.Instance?.ShowHighlightBlob(show: true);
			if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.Prologue)
			{
				SceneSingleton<AdventureIndicatorController>.Instance?.ShowHighlightBlob(show: false);
			}
			if (_hideRC < 0)
			{
				_logger.LogWarning("HideAllHUD与ShowAllHUD使用不匹配，请成对使用");
			}
		}
	}
}

namespace P08Main.Loading;

public class HorusT0GameLoading : BaseT0Gameloading
{
	private const string HorusUIPath = "Widget/System/Main_T0SceneGame/104402/104402_SceneLoading";

	public static HorusT0GameLoading Instance;

	public override string GetUIPath()
	{
		return "Widget/System/Main_T0SceneGame/104402/104402_SceneLoading";
	}

	public override LoadingImpl GetEnum()
	{
		return LoadingImpl.HorusT0_Loading;
	}

	public override void InitLoading(object param = null)
	{
		base.InitLoading(param);
		Instance = this;
	}
}

namespace P08Main.Loading;

public class SkuldT0GameLoading : BaseT0Gameloading
{
	private const string SkdIPath = "Widget/System/Main_T0SceneGame/108502/108502_SceneLoading";

	public static SkuldT0GameLoading Instance;

	public override string GetUIPath()
	{
		return "Widget/System/Main_T0SceneGame/108502/108502_SceneLoading";
	}

	public override LoadingImpl GetEnum()
	{
		return LoadingImpl.SkuldT0_Loading;
	}

	public override void InitLoading(object param = null)
	{
		base.InitLoading(param);
		Instance = this;
	}
}

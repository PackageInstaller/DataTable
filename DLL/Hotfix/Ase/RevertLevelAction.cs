using ParadoxNotion.Design;

namespace Ase;

[Name("重置关卡", 0)]
[Description("执行重置关卡的行为。")]
[Category("✫ DragonLost/Interactive")]
public class RevertLevelAction : ActionTaskBase
{
	[Name("是否复活烬天使", 0)]
	[Description("指示是否复活烬天使。")]
	public bool rebornHero;

	protected override async void OnExecute()
	{
		base.OnExecute();
		WhiteScreenWindow obj = await GameEntry.UI.OpenWindow<WhiteScreenWindow>("Loading/WhiteScreenWindow", "TIMELINE");
		GetOwnerEntity().GetSystem<SceneSystem>().RevertLevel(rebornHero, teleport: false, null, blackOpen: false, isResetTeam: true, forceEnterRoom: true);
		obj.Dismiss();
		OnActionFinish();
	}
}

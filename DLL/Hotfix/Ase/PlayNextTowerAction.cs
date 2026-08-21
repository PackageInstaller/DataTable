using ParadoxNotion.Design;

namespace Ase;

[Name("进入下一层爬塔", 0)]
[Description("进入下一层爬塔。")]
[Category("✫ DragonLost/Interactive")]
public class PlayNextTowerAction : ActionTaskBase
{
	protected override async void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity()?.GetSystem<ClimbTowerSystem>()?.EnterNextFloor();
		OnActionFinish();
	}
}

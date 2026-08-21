using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("打开篝火菜单", 0)]
[Description("打开篝火菜单的行为。")]
[Category("✫ DragonLost/Interactive")]
public class OpenBonfireMenuAction : ActionTaskBase
{
	public BBParameter<string> isReset;

	protected override async void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetSystem<BattleSystem>().OpenBonfireMenu(CloseMenu);
	}

	private void CloseMenu(bool reset)
	{
		isReset.value = reset.ToString().ToLower();
		OnActionFinish();
	}
}

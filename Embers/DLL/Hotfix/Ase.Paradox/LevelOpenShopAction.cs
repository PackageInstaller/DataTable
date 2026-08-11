using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("打开商店", 0)]
[Category("✫ DragonLost/Interactive")]
[Description("在关卡中打开商店。")]
public class LevelOpenShopAction : ActionTaskBase
{
	public BBParameter<int> TableIndex;

	public BBParameter<int> SubTabIndex;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().OpenShopWindow(TableIndex.value, SubTabIndex.value);
		OnActionFinish();
	}
}

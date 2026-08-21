using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取小队复活次数", 0)]
[Description("获取当前小队的复活次数。")]
[Category("✫ DragonLost/Target")]
public class GetTeamRebornCount : ActionTaskBase
{
	[Name("小队复活次数", 0)]
	[Description("存储获取到的小队复活次数。")]
	public BBParameter<int> TeamRebornCount;

	protected override void OnExecute()
	{
		base.OnExecute();
		TeamRebornCount.value = ownerEntity.GetSystem<BattleSystem>().TeamRebornNumber;
		EndAction();
	}
}

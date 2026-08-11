using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取小队人数", 0)]
[Description("获取小队中的人数，可以选择是否包含AI角色。")]
[Category("✫ DragonLost/Target")]
public class GetTeamNumberAction : ActionTaskBase
{
	[Name("是否包含AI", 0)]
	[Description("指定是否计算AI角色在内。")]
	public bool IsIncludeAi;

	[Name("数量", 0)]
	[Description("存储获取到的小队人数。")]
	public BBParameter<int> Number;

	protected override void OnExecute()
	{
		base.OnExecute();
		Number.value = ownerEntity.GetSystem<EntitySystem>().GetTeamHeroNumber(IsIncludeAi);
		EndAction();
	}
}

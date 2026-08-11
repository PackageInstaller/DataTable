using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("重置怪物的韧性条", 0)]
[Category("✫ DragonLost/Monster")]
[Description("重置怪物的韧性条.")]
public class ResetMonsterTenacity : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<TenacityComponent>()?.ResetMonsterTenacity();
		EndAction();
	}
}

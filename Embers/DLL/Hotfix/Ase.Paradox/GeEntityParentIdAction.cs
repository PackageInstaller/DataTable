using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取创建者Id", 0)]
[Description("获取当前实体的创建者（父实体）的 Id，并指示当前实体是否有创建者。")]
[Category("✫ DragonLost/Entity")]
public class GeEntityParentIdAction : ActionTaskBase
{
	[Name("返回的父实体Id", 0)]
	[Description("获取的创建者（父实体）的 Id。如果当前实体没有父实体，则返回值为 0。")]
	public BBParameter<int> returnParentEntityId = new BBParameter<int>();

	[Name("是否有父实体", 0)]
	[Description("指示当前实体是否有创建者（父实体）。")]
	public BBParameter<bool> hasParent = new BBParameter<bool>();

	protected override void OnExecute()
	{
		base.OnExecute();
		if (GetOwnerEntity().Parent != null)
		{
			returnParentEntityId.value = GetOwnerEntity().Parent.Id;
			hasParent.value = true;
		}
		else
		{
			hasParent.value = false;
			returnParentEntityId.value = 0;
		}
		OnActionFinish();
	}
}

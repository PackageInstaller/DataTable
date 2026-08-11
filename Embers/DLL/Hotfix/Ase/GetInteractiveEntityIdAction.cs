using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("获取交互中的实体Id", 0)]
[Description("获取当前交互中的实体ID。")]
[Category("✫ DragonLost/Interactive")]
public class GetInteractiveEntityIdAction : ActionTaskBase
{
	[Name("交互中实体Id", 0)]
	[Description("存储当前交互中的实体ID的参数。")]
	public BBParameter<int> interactiveEntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		interactiveEntityId.value = GetOwnerEntity().GetComponent<HeroInteractiveComponent>().GetInteractiveEntityId();
		OnActionFinish();
	}
}

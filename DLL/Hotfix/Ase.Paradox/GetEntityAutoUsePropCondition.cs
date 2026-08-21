using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体是否开启自动释放道具", 0)]
[Category("✫ DragonLost/Entity")]
[Description("获取实体是否开启自动释放道具")]
public class GetEntityAutoUsePropCondition : ConditionTaskBase
{
	[Name("目标实体ID", 0)]
	[Description("目标实体ID")]
	public BBParameter<int> targetEntityId;

	protected override bool OnCheck()
	{
		base.OnCheck();
		bool result = false;
		EntitySystem system = GetOwnerEntity().GetSystem<EntitySystem>();
		if (system != null)
		{
			BaseEntity entity = system.GetEntity(targetEntityId.value);
			if (entity != null)
			{
				AutoFightCompment component = entity.GetComponent<AutoFightCompment>();
				if (component != null)
				{
					result = component.AutoUseProp;
				}
			}
		}
		return result;
	}
}

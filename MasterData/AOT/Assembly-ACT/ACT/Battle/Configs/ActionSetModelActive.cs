using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置模型激活", "Action", new string[] { "set", "model", "active", "state", "status", "tag" })]
public class ActionSetModelActive : ConfigAction
{
	public bool value;

	public override void Do(ActionMemory memory)
	{
		memory.target.entity.GetModelTrans()?.gameObject.SetActive(value);
	}
}

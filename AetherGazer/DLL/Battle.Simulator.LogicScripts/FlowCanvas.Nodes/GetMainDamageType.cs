using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取主属性(元素属性)", 0)]
[Category("Logic/Config")]
[Description("获取主属性，即角色的元素属性")]
public class GetMainDamageType : FlowNode
{
	private SkillDamageType _type = SkillDamageType.All;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "RoleID");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("主属性", "MainDamageType", () => _type);
		FlowOutput successFlowOutput = AddFlowOutput("找到");
		FlowOutput failedFlowOutput = AddFlowOutput("未找到");
		AddFlowInput("IN", delegate(Flow f)
		{
			if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleIDInput.value, out var config))
			{
				SkillDamageType skillDamageType = config.MainDamageType;
				if (skillDamageType == SkillDamageType.Random)
				{
					AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value), 2222, out var baseValue, out var _, out var _);
					skillDamageType = (SkillDamageType)baseValue;
				}
				_type = skillDamageType;
				successFlowOutput.Call(f);
			}
			else
			{
				failedFlowOutput.Call(f);
			}
		});
	}

	public static bool TryGetBySimEntity(SimEntity simEntity, out SkillDamageType skillDamageType)
	{
		if (TryGetByRoleID(simEntity.entityConfig.mId, out skillDamageType))
		{
			if (skillDamageType == SkillDamageType.Random)
			{
				AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(simEntity.creationIndex), 2222, out var baseValue, out var _, out var _);
				skillDamageType = (SkillDamageType)baseValue;
			}
			return true;
		}
		return false;
	}

	public static bool TryGetByRoleID(int roleID, out SkillDamageType skillDamageType)
	{
		skillDamageType = SkillDamageType.All;
		if (ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleID, out var config))
		{
			skillDamageType = config.MainDamageType;
			return true;
		}
		return false;
	}
}

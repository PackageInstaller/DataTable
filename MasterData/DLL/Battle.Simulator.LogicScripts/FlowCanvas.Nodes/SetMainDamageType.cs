using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置主属性(元素属性)", 0)]
[Category("Logic/Config")]
[Description("只有本身角色属性配置为随机属性的角色才有")]
public class SetMainDamageType : FlowNode
{
	private SkillDamageType _type = SkillDamageType.All;

	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "RoleID");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<SkillDamageType> mainDamageTypeInput = AddValueInput<SkillDamageType>("主属性", "mainDamageType");
		AddValueOutput("主属性", "MainDamageType", () => _type);
		AddFlowOutput("Out", "output");
		FlowOutput failedFlowOutput = AddFlowOutput("无效", "failed");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("IN", delegate(Flow f)
		{
			RoleConfig config;
			if (base.mSimContext.GetEntityWithEntityID(entityIDInput.value) == null)
			{
				errorOut.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<RoleConfig>(roleIDInput.value, out config))
			{
				failedFlowOutput.Call(f);
			}
			else
			{
				int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(entityIDInput.value);
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, 2222, out var baseValue, out var _, out var _);
				baseValue = (long)mainDamageTypeInput.value;
				AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, 2222, baseValue, 0L, 0L);
				_type = (SkillDamageType)baseValue;
			}
		});
	}
}

using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI出场判断", 0)]
[Category("Logic/AI")]
[Description("AI出场判断")]
public class AIAppear : FlowNode
{
	private FlowOutput m_appearPlayingOut;

	protected override void RegisterPorts()
	{
		ValueInput<int> hasAppearVarNameInput = AddValueInput<int>("是否播放出场动作变量名");
		ValueInput<int> appearedVarNameInput = AddValueInput<int>("播放过出场动作变量名");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		FlowOutput donotPlayOut = AddFlowOutput("不播出场动作");
		FlowOutput notAppearOut = AddFlowOutput("没有播出场");
		m_appearPlayingOut = AddFlowOutput("播放出场中", "appearPlaying");
		FlowOutput appearedOut = AddFlowOutput("播过出场了");
		AddFlowInput("", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = hasAppearVarNameInput.value;
			int value3 = appearedVarNameInput.value;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(value);
			AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, value2, out var baseValue, out var plusValue, out var tempPlusValue);
			if (baseValue == 0L)
			{
				f.Call(donotPlayOut);
			}
			else
			{
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, value3, out var baseValue2, out plusValue, out tempPlusValue);
				switch (baseValue2)
				{
				case 0L:
				{
					SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(value);
					RoleConfig config2 = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID2.ENTITY_CONFIG_ID);
					AIProcessor.AIStartAttack(value, entityWithEntityID2.entityPositon.mPosition, config2.Appear);
					AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, value3, -1L, 0L, 0L);
					f.Call(notAppearOut);
					break;
				}
				case -1L:
				{
					SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(value);
					RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
					if (entityWithEntityID.hasEntityActionAbility && entityWithEntityID.entityActionAbility.mAbilityID == config.Appear)
					{
						m_appearPlayingOut.Call(f);
					}
					else
					{
						AttributeProcessor.SetAttributeWithIntName(attributeIDByEntityID, value3, 1L, 0L, 0L);
					}
					break;
				}
				default:
					f.Call(appearedOut);
					break;
				}
			}
		});
	}
}

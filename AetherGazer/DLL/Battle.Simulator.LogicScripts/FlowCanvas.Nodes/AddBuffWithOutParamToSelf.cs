using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加Buff(数值版)(自我)", 0)]
[Category("Logic/Buff")]
[Description("向实体添加buff表内预定义的数值buff。\n若已存在相同ConfigId的buff，会先将原有buff移除，再添加新的buff")]
public class AddBuffWithOutParamToSelf : FlowNode
{
	private bool hasOverWriteLogic = true;

	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => targetIDInput.value);
		ValueInput<int> buffIDInput = AddValueInput<int>("配置ID", "buffID");
		AddValueOutput("配置ID", "buffID", () => buffIDInput.value);
		ValueInput<int> levelInput = AddValueInput<int>("等级").SetDefaultAndSerializedValue(1);
		ValueInput<SimVar> param1Input = AddValueInput<SimVar>("参数1", "buff参数1");
		ValueInput<SimVar> param2Input = AddValueInput<SimVar>("参数2", "buff参数2");
		ValueInput<SimVar> param3Input = AddValueInput<SimVar>("参数3", "buff参数3");
		ValueInput<SimVar> param4Input = AddValueInput<SimVar>("参数4", "buff参数4");
		FlowOutput output = AddFlowOutput("");
		FlowOutput outputFalse = AddFlowOutput("没有添加");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			if (hasOverWriteLogic)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
				if (entityWithEntityID == null)
				{
					return;
				}
				if (!entityWithEntityID.hasEntityBuff)
				{
					flag = true;
				}
				else
				{
					int buffClassId = ConfigHelper.GetInstance().GetConfig<public_buff>(buffIDInput.GetValue()).BuffClassId;
					switch (BuffRelationShip.GetRelationShip(entityWithEntityID, buffClassId))
					{
					case BuffRelationShipType.None:
						flag = true;
						break;
					case BuffRelationShipType.OverWrite:
						flag = true;
						BuffRelationShip.RemoveOverWriteList(entityWithEntityID, buffClassId, -1);
						break;
					case BuffRelationShipType.RemoveTogether:
						flag = false;
						BuffRelationShip.RemoveTogetherList(entityWithEntityID, buffClassId, -1);
						break;
					case BuffRelationShipType.RemoveSelf:
						flag = false;
						break;
					}
				}
			}
			if (flag)
			{
				if (AddBuff.AddBuffWithConfigID(base.mSimContext, targetIDInput.GetValue(), targetIDInput.GetValue(), buffIDInput.GetValue(), levelInput.GetValue(), param1Input.GetValue(), param2Input.GetValue(), param3Input.GetValue(), param4Input.GetValue()))
				{
					output.Call(f);
				}
				else
				{
					outputFalse.Call(f);
				}
			}
			else
			{
				outputFalse.Call(f);
			}
		});
	}
}

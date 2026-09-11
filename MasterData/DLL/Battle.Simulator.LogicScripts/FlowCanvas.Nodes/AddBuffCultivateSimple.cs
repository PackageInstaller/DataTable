using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("叠加Buff(数值版)", 0)]
[Category("Logic/Buff")]
[Description("针对可叠加通用buff。添加buff时，若已存在相同ConfigId的buff，则会尝试将原有buff等级+levelUp(支持负数)并刷新该buff。Buff等级不会低于1级。\n若原有buff等级已经是输入所指定的最大等级，则不会再叠加buff等级。\n\n最大叠加层数：指定该buff能添加的最大等级是多少，会无视public_buff表中规定的最大层数\nOut：本次添加buff成功时\n没有添加：本次buff添加失败时")]
public class AddBuffCultivateSimple : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID", "作用对象");
		AddValueOutput("目标实体ID", "作用对象", () => targetIDInput.value);
		ValueInput<int> casterIDInput = AddValueInput<int>("释放者实体ID", "添加者");
		AddValueOutput("释放者实体ID", "添加者", () => casterIDInput.value);
		ValueInput<int> vInConfigId = AddValueInput<int>("配置ID", "buffID");
		AddValueOutput("配置ID", "buffID", () => vInConfigId.value);
		ValueInput<int> levelUpInput = AddValueInput<int>("本次叠加层数", "叠加层数").SetDefaultAndSerializedValue(1);
		ValueInput<int> vInMaxLevel = AddValueInput<int>("最大叠加层数").SetDefaultAndSerializedValue(1);
		ValueInput<SimVar> param1Input = AddValueInput<SimVar>("参数1", "buff参数1");
		ValueInput<SimVar> param2Input = AddValueInput<SimVar>("参数2", "buff参数2");
		ValueInput<SimVar> param3Input = AddValueInput<SimVar>("参数3", "buff参数3");
		ValueInput<SimVar> param4Input = AddValueInput<SimVar>("参数4", "buff参数4");
		FlowOutput fOut = AddFlowOutput("Out");
		FlowOutput fPass = AddFlowOutput("没有添加");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			int num = -1;
			int num2 = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID == null)
			{
				f.Call(fPass);
			}
			else if (!entityWithEntityID.hasEntityBuff || BuffRelationShip.ProcessRelationShipByConfigID(entityWithEntityID, vInConfigId.value))
			{
				if (entityWithEntityID.hasEntityBuff)
				{
					num = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(vInConfigId.value);
					if (num >= 0)
					{
						num2 = entityWithEntityID.entityBuff.mBuffFloor[num];
					}
				}
				num2 = IntMath.Clamp(num2 + levelUpInput.value, 1, vInMaxLevel.value);
				if (AddBuff.AddBuffWithConfigID(base.mSimContext, casterIDInput.GetValue(), targetIDInput.GetValue(), vInConfigId.GetValue(), num2, param1Input.GetValue(), param2Input.GetValue(), param3Input.GetValue(), param4Input.GetValue()))
				{
					fOut.Call(f);
				}
				else
				{
					fPass.Call(f);
				}
			}
			else
			{
				fPass.Call(f);
			}
		});
	}
}

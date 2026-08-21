using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("叠加Buff(数值版)(详细)", 0)]
[Category("Logic/Buff")]
[Description("针对可叠加通用buff。添加buff时，若已存在相同ConfigId的buff，则会尝试将原有buff等级+levelUp(支持负数)并刷新该buff。若原有buff等级已经是输入所指定的最大等级，则不会再叠加buff等级。根据【达到上限时不再刷新】决定达到上限后是否刷新buff\n\n最大叠加层数：指定该buff能添加的最大等级是多少，会无视public_buff表中规定的最大层数\n达到上限时不再刷新：指定该buff等级达到上限后，再次添加buff会不会刷新该buff。若为true，则不会刷新。\n\nOut：本次添加buff成功，且添加后的buff层数不等于最大层数，且添加前存在本buff时\n首次添加：本次添加buff成功，且添加前不存在本buff时\n达到最大层数：本次buff添加成功，且添加后的buff层数等于最大层数时\n达到上限未添加：当【达到上限时不再刷新】为true，且本次添加前，该buff已达到最大层数时（本次不会刷新）\n没有添加：不符合【达到上限未添加】，且该buff没有添加时（被关系表抵挡或添加失败时）\n层数不高于0时移除Buff：为True时，若本来无Buff且本次叠加层数<=0，则直接走【没有添加】；为False时，Buff等级不会低于1级\n若本来有Buff且Buff原等级+本次叠加层数<=0，则直接移除该Buff并走【Out】Error：实体不存在时")]
public class AddBuffCultivate : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("目标实体ID", "作用对象");
		AddValueOutput("目标实体ID", "作用对象", () => targetIDInput.value);
		ValueInput<int> casterIDInput = AddValueInput<int>("释放者实体ID", "添加者");
		AddValueOutput("释放者实体ID", "添加者", () => casterIDInput.value);
		ValueInput<int> vInConfigId = AddValueInput<int>("配置ID", "buffID");
		AddValueOutput("配置ID", "buffID", () => vInConfigId.value);
		int level = 0;
		AddValueOutput("buff等级", () => level);
		ValueInput<int> levelUpInput = AddValueInput<int>("本次叠加层数", "叠加层数").SetDefaultAndSerializedValue(1);
		ValueInput<int> vInMaxLevel = AddValueInput<int>("最大叠加层数").SetDefaultAndSerializedValue(1);
		ValueInput<bool> vInRefreshWhenExceed = AddValueInput<bool>("达到上限时不再刷新").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> removeIflevelUpInputLessZero = AddValueInput<bool>("层数不高于0时移除Buff").SetDefaultAndSerializedValue(v: false);
		ValueInput<SimVar> param1Input = AddValueInput<SimVar>("参数1", "buff参数1");
		ValueInput<SimVar> param2Input = AddValueInput<SimVar>("参数2", "buff参数2");
		ValueInput<SimVar> param3Input = AddValueInput<SimVar>("参数3", "buff参数3");
		ValueInput<SimVar> param4Input = AddValueInput<SimVar>("参数4", "buff参数4");
		FlowOutput fOut = AddFlowOutput("Out");
		FlowOutput fFirst = AddFlowOutput("首次添加");
		FlowOutput fExceed = AddFlowOutput("达到最大层数");
		FlowOutput fExceedNoRefresh = AddFlowOutput("达到上限未添加");
		FlowOutput fPass = AddFlowOutput("没有添加");
		FlowOutput fError = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			int num = -1;
			level = 0;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
			if (entityWithEntityID == null)
			{
				f.Call(fError);
			}
			else if (!entityWithEntityID.hasEntityBuff || BuffRelationShip.ProcessRelationShipByConfigID(entityWithEntityID, vInConfigId.value))
			{
				int value = levelUpInput.value;
				if (entityWithEntityID.hasEntityBuff)
				{
					num = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(vInConfigId.value);
					if (num >= 0)
					{
						level = entityWithEntityID.entityBuff.mBuffFloor[num];
						if (level >= vInMaxLevel.value && vInRefreshWhenExceed.value)
						{
							level = vInMaxLevel.value;
							fExceedNoRefresh.Call(f);
							return;
						}
					}
				}
				if (removeIflevelUpInputLessZero.value)
				{
					if (num == -1 && value <= 0)
					{
						level = 0;
						fPass.Call(f);
						return;
					}
					if (level + value <= 0)
					{
						BuffProcessor.RemoveBuffByListIndex(entityWithEntityID, num);
						level = 0;
						fOut.Call(f);
						return;
					}
				}
				level = IntMath.Clamp(level + value, 1, vInMaxLevel.value);
				if (AddBuff.AddBuffWithConfigID(base.mSimContext, casterIDInput.GetValue(), targetIDInput.GetValue(), vInConfigId.GetValue(), level, param1Input.GetValue(), param2Input.GetValue(), param3Input.GetValue(), param4Input.GetValue()))
				{
					fOut.Call(f);
					if (num == -1)
					{
						fFirst.Call(f);
					}
					if (level >= vInMaxLevel.value)
					{
						fExceed.Call(f);
					}
				}
				else
				{
					level = 0;
					fPass.Call(f);
				}
			}
			else
			{
				level = 0;
				fPass.Call(f);
			}
		});
	}
}

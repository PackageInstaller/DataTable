using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("增加或刷新Buff(数值版)", 0)]
[Category("Logic/Buff")]
[Description("若目标身上已存在释放者ID、配置ID、等级、参数1到4都完全相同的数值Buff，则会读取该Buff的配置持续时间并据此修改Buff的剩余时间，否则等同于对目标使用了一个【增加Buff(数值版)】的节点")]
public class AddOrUpdateBuffWithOutParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> targetIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> casterIDInput = AddValueInput<int>("释放者ID");
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("Buff配置ID");
		ValueInput<int> levelInput = AddValueInput<int>("等级").SetDefaultAndSerializedValue(1);
		ValueInput<Int3> v1 = AddValueInput<Int3>("参数1");
		ValueInput<Int3> v2 = AddValueInput<Int3>("参数2");
		ValueInput<Int3> v3 = AddValueInput<Int3>("参数3");
		ValueInput<Int3> v4 = AddValueInput<Int3>("参数4");
		AddValueOutput("目标实体ID", "目标实体ID", () => targetIDInput.value);
		AddValueOutput("释放者实体ID", "释放者实体ID", () => casterIDInput.value);
		AddValueOutput("配置ID", "buff配置ID", () => buffConfigIDInput.value);
		bool hasUpdateBuffKeepTime = false;
		AddValueOutput("是否是刷新了已有Buff的时间", () => hasUpdateBuffKeepTime);
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput outputFalse = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			bool flag = true;
			bool flag2 = false;
			int index = 0;
			hasUpdateBuffKeepTime = false;
			SimEntity simEntity = null;
			if (targetIDInput != null)
			{
				simEntity = base.mSimContext.GetEntityWithEntityID(targetIDInput.value);
				if (simEntity == null)
				{
					outputFalse.Call(f);
				}
				else
				{
					if (simEntity.hasEntityBuff)
					{
						for (int i = 0; i < simEntity.entityBuff.mBuffKeepTimeArray.Count; i++)
						{
							if (casterIDInput.value == simEntity.entityBuff.mBuffCasterArray[i] && buffConfigIDInput.value == simEntity.entityBuff.mBuffConfigID[i] && levelInput.value == simEntity.entityBuff.mBuffFloor[i] && v1.value == simEntity.entityBuff.mBuffParamsArray[i].v1 && v2.value == simEntity.entityBuff.mBuffParamsArray[i].v2 && v3.value == simEntity.entityBuff.mBuffParamsArray[i].v3 && v4.value == simEntity.entityBuff.mBuffParamsArray[i].v4)
							{
								flag2 = true;
								index = i;
								break;
							}
							flag2 = false;
						}
					}
					if (flag2)
					{
						public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(buffConfigIDInput.value);
						simEntity.entityBuff.mDuringArray[index] = config.KeepTime;
						hasUpdateBuffKeepTime = true;
						output.Call(f);
					}
					else
					{
						if (simEntity.hasEntityBuff)
						{
							int buffClassId = ConfigHelper.GetInstance().GetConfig<public_buff>(buffConfigIDInput.GetValue()).BuffClassId;
							switch (BuffRelationShip.GetRelationShip(simEntity, buffClassId))
							{
							case BuffRelationShipType.None:
								flag = true;
								break;
							case BuffRelationShipType.OverWrite:
								flag = true;
								BuffRelationShip.RemoveOverWriteList(simEntity, buffClassId, -1);
								break;
							case BuffRelationShipType.RemoveTogether:
								flag = false;
								BuffRelationShip.RemoveTogetherList(simEntity, buffClassId, -1);
								break;
							case BuffRelationShipType.RemoveSelf:
								flag = false;
								break;
							}
						}
						if (flag)
						{
							if (AddBuff.AddBuffWithConfigID(base.mSimContext, casterIDInput.GetValue(), targetIDInput.GetValue(), buffConfigIDInput.GetValue(), levelInput.GetValue(), v1.value, v2.value, v3.value, v4.value))
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
					}
				}
			}
			else
			{
				outputFalse.Call(f);
			}
		});
	}
}

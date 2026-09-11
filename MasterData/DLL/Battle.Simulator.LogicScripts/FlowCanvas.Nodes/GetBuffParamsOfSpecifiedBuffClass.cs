using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指定类型Buff数据(枚举)", 0)]
[Category("Logic/Buff/通用")]
[Description("得到EntityID对应的实体身上指定类型对应的第一个buff的数据")]
public class GetBuffParamsOfSpecifiedBuffClass : FlowControlNode
{
	private int mOwnerID;

	private int mCasterID;

	private int mBuffClass;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput nulloutput = AddFlowOutput("无BUFF");
		FlowOutput abnormalOut = AddFlowOutput("无效EntityID");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		ValueInput<BuffClass> buffClassVar = AddValueInput<BuffClass>("BUFF类型ID");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDVar.GetValue());
			if (entityWithEntityID == null)
			{
				abnormalOut.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				nulloutput.Call(f);
			}
			else
			{
				int value = (int)buffClassVar.value;
				for (int i = 0; i < entityWithEntityID.entityBuff.mBuffClassIDArray.Count; i++)
				{
					if (entityWithEntityID.entityBuff.mBuffClassIDArray[i] == value)
					{
						mOwnerID = entityWithEntityID.creationIndex;
						mCasterID = entityWithEntityID.entityBuff.mBuffCasterArray[i];
						mBuffClass = entityWithEntityID.entityBuff.mBuffClassIDArray[i];
						BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[i];
						mBuffParam1 = buffParams.v1;
						mBuffParam2 = buffParams.v2;
						mBuffParam3 = buffParams.v3;
						mBuffParam4 = buffParams.v4;
						output.Call(f);
						return;
					}
				}
				nulloutput.Call(f);
			}
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
		AddValueOutput("添加者ID", () => mCasterID);
		AddValueOutput("作用对象ID", () => mOwnerID);
		AddValueOutput("buff类型", () => mBuffClass);
		AddValueOutput("Buff参数1", () => mBuffParam1);
		AddValueOutput("Buff参数2", () => mBuffParam2);
		AddValueOutput("Buff参数3", () => mBuffParam3);
		AddValueOutput("Buff参数4", () => mBuffParam4);
	}
}

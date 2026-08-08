using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff信息(配置ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("获取buff信息(ID), 找到他身上第一个这个ID的buff信息")]
public class GetBuffInfoByConfigID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID", "BuffID");
		int floor = 0;
		int index = 0;
		int maxFloor = 0;
		int duringTime = 0;
		int leftTime = 0;
		string subType = "";
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		AddValueOutput("数组下标", "索引", () => index);
		AddValueOutput("Buff层数", "层数", () => floor);
		AddValueOutput("剩余时长", "剩余时间", () => leftTime);
		AddValueOutput("配置ID", "buffConfigID", () => configIDInput.GetValue());
		AddValueOutput("最大层数", "最大等级", () => maxFloor);
		AddValueOutput("持续总长", "buff持续时间", () => duringTime);
		AddValueOutput("子类型", "BUFF子类型", () => subType);
		FlowOutput output = AddFlowOutput("");
		FlowOutput falseOutput = AddFlowOutput("没有信息", "false");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			int value = configIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				errorOutput.Call(f);
			}
			else if (!entityWithEntityID.hasEntityBuff)
			{
				falseOutput.Call(f);
			}
			else
			{
				index = entityWithEntityID.entityBuff.GetBuffConfigIDIndex(value);
				if (index == -1)
				{
					falseOutput.Call(f);
				}
				else
				{
					floor = entityWithEntityID.entityBuff.mBuffFloor[index];
					value = entityWithEntityID.entityBuff.mBuffConfigID[index];
					public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(value);
					maxFloor = config.MaxLevel;
					leftTime = entityWithEntityID.entityBuff.mDuringArray[index];
					duringTime = config.KeepTime;
					subType = config.SubType;
					output.Call(f);
				}
			}
		});
	}
}

using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到Buff信息(数组下标)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("得到Buff的一部分运行信息、一部分配置信息;")]
public class GetBuffInfoByIndex : FlowNode
{
	private int m_tickTime;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "实体ID");
		ValueInput<int> indexInput = AddValueInput<int>("数组下标", "索引");
		int floor = 0;
		int configID = 0;
		int maxFloor = 0;
		int duringTime = 0;
		int leftTime = 0;
		string subType = "";
		m_tickTime = 0;
		AddValueOutput("实体ID", "实体ID", () => entityIDInput.value);
		AddValueOutput("数组下标", "buffListIndex", () => indexInput.GetValue());
		AddValueOutput("Buff层数", "层数", () => floor);
		AddValueOutput("剩余时长", "剩余时间", () => leftTime);
		AddValueOutput("配置ID", "BuffID", () => configID);
		AddValueOutput("最大层数", "最大等级", () => maxFloor);
		AddValueOutput("持续总长", "buff持续时间", () => duringTime);
		AddValueOutput("触发间隔时长(毫秒)", "buffTick", () => m_tickTime);
		AddValueOutput("子类型", "BUFF子类型", () => subType);
		FlowOutput output = AddFlowOutput("");
		FlowOutput falseOutput = AddFlowOutput("无Buff", "false");
		FlowOutput errorOutput = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			int value = indexInput.value;
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
				floor = entityWithEntityID.entityBuff.mBuffFloor[value];
				configID = entityWithEntityID.entityBuff.mBuffConfigID[value];
				public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(configID);
				maxFloor = config.MaxLevel;
				leftTime = entityWithEntityID.entityBuff.mDuringArray[value];
				duringTime = entityWithEntityID.entityBuff.mBuffKeepTimeArray[value];
				subType = config.SubType;
				m_tickTime = entityWithEntityID.entityBuff.mTickArray[value];
				output.Call(f);
			}
		});
	}
}

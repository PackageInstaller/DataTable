using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("怪物警戒事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("怪物警戒事件")]
public class EnemyAlertEventNode : EventNode
{
	private FlowOutput Found;

	private FlowOutput AlertValueMax;

	private FlowOutput LoseTarget;

	private FlowOutput AlertValueEmpty;

	private int enemyEntityID;

	private int playerEntityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.mSimContext.SimEventSystem.AddHandler<EnemyAlertEvent>(OnEnemyAlertEvent);
	}

	private void OnEnemyAlertEvent(EnemyAlertEvent eventReceived)
	{
		Flow flow = new Flow
		{
			returnData = returnData
		};
		enemyEntityID = eventReceived.enemyEntityID;
		playerEntityID = eventReceived.playerEntityID;
		switch (eventReceived.state)
		{
		case EnemyAlertState.Found:
			flow.Call(Found);
			break;
		case EnemyAlertState.AlertValueMax:
			flow.Call(AlertValueMax);
			break;
		case EnemyAlertState.LoseTarget:
			flow.Call(LoseTarget);
			break;
		case EnemyAlertState.AlertValueEmpty:
			flow.Call(AlertValueEmpty);
			break;
		}
	}

	protected override void RegisterPorts()
	{
		AddValueOutput("敌方实体ID", () => enemyEntityID);
		AddValueOutput("玩家实体ID", () => playerEntityID);
		Found = AddFlowOutput("发现目标");
		AlertValueMax = AddFlowOutput("警戒值满");
		LoseTarget = AddFlowOutput("丢失目标");
		AlertValueEmpty = AddFlowOutput("警戒值空");
	}
}

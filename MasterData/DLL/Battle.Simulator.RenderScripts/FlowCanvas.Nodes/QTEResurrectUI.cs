using System;
using NetProcol;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("复活界面(QTE)", 0)]
[Category("Render/UI")]
[Description("QTE复活界面, 目前是直接用节点调用的, \n UI路径以及模式使用设置复活模式触发器进行修改(内嵌复活指令)")]
public class QTEResurrectUI : FlowNode
{
	private GameObject QTEPrefab;

	private GameObject BattlePanelPrefab;

	private int entityID;

	private bool QTEIsActive;

	public override void OnGraphStarted()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		worldStateManager.mQteFinshEvent = (Action<bool>)Delegate.Combine(worldStateManager.mQteFinshEvent, new Action<bool>(GetQTEFinsh));
	}

	public override void OnGraphStoped()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		worldStateManager.mQteFinshEvent = (Action<bool>)Delegate.Remove(worldStateManager.mQteFinshEvent, new Action<bool>(GetQTEFinsh));
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> TimelinePrefabInput = AddValueInput<string>("QTE预制体路径", "PrefabPath");
		ValueInput<string> PrefabRootInput = AddValueInput<string>("战斗面板下挂载路径", "PrefabRootPath");
		ValueInput<int> EntityIDInput = AddValueInput<int>("实体ID", "entityID");
		AddValueOutput("实体ID", "EntityID", () => entityID);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(TimelinePrefabInput.value))
			{
				Debug.LogError("QteResurrectPathIsNull");
				output.Call(f);
			}
			else
			{
				if (BattlePanelPrefab == null)
				{
					if (string.IsNullOrEmpty(PrefabRootInput.GetValue()))
					{
						BattlePanelPrefab = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel");
					}
					else
					{
						BattlePanelPrefab = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel/" + PrefabRootInput.GetValue());
					}
				}
				QTEPrefab = Asset.InstantiateWithoutCache(TimelinePrefabInput.value, BattlePanelPrefab.transform);
				entityID = EntityIDInput.value;
				QTEIsActive = true;
				output.Call(f);
			}
		});
	}

	public void GetQTEFinsh(bool result)
	{
		if (QTEIsActive)
		{
			SendLocalCommand(result);
			QTEIsActive = false;
			PooledAsset.DestroyOrReturn(QTEPrefab);
			QTEPrefab = null;
		}
	}

	public void SendLocalCommand(bool result)
	{
		ResurrectCommand resurrectCommand = CommandFactory.Create(NetprotoOperationCode.CmdResurrect) as ResurrectCommand;
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetPlayerAgent();
		if (playerAgent != null)
		{
			resurrectCommand.SetData(playerAgent.AgentID, entityID, result);
			ClientSimulator.Instance.SendLocalCommand(resurrectCommand);
		}
	}
}

using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("奥义增幅距离规则", 0)]
[Category("Render")]
[Description("奥义增幅距离显示规则")]
public class OnlineUniqueSkillDistanceRule : FlowNode
{
	private Dictionary<int, Image> keyValuePairs = new Dictionary<int, Image>();

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		keyValuePairs.Clear();
	}

	public void Init(string path, string name)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent playerAgent = agentManager.GetPlayerAgent();
		if (playerAgent == null)
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null || battleScene.battlePanelGameObject == null)
		{
			return;
		}
		Transform transform = battleScene.battlePanelGameObject.transform.Find(path);
		if (transform == null)
		{
			return;
		}
		keyValuePairs[playerAgent.AgentID] = transform.GetComponent<Image>();
		NAgent agentByMemberPostion = AgentManager.GetAgentManager().GetAgentByMemberPostion(MemberPosition.First);
		if (agentByMemberPostion != null && agentByMemberPostion != playerAgent)
		{
			RoleTalkPanel roleTalkPanel = (agentByMemberPostion as AgentHuman).RoleTalkPanel;
			if (roleTalkPanel != null)
			{
				Image component = roleTalkPanel.transform.Find(name).GetComponent<Image>();
				keyValuePairs[agentByMemberPostion.AgentID] = component;
			}
		}
		NAgent agentByMemberPostion2 = AgentManager.GetAgentManager().GetAgentByMemberPostion(MemberPosition.Second);
		if (agentByMemberPostion2 != null && agentByMemberPostion2 != playerAgent)
		{
			RoleTalkPanel roleTalkPanel2 = (agentByMemberPostion2 as AgentHuman).RoleTalkPanel;
			if (roleTalkPanel2 != null)
			{
				Image component2 = roleTalkPanel2.transform.Find(name).GetComponent<Image>();
				keyValuePairs[agentByMemberPostion2.AgentID] = component2;
			}
		}
		NAgent agentByMemberPostion3 = AgentManager.GetAgentManager().GetAgentByMemberPostion(MemberPosition.Third);
		if (agentByMemberPostion3 != null && agentByMemberPostion3 != playerAgent)
		{
			RoleTalkPanel roleTalkPanel3 = (agentByMemberPostion3 as AgentHuman).RoleTalkPanel;
			if (roleTalkPanel3 != null)
			{
				Image component3 = roleTalkPanel3.transform.Find(name).GetComponent<Image>();
				keyValuePairs[agentByMemberPostion3.AgentID] = component3;
			}
		}
	}

	public bool UpdateState(NAgent player, NAgent mate, double distance, string path, string name)
	{
		if (mate != null && mate != player && (double)Vector3.SqrMagnitude(mate.Position - player.Position) < distance)
		{
			keyValuePairs.TryGetValue(mate.AgentID, out var value);
			keyValuePairs.TryGetValue(player.AgentID, out var value2);
			if (value == null || value2 == null)
			{
				Init(path, name);
				keyValuePairs.TryGetValue(mate.AgentID, out value);
				keyValuePairs.TryGetValue(player.AgentID, out value2);
				if (value == null || value2 == null)
				{
					return false;
				}
			}
			value.enabled = true;
			value2.enabled = true;
		}
		return true;
	}

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<string> nameInput = AddValueInput<string>("队友图片路径名").SetDefaultAndSerializedValue("Image");
		ValueInput<string> pathInput = AddValueInput<string>("玩家图片路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BattleButtons/QTEButton/DistanceImage");
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		AddFlowInput("update", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				foreach (KeyValuePair<int, Image> keyValuePair in keyValuePairs)
				{
					if (keyValuePair.Value != null)
					{
						keyValuePair.Value.enabled = false;
					}
				}
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					double num = (double)distanceInput.value / 1000.0;
					num *= num;
					string value = pathInput.value;
					string value2 = nameInput.value;
					NAgent agentByMemberPostion = AgentManager.GetAgentManager().GetAgentByMemberPostion(MemberPosition.First);
					UpdateState(playerAgent, agentByMemberPostion, num, value, value2);
					NAgent agentByMemberPostion2 = AgentManager.GetAgentManager().GetAgentByMemberPostion(MemberPosition.Second);
					UpdateState(playerAgent, agentByMemberPostion2, num, value, value2);
					NAgent agentByMemberPostion3 = AgentManager.GetAgentManager().GetAgentByMemberPostion(MemberPosition.Third);
					UpdateState(playerAgent, agentByMemberPostion3, num, value, value2);
					output.Call(f);
				}
			}
		});
	}
}

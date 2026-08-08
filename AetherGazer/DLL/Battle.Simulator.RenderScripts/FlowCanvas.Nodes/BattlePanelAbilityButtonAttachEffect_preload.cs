using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(战斗界面按钮)_preload", 0)]
[Category("Render/特效")]
[Description("创建战斗界面上的按钮特效")]
public class BattlePanelAbilityButtonAttachEffect_preload : EffectCreateBaseNode
{
	private GameObject m_battlePanel;

	private Transform m_button;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		ValueInput<string> battlePanelPathInput = AddValueInput<string>("BattlePanel实例查找路径", "battlePanelPathInput").SetDefaultAndSerializedValue("UICamera/Canvas/UIMain/BattlePanel");
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮(当前仅技能)", "buttonTypeInput").SetDefaultAndSerializedValue(ButtonType.SKILL1);
		ValueInput<float> holdTimeInput = AddValueInput<float>("持续时长(毫秒)", "holdTimeInput").SetDefaultAndSerializedValue(2f);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput falseOut = AddFlowOutput("非本地玩家", "falseOut");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager == null || agentManager.mPlayerAgentID != agentIDInput.GetValue())
			{
				falseOut.Call(f);
			}
			else
			{
				if (m_battlePanel == null)
				{
					m_battlePanel = GameObject.Find(battlePanelPathInput.GetValue());
					if (m_battlePanel == null)
					{
						error.Call(f);
						return;
					}
				}
				if (m_button == null)
				{
					switch (buttonTypeInput.GetValue())
					{
					case ButtonType.SKILL1:
						m_button = m_battlePanel.transform.Find("AbilityButtons/AbilitButton0");
						break;
					case ButtonType.SKILL2:
						m_button = m_battlePanel.transform.Find("AbilityButtons/AbilitButton1");
						break;
					case ButtonType.SKILL3:
						m_button = m_battlePanel.transform.Find("AbilityButtons/AbilitButton2");
						break;
					case ButtonType.QTE:
						m_button = m_battlePanel.transform.Find("AbilityButtons/QTEButton");
						break;
					}
					if (m_button == null)
					{
						error.Call(f);
						return;
					}
				}
				EffectController effectController = CommonEffectClipPlayer.PlayEffect(m_button, _effectPathInput.GetValue(), string.Empty, Vector3.zero, Vector3.one, Vector3.zero, Vector3.forward, isAttach: true, isLoop: false, 1f, 0f, holdTimeInput.GetValue());
				if (effectController != null)
				{
					_effectInstance = effectController.gameObject;
				}
				output.Call(f);
			}
		});
		base.RegisterPorts();
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		m_button = null;
		m_battlePanel = null;
	}
}

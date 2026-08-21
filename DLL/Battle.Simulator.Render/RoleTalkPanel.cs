using System;
using UnityEngine;
using UnityEngine.UI;

public class RoleTalkPanel : MonoBehaviour
{
	public Image Head;

	public Image HpBar;

	public Image HpSlowBar;

	public Image SpBar;

	public Button QTEButton;

	public P08AttackButton AttackButton;

	public GameObject QTEEffect;

	public TalkTextPanel m_talkTextPanel;

	public Material m_GreyMaterial;

	private Material m_OriMaterial;

	public Image m_CDMask;

	public Text m_CDNum;

	private MemberPosition m_Position;

	private BattleScene m_battleScene;

	private BBHumanoid m_blackboard;

	private ComponentHealth m_componentHealth;

	public const string ICON_FOLDER = "TextureConfig/Character/LittleIcon/";

	public void Init(MemberPosition position, int roleID)
	{
		m_Position = position;
		m_talkTextPanel.Init();
		if (roleID != 0)
		{
			Sprite spriteWithoutAtlas = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/Character/LittleIcon/" + roleID);
			if (spriteWithoutAtlas != null)
			{
				Head.sprite = spriteWithoutAtlas;
			}
		}
		InitComponent();
	}

	public void ShowTalk(string content, long milliTime)
	{
		bool flag = false;
		if (!(m_battleScene == null))
		{
			GameMode mGameMode = m_battleScene.mGameMode;
			if ((mGameMode == GameMode.SinglePlayer || mGameMode == GameMode.EditorSinglePlayer || mGameMode == GameMode.Replay) ? true : false)
			{
				m_talkTextPanel.ShowText(content, milliTime);
			}
		}
	}

	private void InitComponent()
	{
		m_battleScene = (BattleScene)NScene.GetCurrentScene();
		if (null == m_battleScene)
		{
			return;
		}
		AgentManager agentManager = m_battleScene.GetAgentManager();
		int agentIDByMemberPosition = agentManager.GetAgentIDByMemberPosition(m_Position);
		NAgent agent = agentManager.GetAgent(agentIDByMemberPosition);
		if (!(null == agent))
		{
			if (m_blackboard != null)
			{
				BBHumanoid blackboard = m_blackboard;
				blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(blackboard.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler));
			}
			m_blackboard = agent.Blackboard as BBHumanoid;
			m_componentHealth = agent.GetComponent<ComponentHealth>();
			BBHumanoid blackboard2 = m_blackboard;
			blackboard2.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard2.ActionHandler, new BBCommom.AgentActionHandler(ActionHandler));
			AgentHuman agentHuman = agent as AgentHuman;
			if (agentHuman != null)
			{
				agentHuman.RoleTalkPanel = this;
			}
		}
	}

	private void Update()
	{
		if (null == m_componentHealth)
		{
			InitComponent();
		}
		else if (m_componentHealth.Health > 0)
		{
			if (m_OriMaterial != null)
			{
				Head.material = m_OriMaterial;
				m_OriMaterial = null;
			}
			if ((bool)QTEButton)
			{
				QTEButton.enabled = true;
			}
			if ((bool)AttackButton)
			{
				AttackButton.enabled = true;
			}
			if (null != m_componentHealth && m_componentHealth.MaxHealth != 0L)
			{
				HpBar.fillAmount = (float)m_componentHealth.Health * 1f / (float)m_componentHealth.MaxHealth;
				HpSlowBar.fillAmount = (float)m_componentHealth.HealthChangeSlowly * 1f / (float)m_componentHealth.MaxHealth;
			}
			if (!(m_blackboard == null))
			{
				_ = m_blackboard.m_NextSimFrameData;
			}
		}
	}

	private void ActionHandler(AgentAction action)
	{
		if (action is AgentActionDead)
		{
			if ((bool)HpBar)
			{
				HpBar.fillAmount = 0f;
			}
			if ((bool)HpSlowBar)
			{
				HpSlowBar.fillAmount = 0f;
			}
			if ((bool)SpBar)
			{
				SpBar.fillAmount = 0f;
			}
			if ((bool)QTEButton)
			{
				QTEButton.enabled = false;
			}
			if ((bool)AttackButton)
			{
				AttackButton.enabled = false;
			}
			if ((bool)QTEEffect)
			{
				QTEEffect.gameObject.SetActive(value: false);
			}
			if (m_GreyMaterial != null)
			{
				m_OriMaterial = Head.material;
				Head.material = m_GreyMaterial;
			}
			if (m_CDMask != null)
			{
				m_CDMask.enabled = false;
			}
			if (m_CDNum != null)
			{
				m_CDNum.enabled = false;
			}
		}
	}
}

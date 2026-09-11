using UnityEngine;

public class BattleTalkPanel : MonoBehaviour
{
	public RoleTalkPanel RolePanel1;

	public RoleTalkPanel RolePanel2;

	public GameObject MasterSkillButton;

	public string TuneIndicatorPath = "UI/BattlePanelEffect/TuneIndicator";

	private TuneIndicatorHelper TuneIndicator;

	private int m_roleID1;

	private int m_agent1ID;

	private int m_roleID2;

	private int m_agent2ID;

	private bool inited;

	private void Init()
	{
		if (!inited)
		{
			RolePanel1.gameObject.SetActive(value: false);
			RolePanel2.gameObject.SetActive(value: false);
			if (TuneIndicator != null)
			{
				TuneIndicator.gameObject.SetActive(value: false);
			}
			inited = true;
		}
	}

	private void Awake()
	{
		inited = false;
		Init();
	}

	public void ShowRoleTalk(int roleID, string content, long milliTime)
	{
		Init();
		if (roleID == m_roleID1)
		{
			RolePanel1.ShowTalk(content, milliTime);
		}
		else if (roleID == m_roleID2)
		{
			RolePanel2.ShowTalk(content, milliTime);
		}
	}

	public void OnPlayerChange(NAgent from, NAgent to)
	{
		if (!(from == null) && !(to == null))
		{
			if (from is AgentHuman agentHuman)
			{
				agentHuman.RoleTalkPanel = null;
			}
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (m_agent1ID == from.AgentID)
			{
				m_roleID1 = to.AgentSkinID;
				m_agent1ID = to.AgentID;
				RolePanel1.Init(agentManager.GetMemberPositionByAgentID(m_agent1ID), m_roleID1);
				RolePanel1.gameObject.SetActive(value: true);
			}
			else if (m_agent2ID == from.AgentID)
			{
				m_roleID2 = to.AgentSkinID;
				m_agent2ID = to.AgentID;
				RolePanel2.Init(agentManager.GetMemberPositionByAgentID(m_agent2ID), m_roleID2);
				RolePanel2.gameObject.SetActive(value: true);
			}
			if (TuneIndicator != null)
			{
				TuneIndicator.OnPlayerChange(from, to);
			}
		}
	}

	public void OnPlayerSpawn(NAgent nAgent, MemberPosition mRolePosition)
	{
		if (!nAgent.IsLocalPlayer && mRolePosition == MemberPosition.First)
		{
			m_roleID1 = nAgent.AgentSkinID;
			m_agent1ID = nAgent.AgentID;
			RolePanel1.Init(MemberPosition.First, m_roleID1);
			RolePanel1.gameObject.SetActive(value: true);
		}
		if (!nAgent.IsLocalPlayer && mRolePosition == MemberPosition.Third)
		{
			m_roleID2 = nAgent.AgentSkinID;
			m_agent2ID = nAgent.AgentID;
			RolePanel2.Init(MemberPosition.Third, m_roleID2);
			RolePanel2.gameObject.SetActive(value: true);
		}
		if (!nAgent.IsLocalPlayer && mRolePosition == MemberPosition.Second)
		{
			if (m_roleID1 != 0 && m_agent1ID != nAgent.AgentID)
			{
				m_roleID2 = nAgent.AgentSkinID;
				m_agent2ID = nAgent.AgentID;
				RolePanel2.Init(MemberPosition.Second, m_roleID2);
				RolePanel2.gameObject.SetActive(value: true);
			}
			else
			{
				m_roleID1 = nAgent.AgentSkinID;
				m_agent1ID = nAgent.AgentID;
				RolePanel1.Init(MemberPosition.Second, m_roleID1);
				RolePanel1.gameObject.SetActive(value: true);
			}
		}
		if (!TuneIndicatorHelper.IsTuneRole(nAgent.AgentConfigID))
		{
			return;
		}
		if (TuneIndicator == null)
		{
			GameObject gameObject = Asset.Instantiate(TuneIndicatorPath);
			if (gameObject == null || MasterSkillButton == null)
			{
				Debug.LogError("无法加载协律指示器,路径下资源不存在 " + TuneIndicatorPath);
				return;
			}
			P08AttackButton component = MasterSkillButton.GetComponent<P08AttackButton>();
			if (component == null || !(component.GetButtonUILogic() is P08MasterSkillButtonUILogic p08MasterSkillButtonUILogic))
			{
				return;
			}
			gameObject.transform.SetParent(MasterSkillButton.transform, worldPositionStays: false);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localScale = Vector3.one;
			TuneIndicator = gameObject.GetComponent<TuneIndicatorHelper>();
			p08MasterSkillButtonUILogic.tuneIndicator = TuneIndicator;
		}
		if (!(TuneIndicator == null))
		{
			if (!TuneIndicator.gameObject.activeSelf)
			{
				TuneIndicator.gameObject.SetActive(value: true);
			}
			TuneIndicator.Init(mRolePosition, nAgent);
		}
	}
}

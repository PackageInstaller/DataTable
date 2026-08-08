using NetProcol;
using UnityEngine;
using UnityEngine.EventSystems;

public class AttackButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	[SerializeField]
	private ButtonType _buttonType;

	[SerializeField]
	private KeyCode _buttonKeyCode;

	private bool _inited;

	[SerializeField]
	private MemberPosition _memberPosition;

	private Camera _mainCamera;

	public bool isFrozen;

	public ButtonType ButtonType => _buttonType;

	public MemberPosition MemberPosition => _memberPosition;

	private void Start()
	{
		_inited = _buttonKeyCode != KeyCode.None;
	}

	public void OnClick()
	{
		if (_memberPosition == MemberPosition.First)
		{
			ChooseTarget();
		}
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		NAgent agent = GetAgent();
		if (agent != null)
		{
			_ = agent.Blackboard;
			startMeleeCommand.SetData(agent.AgentID, (int)_buttonType, isPressing: true);
			ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
		}
	}

	public void OnRelease()
	{
		NAgent agent = GetAgent();
		if (agent != null)
		{
			StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
			_ = agent.Blackboard;
			startMeleeCommand.SetData(agent.AgentID, (int)_buttonType, isPressing: false);
			ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
		}
	}

	public int ChooseTarget()
	{
		WorldStateManager worldSatetManager = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager();
		if (worldSatetManager.hasManualLock)
		{
			return 0;
		}
		if (worldSatetManager.lockType == LockType.lockNearest)
		{
			return 0;
		}
		if (worldSatetManager.lockType == LockType.manualType && worldSatetManager.lockedAgentID != 0)
		{
			worldSatetManager.hasManualLock = true;
		}
		NAgent agent = GetAgent();
		if (agent != null)
		{
			ChooseTargetCommand chooseTargetCommand = CommandFactory.Create(NetprotoOperationCode.CmdChooseTarget) as ChooseTargetCommand;
			int lockedAgentID = worldSatetManager.lockedAgentID;
			if (_mainCamera == null)
			{
				_mainCamera = Camera.main;
			}
			Int obj = IntMath.AngleOfVector((Int3)_mainCamera.transform.forward);
			chooseTargetCommand.SetData(agent.AgentID, lockedAgentID, obj.i);
			ClientSimulator.Instance.SendLocalCommand(chooseTargetCommand);
		}
		return 0;
	}

	private void Update()
	{
		_ = _inited;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (!isFrozen)
		{
			OnClick();
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (!isFrozen)
		{
			OnRelease();
		}
	}

	private NAgent GetAgent()
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		AgentManager agentManager = battleScene.GetAgentManager();
		if (battleScene.mGameMode == GameMode.SinglePlayer || battleScene.mGameMode == GameMode.EditorSinglePlayer)
		{
			NAgent playerAgent = agentManager.GetPlayerAgent();
			if (playerAgent == null || (playerAgent.Blackboard as BBHumanoid).m_NextSimFrameData.HP <= 0)
			{
				return null;
			}
			return agentManager.GetAgentByMemberPostion(_memberPosition);
		}
		NAgent playerAgent2 = agentManager.GetPlayerAgent();
		if (playerAgent2 == null || (playerAgent2.Blackboard as BBHumanoid).m_NextSimFrameData.HP <= 0)
		{
			return null;
		}
		return playerAgent2;
	}
}

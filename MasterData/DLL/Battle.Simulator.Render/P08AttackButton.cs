using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class P08AttackButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IBattleUIElement
{
	public CanvasGroup canvasGroup;

	public MemberPosition memberPosition;

	public ButtonType buttonType;

	private Camera _mainCamera;

	[Tooltip("技能消耗文本")]
	public Text consumeText;

	[Tooltip("技能消耗 托着文本那条线")]
	public Image consumeLine;

	[Tooltip("cd 文本")]
	public Text cdText;

	[Tooltip("cd mask 图")]
	public Image cdImage;

	[Tooltip("体力槽 (闪避按钮外面那个圈)")]
	public Image endurance;

	[Tooltip("图标")]
	public Image abilityIcon;

	[Tooltip("禁用样式")]
	public GameObject disableGo;

	[Tooltip("强化技能的动效")]
	public GameObject effectExtensionalSkill;

	[Tooltip("技能切换的动效")]
	public GameObject effectSwitchAbility;

	[Tooltip("cd结束的动效")]
	public GameObject effectCDRefresh;

	[Tooltip("奥义可以使用时的特效")]
	public GameObject qteEffect;

	[Tooltip("奥义充能的环")]
	public Image uniqueBar;

	[Tooltip("奥义表现初始进度")]
	public float startAmount = 0.25f;

	[Tooltip("管理员助战技能的管理员头像部分")]
	public Image masterIcon;

	private IButtonUILogic p08Button;

	private SubStickController JoyStick;

	private SubStickEffectController JoyStickEffectController;

	public P08UISwitch uiSwitch { get; set; }

	private bool isSkill
	{
		get
		{
			if (buttonType != ButtonType.MELEE && buttonType != ButtonType.LOCK && buttonType != ButtonType.QTE && buttonType != ButtonType.AVOID)
			{
				return buttonType != ButtonType.MASTER_SKILL;
			}
			return false;
		}
	}

	private bool isSkillOrMelee
	{
		get
		{
			if (buttonType != ButtonType.LOCK && buttonType != ButtonType.MASTER_SKILL && buttonType != ButtonType.QTE)
			{
				return buttonType != ButtonType.AVOID;
			}
			return false;
		}
	}

	private bool isQTEOrMasterSkill
	{
		get
		{
			if (buttonType != ButtonType.QTE)
			{
				return buttonType == ButtonType.MASTER_SKILL;
			}
			return true;
		}
	}

	private void Awake()
	{
		SwitchLogicOnAwake();
		UIContentOnAwake();
	}

	public void OnDisable()
	{
		ClickLogicOnPointerUp();
		JoyStickLogicOnPointerUp();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		ClickLogicOnPointerDown();
		JoyStickLogicOnPointerDown();
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		ClickLogicOnPointerUp();
		JoyStickLogicOnPointerUp();
	}

	public void Update()
	{
		UpdateUIContent();
	}

	public void SetActive(bool isActive, BattleUIElementActiveChangeReason reason)
	{
		if (this != null && uiSwitch != null)
		{
			uiSwitch.SetActive(isActive, reason);
		}
	}

	private void SwitchLogicOnAwake()
	{
		if (uiSwitch == null)
		{
			uiSwitch = new P08UISwitch();
			uiSwitch.canvasGroup = canvasGroup;
			uiSwitch.gameObject = base.gameObject;
		}
	}

	private NAgent GetAgent()
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return null;
		}
		NAgent nAgent = null;
		if (memberPosition == MemberPosition.First)
		{
			nAgent = agentManager.GetPlayerAgent();
		}
		else if (memberPosition == MemberPosition.Second)
		{
			nAgent = agentManager.GetAgentByMemberPostion(MemberPosition.First);
			if (nAgent != null && nAgent.IsLocalPlayer)
			{
				nAgent = agentManager.GetAgentByMemberPostion(MemberPosition.Second);
			}
		}
		else if (memberPosition == MemberPosition.Third)
		{
			nAgent = agentManager.GetAgentByMemberPostion(MemberPosition.Third);
			if (nAgent != null && nAgent.IsLocalPlayer)
			{
				nAgent = agentManager.GetAgentByMemberPostion(MemberPosition.Second);
			}
		}
		if (nAgent == null)
		{
			return null;
		}
		BBHumanoid bBHumanoid = nAgent.Blackboard as BBHumanoid;
		if (bBHumanoid == null)
		{
			return null;
		}
		SimFrameData nextSimFrameData = bBHumanoid.m_NextSimFrameData;
		if (nextSimFrameData == null)
		{
			return null;
		}
		if (nextSimFrameData.HP <= 0)
		{
			return null;
		}
		return nAgent;
	}

	private void ChooseTarget()
	{
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager == null || worldStateManager.hasManualLock || worldStateManager.lockType == LockType.lockNearest)
		{
			return;
		}
		if (worldStateManager.lockType == LockType.manualType && worldStateManager.lockedAgentID != 0)
		{
			worldStateManager.hasManualLock = true;
		}
		NAgent agent = GetAgent();
		if (agent == null)
		{
			return;
		}
		ChooseTargetCommand chooseTargetCommand = CommandFactory.Create(NetprotoOperationCode.CmdChooseTarget) as ChooseTargetCommand;
		int num = worldStateManager.lockedAgentID;
		NAgent agent2 = AgentManager.GetAgentManager().GetAgent(num);
		if (agent2 != null)
		{
			foreach (ShapeState mShapeState in (agent2.Blackboard as BBHumanoid).m_NextSimFrameData.mShapeStates)
			{
				if (mShapeState.mPartType == (ShapePartType)worldStateManager.lockedAgentPart)
				{
					num = mShapeState.mShapeEntityID;
				}
			}
		}
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		Int obj = IntMath.AngleOfVector((Int3)_mainCamera.transform.forward);
		chooseTargetCommand.SetData(agent.AgentID, num, obj.i);
		ClientSimulator.Instance.SendLocalCommand(chooseTargetCommand);
	}

	public void ClickLogicOnPointerDown()
	{
		NAgent agent = GetAgent();
		if (agent == null)
		{
			return;
		}
		if (agent.IsLocalPlayer)
		{
			ChooseTarget();
		}
		else
		{
			GameMode mGameMode = (NScene.GetCurrentScene() as BattleScene).mGameMode;
			if (mGameMode == GameMode.EditorMultiPlayer || mGameMode == GameMode.Multiplayer)
			{
				return;
			}
		}
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		startMeleeCommand.SetData(agent.AgentID, (int)buttonType, isPressing: true);
		ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
	}

	public void ClickLogicOnPointerUp()
	{
		NAgent agent = GetAgent();
		if (agent == null)
		{
			return;
		}
		if (!agent.IsLocalPlayer)
		{
			GameMode mGameMode = (NScene.GetCurrentScene() as BattleScene).mGameMode;
			if (mGameMode == GameMode.EditorMultiPlayer || mGameMode == GameMode.Multiplayer)
			{
				return;
			}
		}
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		startMeleeCommand.SetData(agent.AgentID, (int)buttonType, isPressing: false);
		ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
	}

	public void UIContentOnAwake()
	{
		switch (buttonType)
		{
		case ButtonType.MELEE:
			p08Button = new P08MeleeButtonUILogic(abilityIcon, effectSwitchAbility);
			break;
		case ButtonType.QTE:
			p08Button = new P08QTEButtonUILogic(startAmount, abilityIcon, cdText, cdImage, qteEffect, uniqueBar, disableGo, null);
			break;
		case ButtonType.AVOID:
			p08Button = new P08AvoidButtonUILogic(abilityIcon, cdText, cdImage, disableGo, endurance, null);
			break;
		case ButtonType.MASTER_SKILL:
			p08Button = new P08MasterSkillButtonUILogic(abilityIcon, cdText, cdImage, qteEffect, uniqueBar, disableGo, uiSwitch, masterIcon);
			break;
		default:
			p08Button = new P08SkillButtonUILogic(buttonType, abilityIcon, cdText, cdImage, consumeText, consumeLine, effectExtensionalSkill, effectSwitchAbility, effectCDRefresh, disableGo, null);
			break;
		case ButtonType.LOCK:
			break;
		}
	}

	public IButtonUILogic GetButtonUILogic()
	{
		return p08Button;
	}

	public void UpdateUIContent()
	{
		if (p08Button != null)
		{
			p08Button.UpdateUIContent(GetAgent());
		}
	}

	public void SetCD(int current, int max, int chargeCount)
	{
		if (p08Button is P08ButtonUILogic p08ButtonUILogic)
		{
			p08ButtonUILogic?.SetCD(current, max, chargeCount);
		}
	}

	public void SetEnable(bool enable)
	{
		if (p08Button is P08SkillButtonUILogic p08SkillButtonUILogic)
		{
			p08SkillButtonUILogic?.SetEnable(enable);
		}
	}

	public void SetEffect(bool enable)
	{
		if (p08Button is P08SkillButtonUILogic p08SkillButtonUILogic)
		{
			p08SkillButtonUILogic?.SetEffect(enable);
		}
	}

	public void SetConsume(int consume)
	{
		if (p08Button is P08SkillButtonUILogic p08SkillButtonUILogic)
		{
			p08SkillButtonUILogic.SetConsume(consume);
		}
	}

	public SubStickController ChangeType2SubJoystick(string subJoystickPrefabPath)
	{
		GameObject gameObject = CommonEffectClipPlayer.InstantiateEffect(base.transform, subJoystickPrefabPath, string.Empty, Vector3.zero, Vector3.one, Vector3.zero, Vector3.forward, isAttach: true);
		if (gameObject != null)
		{
			JoyStick = gameObject.GetComponent<SubStickController>();
			JoyStickEffectController = gameObject.GetComponent<SubStickEffectController>();
			JoyStickEffectController.InitEvent(delegate
			{
				JoyStick.gameObject.SetActive(value: false);
			});
			gameObject.SetActive(value: false);
		}
		return JoyStick;
	}

	private void JoyStickLogicOnPointerDown()
	{
		if (JoyStick == null)
		{
			return;
		}
		NAgent agent = GetAgent();
		if (!(agent == null))
		{
			bool flag = (((agent.Blackboard as BBHumanoid).m_NextSimFrameData.mAbilityOriginalCanUse >> (int)buttonType) & 1) == 1;
			if ((cdImage == null || cdImage.fillAmount <= 0f) & flag)
			{
				JoyStick.gameObject.SetActive(value: true);
				JoyStick.Enable = true;
				JoyStick.transform.position = base.transform.position;
				JoyStickEffectController.Enter();
			}
			JoyStick.InitAimPosition();
		}
	}

	public void JoyStickLogicOnPointerUp()
	{
		if (!(JoyStick == null) && !(GetAgent() == null))
		{
			JoyStick.Enable = false;
			JoyStick.SendLocalCommandend();
			JoyStickEffectController.Exit();
		}
	}
}

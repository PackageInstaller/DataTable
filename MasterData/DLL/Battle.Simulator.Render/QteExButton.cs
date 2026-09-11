using System;
using NetProcol;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class QteExButton : P08EXButton
{
	public float effectTime = 2f;

	public bool isInCDShow;

	public bool isOnlyLock = true;

	public bool isStandby;

	public bool isShowCount;

	public Image abilityIcon;

	public Image cdMaskImage;

	public Text cdText;

	public Text CostText;

	public GameObject CostGO;

	public GameObject SkillLine;

	public CanvasGroup canvasGroup;

	public GameObject disableGo;

	public PlayableDirector effectCDRefresh;

	public Vector2 defaultSceneSize = new Vector2(1920f, 1080f);

	private bool useableCD = true;

	public MemberPosition memberPosition;

	public ButtonType buttonType;

	private bool hasPress;

	private void Awake()
	{
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(OnButtonDown));
		actionOnPointerUp = (Action)Delegate.Combine(actionOnPointerUp, new Action(OnButtonUp));
	}

	private void OnDestroy()
	{
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(OnButtonDown));
		actionOnPointerUp = (Action)Delegate.Remove(actionOnPointerUp, new Action(OnButtonUp));
	}

	public void OnButtonDown()
	{
		if (!useableCD)
		{
			return;
		}
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
		hasPress = true;
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		startMeleeCommand.SetData(agent.AgentID, (int)buttonType, isPressing: true);
		ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
	}

	public void OnButtonUp()
	{
		if (!hasPress)
		{
			return;
		}
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
		hasPress = false;
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		startMeleeCommand.SetData(agent.AgentID, (int)buttonType, isPressing: false);
		ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
	}

	private NAgent GetAgent()
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return null;
		}
		NAgent nAgent = agentManager.GetAgentByMemberPostion(memberPosition);
		GameMode mGameMode = (NScene.GetCurrentScene() as BattleScene).mGameMode;
		if (mGameMode == GameMode.EditorMultiPlayer || mGameMode == GameMode.Multiplayer)
		{
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

	public void Init(ButtonType buttonType, string atlasPath, string imagePath)
	{
		this.buttonType = buttonType;
		SetIcon(atlasPath, imagePath);
		if (effectCDRefresh != null)
		{
			StopTimeline(effectCDRefresh);
			effectCDRefresh.stopped += OnTimelineStop;
		}
		SetCD(0, 1);
	}

	private void SetIcon(string atlasPath, string imagePath)
	{
		if (!string.IsNullOrEmpty(atlasPath) && !(abilityIcon == null))
		{
			abilityIcon.sprite = AtlasManager.GetSprite(atlasPath, imagePath);
		}
	}

	public void SetCD(int percectCD, int maxCD)
	{
		if (percectCD <= 0 && !useableCD)
		{
			PlayTimeline(effectCDRefresh);
		}
		SetCDTime(percectCD, maxCD);
		SetCDText(percectCD);
		SetEnable(percectCD <= 0);
	}

	private void StopTimeline(PlayableDirector playableDirector)
	{
		playableDirector.Stop();
		playableDirector.gameObject.SetActive(value: false);
	}

	private void OnTimelineStop(PlayableDirector playableDirector)
	{
		playableDirector.gameObject.SetActive(value: false);
	}

	private void PlayTimeline(PlayableDirector playableDirector)
	{
		if (!(playableDirector == null))
		{
			playableDirector.gameObject.SetActive(value: true);
			playableDirector.time = 0.0;
			playableDirector.Play();
		}
	}

	private void SetCDTime(int current, int max)
	{
		cdMaskImage.fillAmount = (float)current / (float)max;
		if (current > 0)
		{
			useableCD = false;
		}
		else
		{
			useableCD = true;
		}
	}

	private void SetCDText(int current)
	{
		if (!(null != cdText))
		{
			return;
		}
		if (0 < current)
		{
			int num = Mathf.CeilToInt((float)current / 1000f);
			if (num < CommonString.Numbers.Length)
			{
				cdText.text = CommonString.Numbers[num];
			}
			else
			{
				cdText.text = num.ToString();
			}
		}
		else
		{
			cdText.text = string.Empty;
		}
	}

	private void SetEnable(bool enable)
	{
		if (disableGo != null && disableGo.activeSelf == enable)
		{
			disableGo.SetActive(!enable);
		}
		bool flag = useableCD & enable;
		if (!(abilityIcon == null))
		{
			if (flag)
			{
				Color color = abilityIcon.color;
				color.a = 1f;
				abilityIcon.color = color;
			}
			else
			{
				Color color2 = abilityIcon.color;
				color2.a = 8f / 85f;
				abilityIcon.color = color2;
			}
		}
	}
}

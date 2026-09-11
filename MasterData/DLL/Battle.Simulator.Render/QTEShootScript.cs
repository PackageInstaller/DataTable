using System;
using System.Collections.Generic;
using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class QTEShootScript : P08EXButton
{
	public TargetCampType targetCamp;

	public float effectTime = 2f;

	public bool isInCDShow;

	public bool isOnlyLock = true;

	public bool isStandby;

	public bool isShowCount;

	public string EffectPath;

	public string OutSideEffectPath;

	public string StandardEffectPath;

	public string OutLockEffectPath;

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

	private BattleScene _battleScene;

	private WorldStateManager _mgr;

	private Camera _mainCamera;

	private bool useableCD = true;

	private EffectController StandbyEffect;

	private EffectController OutLockEffect;

	private void Awake()
	{
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(Shoot));
	}

	private void OnDestroy()
	{
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(Shoot));
	}

	private void OnDisable()
	{
		if (StandbyEffect != null)
		{
			PooledAsset.DestroyOrReturn(StandbyEffect.gameObject);
			StandbyEffect = null;
		}
		if (OutLockEffect != null)
		{
			PooledAsset.DestroyOrReturn(OutLockEffect.gameObject);
			OutLockEffect = null;
		}
	}

	private void Update()
	{
		if (!isStandby)
		{
			return;
		}
		if (!useableCD)
		{
			if (StandbyEffect != null)
			{
				PooledAsset.DestroyOrReturn(StandbyEffect.gameObject);
				StandbyEffect = null;
			}
			return;
		}
		if (_mgr == null)
		{
			if (_battleScene == null)
			{
				return;
			}
			_mgr = _battleScene.GetWorldSatetManager();
			if (_mgr == null)
			{
				return;
			}
		}
		NAgent nAgent = null;
		if (targetCamp == TargetCampType.Enemy)
		{
			int lockedAgentID = _mgr.lockedAgentID;
			nAgent = _battleScene.GetAgentManager().GetAgent(lockedAgentID);
		}
		if (nAgent == null)
		{
			if (StandbyEffect != null && StandbyEffect.enabled)
			{
				StandbyEffect.SetActive(active: false);
				if (OutLockEffect == null)
				{
					OutLockEffect = InitEffect(OutLockEffectPath);
				}
				if (OutLockEffect != null && StandbyEffect != null)
				{
					OutLockEffect.SetActive(active: false);
					OutLockEffect.SetActive(active: true);
					OutLockEffect.transform.position = StandbyEffect.transform.position;
				}
			}
			return;
		}
		if (StandbyEffect == null)
		{
			StandbyEffect = InitEffect(StandardEffectPath);
			if (StandbyEffect == null)
			{
				return;
			}
		}
		if (InView(nAgent.transform.position))
		{
			if (!StandbyEffect.enabled)
			{
				StandbyEffect.SetActive(active: true);
			}
			Vector3 position = ComponentIndicator.GetLockAttachPoint(nAgent, _mgr.lockedAgentPart).transform.position;
			position = (position - _mainCamera.transform.position).normalized * 0.5f;
			StandbyEffect.transform.position = _mainCamera.transform.position + position;
		}
		else if (StandbyEffect.enabled)
		{
			StandbyEffect.SetActive(active: false);
		}
	}

	private EffectController InitEffect(string EffectPath)
	{
		if (string.IsNullOrEmpty(EffectPath))
		{
			return null;
		}
		GameObject gameObject = Asset.Instantiate(EffectPath);
		if (gameObject == null)
		{
			return null;
		}
		gameObject.transform.position = Vector3.zero;
		EffectController effectController = EffectController.GetEffectController(gameObject);
		effectController.Initialize(isLoop: false, 99999f, 1f, EEffectQuality.Fantastic, null);
		effectController.Simulator(0f);
		effectController.m_CameraEffectController = U3DUtil.Get<CameraEffectController>(effectController.gameObject);
		effectController.m_CameraEffectController.m_effectController = effectController;
		effectController.m_CameraEffectController.Initalization(Vector3.one, 55f, defaultSceneSize);
		gameObject.transform.position = Vector3.zero;
		gameObject.transform.SetParent(_mainCamera.transform);
		gameObject.transform.localRotation = Quaternion.identity;
		return effectController;
	}

	private NAgent ChooseTarget()
	{
		List<NAgent> list = new List<NAgent>();
		switch (targetCamp)
		{
		case TargetCampType.Oneself:
			list.Add(_battleScene.GetPlayerAgent());
			break;
		case TargetCampType.All:
			list.AddRange(_battleScene.GetAgentManager().GetCampAgent(2u));
			list.AddRange(_battleScene.GetAgentManager().GetCampAgent(1u));
			break;
		default:
			list.AddRange(_battleScene.GetAgentManager().GetCampAgent((uint)targetCamp));
			break;
		case TargetCampType.None:
			break;
		}
		if (list.Count != 0)
		{
			return list[UnityEngine.Random.Range(0, list.Count)];
		}
		return null;
	}

	private bool InView(Vector3 position)
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
		}
		Vector3 vector = _mainCamera.WorldToScreenPoint(position);
		if (vector.z > 0f && vector.x > 0f && vector.x < (float)Screen.width && vector.y > 0f)
		{
			return vector.y < (float)Screen.height;
		}
		return false;
	}

	public void Shoot()
	{
		if (_battleScene == null)
		{
			return;
		}
		if (_mgr == null)
		{
			if (_battleScene == null)
			{
				return;
			}
			_mgr = _battleScene.GetWorldSatetManager();
			if (_mgr == null)
			{
				return;
			}
		}
		NAgent nAgent = null;
		if (targetCamp == TargetCampType.Enemy)
		{
			int lockedAgentID = _mgr.lockedAgentID;
			nAgent = _battleScene.GetAgentManager().GetAgent(lockedAgentID);
		}
		if (nAgent == null)
		{
			if (isOnlyLock)
			{
				return;
			}
			nAgent = ChooseTarget();
			if (nAgent == null)
			{
				return;
			}
		}
		ButtonShootCommand buttonShootCommand = CommandFactory.Create(NetprotoOperationCode.CmdButtonShoot) as ButtonShootCommand;
		buttonShootCommand.SetData(_battleScene.GetPlayerAgent().AgentID, nAgent.AgentID);
		ClientSimulator.Instance.SendLocalCommand(buttonShootCommand);
		Vector3 zero = Vector3.zero;
		Vector3 zero2 = Vector3.zero;
		zero2 = ((nAgent.AgentID != _mgr.lockedAgentID) ? (nAgent.Position + Vector3.up) : ComponentIndicator.GetLockAttachPoint(nAgent, _mgr.lockedAgentPart).transform.position);
		Vector3 normalized = (zero2 - _mainCamera.transform.position).normalized;
		zero = normalized * 0.5f;
		GameObject gameObject;
		if (InView(nAgent.transform.position))
		{
			if (string.IsNullOrEmpty(EffectPath))
			{
				return;
			}
			gameObject = Asset.Instantiate(EffectPath);
		}
		else
		{
			if (string.IsNullOrEmpty(OutSideEffectPath))
			{
				return;
			}
			zero = ((!(Vector3.Cross(_mainCamera.transform.forward, normalized).y < 0f)) ? (_mainCamera.transform.forward + _mainCamera.transform.right) : (_mainCamera.transform.forward - _mainCamera.transform.right));
			gameObject = Asset.Instantiate(OutSideEffectPath);
		}
		if (!(gameObject == null))
		{
			EffectController effectController = EffectController.GetEffectController(gameObject);
			effectController.Initialize(isLoop: false, effectTime, 1f, EEffectQuality.Fantastic, null);
			effectController.Simulator(0f);
			effectController.m_CameraEffectController = U3DUtil.Get<CameraEffectController>(effectController.gameObject);
			effectController.m_CameraEffectController.m_effectController = effectController;
			effectController.m_CameraEffectController.Initalization(Vector3.one, 55f, defaultSceneSize);
			gameObject.transform.localPosition = _mainCamera.transform.position + zero;
			gameObject.transform.SetParent(_mainCamera.transform);
			gameObject.transform.localRotation = Quaternion.identity;
		}
	}

	public void Init(TargetCampType tarCamp, string effectPath, string outsideEffectPath, bool isCdShow, bool OnlyLock, bool Standby, string StandbyEffect, string OutLockEffect)
	{
		_battleScene = (BattleScene)NScene.GetCurrentScene();
		_mgr = _battleScene.GetWorldSatetManager();
		targetCamp = tarCamp;
		EffectPath = effectPath;
		OutSideEffectPath = outsideEffectPath;
		isStandby = Standby;
		StandardEffectPath = StandbyEffect;
		OutLockEffectPath = OutLockEffect;
		isInCDShow = isCdShow;
		isOnlyLock = OnlyLock;
		_mainCamera = Camera.main;
		if (effectCDRefresh != null)
		{
			StopTimeline(effectCDRefresh);
			effectCDRefresh.stopped += OnTimelineStop;
		}
		SetCD(0, 1);
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
		if (abilityIcon == null)
		{
			return;
		}
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
		if (!flag)
		{
			if (!isInCDShow)
			{
				canvasGroup.alpha = 0f;
			}
			canvasGroup.blocksRaycasts = false;
		}
		else
		{
			if (!isInCDShow)
			{
				canvasGroup.alpha = 1f;
			}
			canvasGroup.blocksRaycasts = true;
		}
	}

	public void SetEffectPath(string effectPath, string outsideEffectPath, bool Standby, string standbyEffectPath, string outLockEffectPath)
	{
		EffectPath = effectPath;
		OutSideEffectPath = outsideEffectPath;
		OutLockEffectPath = outLockEffectPath;
		isStandby = Standby;
		if ((!isStandby || StandardEffectPath != standbyEffectPath) && StandbyEffect != null)
		{
			PooledAsset.DestroyOrReturn(StandbyEffect.gameObject);
			StandbyEffect = null;
		}
		StandardEffectPath = standbyEffectPath;
	}

	public void SetUseCount(bool canUse, int useCount)
	{
		if (!canUse)
		{
			if (SkillLine.activeSelf)
			{
				SkillLine.SetActive(value: false);
				CostGO.SetActive(value: false);
			}
			return;
		}
		if (!SkillLine.activeSelf)
		{
			SkillLine.SetActive(value: true);
			CostGO.SetActive(value: true);
		}
		CostText.text = useCount.ToString();
	}
}

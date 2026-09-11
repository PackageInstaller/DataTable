using System;
using System.Collections.Generic;
using System.Linq;
using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

public class QTEAimShootWithListScript : P08EXButton
{
	public TargetCampType mTargetCamp;

	public float mAimTime;

	private bool mAimRunning;

	public int mAimCount;

	public int mShootCount;

	public bool mIsShootEnd;

	public bool mStopLock;

	public float mAimAreaPercent = 0.5f;

	public float mAimMaxDistance;

	public string mEffectPath;

	public bool banInput;

	public float mPressShootTime = -1f;

	private float pressTime;

	public HashSet<int> mAimTargets = new HashSet<int>();

	private Dictionary<int, EffectController> mLockEffect = new Dictionary<int, EffectController>();

	public Action mShootEvent;

	public Action mEndAimEvent;

	public Action<int> mAddAimTargetEvent;

	public Action<int> mRemoveAimTargetEvent;

	public Action mPointdownEvent;

	public Action mPointUpEvent;

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

	private Vector3 midPoint = new Vector3(Screen.width / 2, Screen.height / 2, 0f);

	private BattleScene _battleScene;

	private WorldStateManager _mgr;

	private Camera mainCamera;

	private NAgent playerAgent;

	private bool isPress;

	public void Init(float AimTime, int AimCount, int ShootCount, float AimAreaPercent, float AimMaxDis, string effectPath, bool isShootEnd, float pressTime)
	{
		mAimTime = AimTime;
		mAimCount = AimCount;
		mShootCount = ShootCount;
		mAimAreaPercent = AimAreaPercent;
		mAimMaxDistance = AimMaxDis;
		mEffectPath = effectPath;
		mAimRunning = true;
		mIsShootEnd = isShootEnd;
		mPressShootTime = pressTime;
		isPress = false;
	}

	private void Awake()
	{
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(ShootLockTarget));
		actionOnPointerDown = (Action)Delegate.Combine(actionOnPointerDown, new Action(PointDownEvent));
		actionOnPointerUp = (Action)Delegate.Combine(actionOnPointerUp, new Action(PointUpEvent));
	}

	private void OnDestroy()
	{
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(ShootLockTarget));
		actionOnPointerDown = (Action)Delegate.Remove(actionOnPointerDown, new Action(PointDownEvent));
		actionOnPointerUp = (Action)Delegate.Remove(actionOnPointerUp, new Action(PointUpEvent));
	}

	private void Update()
	{
		if (!mAimRunning)
		{
			return;
		}
		if (mStopLock)
		{
			UnLockAllTarget();
			return;
		}
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null || WorldStateManager.GetWorldStateManager() == null)
		{
			return;
		}
		if (playerAgent == null)
		{
			playerAgent = agentManager.GetPlayerAgent();
		}
		Dictionary<int, NAgent>.Enumerator enumerator = agentManager.mAgentsCreatedThisFrame.GetEnumerator();
		uint interestCamp = RoleCampProcessor.GetInterestCamp(playerAgent.Camp);
		while (enumerator.MoveNext())
		{
			BBHumanoid bBHumanoid = enumerator.Current.Value.Blackboard as BBHumanoid;
			if (bBHumanoid == null || (interestCamp & enumerator.Current.Value.Camp) == 0)
			{
				continue;
			}
			if (mainCamera == null)
			{
				mainCamera = Camera.main;
			}
			if (bBHumanoid.m_NextSimFrameData.mCantBeLocked || bBHumanoid.HP <= 0 || bBHumanoid.m_NextSimFrameData.mIsHide != E_EntityHideType.None)
			{
				for (int i = 0; i < bBHumanoid.m_NextSimFrameData.mShapeStates.Count; i++)
				{
					ShapeState shapeState = bBHumanoid.m_NextSimFrameData.mShapeStates[i];
					if (mAimTargets.Contains(shapeState.mShapeEntityID))
					{
						UnlockTarget(shapeState.mShapeEntityID);
					}
				}
				continue;
			}
			for (int j = 0; j < bBHumanoid.m_NextSimFrameData.mShapeStates.Count; j++)
			{
				ShapeState shapeState2 = bBHumanoid.m_NextSimFrameData.mShapeStates[j];
				Transform lockAttachPoint = ComponentIndicator.GetLockAttachPoint(bBHumanoid.mAgent, (int)shapeState2.mPartType);
				if (!InView(lockAttachPoint.position))
				{
					if (mAimTargets.Contains(shapeState2.mShapeEntityID))
					{
						UnlockTarget(shapeState2.mShapeEntityID);
					}
					continue;
				}
				float magnitude = (lockAttachPoint.position - playerAgent.transform.position).magnitude;
				if (mAimTargets.Contains(shapeState2.mShapeEntityID))
				{
					if (magnitude > mAimMaxDistance)
					{
						UnlockTarget(shapeState2.mShapeEntityID);
					}
					else
					{
						UpdateEffectPosition(shapeState2.mShapeEntityID, lockAttachPoint);
					}
				}
				else if (!(magnitude > mAimMaxDistance) && mAimCount > mAimTargets.Count)
				{
					LockTarget(lockAttachPoint, shapeState2.mShapeEntityID);
				}
			}
		}
		if (isPress && mPressShootTime >= 0f)
		{
			pressTime -= Time.deltaTime;
			if (pressTime <= 0f)
			{
				ShootLockTarget();
				pressTime = mPressShootTime;
			}
		}
		mAimTime -= Time.deltaTime;
		if (mAimTime < 0f)
		{
			UnLockAllTarget();
			mAimRunning = false;
			mEndAimEvent?.Invoke();
		}
	}

	private bool InView(Vector3 position)
	{
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		Vector3 vector = mainCamera.WorldToScreenPoint(position);
		float magnitude = (vector.NewZ(0f) - midPoint).magnitude;
		if (vector.z > 0f)
		{
			return magnitude <= (float)Screen.width * mAimAreaPercent;
		}
		return false;
	}

	private void LockTarget(Transform target, int targetID)
	{
		if (!mAimTargets.Contains(targetID) && !mLockEffect.ContainsKey(targetID) && !(target == null))
		{
			EffectController effectController = InitEffect(mEffectPath);
			if (effectController == null)
			{
				Debug.LogError("输入锁定特效路径错误 " + mEffectPath);
			}
			mAimTargets.Add(targetID);
			mLockEffect[targetID] = effectController;
			Vector3 vector = (target.position - mainCamera.transform.position).normalized * 0.5f;
			effectController.transform.position = mainCamera.transform.position + vector;
			mAddAimTargetEvent?.Invoke(targetID);
		}
	}

	public void EndShoot()
	{
		UnLockAllTarget();
	}

	private void UnLockAllTarget()
	{
		foreach (KeyValuePair<int, EffectController> item in mLockEffect)
		{
			PooledAsset.DestroyOrReturn(item.Value.gameObject);
			mRemoveAimTargetEvent?.Invoke(item.Key);
		}
		mLockEffect.Clear();
		mAimTargets.Clear();
	}

	private void UnlockTarget(int targetID)
	{
		if (mAimTargets.Contains(targetID) && mLockEffect.ContainsKey(targetID))
		{
			mAimTargets.Remove(targetID);
			PooledAsset.DestroyOrReturn(mLockEffect[targetID].gameObject);
			mLockEffect.Remove(targetID);
			mRemoveAimTargetEvent?.Invoke(targetID);
		}
	}

	private void UpdateEffectPosition(int targetID, Transform target)
	{
		if (mLockEffect.TryGetValue(targetID, out var value))
		{
			Vector3 vector = (target.position - mainCamera.transform.position).normalized * 0.5f;
			value.transform.position = mainCamera.transform.position + vector;
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
		gameObject.transform.SetParent(mainCamera.transform);
		gameObject.transform.localRotation = Quaternion.identity;
		return effectController;
	}

	private void ShootLockTarget()
	{
		if (!banInput && (!playerAgent || (playerAgent.Blackboard as BBHumanoid).HP > 0) && mShootCount > 0)
		{
			ButtonLockListCommand buttonLockListCommand = CommandFactory.Create(NetprotoOperationCode.CmdLockListEmeny) as ButtonLockListCommand;
			buttonLockListCommand.SetData(playerAgent.AgentID, mAimTargets.ToList());
			ClientSimulator.Instance.SendLocalCommand(buttonLockListCommand);
			if (mShootEvent != null)
			{
				mShootEvent();
			}
			mShootCount--;
			if (mIsShootEnd && mShootCount == 0)
			{
				UnLockAllTarget();
				mAimRunning = false;
				mEndAimEvent?.Invoke();
			}
		}
	}

	private void PointDownEvent()
	{
		isPress = true;
		pressTime = mPressShootTime;
		if (mPointdownEvent != null)
		{
			mPointdownEvent();
		}
	}

	private void PointUpEvent()
	{
		isPress = false;
		if (mPointUpEvent != null)
		{
			mPointUpEvent();
		}
	}
}

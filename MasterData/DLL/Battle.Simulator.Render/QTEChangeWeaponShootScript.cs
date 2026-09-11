using System;
using System.Collections.Generic;
using System.Linq;
using Config;
using NetProcol;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class QTEChangeWeaponShootScript : P08EXButton, IPointerDownHandler, IEventSystemHandler, IDragHandler
{
	public ButtonType buttonType;

	public TargetCampType mTargetCamp;

	public float mAimTime;

	private float mAimRunningTime;

	private bool mAimRunning;

	public int mAimCount;

	public int mShootCount;

	public float mLockToStartTime;

	private float mLockTime;

	public bool mEndLockShoot;

	public Transform mAgentRotateTarget;

	private string mEffectPath;

	private int mSightIndex;

	private bool mIsInLock = true;

	private List<Transform> mLockSightList = new List<Transform>();

	private List<Transform> mUnLockSightList = new List<Transform>();

	private List<string> mSightGlassInList;

	private List<string> mSightGlassOutList;

	private EffectController mCurSightGlassEc;

	private Vector3 mSightPosition;

	private Transform mCurrentSight;

	private Transform mBullerCountTran;

	private Text mBullerText1;

	private Text mBullerText2;

	private float mChargePercent;

	private Image mChargePercentImg;

	private Text mChargePercent1;

	private Text mChargePercent2;

	private float mLockSize;

	private float mUpSize;

	private float mDownSize;

	private float mLeftSize;

	private float mRightSize;

	public HashSet<int> mAimTargets = new HashSet<int>();

	private Dictionary<int, EffectController> mLockEffect = new Dictionary<int, EffectController>();

	public Vector2 defaultSceneSize = new Vector2(1920f, 1080f);

	private Camera mainCamera;

	private Camera uiCamera = CanvasManager.Instance.uiCamera;

	private NAgent playerAgent;

	public float speed = 1f;

	public float speedHeight = -12f;

	private Vector3 mInitRotate;

	private Transform mTargetCamera;

	private float mLeftRightAngleLimit = 30f;

	private float mUpDownAngleLimit = 60f;

	private Vector2 dragDelta = Vector2.zero;

	private bool isInit;

	private Vector3 centerPosition = new Vector3(Screen.width / 2, Screen.height / 2, 0f);

	private float ScreenMaxWidth;

	private float ScreenMaxHeight;

	public float mSightDis = 20f;

	public void Init(float AimTime, int AimCount, int ShootCount, float LockToStartTime, float LockSize, string EffectPath, bool EndLockShoot, float SightDis, Transform TargetCamera, float LeftRightAngleLimit, float UpDownAngleLimit, List<string> LockSightPath, List<string> UnLockSightPath, List<string> GlassInList, List<string> GlassOutList, string BulletCountPath, float upSize, float downSize, float leftSize, float rightSize)
	{
		mAimTime = AimTime;
		mAimCount = AimCount;
		mShootCount = ShootCount;
		mLockToStartTime = LockToStartTime;
		mLockSize = LockSize;
		mEffectPath = EffectPath;
		mEndLockShoot = EndLockShoot;
		InitSightGo(LockSightPath, UnLockSightPath, GlassInList, GlassOutList);
		InitBulletGo(BulletCountPath);
		actionOnPointerUp = (Action)Delegate.Combine(actionOnPointerUp, new Action(PointUpAction));
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, new Vector2(Screen.width, Screen.height), uiCamera, out var localPoint);
		ScreenMaxWidth = localPoint.x;
		ScreenMaxHeight = localPoint.y;
		mSightDis = SightDis;
		mTargetCamera = TargetCamera;
		if (mTargetCamera != null)
		{
			mInitRotate = mTargetCamera.eulerAngles;
		}
		mLeftRightAngleLimit = LeftRightAngleLimit;
		mUpDownAngleLimit = UpDownAngleLimit;
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null && WorldStateManager.GetWorldStateManager() != null)
		{
			if (playerAgent == null)
			{
				playerAgent = agentManager.GetPlayerAgent();
			}
			if (mainCamera == null)
			{
				mainCamera = Camera.main;
			}
			ChangeLockType(LockType: false);
			InitSize(upSize, downSize, leftSize, rightSize);
		}
	}

	private void InitSize(float up, float down, float left, float right)
	{
		int num = Screen.width / 2;
		int num2 = Screen.height / 2;
		mUpSize = (float)num2 + (float)num2 * up;
		mDownSize = (float)num2 - (float)num2 * down;
		mLeftSize = (float)num - (float)num * left;
		mRightSize = (float)num + (float)num * right;
	}

	private void InitBulletGo(string path)
	{
		if (!string.IsNullOrEmpty(path))
		{
			GameObject gameObject = Asset.InstantiateWithoutCache(path, base.transform);
			if (gameObject == null)
			{
				Debug.LogError("初始化特效失败,寻找不到该特效 " + path);
				return;
			}
			mBullerCountTran = gameObject.transform;
			mBullerText1 = mBullerCountTran.Find("textTittle").GetComponent<Text>();
			mBullerText2 = mBullerCountTran.Find("textTittle/tittleline").GetComponent<Text>();
		}
	}

	public void SetSightIndex(int index, int maxAimCount, float lockToShoot, int shootCount, bool isEndShoot)
	{
		ChangeLockIndex(index, maxAimCount, lockToShoot, shootCount, isEndShoot);
	}

	private void InitSightGo(List<string> LockList, List<string> UnLockList, List<string> glassInList, List<string> glassOutList)
	{
		if (LockList == null || UnLockList == null || LockList.Count != UnLockList.Count)
		{
			Debug.LogError("锁定图标列表和非锁定图标列表有误或数量不相同");
			return;
		}
		for (int i = 0; i < LockList.Count; i++)
		{
			string text = LockList[i];
			if (!string.IsNullOrEmpty(text))
			{
				GameObject gameObject = Asset.InstantiateWithoutCache(text, base.transform);
				if (gameObject == null)
				{
					Debug.LogError("初始化特效失败,寻找不到该特效 " + text);
					continue;
				}
				gameObject.SetActive(value: false);
				mLockSightList.Add(gameObject.transform);
			}
		}
		for (int j = 0; j < UnLockList.Count; j++)
		{
			string text2 = UnLockList[j];
			if (!string.IsNullOrEmpty(text2))
			{
				GameObject gameObject2 = Asset.InstantiateWithoutCache(text2, base.transform);
				if (gameObject2 == null)
				{
					Debug.LogError("初始化特效失败,寻找不到该特效 " + text2);
					continue;
				}
				gameObject2.SetActive(value: false);
				mUnLockSightList.Add(gameObject2.transform);
			}
		}
		for (int k = 0; k < glassInList.Count; k++)
		{
			string text3 = glassInList[k];
			if (!string.IsNullOrEmpty(text3))
			{
				Asset.Cache(text3);
			}
		}
		mSightGlassInList = glassInList;
		for (int l = 0; l < glassOutList.Count; l++)
		{
			string text4 = glassOutList[l];
			if (!string.IsNullOrEmpty(text4))
			{
				Asset.Cache(text4);
			}
		}
		mSightGlassOutList = glassOutList;
		mSightIndex = 0;
		mSightPosition = new Vector3(Screen.width / 2, Screen.height / 2, 0f);
	}

	private void Update()
	{
		UpdateSightPosition();
		if (!mAimRunning)
		{
			return;
		}
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null && WorldStateManager.GetWorldStateManager() != null)
		{
			if (playerAgent == null)
			{
				playerAgent = agentManager.GetPlayerAgent();
			}
			if (mainCamera == null)
			{
				mainCamera = Camera.main;
			}
			UpdateLockLogic(agentManager.mAgentsCreatedThisFrame);
			UpdateLockTime();
			UpdateGlassPosition();
			mAimRunningTime -= Time.deltaTime;
			if (mAimRunningTime <= 0f)
			{
				ChangeSightType(IsInSight: false);
			}
		}
	}

	private void UpdateLockLogic(Dictionary<int, NAgent> targetDic)
	{
		Dictionary<int, NAgent>.Enumerator enumerator = targetDic.GetEnumerator();
		uint interestCamp = RoleCampProcessor.GetInterestCamp(playerAgent.Camp);
		while (enumerator.MoveNext())
		{
			BBHumanoid bBHumanoid = enumerator.Current.Value.Blackboard as BBHumanoid;
			if (bBHumanoid == null || (interestCamp & enumerator.Current.Value.Camp) == 0)
			{
				continue;
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
				}
				else if (mAimTargets.Contains(shapeState2.mShapeEntityID))
				{
					UpdateEffectPosition(shapeState2.mShapeEntityID, lockAttachPoint);
				}
				else if (mAimCount > mAimTargets.Count)
				{
					LockTarget(lockAttachPoint, shapeState2.mShapeEntityID);
				}
			}
		}
	}

	private void UpdateLockTime()
	{
		if (mAimTargets.Count > 0)
		{
			mLockTime += Time.deltaTime;
			if (mLockTime >= mLockToStartTime)
			{
				ShootLockTarget();
				mLockTime = 0f;
			}
		}
		else
		{
			mLockTime = 0f;
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

	private void UpdateEffectPosition(int targetID, Transform target)
	{
		if (mLockEffect.TryGetValue(targetID, out var value))
		{
			Vector3 vector = (target.position - mainCamera.transform.position).normalized * 0.5f;
			value.transform.position = mainCamera.transform.position + vector;
		}
	}

	private bool InView(Vector3 position)
	{
		if (mainCamera == null)
		{
			mainCamera = Camera.main;
		}
		Vector3 vector = mainCamera.WorldToScreenPoint(position);
		float magnitude = (vector.NewZ(0f) - mSightPosition).magnitude;
		if (vector.z > 0f)
		{
			return magnitude <= (float)Screen.width * mLockSize;
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
		}
	}

	private void UnLockAllTarget()
	{
		foreach (KeyValuePair<int, EffectController> item in mLockEffect)
		{
			PooledAsset.DestroyOrReturn(item.Value.gameObject);
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
		}
	}

	private void PointDownAction()
	{
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		startMeleeCommand.SetData(playerAgent.AgentID, (int)buttonType, isPressing: true);
		ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
	}

	private void PointUpAction()
	{
		StartMeleeCommand startMeleeCommand = CommandFactory.Create(NetprotoOperationCode.CmdMeleeAttack) as StartMeleeCommand;
		startMeleeCommand.SetData(playerAgent.AgentID, (int)buttonType, isPressing: false);
		ClientSimulator.Instance.SendLocalCommand(startMeleeCommand);
	}

	private void ShootLockTarget()
	{
		if (mShootCount > 0)
		{
			ButtonLockListCommand buttonLockListCommand = CommandFactory.Create(NetprotoOperationCode.CmdLockListEmeny) as ButtonLockListCommand;
			buttonLockListCommand.SetData(playerAgent.AgentID, mAimTargets.ToList());
			ClientSimulator.Instance.SendLocalCommand(buttonLockListCommand);
			PlayShootAnimator();
			mLockTime = 0f;
		}
	}

	private void PlayShootAnimator()
	{
		Animator component = mCurrentSight.GetComponent<Animator>();
		if (component != null)
		{
			component.Play("Shoot");
		}
	}

	public void ChangeLockIndex(int index, int maxLock, float aimShootTime, int shootCount, bool isEndShoot)
	{
		if (index >= 0 && index < mLockSightList.Count)
		{
			mSightIndex = index;
			mBullerCountTran.SetParent(base.transform);
			mCurrentSight.gameObject.SetActive(value: false);
			if (mIsInLock)
			{
				mCurrentSight = mLockSightList[mSightIndex];
			}
			else
			{
				mCurrentSight = mUnLockSightList[mSightIndex];
			}
			mCurrentSight.gameObject.SetActive(value: true);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, mSightPosition, uiCamera, out var localPoint);
			mCurrentSight.localPosition = localPoint;
			mBullerCountTran.SetParent(mCurrentSight);
			mAimCount = maxLock;
			mLockToStartTime = aimShootTime;
			mLockTime = 0f;
			ChangeShootCount(shootCount);
			mEndLockShoot = isEndShoot;
			mChargePercentImg = (mCurrentSight.Find("Harm/progress") ? mCurrentSight.Find("Harm/progress").GetComponent<Image>() : null);
			mChargePercent1 = (mCurrentSight.Find("Harm/textTittle01") ? mCurrentSight.Find("Harm/textTittle01").GetComponent<Text>() : null);
			mChargePercent2 = (mCurrentSight.Find("Harm/textTittle01/tittleline") ? mCurrentSight.Find("Harm/textTittle01/tittleline").GetComponent<Text>() : null);
		}
	}

	public void ChangeLockType(bool LockType)
	{
		if (LockType != mIsInLock)
		{
			mIsInLock = LockType;
			if (mCurrentSight != null)
			{
				mCurrentSight.localScale = Vector3.one;
			}
			mBullerCountTran.SetParent(base.transform);
			mCurrentSight?.gameObject.SetActive(value: false);
			if (mIsInLock)
			{
				mCurrentSight = mLockSightList[mSightIndex];
			}
			else
			{
				mCurrentSight = mUnLockSightList[mSightIndex];
			}
			mCurrentSight.gameObject.SetActive(value: true);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, mSightPosition, uiCamera, out var localPoint);
			mCurrentSight.localPosition = localPoint;
			mCurrentSight.localScale = Vector3.one;
			mBullerCountTran.SetParent(mCurrentSight);
			mChargePercentImg = (mCurrentSight.Find("Harm/progress") ? mCurrentSight.Find("Harm/progress").GetComponent<Image>() : null);
			mChargePercent1 = (mCurrentSight.Find("Harm/textTittle01") ? mCurrentSight.Find("Harm/textTittle01").GetComponent<Text>() : null);
			mChargePercent2 = (mCurrentSight.Find("Harm/textTittle01/tittleline") ? mCurrentSight.Find("Harm/textTittle01/tittleline").GetComponent<Text>() : null);
		}
	}

	public void ChangeShootCount(int count)
	{
		mShootCount = count;
		mBullerText1.text = mShootCount.ToString();
		mBullerText2.text = mShootCount.ToString();
	}

	public void ChangeChargePercent(int percent)
	{
		mChargePercent = (float)percent / 1000f;
		if ((bool)mChargePercent1)
		{
			mChargePercent1.text = $"{(float)percent / 10f}%";
		}
		if ((bool)mChargePercent2)
		{
			mChargePercent2.text = $"{(float)percent / 10f}%";
		}
		if ((bool)mChargePercentImg)
		{
			mChargePercentImg.fillAmount = mChargePercent;
		}
	}

	public void UpdateAimTime(float time)
	{
		mAimTime = time;
	}

	public void ChangeSightType(bool IsInSight)
	{
		ChangeLockType(IsInSight);
		if (IsInSight)
		{
			mAimRunningTime = mAimTime;
			mAimRunning = true;
			mLockTime = 0f;
		}
		else
		{
			mAimRunning = false;
			if (mEndLockShoot)
			{
				ShootLockTarget();
			}
			UnLockAllTarget();
		}
		ChangeGlassType(IsInSight);
	}

	public new void OnPointerDown(PointerEventData eventData)
	{
		dragDelta = eventData.position - (Vector2)mSightPosition;
		if ((bool)mCurrentSight)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, mSightPosition, uiCamera, out var localPoint);
			mCurrentSight.localPosition = localPoint;
		}
		PointDownAction();
		isInit = true;
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragDelta = eventData.delta;
	}

	public void SetDragDelta(Vector2 delta)
	{
		dragDelta = delta;
	}

	private void UpdateSightPosition()
	{
		if (dragDelta != Vector2.zero)
		{
			mSightPosition.x += dragDelta.x;
			mSightPosition.y += dragDelta.y;
			UpdateCameraRotate(dragDelta.x * speed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f, dragDelta.y * speedHeight / (float)Screen.height);
			ClampSightPosition();
			UpdateAgentRotate();
			if ((bool)mCurrentSight)
			{
				RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform as RectTransform, mSightPosition, uiCamera, out var localPoint);
				mCurrentSight.localPosition = localPoint;
			}
			dragDelta = Vector2.zero;
		}
	}

	private void UpdateCameraRotate(float deltaX, float deltaY)
	{
		if (mTargetCamera == null)
		{
			return;
		}
		if (isInit)
		{
			isInit = false;
			return;
		}
		if (Mathf.Abs(deltaX) >= 0.01f)
		{
			Vector3 eulerAngles = mTargetCamera.eulerAngles;
			float angle = mTargetCamera.eulerAngles.y + deltaX;
			float y = ClampAngle(angle, mInitRotate.y, mLeftRightAngleLimit);
			mTargetCamera.rotation = Quaternion.Euler(eulerAngles.x, y, eulerAngles.z);
		}
		if (Mathf.Abs(deltaY) >= 0.01f)
		{
			Vector3 eulerAngles2 = mTargetCamera.eulerAngles;
			float angle2 = mTargetCamera.eulerAngles.x + deltaY;
			float x = ClampAngle(angle2, mInitRotate.x, mUpDownAngleLimit);
			mTargetCamera.rotation = Quaternion.Euler(x, eulerAngles2.y, eulerAngles2.z);
		}
	}

	private void UpdateAgentRotate()
	{
		if (playerAgent != null && playerAgent.Animator != null)
		{
			Vector3 vector = mSightPosition - centerPosition;
			playerAgent.Animator.SetFloat("aimX", vector.x / (float)(Screen.width / 2));
			playerAgent.Animator.SetFloat("aimY", vector.y / (float)(Screen.height / 2));
		}
	}

	private float ClampAngle(float angle, float centerAngle, float range)
	{
		angle = Mathf.Repeat(angle, 360f);
		centerAngle = Mathf.Repeat(centerAngle, 360f);
		float value = Mathf.Repeat(angle - centerAngle + 180f, 360f) - 180f;
		value = Mathf.Clamp(value, 0f - range, range);
		return Mathf.Repeat(centerAngle + value, 360f);
	}

	private void ClampSightPosition()
	{
		mSightPosition.x = Mathf.Clamp(mSightPosition.x, mLeftSize, mRightSize);
		mSightPosition.y = Mathf.Clamp(mSightPosition.y, mDownSize, mUpSize);
	}

	private void UpdateGlassPosition()
	{
		if (mCurSightGlassEc != null)
		{
			Vector2 vector = uiCamera.WorldToScreenPoint(mCurrentSight.position);
			Vector3 position = mainCamera.ScreenToWorldPoint(new Vector3(vector.x, vector.y, mSightDis));
			mCurSightGlassEc.transform.position = position;
			mCurSightGlassEc.transform.rotation = mainCamera.transform.rotation;
		}
	}

	private void ChangeGlassType(bool isOpen)
	{
		if (isOpen)
		{
			string text = mSightGlassInList[mSightIndex];
			if (mCurSightGlassEc != null)
			{
				mCurSightGlassEc.Stop();
			}
			if (!string.IsNullOrEmpty(text) && InitGlassEffect(text))
			{
				Vector2 vector = uiCamera.WorldToScreenPoint(mCurrentSight.position);
				Vector3 position = mainCamera.ScreenToWorldPoint(new Vector3(vector.x, vector.y, 10f));
				mCurSightGlassEc.transform.position = position;
				mCurSightGlassEc.transform.rotation = mainCamera.transform.rotation;
			}
		}
		else
		{
			string text2 = mSightGlassOutList[mSightIndex];
			if (mCurSightGlassEc != null)
			{
				mCurSightGlassEc.Stop();
			}
			if (!string.IsNullOrEmpty(text2) && InitGlassEffect(text2))
			{
				Vector2 vector2 = uiCamera.WorldToScreenPoint(mCurrentSight.position);
				Vector3 position2 = mainCamera.ScreenToWorldPoint(new Vector3(vector2.x, vector2.y, 10f));
				mCurSightGlassEc.transform.position = position2;
				mCurSightGlassEc.transform.rotation = mainCamera.transform.rotation;
			}
		}
	}

	private bool InitGlassEffect(string path)
	{
		GameObject gameObject = Asset.Instantiate(path);
		if (gameObject == null)
		{
			mCurSightGlassEc = null;
			return false;
		}
		mCurSightGlassEc = gameObject.GetComponent<EffectController>();
		EffectController effectController = mCurSightGlassEc;
		if (effectController != null)
		{
			effectController.Initialize(isLoop: false, 99999f, 1f, EEffectQuality.Fantastic, null);
			effectController.Simulator(0f);
		}
		return effectController;
	}
}

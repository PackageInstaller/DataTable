using System.Collections.Generic;
using Config;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class PartBreakUI : MonoBehaviour, IBattleUIElement
{
	public CanvasGroup canvasGroup;

	public RectTransform mTransform;

	public const string SLIDER_PATH = "";

	public GameObject sliderGO;

	public bool mHasLock;

	public NAgent mTarget;

	public int mLockAgentPart;

	private Camera uiCamera;

	private float mUnlockHideTime = 3f;

	private float mAutoHideTime = 10f;

	private bool mStartTime;

	public bool mInit;

	private Vector3 mDelta;

	private List<BreakUIStruct> mUseItem = new List<BreakUIStruct>();

	private Stack<BreakUIStruct> mStack = new Stack<BreakUIStruct>();

	public P08UISwitch uiSwitch { get; set; }

	public void SetActive(bool isActive, BattleUIElementActiveChangeReason reason)
	{
		uiSwitch.SetActive(isActive, reason);
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

	public void Awake()
	{
		SwitchLogicOnAwake();
		mDelta = new Vector3(0f, (float)Screen.height / 10f, 0f);
		for (int i = 0; i < 1; i++)
		{
			GameObject gameObject = Object.Instantiate(sliderGO, base.transform);
			BreakUIStruct breakUIStruct = new BreakUIStruct();
			breakUIStruct.mSliderGo = gameObject;
			breakUIStruct.mSlider = gameObject.GetComponent<Slider>();
			breakUIStruct.mLockGo = gameObject.transform.Find("LockGo").gameObject;
			breakUIStruct.mBreakGo = gameObject.transform.Find("BreakGo").gameObject;
			mStack.Push(breakUIStruct);
		}
	}

	private void UpdateUI(BreakUIStruct item)
	{
		if (item.mTargetBB.m_NextSimFrameData == null)
		{
			return;
		}
		Transform lockAttachPoint = ComponentIndicator.GetLockAttachPoint(item.mTarget, item.mLockAgentPart);
		if (!(lockAttachPoint != null))
		{
			return;
		}
		Vector3 vector = Camera.main.WorldToScreenPoint(lockAttachPoint.transform.position);
		if (uiCamera == null)
		{
			uiCamera = CanvasManager.Instance.uiCamera;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(mTransform, vector, uiCamera, out var localPoint);
		item.mSliderGo.transform.localPosition = localPoint;
		for (int i = 0; i < item.mTargetBB.m_NextSimFrameData.mShapeStates.Count; i++)
		{
			if (item.mTargetBB.m_NextSimFrameData.mShapeStates[i].mPartType == (ShapePartType)item.mLockAgentPart)
			{
				if (item.mBreakMax == 0)
				{
					item.mSlider.value = (float)item.mTargetBB.m_NextSimFrameData.mShapeStates[i].mDestroyVal / ((float)item.mTargetBB.m_NextSimFrameData.mShapeStates[i].mDestroyValLimit * (float)item.mTargetBB.MaxHP) * 1000f;
				}
				else
				{
					item.mSlider.value = (float)item.mTargetBB.m_NextSimFrameData.mShapeStates[i].mDestroyVal / (float)item.mBreakMax;
				}
			}
		}
	}

	public void Update()
	{
		if (!mInit)
		{
			return;
		}
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager != null)
		{
			if (worldStateManager.hasManualLock)
			{
				if (mTarget == null || worldStateManager.lockedAgentID != mTarget.AgentID || worldStateManager.lockedAgentPart != mLockAgentPart || !mHasLock)
				{
					AddBreakUI(worldStateManager.lockedAgentID, worldStateManager.lockedAgentPart, 9999f);
					mHasLock = true;
				}
			}
			else if (mHasLock)
			{
				RemoveBreakUI();
				mHasLock = false;
			}
		}
		for (int num = mUseItem.Count - 1; num >= 0; num--)
		{
			BreakUIStruct breakUIStruct = mUseItem[num];
			breakUIStruct.mDisableTime -= Time.deltaTime;
			if (breakUIStruct.mDisableTime < 0f)
			{
				breakUIStruct.Reset();
				breakUIStruct.mSliderGo.SetActive(value: false);
				mStack.Push(breakUIStruct);
				mUseItem.RemoveAt(num);
			}
			else
			{
				UpdateUI(breakUIStruct);
			}
		}
	}

	private void SetVisible(bool visible)
	{
		SetActive(visible, BattleUIElementActiveChangeReason.DefaultState);
	}

	public void AddBreakUI(int targetID, int targetPartID, float disableTime, int maxBreak = 0)
	{
		if (!mInit)
		{
			return;
		}
		NAgent agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(targetID);
		if (!(agent != null))
		{
			return;
		}
		if (mStack.Count <= 0)
		{
			GameObject gameObject = Object.Instantiate(sliderGO, base.transform);
			BreakUIStruct breakUIStruct = new BreakUIStruct();
			breakUIStruct.mSliderGo = gameObject;
			breakUIStruct.mSlider = gameObject.GetComponent<Slider>();
			breakUIStruct.mLockGo = gameObject.transform.Find("LockGo").gameObject;
			breakUIStruct.mBreakGo = gameObject.transform.Find("BreakGo").gameObject;
			mStack.Push(breakUIStruct);
		}
		BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
		for (int i = 0; i < bBHumanoid.m_NextSimFrameData.mShapeStates.Count; i++)
		{
			if (bBHumanoid.m_NextSimFrameData.mShapeStates[i].mPartType == (ShapePartType)targetPartID && bBHumanoid.m_NextSimFrameData.mShapeStates[i].mdestroyValChangeRule != 0 && bBHumanoid.m_NextSimFrameData.mShapeStates[i].mDestroyValLimit > 0)
			{
				BreakUIStruct breakUIStruct2 = ((mUseItem.Count > 0) ? mUseItem[0] : mStack.Pop());
				breakUIStruct2.mDisableTime = disableTime;
				breakUIStruct2.mSliderGo.SetActive(value: true);
				breakUIStruct2.mTarget = agent;
				breakUIStruct2.mTargetBB = agent.Blackboard as BBHumanoid;
				breakUIStruct2.mLockAgentPart = targetPartID;
				breakUIStruct2.mBreakMax = maxBreak;
				if (mUseItem.Count == 0)
				{
					mUseItem.Add(breakUIStruct2);
				}
				mTarget = agent;
				mLockAgentPart = targetPartID;
				breakUIStruct2.mBreakGo.SetActive(value: false);
				breakUIStruct2.mLockGo.SetActive(value: false);
				break;
			}
		}
	}

	public void RemoveBreakUI()
	{
		if (mUseItem.Count != 0)
		{
			BreakUIStruct breakUIStruct = mUseItem[0];
			breakUIStruct.Reset();
			breakUIStruct.mSliderGo.SetActive(value: false);
			mStack.Push(breakUIStruct);
			mUseItem.RemoveAt(0);
		}
	}

	public bool GetFirstRuningUI(out BreakUIStruct firstRuningUI)
	{
		if (mUseItem.Count == 0)
		{
			firstRuningUI = null;
			return false;
		}
		firstRuningUI = mUseItem[0];
		return true;
	}

	public void AddLock(int targetID, int targetPartID, float time)
	{
		if (GetFirstRuningUI(out var firstRuningUI) && firstRuningUI.mTarget.AgentID == targetID && firstRuningUI.mLockAgentPart == targetPartID)
		{
			firstRuningUI.mLockGo.SetActive(value: true);
			firstRuningUI.mDisableTime = time;
		}
	}

	public void AddBreak(int targetID, int targetPartID, float time)
	{
		if (GetFirstRuningUI(out var firstRuningUI) && firstRuningUI.mTarget.AgentID == targetID && firstRuningUI.mLockAgentPart == targetPartID)
		{
			firstRuningUI.mBreakGo.SetActive(value: true);
			firstRuningUI.mDisableTime = time;
		}
	}
}

using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.UI;

namespace T0World;

public class T0BedGame : MonoBehaviour
{
	private static T0BedGame mBedGame;

	public Transform likeContentTrans;

	public Transform propContentTrans;

	public Transform handleContentTrans;

	public Button btnExit;

	public ControllerExCollection currentSelectControllerEx;

	private ControllerEx currentController;

	private List<T0BedGameLikeStageItem> likeStageItemList;

	private List<T0BedGameSelectItem> propItemList;

	private List<T0BedGameSelectItem> handleItemList;

	private ControllerExCollection controllerEx;

	private ControllerEx modeController;

	public BedGameContext context;

	private T0BedInteractAreaMgr interactAreaMgr;

	private List<T0InterationBedSelectBase> runInterationList;

	private const string FACE_TIMELINE_ASSET_PATH = "T0World/UITimeLine/104402/{0}";

	private Dictionary<string, GameObject> timelinePool = new Dictionary<string, GameObject>();

	public static T0BedGame bedGame => mBedGame;

	public void RegisterInteration(T0InterationBedSelectBase eventData)
	{
		if (runInterationList == null)
		{
			runInterationList = new List<T0InterationBedSelectBase>();
		}
		runInterationList.Add(eventData);
	}

	public void UnRegisterInteration(T0InterationBedSelectBase eventData)
	{
		if (runInterationList != null && runInterationList.Contains(eventData))
		{
			runInterationList.Remove(eventData);
		}
	}

	public void ClearRunEvent()
	{
		if (runInterationList != null)
		{
			runInterationList.Clear();
		}
	}

	public void InvokeSelectCallback(T0BedClickType clickType)
	{
		if (runInterationList == null)
		{
			return;
		}
		foreach (T0InterationBedSelectBase runInteration in runInterationList)
		{
			runInteration.CheckBedFinishEvent(clickType);
		}
	}

	private void Awake()
	{
		mBedGame = this;
		controllerEx = GetComponent<ControllerExCollection>();
		if ((bool)controllerEx)
		{
			modeController = controllerEx.GetController("mode");
		}
		if (currentSelectControllerEx != null)
		{
			currentController = currentSelectControllerEx.GetController("selectType");
		}
		Init();
	}

	public void UpdateLikeProcess(int updateValue)
	{
		context.checkBeforeLikeValue = context.likeValue;
		context.likeValue += updateValue;
		RefreshLikeStageUI();
	}

	public bool CheckIsMeetLikeFirstArrive(int checkValue)
	{
		bool result = false;
		if (context.likeValue >= checkValue && context.checkBeforeLikeValue < checkValue)
		{
			result = true;
		}
		return result;
	}

	public bool CheckIsMeetLikeValue(int checkValue)
	{
		return context.likeValue >= checkValue;
	}

	private void Init()
	{
		if (context == null)
		{
			context = new BedGameContext();
		}
		context.Init();
		InitInteractArea();
		InitLikeStageUI();
		InitPropList();
		InitHandleList();
		ShowExitBtn(isShow: false);
	}

	private void InitInteractArea()
	{
		if (interactAreaMgr == null)
		{
			interactAreaMgr = new T0BedInteractAreaMgr();
		}
		interactAreaMgr.Init();
		interactAreaMgr.SetClickCallback(OnClickAreaPosItem);
	}

	private void OnClickAreaPosItem(BedPosEnum posType)
	{
		context.currentHandleType = BedHandleEnum.click;
		RefreshHandleUI();
		context.currentPosType = posType;
		InvokeSelectCallback(T0BedClickType.SELECT_BODY_POS);
	}

	private void InitLikeStageUI()
	{
		if (likeStageItemList == null)
		{
			likeStageItemList = new List<T0BedGameLikeStageItem>();
		}
		likeStageItemList.Clear();
		int count = context.likeStageDataList.Count;
		for (int i = 0; i < likeContentTrans.childCount; i++)
		{
			T0BedGameLikeStageItem component = likeContentTrans.GetChild(i).GetComponent<T0BedGameLikeStageItem>();
			if (component != null && i < context.likeStageDataList.Count)
			{
				component.SetData(context.likeStageDataList[i], i == count - 1);
			}
			likeStageItemList.Add(component);
		}
	}

	private void InitPropList()
	{
		if (propItemList == null)
		{
			propItemList = new List<T0BedGameSelectItem>();
		}
		propItemList.Clear();
		for (int i = 0; i < propContentTrans.childCount; i++)
		{
			T0BedGameSelectItem component = propContentTrans.GetChild(i).GetComponent<T0BedGameSelectItem>();
			if (component != null && i < context.propDataList.Count)
			{
				component.InitUI();
				component.SetData(context.propDataList[i]);
				component.SetClickCallback(OnClickSelectItem);
			}
			propItemList.Add(component);
		}
	}

	private void InitHandleList()
	{
		if (handleItemList == null)
		{
			handleItemList = new List<T0BedGameSelectItem>();
		}
		handleItemList.Clear();
		for (int i = 0; i < handleContentTrans.childCount; i++)
		{
			T0BedGameSelectItem component = handleContentTrans.GetChild(i).GetComponent<T0BedGameSelectItem>();
			if (component != null && i < context.handleDataList.Count)
			{
				component.InitUI();
				component.SetData(context.handleDataList[i]);
				component.SetClickCallback(OnClickSelectItem);
			}
			handleItemList.Add(component);
		}
		if (btnExit != null)
		{
			btnExit.onClick.AddListener(delegate
			{
				OnClickExitBtn();
			});
		}
	}

	private void OnClickExitBtn()
	{
		HideHandleArea();
		BedInteractPosGameData bedInteractPosGameData = context.propDataList.Find((BedGamePropSelectData x) => x.propType == context.currentPropType).interactPosDataList.Find((BedInteractPosGameData x) => x.posType == context.currentPosType);
		T0WorldInteractionBehavior component = T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0WorldInteractionBehavior>();
		if (component != null)
		{
			if (bedInteractPosGameData == null)
			{
				return;
			}
			if (bedInteractPosGameData.beginAni == string.Empty)
			{
				InvokeSelectCallback(T0BedClickType.EXIT_HANDLE);
				return;
			}
			component.PlayTimeline(bedInteractPosGameData.returnAni, out var playable, out var _);
			playable.stopped += delegate
			{
				InvokeSelectCallback(T0BedClickType.EXIT_HANDLE);
			};
		}
		else
		{
			InvokeSelectCallback(T0BedClickType.EXIT_HANDLE);
		}
	}

	public void InitData()
	{
		context.Init();
		InitPenPatternContent();
		RefreshUI();
	}

	public void HideHandleArea()
	{
		if (interactAreaMgr != null)
		{
			interactAreaMgr.HideHandleArea();
		}
	}

	public void ShowExitBtn(bool isShow)
	{
		btnExit.gameObject.SetActive(isShow);
	}

	public void RefreshUI()
	{
		RefreshModeUI();
		RefreshLikeStageUI();
		RefreshPropUI();
		RefreshHandleUI();
	}

	public void SetModeUIType(BedSelectEnum selectType)
	{
		context.currentSelectType = selectType;
		RefreshModeUI();
		RefreshPropUI();
	}

	private void RefreshModeUI()
	{
		if (context.currentSelectType == BedSelectEnum.prop)
		{
			modeController.SetSelectedState("prop");
			RefreshInteractAreaUI();
		}
		else if (context.currentSelectType == BedSelectEnum.handle)
		{
			modeController.SetSelectedState("handle");
			interactAreaMgr.HideAllArea();
		}
	}

	private void RefreshLikeStageUI()
	{
		int nowLikeLv = context.GetNowLikeLv();
		int num = context.likeValue;
		for (int i = 0; i < likeStageItemList.Count; i++)
		{
			T0BedGameLikeStageItem t0BedGameLikeStageItem = likeStageItemList[i];
			if (t0BedGameLikeStageItem != null)
			{
				t0BedGameLikeStageItem.UpdateLikeValue(num);
				num -= t0BedGameLikeStageItem.GetTotalLikeValue();
				t0BedGameLikeStageItem.SetLockState(t0BedGameLikeStageItem.stageIndex >= nowLikeLv);
			}
		}
	}

	private void RefreshPropUI()
	{
		int likeValue = context.likeValue;
		for (int i = 0; i < propItemList.Count; i++)
		{
			T0BedGameSelectItem t0BedGameSelectItem = propItemList[i];
			if (t0BedGameSelectItem != null)
			{
				BedGamePropSelectData bedGamePropSelectData = context.propDataList[i];
				bool selectState = bedGamePropSelectData.propType == context.currentPropType;
				t0BedGameSelectItem.SetSelectState(selectState);
				bool flag = likeValue >= bedGamePropSelectData.unlockLikeValue;
				t0BedGameSelectItem.SetLockState(!flag);
			}
		}
	}

	private void RefreshHandleUI()
	{
		for (int i = 0; i < handleItemList.Count; i++)
		{
			T0BedGameSelectItem t0BedGameSelectItem = handleItemList[i];
			if (t0BedGameSelectItem != null)
			{
				bool selectState = context.handleDataList[i].handleType == context.currentHandleType;
				t0BedGameSelectItem.SetSelectState(selectState);
			}
		}
	}

	public void RefreshInteractAreaUI()
	{
		context.IsCanClickUI = true;
		if (interactAreaMgr != null)
		{
			BedGamePropSelectData bedGamePropSelectData = context.propDataList.Find((BedGamePropSelectData x) => x.propType == context.currentPropType);
			if (bedGamePropSelectData != null)
			{
				interactAreaMgr.UpdateAreaList(bedGamePropSelectData);
			}
		}
	}

	private string GetCurrentHandleIdleAni()
	{
		if (context.currentPropType != BedPropEnum.ice)
		{
			return string.Empty;
		}
		if (context.currentHandleType == BedHandleEnum.click)
		{
			T0BedGameIceIdleData t0BedGameIceIdleData = context.gameData.iceData.iceDragToClickDataList.Find((T0BedGameIceIdleData x) => x.posType == context.currentPosType);
			if (t0BedGameIceIdleData != null)
			{
				return t0BedGameIceIdleData.iceIdleAnim;
			}
		}
		else if (context.currentHandleType == BedHandleEnum.drag)
		{
			T0BedGameIceIdleData t0BedGameIceIdleData2 = context.gameData.iceData.iceIdleToDragDataList.Find((T0BedGameIceIdleData x) => x.posType == context.currentPosType);
			if (t0BedGameIceIdleData2 != null)
			{
				return t0BedGameIceIdleData2.iceIdleAnim;
			}
		}
		return string.Empty;
	}

	public string GetHandleBeginAni()
	{
		BedInteractPosGameData bedInteractPosGameData = context.propDataList.Find((BedGamePropSelectData x) => x.propType == context.currentPropType).interactPosDataList.Find((BedInteractPosGameData x) => x.posType == context.currentPosType);
		if (bedInteractPosGameData != null)
		{
			string text = GetCurrentHandleIdleAni();
			if (text == string.Empty)
			{
				text = bedInteractPosGameData.posAni;
			}
			return text;
		}
		return string.Empty;
	}

	public void PlayEnterHandleAni()
	{
		BedInteractPosGameData bedInteractPosGameData = context.propDataList.Find((BedGamePropSelectData x) => x.propType == context.currentPropType).interactPosDataList.Find((BedInteractPosGameData x) => x.posType == context.currentPosType);
		context.IsCanClickUI = false;
		T0WorldInteractionBehavior behaviour = T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0WorldInteractionBehavior>();
		if (!(behaviour != null) || bedInteractPosGameData == null)
		{
			return;
		}
		string idleAni = GetCurrentHandleIdleAni();
		if (idleAni == string.Empty)
		{
			idleAni = bedInteractPosGameData.posAni;
		}
		GameObject timelineGo;
		if (bedInteractPosGameData.beginAni == string.Empty || context.currentSelectType == BedSelectEnum.handle)
		{
			behaviour.PlayTimeline(idleAni, out var _, out timelineGo, DirectorWrapMode.Loop);
			return;
		}
		behaviour.PlayTimeline(bedInteractPosGameData.beginAni, out var playable2, out timelineGo);
		playable2.stopped += delegate
		{
			behaviour.PlayTimeline(idleAni, out var _, out var _, DirectorWrapMode.Loop);
		};
	}

	public void ShowHandleClickPoint()
	{
		context.IsCanClickUI = true;
		if (interactAreaMgr != null)
		{
			BedInteractPosGameData bedInteractPosGameData = context.propDataList.Find((BedGamePropSelectData x) => x.propType == context.currentPropType).interactPosDataList.Find((BedInteractPosGameData x) => x.posType == context.currentPosType);
			interactAreaMgr.SetHandleAreaPos(bedInteractPosGameData.handlePointPos);
		}
	}

	public void OnClickSelectItem(int selectID, BedSelectEnum selectType)
	{
		if (!context.IsCanClickUI)
		{
			return;
		}
		switch (selectType)
		{
		case BedSelectEnum.prop:
		{
			currentController.SetSelectedIndex(selectID - 1);
			BedGamePropSelectData bedGamePropSelectData = context.propDataList.Find((BedGamePropSelectData x) => x.selectID == selectID);
			if (bedGamePropSelectData != null)
			{
				context.currentPropType = bedGamePropSelectData.propType;
				RefreshPropUI();
			}
			context.currentPosType = BedPosEnum.none;
			InvokeSelectCallback(T0BedClickType.SELECT_PROP);
			break;
		}
		case BedSelectEnum.handle:
		{
			BedGameHandleSelectData bedGameHandleSelectData = context.handleDataList.Find((BedGameHandleSelectData x) => x.selectID == selectID);
			if (context.currentHandleType != bedGameHandleSelectData.handleType)
			{
				if (bedGameHandleSelectData != null)
				{
					ChangeSelectHandle(bedGameHandleSelectData.handleType);
					context.currentHandleType = bedGameHandleSelectData.handleType;
					RefreshHandleUI();
				}
				InvokeSelectCallback(T0BedClickType.SELECT_HANDLE);
			}
			break;
		}
		}
	}

	private void ChangeSelectHandle(BedHandleEnum handleType)
	{
		if (context.currentPropType != BedPropEnum.ice)
		{
			return;
		}
		T0WorldInteractionBehavior behaviour = T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0WorldInteractionBehavior>();
		if (!(behaviour != null))
		{
			return;
		}
		PlayableDirector playable;
		GameObject timelineGo;
		switch (handleType)
		{
		case BedHandleEnum.click:
		{
			T0BedGameIceIdleData dragToClickData = context.gameData.iceData.iceDragToClickDataList.Find((T0BedGameIceIdleData x) => x.posType == context.currentPosType);
			if (dragToClickData != null)
			{
				behaviour.PlayTimeline(dragToClickData.iceTransitionAnim, out playable, out timelineGo);
				playable.stopped += delegate
				{
					behaviour.PlayTimeline(dragToClickData.iceIdleAnim, out var _, out var _, DirectorWrapMode.Loop);
				};
			}
			break;
		}
		case BedHandleEnum.drag:
		{
			T0BedGameIceIdleData clickToDragData = context.gameData.iceData.iceIdleToDragDataList.Find((T0BedGameIceIdleData x) => x.posType == context.currentPosType);
			if (clickToDragData != null)
			{
				behaviour.PlayTimeline(clickToDragData.iceTransitionAnim, out playable, out timelineGo);
				playable.stopped += delegate
				{
					behaviour.PlayTimeline(clickToDragData.iceIdleAnim, out var _, out var _, DirectorWrapMode.Loop);
				};
			}
			break;
		}
		}
	}

	public void InitPenPatternContent()
	{
		if (context == null)
		{
			return;
		}
		Transform transform = T0WorldScene.Scene.agentManager.CharacteraAgent.transform;
		foreach (string showPenPatternKey in context.showPenPatternKeyList)
		{
			Transform transform2 = transform.Find(showPenPatternKey);
			if (transform2 != null)
			{
				transform2.SetActive(bActive: false);
			}
		}
		context.showPenPatternKeyList.Clear();
	}

	public bool IsHavePenPattern(string patternKey)
	{
		if (context == null)
		{
			return false;
		}
		return context.showPenPatternKeyList.Contains(patternKey);
	}

	public void AddPenPattern(string patternKey)
	{
		context.showPenPatternKeyList.Add(patternKey);
	}

	public void Dispose()
	{
		ClearTimelinePool();
		InitPenPatternContent();
		ClearRunEvent();
		context = null;
		if (interactAreaMgr != null)
		{
			interactAreaMgr.Dispose();
			interactAreaMgr = null;
		}
		if (likeStageItemList != null)
		{
			for (int i = 0; i < likeStageItemList.Count; i++)
			{
				likeStageItemList[i].Dispose();
			}
			likeStageItemList.Clear();
			likeStageItemList = null;
		}
		if (propItemList != null)
		{
			for (int j = 0; j < propItemList.Count; j++)
			{
				propItemList[j].Dispose();
			}
			propItemList.Clear();
			propItemList = null;
		}
		if (handleItemList != null)
		{
			for (int k = 0; k < handleItemList.Count; k++)
			{
				handleItemList[k].Dispose();
			}
			handleItemList.Clear();
			handleItemList = null;
		}
		mBedGame = null;
		Object.Destroy(base.gameObject);
	}

	public GameObject GetTimelineGo(string timeLineName)
	{
		GameObject gameObject = null;
		if (timelinePool.ContainsKey(timeLineName))
		{
			gameObject = timelinePool[timeLineName];
		}
		if (gameObject == null)
		{
			GameObject gameObject2 = Asset.Load<GameObject>($"T0World/UITimeLine/104402/{timeLineName}");
			if (gameObject2 != null)
			{
				gameObject = Object.Instantiate(gameObject2);
				gameObject.name = timeLineName;
				timelinePool.Add(timeLineName, gameObject);
				gameObject.transform.SetParent(context.faceTimeLineTrans);
				gameObject.transform.localPosition = Vector3.zero;
				gameObject.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
				gameObject.transform.localScale = Vector3.one;
			}
		}
		return gameObject;
	}

	public void PlayEmoji()
	{
		if (context == null || context.gameData == null || context.gameData.emotionDataList == null)
		{
			return;
		}
		BedGamePropSelectData bedGamePropSelectData = context.propDataList?.Find((BedGamePropSelectData x) => x.propType == context.currentPropType);
		if (bedGamePropSelectData == null || bedGamePropSelectData.interactPosDataList == null)
		{
			return;
		}
		BedInteractPosGameData bedInteractPosGameData = bedGamePropSelectData.interactPosDataList.Find((BedInteractPosGameData x) => x.posType == context.currentPosType);
		if (bedInteractPosGameData != null && bedInteractPosGameData.selectedEmotions != null && bedInteractPosGameData.selectedEmotions.Count > 0)
		{
			int index = Random.Range(0, bedInteractPosGameData.selectedEmotions.Count);
			string emotionName = bedInteractPosGameData.selectedEmotions[index];
			T0BedGameEmotionData t0BedGameEmotionData = context.gameData.emotionDataList.Find((T0BedGameEmotionData x) => x.emotionName == emotionName);
			if (t0BedGameEmotionData != null && !string.IsNullOrEmpty(t0BedGameEmotionData.emotionAnim))
			{
				PlayFaceTimeline(t0BedGameEmotionData.emotionAnim);
			}
		}
	}

	public void PlayFaceTimeline(string faceName)
	{
		GameObject timelineGo = GetTimelineGo(faceName);
		if (!(timelineGo == null))
		{
			timelineGo.SetActive(value: true);
			PlayableDirector component = timelineGo.GetComponent<PlayableDirector>();
			T0WorldInteractionBehavior component2 = T0WorldScene.Scene.agentManager.CharacteraAgent.GetComponent<T0WorldInteractionBehavior>();
			component2.brain.BindPlayableDirector(component);
			component2.brain.RebuildPlayableDirector(component);
			component.extrapolationMode = DirectorWrapMode.None;
			component.Play();
			component.Evaluate();
		}
	}

	public void StopEmoji()
	{
		if (timelinePool == null)
		{
			return;
		}
		foreach (GameObject value in timelinePool.Values)
		{
			if (value != null && value.activeSelf)
			{
				PlayableDirector component = value.GetComponent<PlayableDirector>();
				if (component != null && component.state == PlayState.Playing)
				{
					component.Stop();
				}
				value.SetActive(value: false);
			}
		}
	}

	private void ClearTimelinePool()
	{
		if (timelinePool == null)
		{
			return;
		}
		foreach (GameObject value in timelinePool.Values)
		{
			if (value != null)
			{
				Object.Destroy(value);
			}
		}
		timelinePool.Clear();
	}
}

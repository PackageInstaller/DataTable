using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using ControllerExSpace;
using CriMana;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardGameMain : MonoBehaviour
{
	private class RollbackPreservedState
	{
		public List<RogueCardSaveCardData> DeckCards;

		public List<RogueCardSaveCardData> PileCards;

		public List<RogueCardSaveCardData> HandCards;

		public List<RogueCardSaveJokerData> Jokers;

		public int Gold;

		public List<int> RecordItems;
	}

	public DeterministicRandom randomSystem;

	public RogueCardSaveSystem saveSystem;

	public RogueCardGuideSystem guideSystem;

	private StateMachine mainStateMachine;

	public RogueJokerHolder jokerHolder;

	[HideInInspector]
	public List<Tuple<RogueCardData, RogueCardData>> copyToDeckQueue = new List<Tuple<RogueCardData, RogueCardData>>();

	[HideInInspector]
	public List<Tuple<RogueCardData, RogueCardData>> copyToHandQueue = new List<Tuple<RogueCardData, RogueCardData>>();

	public Dictionary<RogueCardData, RogueCardJokerData> copyDestToJokerMap = new Dictionary<RogueCardData, RogueCardJokerData>();

	[HideInInspector]
	public List<RogueCardData> tempCopiedCards = new List<RogueCardData>();

	private readonly List<RogueCardData> pendingRankDrawCards = new List<RogueCardData>();

	private bool isRankDrawAnimationQueued;

	public RogueCardGameContext gameContext;

	[HideInInspector]
	public int curPackageID;

	[HideInInspector]
	public int playerHandle;

	private bool _isHandle;

	private int deferredRefreshUICount;

	private bool hasPendingRefreshUI;

	private int pendingDiscardNumDisplayOffset;

	private int stageUseTimeBaseSeconds;

	private float stageUseTimeStartRealtime;

	private Queue<GameObject> tempCardPool = new Queue<GameObject>();

	private HashSet<GameObject> activeTempCards = new HashSet<GameObject>();

	private InputLockToken wuChangMovieLock;

	private bool wuChangMovieEnd;

	private HashSet<InputLockToken> activeInputLocks = new HashSet<InputLockToken>();

	private InputLockToken pendingDrawLock;

	public RogueCardStateUIBase curStateUI;

	[Header("绑定UI")]
	public Transform storyContent;

	[HideInInspector]
	public RogueCardStoryBaseUI storyUI;

	public List<RogueCardStateUIBase> stateUIList;

	public Animator mainAni;

	public GameObject storyResultGo;

	public Text storyResultText;

	public GameObject suitLvUpGo;

	public Text suitLvUpText;

	public Text targetScore;

	public RollingNumber curScore;

	public GameObject infScoreText;

	public Text lastPlayNum;

	public Animator lastPlayAni;

	public GameObject playNumFly;

	public Text lastPlayFlyText;

	public Text lastPlayFlyText2;

	public Text lastDiscardNum;

	public Animator lastDiscardAni;

	public GameObject discardNumFly;

	public Text lastDiscardFlyText;

	public Text lastDiscardFlyText2;

	public Animator goldAni;

	public GameObject goldNumFly;

	public Text goldFlyText;

	public Text goldFlyText2;

	public RollingNumber goldNum;

	public Text deckInfo;

	public Text jokerNum;

	public Animator jokerNumAni;

	public Text wealNum;

	public Text woeDesc;

	public Button jokerSortBtn;

	public ControllerExCollection controllerEx;

	public ControllerExCollection jokerSlotEx;

	public GameObject playContentGo;

	public GameObject storyContentGo;

	public Button playContentBtn;

	public Button storyContentBtn;

	public RogueCardCommonTipItem commonTip;

	public Transform jokerTipTrans;

	public Transform cardTipTrans;

	public Button battleInfoBtn;

	public GameObject woeTipGo;

	public Animator woeTipAnimator;

	public Text woeTipText;

	public Text wealNumText;

	public Button wealTipBtn;

	public GameObject wealTipGo;

	public Transform wealTipContent;

	public GameObject wealTipItem;

	public List<Text> wealTextList;

	public List<GameObject> wealGoList;

	public RectTransform jokerSellTrans;

	public ControllerExCollection jokerSellEx;

	public Text jokerSellText;

	[HideInInspector]
	public ControllerEx jokerSellStateCon;

	[HideInInspector]
	public ControllerEx jokerSlotCon;

	[HideInInspector]
	public ControllerEx bgCon;

	[HideInInspector]
	public ControllerEx jokerSellCon;

	[HideInInspector]
	public ControllerEx resultCon;

	[HideInInspector]
	public ControllerEx resultTipCon;

	[HideInInspector]
	public bool isWuChangComplete;

	[HideInInspector]
	public bool isWuChangCopyAnimating;

	[HideInInspector]
	public bool suppressRoundStartForceSelectRefresh;

	[HideInInspector]
	public float CardDrawDuration = 1f;

	[HideInInspector]
	public float CalScoreDuration = 4f;

	[HideInInspector]
	public bool isAniSpeedUp;

	[HideInInspector]
	public bool isPlayingAni;

	[HideInInspector]
	public bool isShowingScore;

	public RogueCardVisualCardHandler wuChangPackageCardHandler;

	public RogueCardVisualCardHandler wuChangCardHandler;

	public RogueCardVisualCardHandler jokerCardHandler;

	public RogueCardVisualCardHandler handCardHandler;

	public Button backgroundBtn;

	public Transform movieContentTrs;

	public GameObject movieTip;

	public Button movieBtn;

	private GameObject movieGo;

	private CriManaMovieControllerForUI movieController;

	private Player moviePlayer;

	[Header("常规Tips")]
	public RogueCardCommonTipButton goldCommonTipBtn;

	public RogueCardCommonTipButton cardCommonTipBtn;

	public RogueCardCommonTipButton woeCommonTipBtn;

	public RogueCardCommonTipButton woeCommonTipBtn2;

	public RogueCardCommonTipButton wealCommonTipBtn;

	public RogueCardCommonTipButton scoreCommonTipBtn;

	public Transform[] commonTipTrans = new Transform[5];

	[HideInInspector]
	public bool storyMode;

	public Text mainTitle;

	public Text clueTitle;

	[Header("手牌移动点")]
	public Transform deckOutPoint;

	public Transform deckTransPoint;

	public Transform cardEndPoint;

	public Transform[] cardScorePoint = new Transform[5];

	public Transform goldFlyStartPoint;

	public Transform goldFlyEndPoint;

	public GameObject goldFlyGo;

	[Header("抽牌动画设置")]
	[SerializeField]
	private AnimationCurve cardDrawCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	public GameObject cardVisualPrefab;

	public Image deckImg;

	private bool activeSettle;

	[HideInInspector]
	public List<int> score_maxRoundScore;

	[HideInInspector]
	public List<float> score_diffScore;

	[HideInInspector]
	public float movieVolume;

	[HideInInspector]
	public float score_ratio;

	[HideInInspector]
	public float challenge_target_score_ratio;

	[HideInInspector]
	public int max_round_score;

	[HideInInspector]
	public int rollBackMaxNum = 5;

	[HideInInspector]
	public int rollBackGainGold = 10;

	[Header("强化覆盖弹窗")]
	public GameObject enhanceWindowGo;

	public Button enhanceWindowYesBtn;

	public Button enhanceWindowNoBtn;

	public Button enhanceWindowRepeatBtn;

	public GameObject enhanceWindowRepeatYesGo;

	public GameObject enhanceWindowRepeatNoGo;

	public Text enhanceWindowText;

	private bool enhanceWindowNoRepeat;

	private InputLockToken enhanceWindowLock;

	private Action<bool> enhanceWindowCallback;

	public bool notScore;

	private PointerEventData _cachedPointerData;

	private List<RaycastResult> _cachedRaycastResults = new List<RaycastResult>();

	private bool hasForcedDeckUICount;

	private int forcedDeckUICount;

	private bool isSettleAni;

	[Header("======局内GM======")]
	public bool NoWuChangMovie;

	public string gmStr;

	public static RogueCardGameMain Instance { get; private set; }

	public static RogueCardGameContext GameContext => Instance.gameContext;

	public static DeterministicRandom Random => Instance.randomSystem;

	public IState CurState => mainStateMachine.GetCurrentState();

	public IState LastState => mainStateMachine?.GetLastState();

	[HideInInspector]
	public bool isHandle
	{
		get
		{
			return _isHandle;
		}
		set
		{
			_isHandle = value;
		}
	}

	public bool ActiveSettle => activeSettle;

	public bool IsSettleAni => isSettleAni;

	public GameObject GetTempRogueCard(Transform parent)
	{
		GameObject gameObject;
		if (tempCardPool.Count > 0)
		{
			gameObject = tempCardPool.Dequeue();
			gameObject.transform.SetParent(parent, worldPositionStays: false);
		}
		else
		{
			gameObject = UnityEngine.Object.Instantiate(cardVisualPrefab, parent);
		}
		gameObject.SetActive(value: true);
		try
		{
			activeTempCards.Add(gameObject);
		}
		catch (Exception)
		{
		}
		gameObject.transform.localScale = Vector3.one;
		gameObject.transform.localRotation = Quaternion.identity;
		gameObject.transform.localPosition = Vector3.zero;
		gameObject.transform.SetAsLastSibling();
		VisualRogueCard component = gameObject.GetComponent<VisualRogueCard>();
		if (component != null)
		{
			component.enabled = false;
			if (component.view != null)
			{
				component.view.transform.localRotation = Quaternion.identity;
				component.view.transform.localScale = Vector3.one;
				component.view.transform.localPosition = Vector3.zero;
				if (component.view.animator != null)
				{
					component.view.animator.Rebind();
					component.view.animator.Play("empty", -1, 0f);
					component.view.animator.Update(0f);
				}
				if (component.view.rootAni != null)
				{
					component.view.rootAni.Rebind();
					component.view.rootAni.Play("empty", -1, 0f);
					component.view.rootAni.Update(0f);
				}
			}
			component.SetSelect(isSelect: false);
		}
		return gameObject;
	}

	public void ReleaseTempRogueCard(GameObject obj)
	{
		if (obj == null)
		{
			return;
		}
		LeanTween.cancel(obj);
		VisualRogueCard component = obj.GetComponent<VisualRogueCard>();
		if (component != null && component.view != null)
		{
			try
			{
				component.view.transform.localRotation = Quaternion.identity;
				component.view.transform.localScale = Vector3.one;
				component.view.transform.localPosition = Vector3.zero;
				if (component.view.animator != null && component.view.animator.isActiveAndEnabled && component.view.animator.gameObject.activeInHierarchy)
				{
					component.view.animator.Rebind();
					component.view.animator.Play("empty", -1, 0f);
					component.view.animator.Update(0f);
				}
				if (component.view.rootAni != null && component.view.rootAni.isActiveAndEnabled && component.view.rootAni.gameObject.activeInHierarchy)
				{
					component.view.rootAni.Rebind();
					component.view.rootAni.Play("empty", -1, 0f);
					component.view.rootAni.Update(0f);
				}
				component.SetSelect(isSelect: false);
			}
			catch (Exception)
			{
			}
		}
		obj.SetActive(value: false);
		obj.transform.SetParent(base.transform, worldPositionStays: false);
		obj.transform.localPosition = Vector3.zero;
		obj.transform.localRotation = Quaternion.identity;
		obj.transform.localScale = Vector3.one;
		try
		{
			activeTempCards.Remove(obj);
		}
		catch (Exception)
		{
		}
		tempCardPool.Enqueue(obj);
	}

	public void ClearAllTempRogueCards()
	{
		if (activeTempCards == null || activeTempCards.Count == 0)
		{
			if (tempCopiedCards != null)
			{
				tempCopiedCards.Clear();
			}
			return;
		}
		GameObject[] array = new GameObject[activeTempCards.Count];
		activeTempCards.CopyTo(array);
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (gameObject == null)
			{
				continue;
			}
			try
			{
				ReleaseTempRogueCard(gameObject);
			}
			catch (Exception ex)
			{
				Debug.LogWarning("ClearAllTempRogueCards failed to release temp card: " + ex.Message);
				try
				{
					UnityEngine.Object.Destroy(gameObject);
				}
				catch (Exception)
				{
				}
				try
				{
					activeTempCards.Remove(gameObject);
				}
				catch (Exception)
				{
				}
			}
		}
		if (tempCopiedCards != null)
		{
			tempCopiedCards.Clear();
		}
	}

	public InputLockToken GetInputLock(string lockName, GameObject boundObject = null, float timeout = 5f, bool ignoreError = false)
	{
		InputLockToken inputLockToken = new InputLockToken(lockName, ignoreError);
		activeInputLocks.Add(inputLockToken);
		playerHandle++;
		if (boundObject != null)
		{
			InputLockWatcher inputLockWatcher = boundObject.GetComponent<InputLockWatcher>();
			if (inputLockWatcher == null)
			{
				inputLockWatcher = boundObject.AddComponent<InputLockWatcher>();
			}
			inputLockWatcher.Watch(inputLockToken);
		}
		if (timeout > 0f)
		{
			StartCoroutine(AutoReleaseLockRoutine(inputLockToken, timeout));
		}
		return inputLockToken;
	}

	public InputLockToken ReserveDrawLock(GameObject boundObject = null, float timeout = 5f)
	{
		if (pendingDrawLock != null && !pendingDrawLock.isReleased)
		{
			return pendingDrawLock;
		}
		pendingDrawLock = GetInputLock("drawCardLock_reserved", boundObject, timeout);
		return pendingDrawLock;
	}

	public void ReleaseInputLock(InputLockToken token)
	{
		if (activeInputLocks.Contains(token))
		{
			activeInputLocks.Remove(token);
			playerHandle = Mathf.Max(0, playerHandle - 1);
		}
	}

	private void ReleaseAllInputLocks()
	{
		if (pendingDrawLock != null && !pendingDrawLock.isReleased)
		{
			pendingDrawLock.Release();
		}
		pendingDrawLock = null;
		if (activeInputLocks.Count > 0)
		{
			List<InputLockToken> list = new List<InputLockToken>(activeInputLocks);
			for (int i = 0; i < list.Count; i++)
			{
				InputLockToken inputLockToken = list[i];
				if (inputLockToken != null && !inputLockToken.isReleased)
				{
					inputLockToken.Release();
				}
			}
			activeInputLocks.Clear();
		}
		playerHandle = 0;
	}

	private IEnumerator AutoReleaseLockRoutine(InputLockToken token, float timeout)
	{
		yield return new WaitForSeconds(timeout);
		if (!token.isReleased && activeInputLocks.Contains(token))
		{
			if (!token.ignoreError)
			{
				Debug.Log($"[InputLock] 安全锁 '{token.lockName}' 超时 ({timeout}s)！已强制释放。这通常意味着某个动画协程报错，或者LeanTween中断。");
			}
			token.Release();
		}
	}

	public static bool CheckDisableInput()
	{
		if (Instance.playerHandle > 0)
		{
			return true;
		}
		if (Instance.guideSystem != null && Instance.guideSystem.IsGuiding && Instance.guideSystem.isLock && Instance.guideSystem.lockType != LockItemType.None)
		{
			return true;
		}
		return false;
	}

	public static bool CheckDisableInput(LockItemType type, int index)
	{
		if (Instance.playerHandle > 0)
		{
			return true;
		}
		if (Instance.guideSystem != null && Instance.guideSystem.IsGuiding && Instance.guideSystem.isLock)
		{
			return Instance.guideSystem.CheckInput(type, index);
		}
		return false;
	}

	private void Awake()
	{
		Instance = this;
		goldCommonTipBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				commonTip.RefreshUI(commonTipTrans[0], "ROGUE_CARD_GOLD_TIPS", goldCommonTipBtn);
			}
		});
		cardCommonTipBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				commonTip.RefreshUI(commonTipTrans[1], "ROGUE_CARD_HAND_AND_DISCARD_TIPS", cardCommonTipBtn);
			}
		});
		woeCommonTipBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				commonTip.RefreshUI(commonTipTrans[3], "ROGUE_CARD_HUO_TIPS", woeCommonTipBtn);
			}
		});
		woeCommonTipBtn2.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				commonTip.RefreshUI(commonTipTrans[3], "ROGUE_CARD_HUO_TIPS", woeCommonTipBtn2);
			}
		});
		wealCommonTipBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				commonTip.RefreshUI(commonTipTrans[4], "ROGUE_CARD_EN_TIPS", wealCommonTipBtn);
			}
		});
		scoreCommonTipBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				commonTip.RefreshUI(commonTipTrans[2], "ROGUE_CARD_SCORE_TIPS", scoreCommonTipBtn);
			}
		});
		if (enhanceWindowYesBtn != null)
		{
			enhanceWindowYesBtn.onClick.AddListener(delegate
			{
				CloseEnhanceWindow(isConfirm: true);
			});
		}
		if (enhanceWindowNoBtn != null)
		{
			enhanceWindowNoBtn.onClick.AddListener(delegate
			{
				CloseEnhanceWindow(isConfirm: false);
			});
		}
		if (enhanceWindowRepeatBtn != null)
		{
			enhanceWindowRepeatBtn.onClick.AddListener(delegate
			{
				enhanceWindowNoRepeat = !enhanceWindowNoRepeat;
				RefreshEnhanceWindowRepeatState();
			});
		}
		RefreshEnhanceWindowRepeatState();
		if (enhanceWindowGo != null)
		{
			enhanceWindowGo.SetActive(value: false);
			LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", false);
		}
		movieBtn.onClick.AddListener(delegate
		{
			if (movieTip.gameObject.activeSelf)
			{
				EndWuChangMovie();
			}
			else
			{
				movieTip.gameObject.SetActive(value: true);
			}
		});
		jokerSortBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				gameContext.SortJokerCard();
				RefreshUI();
			}
		});
		playContentBtn.onClick.AddListener(delegate
		{
			SwitchStoryModule(isStory: false);
		});
		storyContentBtn.onClick.AddListener(delegate
		{
			SwitchStoryModule(isStory: true);
		});
		wealTipBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				wealTipGo.SetActive(value: true);
			}
		});
		battleInfoBtn.onClick.AddListener(delegate
		{
			if (!CheckDisableInput())
			{
				LuaHelper.CallFunction("RogueCardGameBridge.OpenBattleInfo");
				HideTips();
			}
		});
		for (int num = 0; num < stateUIList.Count; num++)
		{
			stateUIList[num].Init();
		}
		RogueCardTipSystem.Init();
		RogueCardTimeSystem.Init();
		guideSystem = new RogueCardGuideSystem();
		guideSystem.Init();
		bgCon = controllerEx.GetController("bg");
		jokerSellCon = controllerEx.GetController("shoppoint");
		resultCon = controllerEx.GetController("Result");
		resultTipCon = controllerEx.GetController("ResultTip");
		jokerSellStateCon = jokerSellEx.GetController("shoppoint");
		jokerSlotCon = jokerSlotEx.GetController("empty");
		jokerNum.UnregisterDirtyVerticesCallback(OnJokerNumChange);
		jokerNum.RegisterDirtyVerticesCallback(OnJokerNumChange);
		lastPlayNum.UnregisterDirtyVerticesCallback(OnPlayNumChange);
		lastPlayNum.RegisterDirtyVerticesCallback(OnPlayNumChange);
		lastDiscardNum.UnregisterDirtyVerticesCallback(OnDiscardNumChange);
		lastDiscardNum.RegisterDirtyVerticesCallback(OnDiscardNumChange);
		mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOADING_TITLE");
		object[] array = LuaHelper.CallFunction("RogueCardGameBridge.GetScoreStageData");
		score_maxRoundScore = new List<int>();
		object[] array2 = array;
		for (int num2 = 0; num2 < array2.Length; num2++)
		{
			LuaTable luaTable = array2[num2] as LuaTable;
			for (int num3 = 1; num3 <= luaTable.Length; num3++)
			{
				score_maxRoundScore.Add((int)(double)luaTable[num3]);
			}
		}
		array2 = LuaHelper.CallFunction("RogueCardGameBridge.GetScoreRatioData");
		for (int num2 = 0; num2 < array2.Length; num2++)
		{
			LuaTable luaTable2 = array2[num2] as LuaTable;
			score_ratio = (float)(double)luaTable2[1];
		}
		array2 = LuaHelper.CallFunction("RogueCardGameBridge.GetRollbackData");
		for (int num2 = 0; num2 < array2.Length; num2++)
		{
			LuaTable luaTable3 = array2[num2] as LuaTable;
			rollBackMaxNum = (int)(double)luaTable3[1];
			rollBackGainGold = (int)(double)luaTable3[2];
		}
		array2 = LuaHelper.CallFunction("RogueCardGameBridge.GetChallengeScoreData");
		for (int num2 = 0; num2 < array2.Length; num2++)
		{
			LuaTable luaTable4 = array2[num2] as LuaTable;
			challenge_target_score_ratio = (float)(double)luaTable4[1];
			max_round_score = (int)(double)luaTable4[2];
		}
		object[] array3 = LuaHelper.CallFunction("RogueCardGameBridge.GetScoreDifficultData");
		score_diffScore = new List<float>();
		array2 = array3;
		for (int num2 = 0; num2 < array2.Length; num2++)
		{
			LuaTable luaTable5 = array2[num2] as LuaTable;
			for (int num4 = 1; num4 <= luaTable5.Length; num4++)
			{
				score_diffScore.Add((float)(double)luaTable5[num4]);
			}
		}
		object[] array4 = LuaHelper.CallFunction("RogueCardGameBridge.GetVolume");
		movieVolume = (float)(double)array4[0];
	}

	private void OnJokerNumChange()
	{
		jokerNumAni.Play("UI_textnum02_cx", 0, 0f);
	}

	private void OnPlayNumChange()
	{
	}

	private void OnDiscardNumChange()
	{
	}

	private void OnGoldNumChange(int num1, int num2)
	{
		if (num1 != num2)
		{
			if (goldAni != null && goldAni.isActiveAndEnabled && goldAni.gameObject.activeInHierarchy)
			{
				goldAni.Play("UI_text", 0, 0f);
			}
			goldFlyText.text = (num2 - num1).ToString("+0;-0;0");
			goldFlyText2.text = (num2 - num1).ToString("+0;-0;0");
			goldNumFly.SetActive(value: false);
			goldNumFly.SetActive(value: true);
			AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_coin", useStream: false);
		}
	}

	private void Update()
	{
		if (mainStateMachine != null)
		{
			mainStateMachine.Update();
		}
		if (RogueCardTimeSystem.isPlayingAni)
		{
			RogueCardTimeSystem.Update();
		}
		if ((!Input.GetMouseButtonDown(0) && !Input.GetMouseButtonDown(1)) || !(EventSystem.current != null) || CheckDisableInput())
		{
			return;
		}
		if (_cachedPointerData == null)
		{
			_cachedPointerData = new PointerEventData(EventSystem.current);
		}
		_cachedPointerData.position = Input.mousePosition;
		_cachedRaycastResults.Clear();
		EventSystem.current.RaycastAll(_cachedPointerData, _cachedRaycastResults);
		if (_cachedRaycastResults.Count <= 0)
		{
			return;
		}
		GameObject gameObject = _cachedRaycastResults[0].gameObject;
		if (wealTipGo.activeSelf)
		{
			bool flag = true;
			foreach (RaycastResult cachedRaycastResult in _cachedRaycastResults)
			{
				if (cachedRaycastResult.gameObject.name == "SVTips")
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				wealTipGo.SetActive(value: false);
			}
		}
		if (storyMode && gameObject.transform.IsChildOf(playContentGo.transform))
		{
			SwitchStoryModule(isStory: false);
		}
		else if (!storyMode && gameObject.transform.IsChildOf(storyContentGo.transform))
		{
			SwitchStoryModule(isStory: true);
		}
	}

	public void OnDisable()
	{
		ResetEnhanceWindowState();
		ReleaseAllInputLocks();
		guideSystem?.OnDispose();
		RogueCardTimeSystem.Reset();
		mainAni.Rebind();
	}

	public void OnDispose()
	{
		RogueCardEffectManager.Instance.ResetForNewGame();
		gameContext?.OnDispose();
		guideSystem?.OnDispose();
		RogueCardTimeSystem.Reset();
		jokerHolder?.OnDispose();
		storyUI?.OnDispose();
		UnityEngine.Object.Destroy(storyUI?.gameObject);
		storyUI = null;
	}

	public void GameInit(int stageID, string saveData, string rollbackData, bool isGuide)
	{
		ResetEnhanceWindowState();
		OnDispose();
		RogueCardEffectManager.Instance.ResetForNewGame();
		mainStateMachine = new StateMachine();
		StartGame(stageID, saveData, rollbackData, isGuide);
		SwitchStoryModule(isStory: true);
		AtlasManager.GetSpriteWithoutAtlas(deckImg, $"TextureConfig/Activity_JokerCard/itembg/rogue_card_back_{gameContext.rogueDeck.deckID}");
	}

	public void GameInit(int stageID, int deckID, int difficulty, bool isGuide)
	{
		ResetEnhanceWindowState();
		OnDispose();
		RogueCardEffectManager.Instance.ResetForNewGame();
		mainStateMachine = new StateMachine();
		if (deckID < 1)
		{
			deckID = 1;
		}
		StartGame(stageID, deckID, difficulty, isGuide);
		SwitchStoryModule(isStory: true);
		AtlasManager.GetSpriteWithoutAtlas(deckImg, $"TextureConfig/Activity_JokerCard/itembg/rogue_card_back_{gameContext.rogueDeck.deckID}");
	}

	public void OnDestroy()
	{
		ResetEnhanceWindowState();
		ReleaseAllInputLocks();
		RogueCardEffectManager.Instance.ResetForNewGame();
		guideSystem?.OnDispose();
		RogueCardTimeSystem.Reset();
		activeTempCards?.Clear();
		tempCardPool?.Clear();
		tempCopiedCards?.Clear();
		copyToDeckQueue?.Clear();
		copyToHandQueue?.Clear();
		copyDestToJokerMap?.Clear();
		if (jokerNum != null)
		{
			jokerNum.UnregisterDirtyVerticesCallback(OnJokerNumChange);
		}
		if (lastPlayNum != null)
		{
			lastPlayNum.UnregisterDirtyVerticesCallback(OnPlayNumChange);
		}
		if (lastDiscardNum != null)
		{
			lastDiscardNum.UnregisterDirtyVerticesCallback(OnDiscardNumChange);
		}
		if (Instance == this)
		{
			Instance = null;
		}
	}

	private void RefreshEnhanceWindowRepeatState()
	{
		if (enhanceWindowRepeatYesGo != null)
		{
			enhanceWindowRepeatYesGo.SetActive(enhanceWindowNoRepeat);
		}
		if (enhanceWindowRepeatNoGo != null)
		{
			enhanceWindowRepeatNoGo.SetActive(!enhanceWindowNoRepeat);
		}
	}

	private void ResetEnhanceWindowState()
	{
		enhanceWindowNoRepeat = false;
		enhanceWindowCallback = null;
		if (enhanceWindowGo != null)
		{
			enhanceWindowGo.SetActive(value: false);
			LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", false);
		}
		if (enhanceWindowLock != null && !enhanceWindowLock.isReleased)
		{
			enhanceWindowLock.Release();
		}
		enhanceWindowLock = null;
		RefreshEnhanceWindowRepeatState();
	}

	private void CloseEnhanceWindow(bool isConfirm)
	{
		if (enhanceWindowGo != null)
		{
			enhanceWindowGo.SetActive(value: false);
			LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", false);
		}
		Action<bool> action = enhanceWindowCallback;
		enhanceWindowCallback = null;
		if (enhanceWindowLock != null && !enhanceWindowLock.isReleased)
		{
			enhanceWindowLock.Release();
		}
		enhanceWindowLock = null;
		action?.Invoke(isConfirm);
	}

	private bool TryGetBlackWuChangCoverType(int blackWuChangID, List<RogueCardData> cards, out EnhanceType coverType)
	{
		coverType = (EnhanceType)0;
		if (blackWuChangID <= 0 || cards == null || cards.Count <= 0)
		{
			return false;
		}
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == blackWuChangID);
		if (rogueCardItemCfg == null || rogueCardItemCfg.effect_list == null || rogueCardItemCfg.effect_list.Length == 0)
		{
			return false;
		}
		if (!RogueCardDataManager.enhanceDatabase.TryGetValue(rogueCardItemCfg.effect_list[0], out var value))
		{
			return false;
		}
		coverType = value.type;
		if (coverType != EnhanceType.Enhance && coverType != EnhanceType.Tag)
		{
			return false;
		}
		int id = value.id;
		for (int num = 0; num < cards.Count; num++)
		{
			RogueCardData rogueCardData = cards[num];
			if (rogueCardData == null)
			{
				continue;
			}
			if (coverType == EnhanceType.Enhance)
			{
				if (rogueCardData.enhanceID > 0 && rogueCardData.enhanceID != id)
				{
					return true;
				}
			}
			else if (rogueCardData.tagID > 0 && rogueCardData.tagID != id)
			{
				return true;
			}
		}
		return false;
	}

	private void ShowEnhanceCoverWindow(EnhanceType coverType, Action<bool> onClosed)
	{
		if (enhanceWindowGo == null)
		{
			onClosed?.Invoke(obj: true);
			return;
		}
		if (enhanceWindowLock != null && !enhanceWindowLock.isReleased)
		{
			enhanceWindowLock.Release();
		}
		enhanceWindowLock = GetInputLock("EnhanceCoverWindow", enhanceWindowGo, 30f);
		enhanceWindowCallback = onClosed;
		if (enhanceWindowText != null)
		{
			string tip = RogueCardTipSystem.GetTip((coverType == EnhanceType.Tag) ? "ROGUE_CARD_TAG" : "ROGUE_CARD_ENHANCE");
			RogueCardTipSystem.SetRichText(enhanceWindowText, RogueCardTipSystem.GetTip("ROGUE_CARD_COVER_TIPS", tip));
		}
		RefreshEnhanceWindowRepeatState();
		enhanceWindowGo.SetActive(value: true);
		LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", true);
	}

	public void ConfirmBlackWuChangCoverIfNeeded(int blackWuChangID, List<RogueCardData> cards, Action onConfirmed)
	{
		if (enhanceWindowNoRepeat || !TryGetBlackWuChangCoverType(blackWuChangID, cards, out var coverType))
		{
			onConfirmed?.Invoke();
			return;
		}
		ShowEnhanceCoverWindow(coverType, delegate(bool isConfirm)
		{
			if (isConfirm)
			{
				onConfirmed?.Invoke();
			}
		});
	}

	public void ChangeSellJokerState(bool isOnUI, int index)
	{
		if ((jokerSellStateCon.GetSelectedIndex() != 0 || isOnUI) && !((jokerSellStateCon.GetSelectedIndex() == 1) & isOnUI))
		{
			jokerSellStateCon.SetSelectedState(isOnUI ? "after" : "before");
		}
	}

	public void ShowDeckInfoUI(bool isShow)
	{
		if (mainStateMachine.GetCurrentState() is StageState && curStateUI is RogueCardStageUI)
		{
			(curStateUI as RogueCardStageUI).ShowDeckUI(isShow);
		}
	}

	public bool IsNormalStageComplete(int stageIndex)
	{
		if (gameContext.curRound > stageIndex)
		{
			return true;
		}
		if (gameContext.curRound == stageIndex && gameContext.curStageState == StageType.Boss)
		{
			return true;
		}
		if (gameContext.curRound == stageIndex && gameContext.curStageState == StageType.Normal && CurState.GetIndex() >= 7)
		{
			return true;
		}
		return false;
	}

	public bool IsStageComplete(int stageIndex)
	{
		if (gameContext.curRound > stageIndex)
		{
			return true;
		}
		if (gameContext.curRound == stageIndex && gameContext.curStageState == StageType.Boss && CurState.GetIndex() >= 7)
		{
			return true;
		}
		return false;
	}

	public void SwapJokerCard(int index1, int index2)
	{
		gameContext.jokerData.SwapCardPositions(index1, index2);
		RefreshJoker();
	}

	public void SelectCard(int index)
	{
		gameContext.SelectCard(index);
		RefreshUI();
	}

	public void DeSelectCard()
	{
		gameContext.DeSelect();
		RefreshMainUI();
		RefreshDeckUI();
		curStateUI?.RefreshUI();
		RefreshJoker();
		RefreshWealAndWoe();
	}

	public void PlayCard()
	{
		if (CheckDisableInput())
		{
			return;
		}
		InputLockToken inputLock = Instance.GetInputLock("PlayCard", base.gameObject, 30f);
		if (gameContext.playNum <= 0)
		{
			inputLock.Release();
			return;
		}
		List<RogueCardData> selectDataList = gameContext.GetSelectDataList();
		int[] selectIndexList = gameContext.GetSelectIndexList();
		List<RogueCardData> unSelectDataList = gameContext.GetUnSelectDataList();
		int[] unSelectIndexList = gameContext.GetUnSelectIndexList();
		gameContext.settleContext.useCardNum += selectDataList.Count;
		gameContext.playNum--;
		int num = 0;
		for (int i = 0; i < selectDataList.Count; i++)
		{
			if (selectDataList[i].rank == Rank.A)
			{
				num++;
			}
		}
		if (num > 0)
		{
			gameContext.settleContext.useANum += num;
		}
		gameContext.PlaySelectedCard(selectDataList, gameContext.scoreResult);
		gameContext.destroyedCardsCache.Clear();
		StartCoroutine(PlayCardSequence(selectDataList, selectIndexList, unSelectDataList, unSelectIndexList, inputLock));
	}

	private IEnumerator PlayCardSequence(List<RogueCardData> playedDatas, int[] playedIndexes, List<RogueCardData> unplayedDatas, int[] unplayedIndexes, InputLockToken inputLock)
	{
		List<GameObject> playedTempCards = new List<GameObject>();
		try
		{
			yield return StartCoroutine(AnimatePlayedCardsFlight(playedDatas, playedIndexes, unplayedDatas, unplayedIndexes, playedTempCards));
			RogueCardScoreSystem.Instance.CalculateScore(gameContext.scoreResult, playedDatas.ToArray());
			long num = gameContext.score + gameContext.scoreResult.TotalScore;
			int nowScore = (int)((num <= int.MaxValue) ? num : int.MaxValue);
			_ = gameContext.GetTargetScore;
			RogueCardSaveSystem.SendTrackingPoint2(gameContext.scoreResult.scoreCardData, saveSystem.GetGameData(), nowScore, (int)((gameContext.GetTargetScore <= int.MaxValue) ? gameContext.GetTargetScore : int.MaxValue), 1, (int)gameContext.scoreResult.TotalScore, (int)gameContext.scoreResult.HandType);
			long num2 = gameContext.scoreResult.TotalScore;
			if (num2 < 0 || num2 >= int.MaxValue)
			{
				num2 = 2147483647L;
				gameContext.scoreResult.TotalScore = 2147483647L;
			}
			gameContext.roundPlayNum++;
			long num3 = gameContext.score + num2;
			if (num3 >= int.MaxValue || num3 < 0)
			{
				gameContext.score = int.MaxValue;
			}
			else
			{
				gameContext.score = (int)num3;
			}
			Canvas.ForceUpdateCanvases();
			DeSelectCard();
			ShowScore(isShow: true);
			HideTips();
			gameContext.randomRank = (Rank)Random.Range(2, 12);
			yield return new WaitUntil(() => !gameContext.scoreResult.Show);
			foreach (GameObject item in playedTempCards)
			{
				item.SetActive(value: true);
			}
			yield return StartCoroutine(AnimateScoredCardsExit(playedTempCards, playedDatas));
			isHandle = true;
		}
		finally
		{
			inputLock?.Release();
		}
	}

	public void ShowScore(bool isShow)
	{
		if (!isShow)
		{
			gameContext.scoreResult.Show = false;
			RefreshUI();
		}
	}

	public void DisCardCard()
	{
		if (!CheckDisableInput() && gameContext.discardNum > 0 && gameContext.GetSelectDataList().Count != 0)
		{
			HideTips();
			StartCoroutine(PlayDiscardAnimation(discardAll: false));
		}
	}

	public void DiscardAndRedraw(int discardCount)
	{
		HideTips();
		StartCoroutine(PlayDiscardAnimation(discardAll: false));
	}

	public void RemoveCard(int num)
	{
		List<RogueCardData> list = randomSystem.RandomSample(gameContext.GetWuChangUnSelect, num);
		for (int i = 0; i < list.Count; i++)
		{
			gameContext.RemoveCard(list[i]);
		}
		RefreshUI();
		HideTips();
	}

	public void ChangeMainState(IState newState)
	{
		mainStateMachine.ChangeState(newState);
		HideTips();
	}

	public void BackMainState()
	{
		mainStateMachine.BackState();
		HideTips();
	}

	public bool CheckBackState()
	{
		return mainStateMachine.CheckBackState();
	}

	private void PerformRefreshUI()
	{
		RefreshMainUI();
		RefreshDeckUI();
		curStateUI?.RefreshUI();
		RefreshJoker();
		RefreshWealAndWoe();
		if (storyUI != null)
		{
			storyUI.RefreshUI();
		}
	}

	public void BeginDeferredRefreshUI()
	{
		deferredRefreshUICount++;
	}

	public void EndDeferredRefreshUI(bool refreshNow = true)
	{
		if (deferredRefreshUICount > 0)
		{
			deferredRefreshUICount--;
		}
		if (deferredRefreshUICount == 0 && hasPendingRefreshUI)
		{
			hasPendingRefreshUI = false;
			if (refreshNow)
			{
				PerformRefreshUI();
			}
		}
	}

	public void RefreshUI()
	{
		if (deferredRefreshUICount > 0)
		{
			hasPendingRefreshUI = true;
		}
		else
		{
			PerformRefreshUI();
		}
	}

	public void RefreshDeckUI()
	{
		int num = (hasForcedDeckUICount ? forcedDeckUICount : gameContext.rogueDeck.cards.Count);
		deckInfo.text = $"{num}/{GameContext.GetAllCards.Count}";
	}

	public void RefreshDeckUI(int deckCount)
	{
		deckInfo.text = $"{deckCount}/{GameContext.GetAllCards.Count}";
	}

	public void SetForcedDeckUICount(int deckCount, bool refreshNow = true)
	{
		hasForcedDeckUICount = true;
		forcedDeckUICount = deckCount;
		if (refreshNow)
		{
			RefreshDeckUI(deckCount);
		}
	}

	public void ClearForcedDeckUICount(bool refreshNow = true)
	{
		hasForcedDeckUICount = false;
		if (refreshNow)
		{
			RefreshDeckUI();
		}
	}

	public void RefreshWealAndWoe()
	{
		if (gameContext.curStageState == StageType.Boss && !gameContext.ignoreWoe)
		{
			Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase = RogueCardDataManager.wealAndWoeDatabase;
			List<int> woeList = gameContext.woeList;
			RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = wealAndWoeDatabase[woeList[woeList.Count - 1]];
			RogueCardTipSystem.SetRichText(woeTipText, rogueCardWealAndWoeCfg.desc);
			woeTipText.transform.parent.gameObject.SetActive(value: true);
		}
		else
		{
			woeTipText.transform.parent.gameObject.SetActive(value: false);
		}
		wealTipBtn.gameObject.SetActive(value: true);
		int count = gameContext.wealList.Count;
		int getCurWealWoeNum = gameContext.GetCurWealWoeNum;
		wealNumText.text = getCurWealWoeNum.ToString();
		int num = 0;
		int num2 = getCurWealWoeNum;
		for (int i = 0; i < count; i++)
		{
			if (gameContext.wealList[i] != 199)
			{
				if (num2 <= 0)
				{
					break;
				}
				if (wealTextList.Count <= num)
				{
					GameObject gameObject = UnityEngine.Object.Instantiate(wealTipItem, wealTipContent);
					Text componentInChildren = gameObject.GetComponentInChildren<Text>();
					wealTextList.Add(componentInChildren);
					wealGoList.Add(gameObject);
				}
				wealGoList[num].SetActive(value: true);
				RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg2 = RogueCardDataManager.wealAndWoeDatabase[gameContext.wealList[i]];
				RogueCardTipSystem.SetRichText(wealTextList[num], rogueCardWealAndWoeCfg2.desc);
				num++;
				num2--;
			}
		}
		for (int j = num; j < wealTextList.Count; j++)
		{
			wealGoList[j].SetActive(value: false);
		}
		if (getCurWealWoeNum == 0)
		{
			wealTipBtn.gameObject.SetActive(value: false);
		}
		else
		{
			wealTipBtn.gameObject.SetActive(value: true);
		}
	}

	public void RefreshMainUI()
	{
		if (deferredRefreshUICount > 0)
		{
			hasPendingRefreshUI = true;
			return;
		}
		curScore.gameObject.SetActive(value: true);
		infScoreText.SetActive(value: false);
		if (movieGo == null)
		{
			movieBtn.gameObject.SetActive(value: false);
			movieTip.gameObject.SetActive(value: false);
		}
		if (!(CurState is StateWithSubstates))
		{
			targetScore.text = "0";
			curScore.SetValueImmediate(0);
		}
		else
		{
			long getTargetScore = gameContext.GetTargetScore;
			targetScore.text = ((getTargetScore >= int.MaxValue) ? "NaN" : getTargetScore.ToString());
			if (!isShowingScore && !gameContext.scoreResult.Show)
			{
				if (gameContext.score >= int.MaxValue)
				{
					curScore.SetValueImmediate(int.MaxValue);
					curScore.gameObject.SetActive(value: false);
					infScoreText.SetActive(value: true);
				}
				else
				{
					curScore.SetValueImmediate(gameContext.score);
				}
			}
			else if (gameContext.score >= int.MaxValue)
			{
				curScore.SetValueImmediate(int.MaxValue);
				curScore.gameObject.SetActive(value: false);
				infScoreText.SetActive(value: true);
			}
		}
		lastPlayNum.text = gameContext.playNum.ToString();
		lastDiscardNum.text = Mathf.Max(0, gameContext.discardNum - pendingDiscardNumDisplayOffset).ToString();
		OnGoldNumChange(goldNum.GetCurValue(), gameContext.gold);
		goldNum.ScrollTo(gameContext.gold);
		jokerNum.text = $"{gameContext.jokerData.HandCount}/{gameContext.globalAttrDic[AttributeType.JokerMaxNum]}";
		jokerSlotCon.SetSelectedState((gameContext.jokerData.HandCount == 0) ? "on" : "off");
		jokerSortBtn.gameObject.SetActive(gameContext.jokerData.HandCount != 0);
	}

	public void DelayDiscardNumDisplay(int amount)
	{
		if (amount > 0)
		{
			pendingDiscardNumDisplayOffset += amount;
		}
	}

	public void ApplyDelayedDiscardNumDisplay(int amount)
	{
		if (amount > 0)
		{
			pendingDiscardNumDisplayOffset = Mathf.Max(0, pendingDiscardNumDisplayOffset - amount);
			RefreshMainUI();
		}
	}

	public void RefreshJoker()
	{
		if (deferredRefreshUICount > 0)
		{
			hasPendingRefreshUI = true;
			return;
		}
		jokerHolder.ShowCard(gameContext);
		Canvas.ForceUpdateCanvases();
		if (jokerHolder != null && jokerHolder.transform is RectTransform layoutRoot)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
		}
	}

	public void BuyShopItem()
	{
		gameContext.shopData.ShopBuyItem();
		HideTips();
		RefreshUI();
		saveSystem.SaveGameData();
	}

	public bool RefreshShopItem()
	{
		bool result = gameContext.RefreshByCost();
		saveSystem.SaveGameData();
		RefreshUI();
		return result;
	}

	public void EndShop()
	{
		ChangeMainState(new SelectStageState());
	}

	public void GainJokerCard(RogueCardJokerData jokerData)
	{
		RecordItem(1, jokerData.id);
		if (jokerData.versionID != 0)
		{
			RecordItem(2, jokerData.versionID);
		}
		gameContext.jokerData.AddCardToHand(jokerData);
		gameContext.settleContext.gainJokerNum++;
		RefreshUI();
	}

	public void PackageGainJoker()
	{
		int id = gameContext.packageJoker[gameContext.packageJokerIndex];
		int packageJokerVersion = gameContext.GetPackageJokerVersion(gameContext.packageJokerIndex);
		RogueCardSaveSystem.SendTrackingPoint3(saveSystem.GetGameData(), 0, 4, new List<int> { gameContext.packageJokerIndex });
		RogueCardJokerData jokerData = RogueCardJokerData.CreateJokerCard(id, packageJokerVersion);
		GainJokerCard(jokerData);
		gameContext.RemovePackageJokerAt(gameContext.packageJokerIndex);
		gameContext.packageJokerIndex = -1;
		RefreshUI();
	}

	public void AddAllWuChang()
	{
		if (gameContext.wuChangWaitCards.GetSelectIndexList().Length == 0)
		{
			return;
		}
		List<RogueCardData> getWuChangSelect = gameContext.GetWuChangSelect;
		if (getWuChangSelect.Count > 0)
		{
			for (int i = 0; i < getWuChangSelect.Count; i++)
			{
				getWuChangSelect[i].AddBlackWuChang(gameContext.blackWuChangID);
			}
		}
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == gameContext.whiteWuChangID);
		RogueCardEffectManager.Instance.RegistEffect(rogueCardItemCfg.effect_list[0]);
		RecordItem(1, gameContext.whiteWuChangID);
		gameContext.settleContext.whiteWuChangNum += gameContext.GetWuChangSelect.Count;
		gameContext.settleContext.blackWuChangNum += gameContext.GetWuChangSelect.Count;
		if (copyToDeckQueue.Count > 0)
		{
			StartCoroutine(PlayWuChangCopyAnimCoroutine());
		}
		else
		{
			RefreshUI();
		}
	}

	public void AddPackageWuChang()
	{
		gameContext.destroyedCardsCache.Clear();
		if (gameContext.wuChangWaitCards.GetSelectIndexList().Length == 0)
		{
			return;
		}
		int wuChangID = ((gameContext.curPackageWuChangID != 0) ? gameContext.curPackageWuChangID : gameContext.packageWuChang[gameContext.selectWuChangIndex]);
		RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg c) => c.id == wuChangID);
		if (rogueCardItemCfg.type == ItemType.BlackWuChang)
		{
			_ = RogueCardDataManager.enhanceDatabase[rogueCardItemCfg.effect_list[0]];
			List<RogueCardData> getWuChangSelect = gameContext.GetWuChangSelect;
			if (getWuChangSelect.Count > 0)
			{
				for (int num = 0; num < getWuChangSelect.Count; num++)
				{
					getWuChangSelect[num].AddBlackWuChang(rogueCardItemCfg.id);
				}
				gameContext.settleContext.blackWuChangNum += gameContext.GetWuChangSelect.Count;
			}
		}
		else if (rogueCardItemCfg.type == ItemType.WhiteWuChang)
		{
			RogueCardEffectManager.Instance.RegistEffect(rogueCardItemCfg.effect_list[0]);
			RecordItem(1, rogueCardItemCfg.id);
			gameContext.settleContext.whiteWuChangNum += gameContext.GetWuChangSelect.Count;
		}
	}

	public void ClearWuChangData()
	{
		if (gameContext.curPackageID > 0 && gameContext.selectWuChangIndex > -1)
		{
			gameContext.packageWuChang.RemoveAt(gameContext.selectWuChangIndex);
		}
		gameContext.selectWuChangIndex = -1;
		foreach (RogueCardData item in gameContext.destroyedCardsCache)
		{
			gameContext.wuChangWaitCards.RemoveCard(item);
		}
		foreach (RogueCardData orderedHandDatum in gameContext.wuChangWaitCards.GetOrderedHandData())
		{
			gameContext.rogueDeck.AddCard(orderedHandDatum);
		}
		gameContext.wuChangWaitCards.ClearCard();
		gameContext.packageWuChang.Clear();
		gameContext.wuChangWaitCards.DeSelect();
	}

	public void DoWuChang()
	{
		if (gameContext.curPackageID != 0)
		{
			gameContext.packageWuChang.RemoveAt(gameContext.selectWuChangIndex);
		}
		gameContext.curPackageWuChangID = 0;
		gameContext.selectWuChangIndex = -1;
		foreach (RogueCardData item in gameContext.destroyedCardsCache)
		{
			gameContext.wuChangWaitCards.RemoveCard(item);
		}
	}

	public void SortCard(int sortType = -1)
	{
		StartCoroutine(sortCard(sortType));
	}

	private IEnumerator sortCard(int sortType = -1)
	{
		InputLockToken sortLock = GetInputLock("Sort", null, 1f);
		try
		{
			int[] array = new int[gameContext.handData.HandCount];
			int[] array2 = new int[gameContext.handData.HandCount];
			RogueCardHolder handHolder = (curStateUI as RogueCardStageUI).handHolder;
			for (int i = 0; i < gameContext.handData.HandCount; i++)
			{
				array[i] = gameContext.handData.cardOrder[i];
			}
			gameContext.SortCard(gameContext.handData, sortType);
			for (int j = 0; j < gameContext.handData.HandCount; j++)
			{
				array2[j] = gameContext.handData.cardOrder[j];
			}
			int sortCount = 0;
			int totalSortAnims = 0;
			int i2 = 0;
			while (i2 < gameContext.handData.HandCount)
			{
				int value = array[i2];
				int num = Array.IndexOf(array2, value);
				RogueCard rogueCard = handHolder.cards.Find((RogueCard c) => c.ParentIndex() == i2);
				if (num >= 0 && num < handHolder.slots.Count && rogueCard != null && rogueCard.cardVisual != null)
				{
					totalSortAnims++;
					rogueCard.cardVisual.SmoothMoveToSlot(handHolder.slots[num].transform as RectTransform, 0.3f, delegate
					{
						sortCount++;
					});
				}
				int num2 = i2 + 1;
				i2 = num2;
			}
			AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_card04", useStream: false);
			if (totalSortAnims > 0)
			{
				yield return new WaitUntil(() => sortCount >= totalSortAnims);
			}
			RefreshUI();
		}
		finally
		{
			sortLock?.Release();
		}
	}

	public void StartGame(int stageID, string saveJson, string rollBackSaveJson, bool isGuide, bool isRollBack = false)
	{
		RollbackPreservedState rollbackState = CaptureRollbackPreservedState(isRollBack);
		saveSystem = new RogueCardSaveSystem();
		guideSystem.SetGuiding(isGuide);
		guideSystem.UnlockCard();
		RogueCardSaveData rogueCardSaveData = saveSystem.LoadGameData(saveJson, rollBackSaveJson);
		saveSystem.saveLock = true;
		if (rogueCardSaveData != null)
		{
			ApplyRollbackOverrides(rogueCardSaveData, rollbackState);
			randomSystem = new DeterministicRandom(rogueCardSaveData.random_seed);
			gameContext = new RogueCardGameContext(rogueCardSaveData);
			LuaHelper.CallFunction("RogueCardGameBridge.GetScoreRatioData");
			GameContext.isRestoringSave = true;
			gameContext.InitStage(stageID, rogueCardSaveData, isRollBack);
			jokerHolder.Init();
			jokerHolder.SwapEvent.RemoveAllListeners();
			jokerHolder.SwapEvent.AddListener(SwapJokerCard);
			jokerHolder.ResetAndRebuild();
			jokerHolder.ShowCard(gameContext);
			if (rogueCardSaveData.cur_state == 0)
			{
				mainStateMachine.Initialize(new SelectStageState(isReadSave: true));
			}
			else if (rogueCardSaveData.cur_state == 1)
			{
				if (gameContext.curStageState == StageType.Normal)
				{
					Instance.ChangeMainState(new NormalStageState(isReadSave: true));
				}
				else
				{
					Instance.ChangeMainState(new BossStageState(isReadSave: true));
				}
			}
			else if (rogueCardSaveData.cur_state == 2)
			{
				mainStateMachine.Initialize(new ShopState());
			}
			else if (rogueCardSaveData.cur_state == 3)
			{
				mainStateMachine.Initialize(new PackageState());
			}
			else if (rogueCardSaveData.cur_state == 4)
			{
				mainStateMachine.Initialize(new WuChangState());
			}
			else if (rogueCardSaveData.cur_state == 5)
			{
				mainStateMachine.Initialize(new TurnSettleState(isReadSave: true));
			}
			else if (rogueCardSaveData.cur_state == 6)
			{
				if (GameContext.stageType == LevelType.Challenge)
				{
					gameContext.result = gameContext.curRound > gameContext.allRoundNum || (gameContext.curRound == gameContext.allRoundNum && gameContext.curStageState == StageType.Boss);
				}
				mainStateMachine.Initialize(new SettleState());
			}
			if (isRollBack)
			{
				gameContext.rollBackNum--;
				gameContext.gold += Instance.rollBackGainGold;
				saveSystem.SaveGameData(isRollbackData: true);
			}
		}
		BeginStageUseTimeTracking((gameContext != null) ? gameContext.stageUseTime : 0);
		InitStory();
		saveSystem.saveLock = false;
		RefreshUI();
		if (rogueCardSaveData == null || rogueCardSaveData.cur_state != 4 || gameContext == null || !gameContext.isRestoringSave)
		{
			gameContext.isRestoringSave = false;
			RefreshShopAfterRollbackIfNeeded(isRollBack, rogueCardSaveData);
			if (isRollBack)
			{
				saveSystem.SaveGameData();
			}
		}
		activeSettle = false;
	}

	private RollbackPreservedState CaptureRollbackPreservedState(bool isRollBack)
	{
		if (!isRollBack || gameContext == null)
		{
			return null;
		}
		return new RollbackPreservedState
		{
			DeckCards = BuildSaveCardList(gameContext.rogueDeck?.cards),
			PileCards = BuildSaveCardList(gameContext.rogueDeck?.discardPile),
			HandCards = BuildSaveCardList(gameContext.handData?.GetOrderedHandData()),
			Jokers = BuildSaveJokerList(gameContext.jokerData?.GetOrderedHandData()),
			Gold = gameContext.gold,
			RecordItems = BuildRecordItems()
		};
	}

	private void ApplyRollbackOverrides(RogueCardSaveData saveData, RollbackPreservedState rollbackState)
	{
		if (rollbackState != null && saveData != null)
		{
			saveData.deck_cards = rollbackState.DeckCards;
			saveData.pile_cards = rollbackState.PileCards;
			saveData.hand_cards = rollbackState.HandCards;
			saveData.jokers = rollbackState.Jokers;
			saveData.gold = rollbackState.Gold;
			saveData.record_items = rollbackState.RecordItems;
			if (saveData.other_data == null)
			{
				saveData.other_data = new List<int>();
			}
			while (saveData.other_data.Count <= 99)
			{
				saveData.other_data.Add(-1);
			}
		}
	}

	public void PlayGoldFlyAnimation(Action onComplete = null)
	{
		if (goldFlyGo == null || goldFlyStartPoint == null || goldFlyEndPoint == null)
		{
			onComplete?.Invoke();
			return;
		}
		goldFlyGo.transform.position = goldFlyStartPoint.position;
		goldFlyGo.SetActive(value: true);
		LeanTween.move(goldFlyGo, goldFlyEndPoint.position, 0.6f).setEase(LeanTweenType.easeInOutQuad).setOnComplete((Action)delegate
		{
			goldFlyGo.SetActive(value: false);
			onComplete?.Invoke();
			if (goldNum != null)
			{
				OnGoldNumChange(goldNum.GetCurValue(), gameContext.gold);
				goldNum.ScrollTo(gameContext.gold);
			}
		});
	}

	private void RefreshShopAfterRollbackIfNeeded(bool isRollBack, RogueCardSaveData saveData)
	{
		if (isRollBack && gameContext != null && saveData != null && saveData.cur_state == 2)
		{
			gameContext.InitShopData();
			RefreshUI();
			saveSystem.SaveGameData(isRollbackData: true);
		}
	}

	private List<RogueCardSaveCardData> BuildSaveCardList(List<RogueCardData> cards)
	{
		List<RogueCardSaveCardData> list = new List<RogueCardSaveCardData>();
		if (cards == null)
		{
			return list;
		}
		for (int i = 0; i < cards.Count; i++)
		{
			RogueCardData rogueCardData = cards[i];
			if (rogueCardData != null)
			{
				list.Add(new RogueCardSaveCardData
				{
					suit = (int)rogueCardData.suit,
					rank = (int)rogueCardData.rank,
					enhance_id = rogueCardData.enhanceID,
					tag_id = rogueCardData.tagID,
					effect_disable = rogueCardData.effectDisable,
					other_data = new List<int>()
				});
			}
		}
		return list;
	}

	private List<RogueCardSaveJokerData> BuildSaveJokerList(List<RogueCardJokerData> jokers)
	{
		List<RogueCardSaveJokerData> list = new List<RogueCardSaveJokerData>();
		if (jokers == null)
		{
			return list;
		}
		for (int i = 0; i < jokers.Count; i++)
		{
			RogueCardJokerData rogueCardJokerData = jokers[i];
			if (rogueCardJokerData == null)
			{
				continue;
			}
			RogueCardSaveJokerData rogueCardSaveJokerData = new RogueCardSaveJokerData
			{
				id = rogueCardJokerData.id,
				real_id = rogueCardJokerData.realID,
				version_id = rogueCardJokerData.versionID,
				add_point = rogueCardJokerData.addPoint,
				add_mutli = rogueCardJokerData.addMutli,
				mul_ratio = rogueCardJokerData.mulRatio,
				other_data = new List<int>()
			};
			for (int j = 0; j < rogueCardJokerData.effect.Count; j++)
			{
				rogueCardSaveJokerData.other_data.Add(rogueCardJokerData.effect[j].triggerCount);
				rogueCardSaveJokerData.other_data.Add(rogueCardJokerData.effect[j].lifeCount);
				int item = 0;
				if (rogueCardJokerData.effect[j].action is ChangeGlobalDataAction)
				{
					item = (rogueCardJokerData.effect[j].action as ChangeGlobalDataAction).changeNum;
				}
				rogueCardSaveJokerData.other_data.Add(item);
			}
			if (rogueCardJokerData.versionEffect != null)
			{
				rogueCardSaveJokerData.other_data.Add(rogueCardJokerData.versionEffect.triggerCount);
				rogueCardSaveJokerData.other_data.Add(rogueCardJokerData.versionEffect.lifeCount);
				int item2 = 0;
				if (rogueCardJokerData.versionEffect.action is ChangeGlobalDataAction)
				{
					item2 = (rogueCardJokerData.versionEffect.action as ChangeGlobalDataAction).changeNum;
				}
				rogueCardSaveJokerData.other_data.Add(item2);
			}
			if (rogueCardJokerData.copyEffect != null)
			{
				rogueCardSaveJokerData.other_data.Add(rogueCardJokerData.copyEffect.triggerCount);
				rogueCardSaveJokerData.other_data.Add(rogueCardJokerData.copyEffect.lifeCount);
				int item3 = 0;
				if (rogueCardJokerData.copyEffect.action is ChangeGlobalDataAction)
				{
					item3 = (rogueCardJokerData.copyEffect.action as ChangeGlobalDataAction).changeNum;
				}
				rogueCardSaveJokerData.other_data.Add(item3);
			}
			list.Add(rogueCardSaveJokerData);
		}
		return list;
	}

	private List<int> BuildPackageJokerIds()
	{
		List<int> list = new List<int>();
		if (gameContext?.packageJoker == null)
		{
			return list;
		}
		for (int i = 0; i < gameContext.packageJoker.Count; i++)
		{
			int jokerID = gameContext.packageJoker[i];
			int versionID = ((i < gameContext.packageJokerVersion.Count) ? gameContext.packageJokerVersion[i] : 0);
			list.Add(RogueCardSaveSystem.EncodePackageJokerID(jokerID, versionID));
		}
		return list;
	}

	private List<int> BuildRecordItems()
	{
		List<int> list = new List<int>();
		if (gameContext == null)
		{
			return list;
		}
		if (gameContext.recordItems != null)
		{
			foreach (int recordItem in gameContext.recordItems)
			{
				list.Add(RogueCardSaveSystem.EncodeRecordItemID(1, recordItem));
			}
		}
		if (gameContext.recordEnhance != null)
		{
			foreach (int item in gameContext.recordEnhance)
			{
				list.Add(RogueCardSaveSystem.EncodeRecordItemID(2, item));
			}
		}
		return list;
	}

	private List<int> BuildRollbackRuntimeOtherData()
	{
		List<int> list = new List<int>();
		while (list.Count <= 99)
		{
			list.Add(-1);
		}
		List<RogueCardGameEffect> registeredEffects = RogueCardEffectManager.Instance.GetRegisteredEffects(EntityType.Deck);
		WriteRuntimeEffectsToOtherData(list, 10, 29, registeredEffects);
		List<RogueCardGameEffect> registeredEffects2 = RogueCardEffectManager.Instance.GetRegisteredEffects(EntityType.Player);
		WriteRuntimeEffectsToOtherData(list, 30, 99, registeredEffects2);
		return list;
	}

	private void WriteRuntimeEffectsToOtherData(List<int> otherData, int startIndex, int endIndex, List<RogueCardGameEffect> effects)
	{
		for (int i = startIndex; i <= endIndex; i++)
		{
			otherData[i] = -1;
		}
		if (effects == null || effects.Count == 0)
		{
			return;
		}
		int num = Math.Min((endIndex - startIndex + 1) / 2, effects.Count);
		for (int j = 0; j < num; j++)
		{
			int num2 = startIndex + j * 2;
			otherData[num2] = effects[j].effectID;
			int actionChangeNum = 0;
			if (effects[j].action is ChangeGlobalDataAction)
			{
				actionChangeNum = (effects[j].action as ChangeGlobalDataAction).changeNum;
			}
			otherData[num2 + 1] = RogueCardSaveSystem.EncodeRuntimeEffectCounts(effects[j].triggerCount, effects[j].lifeCount, actionChangeNum);
		}
	}

	private void WriteRuntimeEffectsToOtherData(List<int> otherData, int startIndex, int endIndex, Dictionary<int, int> effectMap)
	{
		for (int i = startIndex; i <= endIndex; i++)
		{
			otherData[i] = -1;
		}
		if (effectMap == null || effectMap.Count == 0)
		{
			return;
		}
		int num = (endIndex - startIndex + 1) / 2;
		int num2 = 0;
		foreach (KeyValuePair<int, int> item in effectMap)
		{
			if (num2 >= num)
			{
				break;
			}
			int num3 = startIndex + num2 * 2;
			otherData[num3] = item.Key;
			otherData[num3 + 1] = item.Value;
			num2++;
		}
	}

	public void StartGame(int stageID, int deckID, int difficulty, bool isGuiding)
	{
		saveSystem = new RogueCardSaveSystem();
		guideSystem.SetGuiding(isGuiding);
		guideSystem.UnlockCard();
		int num = new System.Random().Next();
		randomSystem = new DeterministicRandom(num);
		gameContext = new RogueCardGameContext(num);
		gameContext.InitStage(stageID, deckID, difficulty);
		jokerHolder.Init();
		jokerHolder.SwapEvent.RemoveAllListeners();
		jokerHolder.SwapEvent.AddListener(SwapJokerCard);
		jokerHolder.ResetAndRebuild();
		jokerHolder.ShowCard(gameContext);
		BeginStageUseTimeTracking((gameContext != null) ? gameContext.stageUseTime : 0);
		InitStory();
		mainStateMachine.Initialize(new InitWaveState());
		RefreshUI();
		activeSettle = false;
	}

	private void InitStory()
	{
		clueTitle.text = RogueCardTipSystem.GetTip($"ROGUE_CARD_STAGE{gameContext.stageID % 100}_TITLE");
		if (null == storyUI)
		{
			GameObject gameObject = Asset.InstantiateWithoutCache($"Widget/System/Activity_JokerCard/ClueStory/ClueStory_{gameContext.stageID}.prefab");
			if (gameObject != null)
			{
				gameObject.transform.SetParent(storyContent, worldPositionStays: false);
			}
			storyUI = gameObject.GetComponent<RogueCardStoryBaseUI>();
			storyUI.Init();
			storyUI.SetData();
		}
	}

	public void InitializeWaveData()
	{
		Instance.ChangeMainState(new SelectStageState());
	}

	public void EnterSelectStageState()
	{
		mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOADING_TITLE");
		if (!gameContext.isRestoringSave)
		{
			gameContext.NewStageData();
		}
		gameContext.RefreshWoeWealList(isChange: false);
		gameContext.RefreshStageData();
		ClearAllTempRogueCards();
		ChangeStateUI(StateType.SelectStage);
		RefreshUI();
		saveSystem.SaveGameData();
	}

	public void EnterStageState()
	{
		mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_INVESTIGATION_TITLE", $"{gameContext.curRound}/{gameContext.allRoundNum}", RogueCardDataManager.stageDatabase[gameContext.stageID].name);
		if (gameContext.curStageState == StageType.Boss)
		{
			storyUI?.OnStartChallengeState();
		}
		else
		{
			storyUI?.OnStartNormalStage();
		}
	}

	public void InitShopState(bool isRefresh)
	{
		if (isRefresh)
		{
			gameContext.InitShopData();
		}
		RefreshUI();
	}

	public void EnterShopState()
	{
		ChangeStateUI(StateType.Shop);
		curStateUI.RefreshUI();
		saveSystem.SaveGameData(isRollbackData: true);
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_SHOP_TITLE");
	}

	public void StartPackage(int packageID)
	{
		gameContext.curPackageID = packageID;
		gameContext.curPackageWuChangID = 0;
		ChangeMainState(new PackageState());
	}

	public void StartBuyWuChang(int itemID)
	{
		if (!gameContext.isRestoringSave)
		{
			gameContext.RefreshWuChangData();
		}
		gameContext.curPackageID = 0;
		gameContext.curPackageWuChangID = itemID;
		ChangeMainState(new PackageState());
	}

	public void EnterPackageState()
	{
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		bool flag = gameContext.curPackageWuChangID != 0;
		if (!flag && gameContext.curPackageID > 0)
		{
			RogueCardPackageCfg rogueCardPackageCfg = RogueCardDataManager.packageDatabase[gameContext.curPackageID];
			flag = rogueCardPackageCfg.type == ItemType.BlackWuChang || rogueCardPackageCfg.type == ItemType.WhiteWuChang;
		}
		if (flag)
		{
			if (!gameContext.isRestoringSave)
			{
				gameContext.SelectWuChangCard(gameContext.globalAttrDic[AttributeType.HandMaxNum]);
			}
		}
		else if (gameContext.wuChangWaitCards != null && gameContext.wuChangWaitCards.HandCount > 0)
		{
			foreach (RogueCardData orderedHandDatum in gameContext.wuChangWaitCards.GetOrderedHandData())
			{
				gameContext.rogueDeck.AddCard(orderedHandDatum);
			}
			gameContext.wuChangWaitCards.ClearCard();
			gameContext.wuChangWaitCards.DeSelect();
		}
		if (flag)
		{
			SetForcedDeckUICount(gameContext.rogueDeck.cards.Count + gameContext.wuChangWaitCards.HandCount, refreshNow: false);
		}
		ChangeStateUI(StateType.Package);
		if (gameContext.curPackageID > 0)
		{
			RogueCardPackageCfg rogueCardPackageCfg2 = RogueCardDataManager.packageDatabase[gameContext.curPackageID];
			if (rogueCardPackageCfg2.type == ItemType.WhiteWuChang)
			{
				bgCon.SetSelectedState("WhiteGhost");
			}
			else if (rogueCardPackageCfg2.type == ItemType.BlackWuChang)
			{
				bgCon.SetSelectedState("BlackGhost");
			}
			else
			{
				bgCon.SetSelectedState("JokerCardBag");
			}
		}
		curStateUI.RefreshUI();
	}

	public void ExitPackageState()
	{
		bgCon.SetSelectedState("Normal");
	}

	public void OpenPackage()
	{
		RogueCardPackageCfg rogueCardPackageCfg = RogueCardDataManager.packageDatabase[gameContext.curPackageID];
		if (rogueCardPackageCfg.type == ItemType.BlackWuChang || rogueCardPackageCfg.type == ItemType.WhiteWuChang)
		{
			OpenWuChangPackage();
		}
		else
		{
			OpenJokerPackage();
		}
	}

	public void OpenJokerPackage()
	{
		gameContext.packageJokerIndex = -1;
		bool flag = gameContext.packageJoker != null && gameContext.packageJoker.Count > 0;
		if (!gameContext.isRestoringSave && !flag)
		{
			gameContext.RefreshJokerPackage();
		}
		if (curStateUI is RogueCardPackageUI)
		{
			(curStateUI as RogueCardPackageUI).ChangeSubWuJokerUI();
		}
		curStateUI.RefreshUI();
	}

	public void OpenWuChangPackage()
	{
		bool flag = (gameContext.packageWuChang != null && gameContext.packageWuChang.Count > 0) || (gameContext.wuChangWaitCards != null && gameContext.wuChangWaitCards.HandCount > 0) || gameContext.curPackageWuChangID != 0;
		if (!gameContext.isRestoringSave && !flag)
		{
			gameContext.RefreshWuChangData();
		}
		if (curStateUI is RogueCardPackageUI)
		{
			(curStateUI as RogueCardPackageUI).ChangeSubWuChangUI();
		}
		curStateUI.RefreshUI();
	}

	public bool PlayerExitedShop()
	{
		return false;
	}

	public void StartWuChangPhase()
	{
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		wuChangMovieEnd = false;
		bgCon.SetSelectedState("Mechanism");
		PlayMovie();
	}

	public void EndWuChangPhase()
	{
		bgCon.SetSelectedState("Normal");
	}

	public bool WuChangPhaseCompleted()
	{
		if (isWuChangComplete)
		{
			isWuChangComplete = false;
			return true;
		}
		return isWuChangComplete;
	}

	public bool IsWaveCompleted()
	{
		return false;
	}

	public void EnterInitStageSubState()
	{
		gameContext.EnterStage();
		suppressRoundStartForceSelectRefresh = true;
		ChangeStateUI(StateType.PlayCard, refreshUI: false);
		RefreshWealAndWoe();
		if (gameContext.ignoreWoe && gameContext.curStageState == StageType.Boss)
		{
			List<RogueCardJokerData> orderedHandData = gameContext.jokerData.GetOrderedHandData();
			for (int i = 0; i < orderedHandData.Count; i++)
			{
				if (orderedHandData[i].id == 309)
				{
					RogueCard card = jokerHolder.GetCard(i);
					(card.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_chufa");
					(card.cardVisual as VisualJokerCard).PlayFlyNum(RogueCardTipSystem.GetTip("ROGUE_CARD_BOSS_EFFECT_LOSE"), FlyNumberType.Normal);
				}
			}
		}
		RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnRoundStart);
		RefreshMainUI();
		LuaHelper.CallFunction("RogueCardGameBridge.CheckTeamMessage", gameContext.stageID, gameContext.curRound, (int)gameContext.curStageState, 1);
	}

	public void ExitInitStageSubState()
	{
		saveSystem.SaveGameData();
	}

	public void ExitStageState()
	{
		ShowDeckInfoUI(isShow: false);
		RefreshUI();
		if (gameContext.result)
		{
			LuaHelper.CallFunction("RogueCardGameBridge.CheckTeamMessage", gameContext.stageID, gameContext.curRound, (int)gameContext.curStageState, 2);
		}
	}

	public void DrawCard()
	{
		gameContext.DrawCard();
		if (gameContext.isRestoringSave && gameContext.handData.forceSelect == null && gameContext.restoreForceSelectIndex >= 0)
		{
			List<RogueCardData> orderedHandData = gameContext.handData.GetOrderedHandData();
			if (gameContext.restoreForceSelectIndex >= 0 && gameContext.restoreForceSelectIndex < orderedHandData.Count)
			{
				gameContext.handData.forceSelect = orderedHandData[gameContext.restoreForceSelectIndex];
			}
			gameContext.restoreForceSelectIndex = -1;
		}
		if (GameContext.isRestoringSave)
		{
			suppressRoundStartForceSelectRefresh = false;
			EndDeferredRefreshUI(refreshNow: false);
			RefreshUI();
		}
		else
		{
			StartCoroutine(DrawCardWithTempAnimationCoroutine(gameContext.drawCardPool, (curStateUI as RogueCardStageUI).handHolder, gameContext.handData));
		}
	}

	public void DrawCard(int num, Rank rank)
	{
		bool num2 = !isRankDrawAnimationQueued;
		bool handHolderPreHidden = false;
		if (num2 && curStateUI is RogueCardStageUI rogueCardStageUI && rogueCardStageUI.handHolder != null)
		{
			CanvasGroup canvasGroup = rogueCardStageUI.handHolder.GetComponent<CanvasGroup>();
			if (canvasGroup == null)
			{
				canvasGroup = rogueCardStageUI.handHolder.gameObject.AddComponent<CanvasGroup>();
			}
			canvasGroup.alpha = 0f;
			handHolderPreHidden = true;
		}
		gameContext.DrawCard(num, rank);
		if (gameContext.drawCardPool != null && gameContext.drawCardPool.Count > 0)
		{
			pendingRankDrawCards.AddRange(gameContext.drawCardPool);
		}
		if (num2)
		{
			isRankDrawAnimationQueued = true;
			StartCoroutine(ProcessQueuedRankDrawAnimations(handHolderPreHidden));
		}
	}

	private IEnumerator ProcessQueuedRankDrawAnimations(bool handHolderPreHidden)
	{
		bool usePreHiddenHolder = handHolderPreHidden;
		try
		{
			yield return null;
			while (pendingRankDrawCards.Count > 0)
			{
				if (!(curStateUI is RogueCardStageUI rogueCardStageUI) || rogueCardStageUI.handHolder == null)
				{
					pendingRankDrawCards.Clear();
					EndDeferredRefreshUI(refreshNow: false);
					RefreshUI();
					break;
				}
				List<RogueCardData> drawnCards = new List<RogueCardData>(pendingRankDrawCards);
				pendingRankDrawCards.Clear();
				yield return StartCoroutine(DrawCardWithTempAnimationCoroutine(drawnCards, rogueCardStageUI.handHolder, gameContext.handData, null, usePreHiddenHolder, dontRefresh: true));
				usePreHiddenHolder = false;
				yield return null;
			}
		}
		finally
		{
			isRankDrawAnimationQueued = false;
		}
	}

	private IEnumerator PlayCardRecallAnimation(int cardCount)
	{
		if (cardCount <= 0)
		{
			yield break;
		}
		int finalCount = gameContext.rogueDeck.cards.Count;
		InputLockToken recallLock = GetInputLock("recallLock", base.gameObject, 2f);
		float num = 1f;
		float delayBetweenCards = num / (float)(cardCount + 1);
		Vector3 startPos = deckOutPoint.position;
		Vector3 endPos = deckTransPoint.position;
		for (int i = 0; i < cardCount; i++)
		{
			GameObject card = GetTempRogueCard(deckTransPoint.transform);
			card.SetActive(value: true);
			card.transform.position = startPos;
			card.transform.rotation = Quaternion.Euler(0f, 180f, 0f);
			finalCount++;
			RefreshDeckUI(finalCount);
			LeanTween.move(card, endPos, 0.15f).setEase(LeanTweenType.easeInCubic).setOnComplete((Action)delegate
			{
				ReleaseTempRogueCard(card);
			});
			yield return new WaitForSeconds(delayBetweenCards);
		}
		yield return new WaitForSeconds(0.3f);
		recallLock.Release();
	}

	private IEnumerator PlayDiscardAnimation(bool discardAll)
	{
		InputLockToken inputLock = Instance.GetInputLock("Discard", base.gameObject, 2f);
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		try
		{
			List<RogueCardData> selectedCards = gameContext.GetSelectDataList();
			if (discardAll)
			{
				selectedCards = gameContext.handData.GetOrderedHandData();
			}
			if (selectedCards.Count == 0)
			{
				yield break;
			}
			(curStateUI as RogueCardStageUI).calController.SetSelectedState("hideBtn");
			List<GameObject> moveCache = new List<GameObject>();
			Dictionary<RogueCardData, RogueCard> cardToUIMap = new Dictionary<RogueCardData, RogueCard>();
			FieldInfo field = typeof(RogueCardCommonView).GetField("cardData", BindingFlags.Instance | BindingFlags.NonPublic);
			foreach (RogueCard card in (curStateUI as RogueCardStageUI).handHolder.cards)
			{
				if (card != null && card.gameObject.activeSelf && card.cardVisual is VisualRogueCard visualRogueCard && visualRogueCard.view != null && field != null && field.GetValue(visualRogueCard.view) is RogueCardData key)
				{
					cardToUIMap[key] = card;
				}
			}
			gameContext.destroyedCardsCache.Clear();
			if (discardAll)
			{
				foreach (RogueCardData tempCopiedCard in tempCopiedCards)
				{
					if (!selectedCards.Contains(tempCopiedCard))
					{
						selectedCards.Add(tempCopiedCard);
					}
					if (!gameContext.destroyedCardsCache.Contains(tempCopiedCard))
					{
						gameContext.destroyedCardsCache.Add(tempCopiedCard);
					}
				}
				tempCopiedCards.Clear();
			}
			if (!discardAll)
			{
				gameContext.settleContext.discardNum += selectedCards.Count;
			}
			if (!discardAll)
			{
				RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnCardDiscarded);
			}
			for (int i = 0; i < selectedCards.Count; i++)
			{
				RogueCardData rogueCardData = selectedCards[i];
				GameContext.curEffectData = rogueCardData;
				if (!discardAll)
				{
					RogueCardEffectManager.Instance.TriggerCard(rogueCardData, TriggerMoment.OnDiscardPlayed);
				}
			}
			for (int j = 0; j < selectedCards.Count; j++)
			{
				RogueCardData rogueCardData2 = selectedCards[j];
				if (!cardToUIMap.TryGetValue(rogueCardData2, out var rogueCard))
				{
					continue;
				}
				GameObject cardGo = rogueCard.gameObject;
				moveCache.Add(cardGo);
				float duration = RogueCardTimeSystem.GetTime("cardDrawAnimationDuration");
				if (gameContext.destroyedCardsCache.Contains(rogueCardData2))
				{
					if (rogueCard.cardVisual is VisualRogueCard visualRogueCard2)
					{
						visualRogueCard2.view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
					}
					yield return new WaitForSeconds(0.4f);
				}
				else
				{
					AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_card05", useStream: false);
					LeanTween.move(cardGo, cardEndPoint, duration).setEase(cardDrawCurve);
					LeanTween.scale(cardGo, new Vector3(0.9f, 0.9f, 0.9f), duration * 0.6f).setEase(LeanTweenType.easeOutBack);
					LeanTween.rotateZ(cardGo, 10f, duration * 0.3f).setEase(LeanTweenType.easeOutSine).setOnComplete((Action)delegate
					{
						LeanTween.rotateZ(cardGo, 0f, duration * 0.3f).setEase(LeanTweenType.easeInSine);
					});
					yield return new WaitForSeconds(0.1f);
					if (rogueCard.cardVisual is VisualRogueCard visualRogueCard3)
					{
						visualRogueCard3.view.PlayAnimation("UI_Com_RogueCardBaseItem_fanzhuan");
					}
					yield return new WaitForSeconds(0.12f);
				}
				rogueCard = null;
			}
			yield return new WaitForSeconds(0.3f);
			gameContext.PlaySelectedCard(selectedCards, null);
			if (!discardAll)
			{
				gameContext.discardNum--;
				gameContext.roundDiscardNum++;
				saveSystem.SaveGameData();
				isHandle = true;
				RogueCardSaveSystem.SendTrackingPoint2(selectedCards, saveSystem.GetCurrentData(), gameContext.score, (int)((gameContext.GetTargetScore <= int.MaxValue) ? gameContext.GetTargetScore : int.MaxValue), 2, 0, 0);
			}
			if (curStateUI is RogueCardStageUI rogueCardStageUI && !discardAll)
			{
				rogueCardStageUI.calController.SetSelectedState("off");
			}
			DeSelectCard();
			HideTips();
			foreach (GameObject item in moveCache)
			{
				if (item != null)
				{
					item.transform.localPosition = Vector3.zero;
				}
			}
		}
		finally
		{
			RogueCardGameMain rogueCardGameMain = this;
			inputLock?.Release();
			if (Instance != null && Instance.mainTitle != null && !discardAll)
			{
				Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_INVESTIGATION_TITLE", $"{rogueCardGameMain.gameContext.curRound}/{rogueCardGameMain.gameContext.allRoundNum}", RogueCardDataManager.stageDatabase[rogueCardGameMain.gameContext.stageID].name);
			}
		}
	}

	public void PlayEffectDiscardCards(List<RogueCardData> cards)
	{
		if (cards != null && cards.Count != 0)
		{
			StartCoroutine(PlayEffectDiscardCardsCoroutine(new List<RogueCardData>(cards)));
		}
	}

	private IEnumerator PlayEffectDiscardCardsCoroutine(List<RogueCardData> cards)
	{
		if (!(curStateUI is RogueCardStageUI rogueCardStageUI))
		{
			gameContext.PlaySelectedCard(cards, null);
			RefreshUI();
			yield break;
		}
		InputLockToken inputLock = GetInputLock("EffectDiscard", base.gameObject, 2f);
		try
		{
			Dictionary<RogueCardData, RogueCard> dictionary = new Dictionary<RogueCardData, RogueCard>();
			FieldInfo field = typeof(RogueCardCommonView).GetField("cardData", BindingFlags.Instance | BindingFlags.NonPublic);
			foreach (RogueCard card in rogueCardStageUI.handHolder.cards)
			{
				if (card != null && card.gameObject.activeSelf && card.cardVisual is VisualRogueCard visualRogueCard && visualRogueCard.view != null && field != null && field.GetValue(visualRogueCard.view) is RogueCardData key)
				{
					dictionary[key] = card;
				}
			}
			List<GameObject> tempCards = new List<GameObject>();
			float duration = RogueCardTimeSystem.GetTime("cardDrawAnimationDuration");
			bool playedAnimation = false;
			for (int i = 0; i < cards.Count; i++)
			{
				RogueCardData rogueCardData = cards[i];
				if (dictionary.TryGetValue(rogueCardData, out var value))
				{
					playedAnimation = true;
					GameObject tempRogueCard = GetTempRogueCard(rogueCardStageUI.handHolder.transform.parent);
					tempRogueCard.transform.position = value.transform.position;
					tempRogueCard.transform.localScale = Vector3.one;
					tempRogueCard.transform.rotation = value.transform.rotation;
					VisualRogueCard component = tempRogueCard.GetComponent<VisualRogueCard>();
					if (component != null)
					{
						component.ShowCardData(rogueCardData);
					}
					tempCards.Add(tempRogueCard);
					if (value.cardVisual != null)
					{
						value.cardVisual.gameObject.SetActive(value: false);
					}
				}
			}
			gameContext.PlaySelectedCard(cards, null);
			notScore = true;
			RefreshUI();
			notScore = false;
			int i2 = 0;
			while (i2 < tempCards.Count)
			{
				GameObject tempGo = tempCards[i2];
				LeanTween.move(tempGo, cardEndPoint, duration).setEase(cardDrawCurve);
				LeanTween.scale(tempGo, new Vector3(0.9f, 0.9f, 0.9f), duration * 0.6f).setEase(LeanTweenType.easeOutBack);
				LeanTween.rotateZ(tempGo, 10f, duration * 0.3f).setEase(LeanTweenType.easeOutSine).setOnComplete((Action)delegate
				{
					LeanTween.rotateZ(tempGo, 0f, duration * 0.3f).setEase(LeanTweenType.easeInSine);
				});
				yield return new WaitForSeconds(0.1f);
				VisualRogueCard component2 = tempGo.GetComponent<VisualRogueCard>();
				if (component2 != null && component2.view != null)
				{
					component2.view.PlayAnimation("UI_Com_RogueCardBaseItem_fanzhuan");
				}
				yield return new WaitForSeconds(0.12f);
				int num = i2 + 1;
				i2 = num;
			}
			if (playedAnimation)
			{
				yield return new WaitForSeconds(0.3f);
			}
			foreach (GameObject item in tempCards)
			{
				if (item != null)
				{
					ReleaseTempRogueCard(item);
				}
			}
		}
		finally
		{
			inputLock?.Release();
		}
	}

	public IEnumerator CompactHandWithTempAnimationCoroutine(RogueCardHolder holder, HandData<RogueCardData> targetHandData, Dictionary<RogueCardData, Vector3> oldPositions)
	{
		yield return null;
	}

	public IEnumerator DrawCardWithTempAnimationCoroutine(List<RogueCardData> drawnCards, RogueCardHolder holder, HandData<RogueCardData> targetHandData, Dictionary<RogueCardData, Vector3> passedOldPos = null, bool holderPreHidden = false, bool dontRefresh = false)
	{
		bool endedDeferredRefresh = false;
		InputLockToken drawCardLock;
		if (pendingDrawLock != null && !pendingDrawLock.isReleased)
		{
			drawCardLock = pendingDrawLock;
			pendingDrawLock = null;
		}
		else
		{
			drawCardLock = GetInputLock("drawCardLock");
		}
		try
		{
			Dictionary<RogueCardData, Vector3> dictionary = passedOldPos ?? new Dictionary<RogueCardData, Vector3>();
			List<RogueCardData> copiedCardsToAnimate = new List<RogueCardData>();
			Dictionary<RogueCardData, RogueCardData> copySourceMap = new Dictionary<RogueCardData, RogueCardData>();
			if (copyToHandQueue.Count > 0)
			{
				foreach (Tuple<RogueCardData, RogueCardData> item2 in copyToHandQueue)
				{
					if (targetHandData.handCards.Contains(item2.Item2))
					{
						copiedCardsToAnimate.Add(item2.Item2);
						copySourceMap[item2.Item2] = item2.Item1;
					}
				}
				copyToHandQueue.Clear();
			}
			CanvasGroup canvasGroup = holder.GetComponent<CanvasGroup>();
			if (canvasGroup == null)
			{
				canvasGroup = holder.gameObject.AddComponent<CanvasGroup>();
			}
			float alpha = (holderPreHidden ? 1f : canvasGroup.alpha);
			canvasGroup.alpha = 0f;
			gameContext.SortCard(targetHandData, gameContext.sortState);
			holder.ShowCardWithoutSelect(targetHandData);
			Canvas.ForceUpdateCanvases();
			int i;
			for (i = 0; i < targetHandData.HandCount; i++)
			{
				RogueCard rogueCard = holder.cards.Find((RogueCard c) => c.ParentIndex() == i);
				if (rogueCard != null && rogueCard.cardVisual != null)
				{
					rogueCard.cardVisual.gameObject.SetActive(value: false);
				}
			}
			canvasGroup.alpha = alpha;
			int finishedCount = 0;
			int totalAnims = targetHandData.HandCount - copiedCardsToAnimate.Count;
			int num = 0;
			List<GameObject> tempCards = new List<GameObject>();
			int finalDeckCount = gameContext.rogueDeck.cards.Count;
			int displayDeckCount = finalDeckCount + (drawnCards?.Count ?? 0);
			RefreshDeckUI(displayDeckCount);
			int i2;
			for (i2 = 0; i2 < targetHandData.HandCount; i2++)
			{
				RogueCardData cardDataAtDisplayIndex = targetHandData.GetCardDataAtDisplayIndex(i2);
				RogueCard rogueCard2 = holder.cards.Find((RogueCard c) => c.ParentIndex() == i2);
				if (copiedCardsToAnimate.Contains(cardDataAtDisplayIndex))
				{
					continue;
				}
				if (rogueCard2 == null)
				{
					finishedCount++;
					continue;
				}
				GameObject tempRogueCard = GetTempRogueCard(holder.transform.parent);
				VisualRogueCard component = tempRogueCard.GetComponent<VisualRogueCard>();
				if (component != null)
				{
					component.ShowCardData(cardDataAtDisplayIndex);
				}
				tempCards.Add(tempRogueCard);
				Vector3 value;
				if (drawnCards != null && drawnCards.Contains(cardDataAtDisplayIndex))
				{
					Vector3 position = ((deckTransPoint != null) ? deckTransPoint.position : holder.transform.position);
					tempRogueCard.transform.position = position;
					tempRogueCard.transform.localScale = Vector3.zero;
					float num2 = (float)num * RogueCardTimeSystem.GetTime("cardDrawInterval");
					num++;
					LeanTween.delayedCall(base.gameObject, num2, (Action)delegate
					{
						displayDeckCount = Mathf.Max(finalDeckCount, displayDeckCount - 1);
						RefreshDeckUI(displayDeckCount);
					});
					AudioManager.Instance.Play("effect", "minigame_activity_5_0", "minigame_activity_5_0_joker_card01", useStream: false);
					LeanTween.scale(tempRogueCard, Vector3.one, 0.4f).setDelay(num2).setEase(LeanTweenType.easeOutBack);
					LeanTween.move(tempRogueCard, rogueCard2.transform.position, 0.4f).setDelay(num2).setEase(LeanTweenType.easeOutCubic)
						.setOnComplete((Action)delegate
						{
							finishedCount++;
						});
				}
				else if (dictionary.TryGetValue(cardDataAtDisplayIndex, out value))
				{
					tempRogueCard.transform.position = value;
					LeanTween.move(tempRogueCard, rogueCard2.transform.position, 0.4f).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
					{
						finishedCount++;
					});
				}
				else
				{
					tempRogueCard.transform.position = rogueCard2.transform.position;
					LeanTween.move(tempRogueCard, rogueCard2.transform.position, 0.4f).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
					{
						finishedCount++;
					});
				}
			}
			yield return new WaitUntil(() => finishedCount >= totalAnims);
			if (copiedCardsToAnimate.Count > 0)
			{
				int copyFinishedCount = 0;
				foreach (RogueCardData item3 in copiedCardsToAnimate)
				{
					RogueCardData item = copySourceMap[item3];
					int sIndex = targetHandData.cardOrder.IndexOf(targetHandData.handCards.IndexOf(item));
					RogueCard sourceSlotCard = holder.cards.Find((RogueCard c) => c.ParentIndex() == sIndex);
					if (sourceSlotCard != null)
					{
						LeanTween.cancel(sourceSlotCard.gameObject);
						LeanTween.rotateZ(sourceSlotCard.gameObject, 15f, 0.2f).setEasePunch().setOnComplete((Action)delegate
						{
							LeanTween.rotateZ(sourceSlotCard.gameObject, 0f, 0.1f);
						});
					}
					if (copyDestToJokerMap.TryGetValue(item3, out var sourceJoker))
					{
						if (jokerHolder != null && jokerHolder.cards != null)
						{
							RogueCard rogueCard3 = jokerHolder.cards.Find((RogueCard j) => gameContext.jokerData.GetCardDataAtDisplayIndex(j.ParentIndex()) == sourceJoker);
							if (rogueCard3 != null)
							{
								VisualJokerCard visualJokerCard = rogueCard3.cardVisual as VisualJokerCard;
								if (visualJokerCard != null)
								{
									visualJokerCard.PlayAnimation("UI_Com_JokerCarditem_chufa");
									visualJokerCard.PlayFlyNum(RogueCardTipSystem.GetTip("ROGUE_CARD_COPY"), FlyNumberType.Normal);
								}
							}
						}
						copyDestToJokerMap.Remove(item3);
					}
					int tIndex = targetHandData.cardOrder.IndexOf(targetHandData.handCards.IndexOf(item3));
					RogueCard rogueCard4 = holder.cards.Find((RogueCard c) => c.ParentIndex() == tIndex);
					GameObject tempRogueCard2 = GetTempRogueCard(holder.transform.parent);
					VisualRogueCard component2 = tempRogueCard2.GetComponent<VisualRogueCard>();
					if (component2 != null)
					{
						component2.ShowCardData(item3);
					}
					tempRogueCard2.transform.position = rogueCard4.transform.position;
					tempRogueCard2.transform.localScale = Vector3.zero;
					tempCards.Add(tempRogueCard2);
					LeanTween.scale(tempRogueCard2, Vector3.one, 0.4f).setEase(LeanTweenType.easeOutBack).setOnComplete((Action)delegate
					{
						copyFinishedCount++;
					});
				}
				yield return new WaitUntil(() => copyFinishedCount >= copiedCardsToAnimate.Count);
				yield return new WaitForSeconds(0.1f);
			}
			yield return null;
			saveSystem.SaveGameData();
			RogueCardSaveSystem.SendTrackingPoint2(gameContext.drawCardPool, saveSystem.GetCurrentData(), gameContext.score, (int)((gameContext.GetTargetScore <= int.MaxValue) ? gameContext.GetTargetScore : int.MaxValue), 4, 0, 0);
			foreach (GameObject item4 in tempCards)
			{
				ReleaseTempRogueCard(item4);
			}
			int i3;
			for (i3 = 0; i3 < targetHandData.HandCount; i3++)
			{
				RogueCard rogueCard5 = holder.cards.Find((RogueCard c) => c.ParentIndex() == i3);
				if (rogueCard5 != null && rogueCard5.cardVisual != null)
				{
					VisualCardBase cardVisual = rogueCard5.cardVisual;
					cardVisual.transform.position = rogueCard5.transform.position;
					cardVisual.transform.localScale = Vector3.one;
					cardVisual.transform.localRotation = Quaternion.identity;
					if (cardVisual is VisualRogueCard visualRogueCard && visualRogueCard.view != null)
					{
						visualRogueCard.view.transform.localRotation = Quaternion.identity;
					}
					cardVisual.gameObject.SetActive(value: true);
				}
			}
			RefreshDeckUI();
			suppressRoundStartForceSelectRefresh = false;
			if (!dontRefresh)
			{
				RefreshUI();
			}
			else
			{
				EndDeferredRefreshUI();
			}
			endedDeferredRefresh = true;
			drawnCards?.Clear();
		}
		finally
		{
			RogueCardGameMain rogueCardGameMain = this;
			rogueCardGameMain.suppressRoundStartForceSelectRefresh = false;
			if (!endedDeferredRefresh)
			{
				rogueCardGameMain.EndDeferredRefreshUI();
			}
			drawCardLock?.Release();
		}
	}

	public IEnumerator PlayWuChangCopyAnimCoroutine()
	{
		if (copyToDeckQueue.Count == 0)
		{
			yield break;
		}
		InputLockToken inputLock = GetInputLock("WuChangCopy", base.gameObject);
		isWuChangCopyAnimating = true;
		try
		{
			List<Tuple<RogueCardData, RogueCardData>> list = new List<Tuple<RogueCardData, RogueCardData>>(copyToDeckQueue);
			copyToDeckQueue.Clear();
			bool isNormalWuChangStage = curStateUI is RogueCardWuChangUI;
			RogueCardHolder handHolder = null;
			if (curStateUI is RogueCardWuChangUI rogueCardWuChangUI)
			{
				handHolder = rogueCardWuChangUI.handHolder;
			}
			else if (curStateUI is RogueCardPackageUI rogueCardPackageUI)
			{
				handHolder = rogueCardPackageUI.wuChangUI.handHolder;
			}
			if (handHolder == null)
			{
				yield break;
			}
			List<RogueCardData> copiedCardsToAnimate = new List<RogueCardData>();
			Dictionary<RogueCardData, RogueCardData> dictionary = new Dictionary<RogueCardData, RogueCardData>();
			foreach (Tuple<RogueCardData, RogueCardData> item in list)
			{
				copiedCardsToAnimate.Add(item.Item2);
				dictionary[item.Item2] = item.Item1;
			}
			Dictionary<RogueCardData, Vector3> dictionary2 = new Dictionary<RogueCardData, Vector3>();
			foreach (RogueCard card in handHolder.cards)
			{
				if (card != null && card.gameObject.activeInHierarchy && card.cardVisual != null)
				{
					RogueCardData cardDataAtDisplayIndex = gameContext.wuChangWaitCards.GetCardDataAtDisplayIndex(card.ParentIndex());
					if (cardDataAtDisplayIndex != null && !IsNewCard(cardDataAtDisplayIndex))
					{
						dictionary2[cardDataAtDisplayIndex] = card.cardVisual.transform.position;
					}
				}
			}
			HandData<RogueCardData> wuChangWaitCards = gameContext.wuChangWaitCards;
			List<RogueCardData> orderedHandData = wuChangWaitCards.GetOrderedHandData();
			int[] selectIndexList = wuChangWaitCards.GetSelectIndexList();
			HashSet<RogueCardData> hashSet = new HashSet<RogueCardData>();
			int[] array = selectIndexList;
			foreach (int displayIndex in array)
			{
				RogueCardData cardDataAtDisplayIndex2 = wuChangWaitCards.GetCardDataAtDisplayIndex(displayIndex);
				if (cardDataAtDisplayIndex2 != null)
				{
					hashSet.Add(cardDataAtDisplayIndex2);
				}
			}
			List<RogueCardData> list2 = new List<RogueCardData>();
			foreach (RogueCardData item2 in orderedHandData)
			{
				if (!IsNewCard(item2))
				{
					list2.Add(item2);
				}
			}
			List<RogueCardData> list3 = new List<RogueCardData>();
			foreach (RogueCardData item3 in list2)
			{
				list3.Add(item3);
				foreach (Tuple<RogueCardData, RogueCardData> item4 in list)
				{
					if (item4.Item1 == item3)
					{
						list3.Add(item4.Item2);
					}
				}
			}
			wuChangWaitCards.ClearCard();
			wuChangWaitCards.DeSelect();
			for (int j = 0; j < list3.Count; j++)
			{
				wuChangWaitCards.AddCardToHand(list3[j]);
				if (hashSet.Contains(list3[j]) || IsNewCard(list3[j]))
				{
					wuChangWaitCards.selectedCardIndex.AddLast(j);
				}
			}
			handHolder.ShowCard(gameContext.wuChangWaitCards);
			Canvas.ForceUpdateCanvases();
			foreach (RogueCard card2 in handHolder.cards)
			{
				if (card2 != null && card2.gameObject.activeInHierarchy && card2.cardVisual != null)
				{
					bool isSelected = Array.IndexOf(gameContext.wuChangWaitCards.GetSelectIndexList(), card2.ParentIndex()) >= 0;
					if (card2.cardVisual is VisualRogueCard visual)
					{
						ResetNormalWuChangCardVisual(visual, isSelected);
					}
					card2.cardVisual.gameObject.SetActive(value: false);
				}
			}
			int finishedCount = 0;
			int totalAnims = 0;
			List<GameObject> tempCards = new List<GameObject>();
			foreach (RogueCard card3 in handHolder.cards)
			{
				if (card3 == null || !card3.gameObject.activeInHierarchy)
				{
					continue;
				}
				RogueCardData cardDataAtDisplayIndex3 = gameContext.wuChangWaitCards.GetCardDataAtDisplayIndex(card3.ParentIndex());
				if (cardDataAtDisplayIndex3 != null && !IsNewCard(cardDataAtDisplayIndex3))
				{
					GameObject tempRogueCard = GetTempRogueCard(handHolder.transform.parent);
					VisualRogueCard component = tempRogueCard.GetComponent<VisualRogueCard>();
					if (component != null)
					{
						component.ShowCardData(cardDataAtDisplayIndex3);
						bool flag = Array.IndexOf(gameContext.wuChangWaitCards.GetSelectIndexList(), card3.ParentIndex()) >= 0;
						component.SetSelect(flag);
					}
					tempCards.Add(tempRogueCard);
					if (dictionary2.TryGetValue(cardDataAtDisplayIndex3, out var value))
					{
						tempRogueCard.transform.position = value;
					}
					else
					{
						tempRogueCard.transform.position = card3.transform.position;
					}
					totalAnims++;
					LeanTween.move(tempRogueCard, card3.transform.position, 0.4f).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
					{
						finishedCount++;
					});
				}
			}
			if (copiedCardsToAnimate.Count > 0)
			{
				int copyFinishedCount = 0;
				foreach (RogueCardData item5 in copiedCardsToAnimate)
				{
					RogueCardData key = dictionary[item5];
					Vector3 vector = handHolder.transform.position + new Vector3(0f, 150f, 0f);
					if (dictionary2.TryGetValue(key, out var value2))
					{
						vector = value2 + new Vector3(0f, 1f, 0f);
					}
					Vector3 to = vector;
					int value3 = -1;
					Transform transform = null;
					foreach (RogueCard card4 in handHolder.cards)
					{
						if (card4 != null && card4.gameObject.activeInHierarchy && gameContext.wuChangWaitCards.GetCardDataAtDisplayIndex(card4.ParentIndex()) == item5)
						{
							value3 = card4.ParentIndex();
							to = card4.transform.position;
							transform = card4.transform.parent.transform;
							break;
						}
					}
					GameObject gameObject = ((!(transform != null)) ? GetTempRogueCard(handHolder.transform.parent) : GetTempRogueCard(transform));
					VisualRogueCard component2 = gameObject.GetComponent<VisualRogueCard>();
					if (component2 != null)
					{
						component2.ShowCardData(item5);
						component2.SetSelect(Array.IndexOf(gameContext.wuChangWaitCards.GetSelectIndexList(), value3) >= 0);
					}
					gameObject.transform.position = vector;
					tempCards.Add(gameObject);
					LeanTween.move(gameObject, to, 0.4f).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
					{
						copyFinishedCount++;
					});
				}
				yield return new WaitUntil(() => copyFinishedCount >= copiedCardsToAnimate.Count && finishedCount >= totalAnims);
				yield return new WaitForSeconds(0.15f);
			}
			else
			{
				yield return new WaitUntil(() => finishedCount >= totalAnims);
			}
			foreach (GameObject item6 in tempCards)
			{
				ReleaseTempRogueCard(item6);
			}
			gameContext.wuChangWaitCards.DeSelect();
			foreach (RogueCard card5 in handHolder.cards)
			{
				if (card5 != null && card5.gameObject.activeInHierarchy && card5.cardVisual != null)
				{
					VisualCardBase cardVisual = card5.cardVisual;
					cardVisual.gameObject.SetActive(value: true);
					cardVisual.transform.position = card5.transform.position;
					cardVisual.transform.localScale = Vector3.one;
					cardVisual.transform.localRotation = Quaternion.identity;
					if (cardVisual is VisualRogueCard visualRogueCard && visualRogueCard.view != null)
					{
						visualRogueCard.view.transform.localScale = Vector3.one;
						visualRogueCard.view.transform.localRotation = Quaternion.identity;
						visualRogueCard.view.transform.localPosition = Vector3.zero;
						ResetNormalWuChangCardVisual(visualRogueCard, isSelected: false);
					}
				}
			}
			RefreshUI();
			bool IsNewCard(RogueCardData data)
			{
				foreach (RogueCardData item7 in copiedCardsToAnimate)
				{
					if (item7 == data)
					{
						return true;
					}
				}
				return false;
			}
			void ResetNormalWuChangCardVisual(VisualRogueCard visualRogueCard2, bool flag2)
			{
				if (isNormalWuChangStage && !(visualRogueCard2 == null) && !(visualRogueCard2.view == null))
				{
					visualRogueCard2.transform.localScale = Vector3.one;
					visualRogueCard2.transform.localRotation = Quaternion.identity;
					visualRogueCard2.view.transform.localScale = Vector3.one;
					visualRogueCard2.view.transform.localRotation = Quaternion.identity;
					visualRogueCard2.view.transform.localPosition = Vector3.zero;
					if (visualRogueCard2.view.animator != null && visualRogueCard2.view.animator.isActiveAndEnabled && visualRogueCard2.view.animator.gameObject.activeInHierarchy)
					{
						visualRogueCard2.view.animator.Rebind();
						visualRogueCard2.view.animator.Play("empty", 0, 0f);
						visualRogueCard2.view.animator.Update(0f);
					}
					if (visualRogueCard2.view.rootAni != null && visualRogueCard2.view.rootAni.isActiveAndEnabled && visualRogueCard2.view.rootAni.gameObject.activeInHierarchy)
					{
						visualRogueCard2.view.rootAni.Rebind();
						visualRogueCard2.view.rootAni.Play("empty", 0, 0f);
						visualRogueCard2.view.rootAni.Update(0f);
					}
					visualRogueCard2.SetSelect(flag2);
				}
			}
		}
		finally
		{
			isWuChangCopyAnimating = false;
			inputLock?.Release();
		}
	}

	private List<GameObject> CreateTempCardsForScore(List<RogueCardData> cardDatas, int[] indexes)
	{
		List<GameObject> list = new List<GameObject>();
		List<RogueCard> list2 = new List<RogueCard>();
		for (int i = 0; i < cardDatas.Count; i++)
		{
			RogueCardData data = cardDatas[i];
			int index = indexes[i];
			RogueCard rogueCard = (curStateUI as RogueCardStageUI).handHolder.cards.Find((RogueCard c) => c.ParentIndex() == index);
			if (!(rogueCard == null))
			{
				list2.Add(rogueCard);
				GameObject tempRogueCard = GetTempRogueCard(handCardHandler.transform);
				tempRogueCard.transform.position = rogueCard.transform.position;
				VisualRogueCard component = tempRogueCard.GetComponent<VisualRogueCard>();
				if (component != null)
				{
					component.ShowCardData(data);
				}
				tempRogueCard.transform.localScale = Vector3.one;
				list.Add(tempRogueCard);
			}
		}
		for (int num = 0; num < list2.Count; num++)
		{
			RogueCard rogueCard2 = list2[num];
			if (rogueCard2.cardVisual != null)
			{
				rogueCard2.cardVisual.gameObject.SetActive(value: false);
			}
		}
		return list;
	}

	public IEnumerator AnimatePlayedCardsFlight(List<RogueCardData> cardsToFly, int[] cardsIndexes, List<RogueCardData> un_cardsToFly, int[] un_cardsIndexes, List<GameObject> outPlayedTempGo)
	{
		int finishedCount = 0;
		List<GameObject> unplayedTempGo = new List<GameObject>();
		LayoutElement unplayedLayoutLock = null;
		bool unplayedLayoutLockCreated = false;
		float unplayedLayoutLockPrevMinH = 0f;
		float unplayedLayoutLockPrevPrefH = 0f;
		float unplayedLayoutLockPrevFlexH = 0f;
		bool unplayedLayoutLockPrevIgnore = false;
		if (cardsToFly != null && cardsToFly.Count != 0)
		{
			List<GameObject> list = CreateTempCardsForScore(cardsToFly, cardsIndexes);
			outPlayedTempGo.AddRange(list);
			for (int i = 0; i < list.Count; i++)
			{
				GameObject obj = list[i];
				Transform transform = ((i >= cardScorePoint.Length) ? cardScorePoint[0] : ((cardsToFly.Count == 3 && i < 3) ? cardScorePoint[i] : ((cardsToFly.Count == 2 && i + 3 < cardScorePoint.Length) ? cardScorePoint[i + 3] : ((cardsToFly.Count != 1) ? cardScorePoint[i] : cardScorePoint[1]))));
				LeanTween.move(obj, transform.position, 0.4f).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
				{
					finishedCount++;
				});
			}
		}
		if (un_cardsToFly != null && un_cardsToFly.Count != 0)
		{
			List<GameObject> list2 = CreateTempCardsForScore(un_cardsToFly, un_cardsIndexes);
			(curStateUI as RogueCardStageUI).calController.SetSelectedState("off_on");
			RogueCardHolder handHolder = (curStateUI as RogueCardStageUI).handHolder;
			RectTransform rectTransform = ((handHolder != null) ? (handHolder.transform as RectTransform) : null);
			if (rectTransform != null)
			{
				Canvas.ForceUpdateCanvases();
				LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
				unplayedLayoutLock = handHolder.GetComponent<LayoutElement>();
				if (unplayedLayoutLock == null)
				{
					unplayedLayoutLock = handHolder.gameObject.AddComponent<LayoutElement>();
					unplayedLayoutLockCreated = true;
				}
				unplayedLayoutLockPrevMinH = unplayedLayoutLock.minHeight;
				unplayedLayoutLockPrevPrefH = unplayedLayoutLock.preferredHeight;
				unplayedLayoutLockPrevFlexH = unplayedLayoutLock.flexibleHeight;
				unplayedLayoutLockPrevIgnore = unplayedLayoutLock.ignoreLayout;
				float height = rectTransform.rect.height;
				unplayedLayoutLock.ignoreLayout = false;
				unplayedLayoutLock.minHeight = height;
				unplayedLayoutLock.preferredHeight = height;
				unplayedLayoutLock.flexibleHeight = 0f;
				Canvas.ForceUpdateCanvases();
				if (rectTransform.parent is RectTransform layoutRoot)
				{
					LayoutRebuilder.ForceRebuildLayoutImmediate(layoutRoot);
				}
			}
			handHolder.ChangeHandNum(un_cardsToFly.Count);
			Canvas.ForceUpdateCanvases();
			if (rectTransform != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
			}
			List<Vector3> list3 = new List<Vector3>();
			for (int num = 0; num < list2.Count; num++)
			{
				if (num < handHolder.slots.Count && handHolder.slots[num] != null)
				{
					list3.Add(handHolder.slots[num].transform.position);
				}
				else
				{
					list3.Add(handHolder.transform.position);
				}
			}
			handHolder.ShowCardWithoutSelect(gameContext.handData);
			Canvas.ForceUpdateCanvases();
			if (rectTransform != null)
			{
				LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
			}
			handHolder.HideAllCards();
			for (int num2 = 0; num2 < list2.Count; num2++)
			{
				GameObject item = list2[num2];
				unplayedTempGo.Add(item);
				Vector3 to = list3[num2];
				LeanTween.move(item, to, 0.4f).setEase(LeanTweenType.easeOutCubic).setOnComplete((Action)delegate
				{
					finishedCount++;
				});
			}
		}
		yield return new WaitUntil(() => finishedCount >= cardsToFly.Count + un_cardsToFly.Count);
		if (unplayedLayoutLock != null)
		{
			unplayedLayoutLock.minHeight = unplayedLayoutLockPrevMinH;
			unplayedLayoutLock.preferredHeight = unplayedLayoutLockPrevPrefH;
			unplayedLayoutLock.flexibleHeight = unplayedLayoutLockPrevFlexH;
			unplayedLayoutLock.ignoreLayout = unplayedLayoutLockPrevIgnore;
			if (unplayedLayoutLockCreated)
			{
				UnityEngine.Object.Destroy(unplayedLayoutLock);
			}
		}
		foreach (GameObject item2 in unplayedTempGo)
		{
			ReleaseTempRogueCard(item2);
		}
		foreach (GameObject item3 in outPlayedTempGo)
		{
			item3.SetActive(value: false);
		}
	}

	public IEnumerator AnimateScoredCardsExit(List<GameObject> tempCards, List<RogueCardData> cardDatas)
	{
		if (tempCards == null || tempCards.Count == 0)
		{
			yield break;
		}
		int finishedCount = 0;
		float time = RogueCardTimeSystem.GetTime("cardDrawAnimationDuration");
		for (int i = 0; i < tempCards.Count; i++)
		{
			GameObject tempGo = tempCards[i];
			RogueCardData rogueCardData = cardDatas[i];
			VisualRogueCard component = tempGo.GetComponent<VisualRogueCard>();
			if (component != null)
			{
				component.ShowCardData(rogueCardData);
			}
			if (gameContext.destroyedCardsCache.Contains(rogueCardData))
			{
				VisualRogueCard visualRogueCard = tempGo.GetComponent<VisualCardBase>() as VisualRogueCard;
				if (visualRogueCard != null && visualRogueCard.view != null)
				{
					visualRogueCard.view.PlayAnimation("UI_Com_RogueCardBaseItem_xiaohui");
				}
				LeanTween.delayedCall(tempGo, 0.6f, (Action)delegate
				{
					ReleaseTempRogueCard(tempGo);
					int num = finishedCount;
					finishedCount = num + 1;
				});
			}
			else
			{
				LeanTween.move(tempGo, cardEndPoint.position, time).setEase(cardDrawCurve);
				LeanTween.scale(tempGo, Vector3.zero, time).setEase(LeanTweenType.easeInBack).setOnComplete((Action)delegate
				{
					ReleaseTempRogueCard(tempGo);
					int num = finishedCount;
					finishedCount = num + 1;
				});
			}
		}
		yield return new WaitUntil(() => finishedCount >= tempCards.Count);
	}

	public void ShowSuitLvUp(int handType, int lv)
	{
		if (handType == 0)
		{
			suitLvUpText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_ADD_LEVEL_ALL", lv.ToString());
			StartCoroutine(showSuitLvUp());
		}
		else
		{
			RogueHandTypeCfg rogueHandTypeCfg = RogueCardDataManager.handTypeDatabase[(HandType)handType];
			suitLvUpText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_ADD_LEVEL_TARGET", rogueHandTypeCfg.name, lv.ToString());
			StartCoroutine(showSuitLvUp());
		}
	}

	private IEnumerator showSuitLvUp()
	{
		suitLvUpGo.SetActive(value: true);
		yield return new WaitForSeconds(1.2f);
		suitLvUpGo.SetActive(value: false);
	}

	public bool CardsReadyToPlay()
	{
		return true;
	}

	public void HandlePlayerInput()
	{
	}

	public bool PlayerFinishedTurn()
	{
		if (isHandle)
		{
			isHandle = false;
			return true;
		}
		return isHandle;
	}

	public bool CheckNoCard()
	{
		if (gameContext.handData.HandCount == 0 && gameContext.rogueDeck.cards.Count == 0)
		{
			gameContext.result = gameContext.stageType == LevelType.Challenge && gameContext.curRound > gameContext.allRoundNum;
			return true;
		}
		return false;
	}

	public void EnterTurnSettleState(Action action)
	{
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		RogueCardGameContext rogueCardGameContext = gameContext;
		if (rogueCardGameContext != null && rogueCardGameContext.stageType == LevelType.Challenge)
		{
			double num = 0.0;
			int settleRound = gameContext.GetSettleRound();
			gameContext.settleContext.round = settleRound;
			if (settleRound < -1)
			{
				num = 0.0;
			}
			else if (settleRound >= score_maxRoundScore.Count)
			{
				settleRound = score_maxRoundScore.Count - 1;
				num = score_maxRoundScore[settleRound];
			}
			else
			{
				num = score_maxRoundScore[settleRound];
			}
			double num2 = ((gameContext.settleContext.maxScore == int.MaxValue) ? ((float)max_round_score) : Mathf.Pow(gameContext.settleContext.maxScore, score_ratio));
			gameContext.settleContext.score = (int)Math.Floor(Math.Pow(num + num2, score_diffScore[gameContext.challengeDifficulty - 1]));
		}
		StartCoroutine(StartExitStageUI(action));
	}

	public void ExitTurnSettleState()
	{
		gameContext.ClearStageData();
	}

	public void EnterTurnSettleStateFromSave()
	{
		SwitchStoryModule(isStory: true);
		storyUI?.RefreshUI();
		ChangeStateUI(StateType.Settle);
		curStateUI?.RefreshUI();
	}

	private IEnumerator StartExitStageUI(Action action)
	{
		InputLockToken endStageLock = GetInputLock("endStage", base.gameObject, 10f);
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		isSettleAni = true;
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		int cardCount = gameContext.GetAllCards.Count - gameContext.rogueDeck.cards.Count;
		yield return StartCoroutine(PlayCardRecallAnimation(cardCount));
		gameContext.ResetDeck();
		isSettleAni = false;
		if (gameContext.stageType == LevelType.Story)
		{
			if (gameContext.curStageState == StageType.Normal)
			{
				yield return StartCoroutine(TurnSettleNormalStory());
			}
			else
			{
				yield return StartCoroutine(TurnSettleBossStory());
			}
		}
		else if (gameContext.stageType == LevelType.Challenge || gameContext.stageType == LevelType.Boss)
		{
			if (gameContext.curStageState == StageType.Normal)
			{
				yield return StartCoroutine(TurnSettleNormalChallenge());
			}
			else
			{
				yield return StartCoroutine(TurnSettleBossChallenge());
			}
		}
		yield return new WaitForSeconds(0.3f);
		gameContext.FinishStage();
		PlayGoldFlyAnimation();
		endStageLock.Release();
		saveSystem.SaveGameData();
		action();
	}

	private IEnumerator TurnSettleBossChallenge()
	{
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		SwitchStoryModule(isStory: true);
		storyUI.OnFinishChallengeStage();
		yield return new WaitForSeconds(1.2f);
		ChangeStateUI(StateType.Settle);
	}

	private IEnumerator TurnSettleNormalChallenge()
	{
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		SwitchStoryModule(isStory: true);
		storyUI.OnFinishNormalStage();
		yield return new WaitForSeconds(1.2f);
		ChangeStateUI(StateType.Settle);
	}

	private IEnumerator TurnSettleNormalStory()
	{
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		SwitchStoryModule(isStory: true);
		storyUI.OnFinishNormalStage();
		storyUI.SelectItem(gameContext.curRound - 1, useLastText: true);
		yield return new WaitForSeconds(0.4f);
		(storyUI as RogueCardStoryUI).RefreshFragmentList();
		yield return new WaitForSeconds(0.3f);
		(storyUI as RogueCardStoryUI).PLayHideAni();
		yield return new WaitForSeconds(0.3f);
		storyUI.SelectItem(-1);
		storyUI.SelectItem(gameContext.curRound - 1);
		yield return new WaitForSeconds(0.4f);
		ChangeStateUI(StateType.Settle);
		RefreshUI();
	}

	private IEnumerator TurnSettleBossStory()
	{
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		SwitchStoryModule(isStory: true);
		storyUI.OnFinishChallengeStage();
		storyUI.SelectItem(gameContext.curRound - 1, useLastText: true);
		yield return new WaitForSeconds(0.4f);
		(storyUI as RogueCardStoryUI).RefreshFragmentList();
		yield return new WaitForSeconds(0.3f);
		(storyUI as RogueCardStoryUI).PLayHideAni();
		yield return new WaitForSeconds(0.3f);
		storyUI.SelectItem(-1);
		storyUI.SelectItem(gameContext.curRound - 1);
		yield return new WaitForSeconds(1.2f);
		ChangeStateUI(StateType.Settle);
		RefreshUI();
	}

	public void FinishStage()
	{
		LuaHelper.CallFunction("RogueCardGameBridge.LuaSettle", true);
		Instance.mainTitle.text = RogueCardTipSystem.GetTip("ROGUE_CARD_COMMUNICATION_LOCK_TITLE");
		if (gameContext.result)
		{
			if (RogueCardDataManager.stageDatabase[gameContext.stageID].type == LevelType.Story)
			{
				StartCoroutine(AllSettleStory());
			}
			else if (RogueCardDataManager.stageDatabase[gameContext.stageID].type == LevelType.Boss)
			{
				StartCoroutine(AllSettleBoss());
			}
			else if (gameContext.isRestoringSave)
			{
				resultCon.SetSelectedState("Challenge");
				int num = 0;
				foreach (KeyValuePair<HandType, int> item in gameContext.settleContext.handTypeUseNum)
				{
					if (num <= item.Value)
					{
						num = item.Value;
						_ = item.Key;
					}
				}
				gameContext.settleContext.round = gameContext.GetSettleRound();
				AppendSettleRecordData();
				RogueCardGameContext rogueCardGameContext = gameContext;
				if (rogueCardGameContext != null && rogueCardGameContext.stageType == LevelType.Challenge)
				{
					double num2 = 0.0;
					int settleRound = gameContext.GetSettleRound();
					gameContext.settleContext.round = settleRound;
					if (settleRound < -1)
					{
						num2 = 0.0;
					}
					else if (settleRound >= score_maxRoundScore.Count)
					{
						settleRound = score_maxRoundScore.Count - 1;
						num2 = score_maxRoundScore[settleRound];
					}
					else
					{
						num2 = score_maxRoundScore[settleRound];
					}
					double num3 = ((gameContext.settleContext.maxScore == int.MaxValue) ? ((float)max_round_score) : Mathf.Pow(gameContext.settleContext.maxScore, score_ratio));
					gameContext.settleContext.score = (int)Math.Floor(Math.Pow(num2 + num3, score_diffScore[gameContext.challengeDifficulty - 1]));
				}
				RogueCardSaveSystem.SendTrackingPoint1(Instance.saveSystem.GetGameData(), isFinish: true, 1, GameContext.score, (int)((GameContext.GetTargetScore <= int.MaxValue) ? GameContext.GetTargetScore : int.MaxValue));
				ChangeStateUI(StateType.FinishSettle);
				curStateUI.RefreshUI();
				saveSystem.SaveGameData();
			}
			else
			{
				StartCoroutine(AllSettleChallenge());
			}
		}
		else
		{
			StartCoroutine(AllSettleLose());
		}
	}

	private IEnumerator AllSettleLose()
	{
		InputLockToken endStageLock = GetInputLock("endStage", base.gameObject);
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		if (gameContext.stageType == LevelType.Challenge)
		{
			storyResultText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOSE_TITLE_EX");
			resultTipCon.SetSelectedState("challenge");
		}
		else
		{
			storyResultText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_LOSE_TITLE");
			resultTipCon.SetSelectedState("normalLose");
		}
		storyResultGo.SetActive(value: true);
		yield return new WaitForSeconds(1f);
		storyResultGo.SetActive(value: false);
		int num = 0;
		foreach (KeyValuePair<HandType, int> item in gameContext.settleContext.handTypeUseNum)
		{
			if (num <= item.Value)
			{
				num = item.Value;
				_ = item.Key;
			}
		}
		gameContext.settleContext.round = gameContext.GetSettleRound();
		RogueCardGameContext rogueCardGameContext = gameContext;
		if (rogueCardGameContext != null && rogueCardGameContext.stageType == LevelType.Challenge)
		{
			int settleRound = gameContext.GetSettleRound();
			gameContext.settleContext.round = settleRound;
			double num2;
			if (settleRound < -1)
			{
				num2 = 0.0;
			}
			else if (settleRound >= score_maxRoundScore.Count)
			{
				settleRound = score_maxRoundScore.Count - 1;
				num2 = score_maxRoundScore[settleRound];
			}
			else
			{
				num2 = score_maxRoundScore[settleRound];
			}
			double num3 = ((gameContext.settleContext.maxScore == int.MaxValue) ? ((float)max_round_score) : Mathf.Pow(gameContext.settleContext.maxScore, score_ratio));
			gameContext.settleContext.score = (int)Math.Floor(Math.Pow(num2 + num3, score_diffScore[gameContext.challengeDifficulty - 1]));
		}
		AppendSettleRecordData();
		if (activeSettle)
		{
			RogueCardSaveSystem.SendTrackingPoint1(Instance.saveSystem.GetGameData(), isFinish: true, 3, GameContext.score, (int)((GameContext.GetTargetScore <= int.MaxValue) ? GameContext.GetTargetScore : int.MaxValue));
		}
		else
		{
			RogueCardSaveSystem.SendTrackingPoint1(Instance.saveSystem.GetGameData(), isFinish: true, 2, GameContext.score, (int)((GameContext.GetTargetScore <= int.MaxValue) ? GameContext.GetTargetScore : int.MaxValue));
		}
		ChangeStateUI(StateType.FinishSettle);
		curStateUI.RefreshUI();
		if (gameContext.stageType == LevelType.Challenge)
		{
			saveSystem.SaveGameData();
		}
		endStageLock.Release();
	}

	private void AppendSettleRecordData()
	{
		int stageUseTimeSeconds = GetStageUseTimeSeconds();
		gameContext.stageUseTime = stageUseTimeSeconds;
		gameContext.settleContext.useTime = stageUseTimeSeconds;
		gameContext.settleContext.useItemID.AddRange(gameContext.recordItems);
		gameContext.settleContext.enhanceID.AddRange(gameContext.recordEnhance);
		int num = Mathf.Min(gameContext.wealList.Count, gameContext.woeList.Count);
		for (int i = 0; i < num; i++)
		{
			if (gameContext.wealList[i] != 199)
			{
				gameContext.settleContext.wealWoeID.Add(gameContext.wealList[i]);
			}
			if (gameContext.woeList[i] != 299)
			{
				gameContext.settleContext.wealWoeID.Add(gameContext.woeList[i]);
			}
		}
	}

	private IEnumerator AllSettleStory()
	{
		InputLockToken endStageLock = GetInputLock("endStage", base.gameObject, 10f);
		isSettleAni = true;
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		storyResultText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_WIN_TITLE");
		resultTipCon.SetSelectedState("storyWin");
		storyResultGo.SetActive(value: true);
		yield return new WaitForSeconds(0.6f);
		SwitchStoryModule(isStory: true);
		yield return new WaitForSeconds(0.2f);
		isSettleAni = false;
		storyUI.OnFinishChallengeStage();
		storyUI.SelectItem(gameContext.curRound - 1, useLastText: true);
		yield return new WaitForSeconds(0.4f);
		(storyUI as RogueCardStoryUI).RefreshFragmentList();
		yield return new WaitForSeconds(0.4f);
		(storyUI as RogueCardStoryUI).PLayHideAni();
		yield return new WaitForSeconds(0.3f);
		storyUI.SelectItem(-1);
		storyUI.SelectItem(gameContext.curRound - 1);
		yield return new WaitForSeconds(1.3f);
		storyUI.SetAll();
		yield return new WaitForSeconds(RogueCardTimeSystem.GetTime("story_end"));
		yield return new WaitForSeconds(0.8f);
		storyResultGo.SetActive(value: false);
		int num = 0;
		foreach (KeyValuePair<HandType, int> item in gameContext.settleContext.handTypeUseNum)
		{
			if (num <= item.Value)
			{
				num = item.Value;
				_ = item.Key;
			}
		}
		gameContext.settleContext.round = gameContext.GetSettleRound();
		AppendSettleRecordData();
		ChangeStateUI(StateType.FinishSettle);
		curStateUI.RefreshUI();
		endStageLock.Release();
	}

	private IEnumerator AllSettleBoss()
	{
		InputLockToken endStageLock = GetInputLock("endStage", base.gameObject, 10f);
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		storyResultText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_WIN_TITLE");
		resultTipCon.SetSelectedState("storyWin");
		storyResultGo.SetActive(value: true);
		yield return new WaitForSeconds(0.6f);
		SwitchStoryModule(isStory: true);
		yield return new WaitForSeconds(0.2f);
		if (RogueCardDataManager.stageDatabase[gameContext.stageID].type != LevelType.Boss)
		{
			storyUI.OnFinishChallengeStage();
			yield return new WaitForSeconds(RogueCardTimeSystem.GetTime("story_item"));
		}
		storyUI.SetAll();
		yield return new WaitForSeconds(RogueCardTimeSystem.GetTime("story_end"));
		yield return new WaitForSeconds(1.2f);
		storyResultGo.SetActive(value: false);
		int num = 0;
		foreach (KeyValuePair<HandType, int> item in gameContext.settleContext.handTypeUseNum)
		{
			if (num <= item.Value)
			{
				num = item.Value;
				_ = item.Key;
			}
		}
		gameContext.settleContext.round = gameContext.GetSettleRound();
		AppendSettleRecordData();
		ChangeStateUI(StateType.FinishSettle);
		curStateUI.RefreshUI();
		endStageLock.Release();
	}

	private IEnumerator AllSettleChallenge()
	{
		InputLockToken endStageLock = GetInputLock("endStage", base.gameObject, 10f);
		yield return StartCoroutine(PlayDiscardAnimation(discardAll: true));
		yield return new WaitForSeconds(0.2f);
		storyResultText.text = RogueCardTipSystem.GetTip("ROGUE_CARD_WIN_TITLE_EX");
		resultTipCon.SetSelectedState("challenge");
		storyResultGo.SetActive(value: true);
		yield return new WaitForSeconds(0.6f);
		SwitchStoryModule(isStory: true);
		yield return new WaitForSeconds(0.2f);
		if (RogueCardDataManager.stageDatabase[gameContext.stageID].type != LevelType.Boss)
		{
			storyUI.SetAll();
			yield return new WaitForSeconds(RogueCardTimeSystem.GetTime("story_item"));
		}
		storyResultGo.SetActive(value: false);
		int num = 0;
		foreach (KeyValuePair<HandType, int> item in gameContext.settleContext.handTypeUseNum)
		{
			if (num <= item.Value)
			{
				num = item.Value;
				_ = item.Key;
			}
		}
		gameContext.settleContext.round = gameContext.GetSettleRound();
		AppendSettleRecordData();
		RogueCardGameContext rogueCardGameContext = gameContext;
		if (rogueCardGameContext != null && rogueCardGameContext.stageType == LevelType.Challenge)
		{
			int settleRound = gameContext.GetSettleRound();
			gameContext.settleContext.round = settleRound;
			double num2;
			if (settleRound < -1)
			{
				num2 = 0.0;
			}
			else if (settleRound >= score_maxRoundScore.Count)
			{
				settleRound = score_maxRoundScore.Count - 1;
				num2 = score_maxRoundScore[settleRound];
			}
			else
			{
				num2 = score_maxRoundScore[settleRound];
			}
			double num3 = ((gameContext.settleContext.maxScore == int.MaxValue) ? ((float)max_round_score) : Mathf.Pow(gameContext.settleContext.maxScore, score_ratio));
			gameContext.settleContext.score = (int)Math.Floor(Math.Pow(num2 + num3, score_diffScore[gameContext.challengeDifficulty - 1]));
		}
		ChangeStateUI(StateType.FinishSettle);
		curStateUI.RefreshUI();
		saveSystem.SaveGameData();
		endStageLock.Release();
	}

	private void PlayMovie()
	{
		curStateUI?.OnExit();
		curStateUI = null;
		movieBtn.gameObject.SetActive(value: true);
		movieTip.gameObject.SetActive(value: false);
		if (movieGo != null)
		{
			UnityEngine.Object.Destroy(movieGo);
			movieGo = null;
		}
		movieGo = Asset.InstantiateWithoutCache("Widget/System/Activity_JokerCard/Gameplay/rogueCardMovieGo.prefab");
		if (movieGo != null)
		{
			movieGo.transform.SetParent(movieContentTrs, worldPositionStays: false);
		}
		movieController = movieGo.GetComponent<CriManaMovieControllerForUI>();
		moviePlayer = movieController.player;
		moviePlayer.statusChangeCallback = OnMovieStatusChange;
		moviePlayer.SetMaxPictureDataSize(300000u);
		moviePlayer.SetVolume(movieVolume);
		moviePlayer.SetFile(null, "SofdecAsset/activity/alpha_activity_5_0_card.usm");
		movieController.Play();
		wuChangMovieLock = GetInputLock("WuChang", movieGo, 10f);
	}

	private void OnMovieStatusChange(Player.Status status)
	{
		if (status == Player.Status.PlayEnd || status == Player.Status.Error)
		{
			wuChangMovieLock.Release();
			movieController.Stop();
			movieGo.SetActive(value: false);
			EndWuChangMovie();
		}
	}

	private void EndWuChangMovie()
	{
		bool num = gameContext != null && gameContext.isRestoringSave;
		movieBtn.gameObject.SetActive(value: false);
		movieTip.gameObject.SetActive(value: false);
		moviePlayer.Stop();
		moviePlayer.statusChangeCallback = null;
		moviePlayer.Dispose();
		movieController.Stop();
		gameContext.SelectWuChangCard(gameContext.globalAttrDic[AttributeType.HandMaxNum]);
		if (!gameContext.isRestoringSave)
		{
			gameContext.RefreshWuChangData();
			gameContext.wuChangResetNum = GameContext.globalAttrDic[AttributeType.WuChangResetNum];
			gameContext.RefreshWuChangWhiteData();
			gameContext.RefreshWuChangBlackData();
		}
		SetForcedDeckUICount(gameContext.rogueDeck.cards.Count + gameContext.wuChangWaitCards.HandCount, refreshNow: false);
		ChangeStateUI(StateType.WuChang);
		curStateUI.RefreshUI();
		saveSystem.SaveGameData();
		RefreshUI();
		if (num)
		{
			gameContext.isRestoringSave = false;
		}
		movieController = null;
		moviePlayer = null;
		UnityEngine.Object.Destroy(movieGo);
		movieGo = null;
		wuChangMovieEnd = true;
	}

	public bool CheckRoundSuccess()
	{
		long totalScore = gameContext.scoreResult.TotalScore;
		if (totalScore > gameContext.settleContext.maxScore)
		{
			gameContext.settleContext.maxScore = (int)((totalScore >= int.MaxValue) ? int.MaxValue : totalScore);
		}
		long getTargetScore = gameContext.GetTargetScore;
		long num = gameContext.score;
		if (getTargetScore >= int.MaxValue)
		{
			if (gameContext.playNum <= 0)
			{
				return false;
			}
			return true;
		}
		if (num >= int.MaxValue)
		{
			return true;
		}
		if (num < getTargetScore && gameContext.playNum <= 0)
		{
			return false;
		}
		return true;
	}

	public void CompleteStage(bool victory)
	{
		if (victory)
		{
			RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnRoundWin);
		}
	}

	public int GetCurrentScore()
	{
		return gameContext.score;
	}

	public long GetTargetScore()
	{
		return gameContext.GetTargetScore;
	}

	public bool IsStageFinish()
	{
		if (gameContext.curRound > gameContext.allRoundNum && gameContext.stageType == LevelType.Challenge)
		{
			return false;
		}
		if (gameContext.curRound >= gameContext.allRoundNum && gameContext.curStageState == StageType.Boss)
		{
			return true;
		}
		return false;
	}

	public int GetLastTurn()
	{
		return gameContext.playNum;
	}

	private void ChangeStateUI(StateType stateType, bool refreshUI = true)
	{
		if (stateType == StateType.WuChang || stateType == StateType.Shop || stateType == StateType.Package || stateType == StateType.FinishSettle)
		{
			gameContext?.ApplyPendingActionCountsIfNeeded();
		}
		if (null != curStateUI)
		{
			curStateUI.OnExit();
		}
		curStateUI = stateUIList[(int)stateType];
		curStateUI.OnEnter();
		if (stateType != StateType.FinishSettle)
		{
			resultCon.SetSelectedState("Plot");
		}
		else if (gameContext.stageType == LevelType.Challenge && stateType == StateType.FinishSettle)
		{
			resultCon.SetSelectedState("Challenge");
		}
		if (refreshUI)
		{
			RefreshUI();
		}
		HideTips();
	}

	public void WuChangSelectCard(int index)
	{
		gameContext.WuChangSelectCard(index);
		curStateUI.RefreshUI();
	}

	public void WuChangSelectWuChang(int index)
	{
		gameContext.WuChangSelectWuChang(index);
		curStateUI.RefreshUI();
	}

	public void PackageJokerSelect(int index, IRogueCardNeedTip target)
	{
		if (gameContext.packageJokerIndex == index)
		{
			gameContext.packageJokerIndex = -1;
			HideTips();
		}
		else
		{
			gameContext.packageJokerIndex = index;
			int jokerID = gameContext.packageJoker[index];
			int packageJokerVersion = gameContext.GetPackageJokerVersion(index);
			RogueCardItemCfg cfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg x) => x.id == jokerID);
			ShopItemData cfg2 = new ShopItemData
			{
				cfg = cfg,
				type = ItemType.Joker,
				isSaled = false,
				index = index,
				versionID = packageJokerVersion
			};
			ShowTips(cfg2, target);
		}
		curStateUI.RefreshUI();
	}

	public bool CheckIsNew(int type, int id)
	{
		if (type == 1)
		{
			if (gameContext.recordItems.Contains(id))
			{
				return false;
			}
		}
		else
		{
			if (id == 0)
			{
				return false;
			}
			if (gameContext.recordEnhance.Contains(id))
			{
				return false;
			}
		}
		return true;
	}

	public float GetAniTime()
	{
		float num = 0.4f;
		if (isAniSpeedUp)
		{
			num /= 2f;
		}
		return num;
	}

	public void ShowJokerSellGo(bool show)
	{
		jokerSellCon.SetSelectedState(show ? "on" : "off");
	}

	public void OnJokerDrag(bool isDrag, int index)
	{
		ShowJokerSellGo(isDrag);
		if (isDrag)
		{
			RogueCardJokerData joker = gameContext.jokerData.GetCardDataAtDisplayIndex(index);
			RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == joker.id);
			jokerSellText.text = joker.GetPrice().ToString();
		}
	}

	public void SwitchStoryModule(bool isStory)
	{
		storyMode = isStory;
		if (isStory)
		{
			storyContentGo.transform.SetAsLastSibling();
			return;
		}
		storyUI.SelectItem(-1);
		playContentGo.transform.SetAsLastSibling();
	}

	public void SellJoker(int index, VisualJokerCard visual)
	{
		if (gameContext.stageID == 101 || (gameContext.stageID == 102 && (gameContext.curRound == 1 || (gameContext.curRound == 2 && gameContext.curStageState == StageType.Normal && CurState.GetIndex() < 9))))
		{
			LuaHelper.CallFunction("ShowTips", RogueCardTipSystem.GetTip("ROGUE_CARD_101_TEACH_TIPS3"));
			return;
		}
		if (visual != null)
		{
			Vector3 position = visual.transform.position;
			Instance.StartCoroutine(Instance.PlayJokerSellAnimation(visual.gameObject, position));
		}
		RogueCardJokerData joker = gameContext.jokerData.GetCardDataAtDisplayIndex(index);
		RogueCardSaveSystem.SendTrackingPoint3(Instance.saveSystem.GetGameData(), joker.GetPrice(), 2, new List<int> { index });
		gameContext.jokerData.RemoveCard(joker);
		RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == joker.id);
		gameContext.gold += joker.GetPrice();
		joker.Disable();
		RefreshUI();
		HideTips();
		saveSystem.SaveGameData();
	}

	public IEnumerator PlayJokerSellAnimation(GameObject originalVisualGo, Vector3 dropPos)
	{
		GameObject tempCard = UnityEngine.Object.Instantiate(originalVisualGo, originalVisualGo.transform.parent);
		tempCard.SetActive(value: true);
		tempCard.transform.position = dropPos;
		tempCard.transform.SetAsLastSibling();
		VisualJokerCard visualJoker = tempCard.GetComponent<VisualJokerCard>();
		visualJoker.qualityGo.SetActive(value: false);
		if (visualJoker != null)
		{
			visualJoker.enabled = false;
			if (visualJoker.mainAnimator != null)
			{
				visualJoker.mainAnimator.Play("UI_diss_xs", -1, 0f);
			}
		}
		yield return null;
		float seconds = 0.5f;
		if (visualJoker != null && visualJoker.mainAnimator != null)
		{
			AnimatorStateInfo currentAnimatorStateInfo = visualJoker.mainAnimator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.IsName("UI_diss_xs"))
			{
				seconds = currentAnimatorStateInfo.length;
			}
		}
		yield return new WaitForSeconds(seconds);
		UnityEngine.Object.Destroy(tempCard);
	}

	public void ChangeAniSpeed(bool isSpeedUp)
	{
		isAniSpeedUp = isSpeedUp;
	}

	public void ChangeAniSpeed()
	{
		isAniSpeedUp = !isAniSpeedUp;
	}

	public void ShowWoeTip(bool isShow)
	{
		if (isShow)
		{
			woeTipAnimator.Rebind();
		}
		woeTipGo.SetActive(isShow);
	}

	public void HideTips()
	{
		commonTip.RefreshUI();
		wealTipGo.SetActive(value: false);
		Instance.gameContext.selectJokerIndex = -1;
	}

	public void ShowTips(RogueCardData data, IRogueCardNeedTip target)
	{
		commonTip.RefreshUI(cardTipTrans, data, target);
	}

	public void ShowTips(RogueCardJokerData joker, IRogueCardNeedTip target)
	{
		commonTip.RefreshUI(cardTipTrans, joker, target);
	}

	public void ShowTips(int wuChangID, IRogueCardNeedTip target)
	{
		commonTip.RefreshUI(cardTipTrans, wuChangID, target);
	}

	public void ShowTips(ShopItemData cfg, IRogueCardNeedTip target)
	{
		commonTip.RefreshUI(cardTipTrans, cfg, target);
	}

	public void ShowTips(RogueCardPackageCfg cfg, IRogueCardNeedTip target)
	{
		commonTip.RefreshUI(cardTipTrans, cfg, target);
	}

	public void RecordItem(int type, int id)
	{
		if (type == 1)
		{
			gameContext.recordItems.Add(id);
		}
		else
		{
			gameContext.recordEnhance.Add(id);
		}
	}

	public void ChallengeContinue()
	{
		gameContext.isChallengeContinue = true;
		if (storyUI is RogueCardStoryChallengeUI rogueCardStoryChallengeUI)
		{
			rogueCardStoryChallengeUI.falseImg.gameObject.SetActive(value: false);
			rogueCardStoryChallengeUI.trueImg.gameObject.SetActive(value: false);
		}
		StartCoroutine(ContinueToNextStage());
	}

	public int GetStageUseTimeSeconds()
	{
		if (gameContext == null)
		{
			return 0;
		}
		int num = Mathf.FloorToInt(Mathf.Max(0f, Time.realtimeSinceStartup - stageUseTimeStartRealtime));
		return Mathf.Max(0, stageUseTimeBaseSeconds + num);
	}

	private void BeginStageUseTimeTracking(int initialSeconds)
	{
		stageUseTimeBaseSeconds = Mathf.Max(0, initialSeconds);
		stageUseTimeStartRealtime = Time.realtimeSinceStartup;
		if (gameContext != null)
		{
			gameContext.stageUseTime = stageUseTimeBaseSeconds;
			gameContext.settleContext.useTime = stageUseTimeBaseSeconds;
		}
	}

	private IEnumerator ContinueToNextStage()
	{
		gameContext.isChallengeContinue = true;
		(storyUI as RogueCardStoryChallengeUI).OnContinueStage();
		yield return new WaitForSeconds(0.4f);
		ChangeMainState(new TurnSettleState());
	}

	public int GetMiniStage()
	{
		return (int)gameContext.curStageState;
	}

	public int GetGuideState()
	{
		if (mainStateMachine.GetCurrentState() is SelectStageState)
		{
			return 1;
		}
		if (mainStateMachine.GetCurrentState().GetIndex() == 5)
		{
			return 2;
		}
		if (mainStateMachine.GetCurrentState() is WuChangState)
		{
			if (wuChangMovieEnd)
			{
				return 3;
			}
			return 2;
		}
		if (mainStateMachine.GetCurrentState() is ShopState)
		{
			return 4;
		}
		if (mainStateMachine.GetCurrentState().GetIndex() == 7 && !mainStateMachine.GetCurrentState().GetIsEnterAni())
		{
			return 5;
		}
		return -1;
	}

	public void LockGuide(int type, int[] lockIndex)
	{
		guideSystem.LockCard(type, lockIndex);
	}

	public void UnlockGuide()
	{
		guideSystem.UnlockCard();
	}

	public bool CheckSelectCard(int card1, int card2, int card3)
	{
		int[] selectIndexList = gameContext.GetSelectIndexList();
		if (selectIndexList.contains(card1) && selectIndexList.contains(card2) && selectIndexList.contains(card3))
		{
			return true;
		}
		return false;
	}

	public bool CheckSelectShopItem(int index)
	{
		if (gameContext.shopData.selectIndex == index)
		{
			return true;
		}
		return false;
	}

	public bool CheckSelectPackageItem(int index)
	{
		if (gameContext.packageJokerIndex == index)
		{
			return true;
		}
		return false;
	}

	public bool CheckSelectJokerItem(int index)
	{
		if (gameContext.selectJokerIndex == index)
		{
			return true;
		}
		return false;
	}

	public void ConfirmGame()
	{
		activeSettle = true;
		if (gameContext.stageType == LevelType.Challenge && gameContext.curRound == 6 && gameContext.curStageState == StageType.Boss && CurState.GetIndex() >= 7)
		{
			gameContext.result = true;
		}
		else
		{
			gameContext.result = false;
		}
		ChangeMainState(new SettleState());
	}

	public bool CheckShowPause()
	{
		if (CurState == null)
		{
			return false;
		}
		if (gameContext.stageID == 101 || gameContext.stageID == 102)
		{
			return true;
		}
		if (gameContext.curRound == 1 && CurState.GetIndex() <= 2)
		{
			if (gameContext.stageType == LevelType.Boss)
			{
				return true;
			}
			if (gameContext.curStageState == StageType.Normal)
			{
				return true;
			}
		}
		return false;
	}

	public void GMSetAttr()
	{
		try
		{
			string[] array = gmStr.Split(" ");
			int num = int.Parse(array[0]);
			int key = int.Parse(array[1]);
			int num2 = int.Parse(array[2]);
			if (num == 0 || num == 2)
			{
				GameContext.globalAttrDic[(AttributeType)key] = num2;
			}
			else
			{
				GameContext.globalAttrDic[(AttributeType)key] += num2;
			}
			RefreshUI();
		}
		catch (Exception)
		{
			Debug.LogError("请检查格式");
		}
	}

	public void GMAddGold()
	{
		try
		{
			int num = int.Parse(gmStr);
			gameContext.gold += num;
			RefreshUI();
		}
		catch (Exception)
		{
			Debug.LogError("请检查格式");
		}
	}

	public void GMAddPlayNum()
	{
		try
		{
			if (CurState is StageState)
			{
				int num = int.Parse(gmStr);
				gameContext.playNum += num;
				RefreshUI();
			}
		}
		catch (Exception)
		{
			Debug.LogError("请检查格式");
		}
	}

	public void GMAddDisCardNum()
	{
		try
		{
			if (CurState is StageState)
			{
				int num = int.Parse(gmStr);
				gameContext.discardNum += num;
				RefreshUI();
			}
		}
		catch (Exception)
		{
			Debug.LogError("请检查格式");
		}
	}

	public void GMSetJoker()
	{
		if (CurState is ShopState)
		{
			if (!int.TryParse(gmStr, out var id))
			{
				Debug.LogError("请输入ID");
			}
			gameContext.shopData.shopItemDataList.Clear();
			RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg c) => c.id == id);
			ShopItemData item = new ShopItemData
			{
				cfg = rogueCardItemCfg,
				type = rogueCardItemCfg.type,
				isSaled = false,
				index = 0
			};
			gameContext.shopData.shopItemDataList.Add(item);
			RefreshUI();
		}
		else
		{
			Debug.LogError("当前不在商店阶段");
		}
	}

	public void GMGetJoker()
	{
		if (!int.TryParse(gmStr, out var result))
		{
			Debug.LogError("请输入ID");
		}
		RogueCardJokerData jokerData = RogueCardJokerData.CreateJokerCard(result);
		GainJokerCard(jokerData);
	}

	public void GMSetPackage()
	{
		if (CurState is ShopState)
		{
			if (!int.TryParse(gmStr, out var result))
			{
				Debug.LogError("请输入ID");
			}
			gameContext.shopData.shopPackageDataList.Clear();
			if (!RogueCardDataManager.packageDatabase.TryGetValue(result, out var value))
			{
				Debug.LogError($"无效的卡包ID: {result}");
				return;
			}
			ShopPackageData item = new ShopPackageData
			{
				cfg = value,
				isSaled = false,
				index = 0
			};
			gameContext.shopData.shopPackageDataList.Add(item);
			RefreshUI();
		}
		else
		{
			Debug.LogError("当前不在商店阶段");
		}
	}

	public void GMSetWealWoe()
	{
		try
		{
			string[] array = gmStr.Split(" ");
			int item = int.Parse(array[0]);
			int item2 = int.Parse(array[1]);
			int count = gameContext.wealList.Count;
			gameContext.wealList.RemoveAt(count - 1);
			gameContext.woeList.RemoveAt(count - 1);
			gameContext.wealList.Add(item);
			gameContext.woeList.Add(item2);
			RefreshUI();
		}
		catch (Exception)
		{
			Debug.LogError("请检查格式");
		}
	}

	public void GMWin()
	{
		if (CurState is StageState)
		{
			if ((CurState as StageState).CheckStageFinish())
			{
				gameContext.resultContinue = true;
				ChangeMainState(new SettleState());
			}
			else
			{
				CompleteStage(victory: true);
				ChangeMainState(new TurnSettleState());
			}
		}
		else
		{
			Debug.LogError("当前不在关卡阶段");
		}
	}
}

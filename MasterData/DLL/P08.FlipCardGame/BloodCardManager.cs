using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using ControllerExSpace;
using LuaInterface;
using P08.Quiz;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public sealed class BloodCardManager : MonoSingleton<BloodCardManager>
{
	private struct cardInfo
	{
		public int id;

		public int needPoint;

		public int type;
	}

	private const float SUFFER_TIME = 30f;

	public PlayerHand PlayerCardHand;

	public EnemyHand EnemyCardHand;

	public Deck PlayerCardDeck;

	public Deck EnemyCardDeck;

	public Deck CardPoolDeck;

	public Deck ChangeCardDeck;

	public GameObject ScreenAniRoot;

	public BloodCardBoard Board;

	public VisualCardsHandler VisualCards;

	public GameObject slotPrefab;

	public GameObject turnGo;

	public GameObject tipsPopGo;

	public GameObject tipsGO;

	public GameObject selfPointEffectGo;

	public GameObject enemyPointEffectGo;

	public GameObject selfResultPointEffectGo;

	public GameObject enemyResultPointEffectGo;

	public Button buttonCancel;

	public Button buttonOk;

	public Button needChangeBtn;

	public Button resultMaskBtn;

	public Button resultYesBtn;

	public Text timeText;

	public Text ChangeSelectNumText;

	public Text firstPlayerScoreText;

	public Text lastPlayerScoreText;

	public Text firstResultPlayerScoreText;

	public Text lastResultPlayerScoreText;

	public Text failTitleText;

	public Text drawTitleText;

	public Text failBtnText;

	public ControllerExCollection controller;

	public ControllerExCollection resultController;

	public ControllerExCollection turnController;

	public ControllerExCollection tipsController;

	public GameObject curveLinePoint;

	public float BezierOffset = 0.15f;

	public float BezierTime = 0.15f;

	public float scoreAniDuration = 1f;

	public float scoreIncrementTime = 0.1f;

	[HideInInspector]
	public ControllerEx stateController;

	[HideInInspector]
	public ControllerEx resultStateController;

	[HideInInspector]
	public ControllerEx turnStateController;

	[HideInInspector]
	public ControllerEx tipsStateController;

	[Header("游戏设置")]
	public int InitCardNum = 30;

	public int guideIndex;

	public int guideID;

	public int stepID;

	public int DealCardNum = 5;

	public float moveCardAniDuration = 2f;

	public float stepMoveCardAniDuration = 0.1f;

	[SerializeField]
	private float sufferWatingTime;

	[SerializeField]
	private float placeCardTime;

	[SerializeField]
	private float backUPTime;

	[Header("游戏内状态")]
	[SerializeField]
	private bool hasReset;

	[SerializeField]
	private int gameRound;

	[SerializeField]
	public int groupIndex = 1;

	[SerializeField]
	public List<int> handCardIds = new List<int>();

	[SerializeField]
	private List<Card> CardPool = new List<Card>();

	[SerializeField]
	public int startGameTimestamp;

	[SerializeField]
	public int drawCardTimestamp;

	[SerializeField]
	public bool isPlayerFirst;

	[SerializeField]
	private float remainingSufferWatingTime;

	public bool isDecidedSuffer;

	private bool needSuffer;

	private bool playerSufferDone;

	private bool enemySufferDone;

	private bool enemyCantPutCard;

	public bool selfCantPutCard;

	public bool playerSufferAniDone;

	public bool playingEffectDone;

	public bool isDrawCardDone;

	public bool isDealCardDone;

	public bool enemyPlaceOverlayCard;

	public bool isAbandon;

	public bool enemyPlaceCardDone = true;

	public bool selfPlaceCardDone = true;

	private bool isEnemyDealCardDone;

	public static string CUE_NAME = "minigame_activity_3_10";

	[SerializeField]
	public List<int> sufferCardIndexs = new List<int>();

	[SerializeField]
	private float playerRemainLeftTime;

	[SerializeField]
	private float playerBackupLeftTime;

	[HideInInspector]
	public int placingIndex;

	[HideInInspector]
	public Card placingCard;

	public bool isMultiGame;

	public LuaState luaState;

	public float ObservationTime
	{
		get
		{
			if (sufferWatingTime != 0f)
			{
				return sufferWatingTime;
			}
			return 30f;
		}
		set
		{
			sufferWatingTime = value;
		}
	}

	[SerializeField]
	public List<Card> handCards
	{
		get
		{
			return PlayerCardHand.cards;
		}
		set
		{
		}
	}

	[SerializeField]
	public List<Card> enemyHandCards
	{
		get
		{
			return EnemyCardHand.cards;
		}
		set
		{
		}
	}

	[SerializeField]
	public List<Card> changeDeckCards
	{
		get
		{
			return ChangeCardDeck.cards;
		}
		set
		{
		}
	}

	public float RemainingSufferWatingTime
	{
		get
		{
			if (!(remainingSufferWatingTime < 0f))
			{
				return remainingSufferWatingTime;
			}
			return 0f;
		}
		set
		{
			remainingSufferWatingTime = value;
		}
	}

	public float PlayerRemainLeftTime
	{
		get
		{
			if (!(playerRemainLeftTime < 0f))
			{
				return playerRemainLeftTime;
			}
			return 0f;
		}
		set
		{
			playerRemainLeftTime = value;
		}
	}

	public float PlayerBackupLeftTime
	{
		get
		{
			if (!(playerBackupLeftTime < 0f))
			{
				return playerBackupLeftTime;
			}
			return 0f;
		}
		set
		{
			playerBackupLeftTime = value;
		}
	}

	public BloodCardEnum.GameStatus CurrentStatus { get; private set; }

	protected override void Awake()
	{
		luaState = LuaHelper.GetFunc("SendStartBloodardGameRequest").GetLuaState();
		base.Awake();
		stateController = controller.GetController("state");
		resultStateController = resultController.GetController("state");
		turnStateController = turnController.GetController("turn");
		tipsStateController = tipsController.GetController("tips");
		resultYesBtn.onClick.RemoveAllListeners();
		resultYesBtn.onClick.AddListener(delegate
		{
			isMultiGame = false;
			LuaHelper.CallFunction("BloodCardGoToHome");
		});
		resultMaskBtn.onClick.RemoveAllListeners();
		resultMaskBtn.onClick.AddListener(delegate
		{
			isMultiGame = false;
			LuaHelper.CallFunction("BloodCardGoToHome");
		});
		failTitleText.text = LuaHelper.CallFunction("GetTips", "ACTIVITY_BLOOD_CARD_GAME_DEFEAT_TIPS_TEXT")[0].ToString();
		drawTitleText.text = LuaHelper.CallFunction("GetTips", "ACTIVITY_BLOOD_CARD_GAME_DEFEAT_TIPS_TEXT")[0].ToString();
		failBtnText.text = LuaHelper.CallFunction("GetTips", "ACTIVITY_BLOOD_CARD_GAME_DEFEAT_BUTTON_TEXT")[0].ToString();
		CurrentStatus = BloodCardEnum.GameStatus.PREPARE;
	}

	public void StartGame(int order, int[] cardIDList, int[] selfLimitCardList, int[] enemyLimitCardList)
	{
		if (guideIndex != 1)
		{
			stateController.SetSelectedState("changeCard");
		}
		else
		{
			stateController.SetSelectedState("gaming");
		}
		TransitionToNextState(BloodCardEnum.GameStatus.PREPARE, 0.1f);
		Debug.Log("Game started, preparing for match.");
		isPlayerFirst = order == 1;
		Board.UpdateBoardIndex(isPlayerFirst);
		startGameTimestamp = (int)(double)LuaHelper.CallFunction("GetServerTime")[0];
		PlayerBackupLeftTime = backUPTime;
		InitCardItem(selfLimitCardList, enemyLimitCardList);
		handCardIds = cardIDList.ToList();
		tipsGO.SetActive(value: false);
		playerSufferDone = true;
		playingEffectDone = true;
		isDealCardDone = false;
		playerSufferAniDone = false;
		isEnemyDealCardDone = false;
		enemyPlaceOverlayCard = false;
		isDecidedSuffer = false;
		hasReset = false;
		isAbandon = false;
		TransitionToNextState(BloodCardEnum.GameStatus.DETERMINEORDER, 1f);
	}

	private void InitCardItem(int[] selfLimitCardList, int[] enemyLimitCardList)
	{
		int num = ((selfLimitCardList.Length != 0 && enemyLimitCardList.Length != 0) ? (selfLimitCardList.Length + enemyLimitCardList.Length) : ((enemyLimitCardList.Length != 0) ? (InitCardNum / 2 + enemyLimitCardList.Length) : ((selfLimitCardList.Length == 0) ? InitCardNum : (InitCardNum / 2 + selfLimitCardList.Length))));
		for (int i = 0; i < InitCardNum; i++)
		{
			if (CardPool[i] == null)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(slotPrefab, CardPoolDeck.transform);
				CardPool[i] = gameObject.transform.GetComponentInChildren<Card>();
				CardPool[i].index = i;
			}
			int num2 = ((selfLimitCardList.Length != 0) ? selfLimitCardList.Length : 15);
			if (i < num2)
			{
				MoveCardToList(CardPoolDeck, PlayerCardDeck, CardPool[i], immediately: true);
			}
			else if (i < num)
			{
				MoveCardToList(CardPoolDeck, EnemyCardDeck, CardPool[i], immediately: true);
			}
			CardPool[i].Show();
		}
		for (int num3 = CardPool.Count - 1; num3 >= num; num3--)
		{
			CardPool[num3]?.Hide();
		}
	}

	public void DetermineOrder()
	{
		CurrentStatus = BloodCardEnum.GameStatus.DETERMINEORDER;
		Debug.Log("Determining order...");
		TransitionToNextState(BloodCardEnum.GameStatus.DRAW_INITIAL_HAND);
	}

	public void DrawInitialHand()
	{
		CurrentStatus = BloodCardEnum.GameStatus.DRAW_INITIAL_HAND;
		Debug.Log("Drawing initial hand...");
		StartCoroutine(DealCards());
		TransitionToNextState(BloodCardEnum.GameStatus.SHUFFLEHAND, 1f);
	}

	private IEnumerator DealCards()
	{
		if (guideIndex == 1)
		{
			StartCoroutine(MoveCardsCoroutine(PlayerCardDeck, PlayerCardHand, PlayerCardDeck.cards, DealCardNum, BloodCardEnum.PlayerRole.SELF, immediately: false, updateImmediately: false, overrideSorting: false, needStep: true, handCardIds));
			stateController.SetSelectedState("gaming");
			AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_change", useStream: false);
		}
		else
		{
			AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_start", useStream: false);
			StartCoroutine(MoveCardsCoroutine(PlayerCardDeck, ChangeCardDeck, PlayerCardDeck.cards, DealCardNum, BloodCardEnum.PlayerRole.SELF, immediately: false, updateImmediately: false, overrideSorting: true, needStep: true, handCardIds, delegate
			{
				isDealCardDone = true;
			}));
		}
		StartCoroutine(MoveCardsCoroutine(EnemyCardDeck, EnemyCardHand, EnemyCardDeck.cards, DealCardNum, BloodCardEnum.PlayerRole.ENEMY, immediately: false, updateImmediately: true, overrideSorting: false, needStep: true, null, delegate
		{
			isEnemyDealCardDone = true;
		}));
		yield break;
	}

	private IEnumerator MoveCardsCoroutine(CardHolder from, CardHolder to, List<Card> cardList, int num, BloodCardEnum.PlayerRole role, bool immediately, bool updateImmediately, bool overrideSorting, bool needStep, List<int> cardIdList = null, Action callback = null, Action stepCallBack = null)
	{
		for (int i = 0; i < num; i++)
		{
			MoveCardToList(from, to, cardList[i], immediately, updateImmediately);
			if (cardIdList != null)
			{
				cardList[i].SetCardData(LazySingleton<LuaCardLoader>.Instance.GetCardData(cardIdList[i]));
				cardList[i].cardVisual.canvas.overrideSorting = overrideSorting;
				if (!updateImmediately)
				{
					cardList[i].place = to.place;
				}
				stepCallBack?.Invoke();
			}
			if (needStep)
			{
				yield return new WaitForSeconds(stepMoveCardAniDuration);
			}
		}
		yield return new WaitForSeconds(moveCardAniDuration);
		if (!updateImmediately)
		{
			from.UpdateCards();
			to.UpdateCards();
		}
		callback?.Invoke();
	}

	public void ShuffleHand()
	{
		CurrentStatus = BloodCardEnum.GameStatus.SHUFFLEHAND;
		playerSufferDone = false;
		enemySufferDone = false;
		RemainingSufferWatingTime = (isMultiGame ? sufferWatingTime : 999f);
		isDecidedSuffer = false;
		if (guideIndex == 1)
		{
			DecideSuffer(need: false);
		}
		playerSufferAniDone = false;
		Debug.Log("Shuffling hand...");
		timeText.text = RemainingSufferWatingTime.ToString();
		needChangeBtn.onClick.RemoveAllListeners();
		needChangeBtn.onClick.AddListener(delegate
		{
			if (isDealCardDone)
			{
				DecideSuffer(need: true);
			}
		});
		needChangeBtn.SetActive(bActive: true);
		StartCoroutine(WatingForInputSuffer());
	}

	public void DecideSuffer(bool need)
	{
		isDecidedSuffer = true;
		needSuffer = need;
		needChangeBtn.SetActive(bActive: false);
	}

	private IEnumerator WatingForInputSuffer()
	{
		sufferCardIndexs.Clear();
		ChangeSelectNumText.transform.parent.gameObject.SetActive(value: true);
		ChangeSelectNumText.text = "0/" + DealCardNum;
		while (RemainingSufferWatingTime > 0f && !isDecidedSuffer)
		{
			yield return null;
			if (CurrentStatus == BloodCardEnum.GameStatus.SHUFFLEHAND)
			{
				RemainingSufferWatingTime -= Time.deltaTime;
				timeText.text = RemainingSufferWatingTime.ToString();
				ChangeSelectNumText.text = sufferCardIndexs.Count + "/" + DealCardNum;
			}
		}
		if (isDecidedSuffer)
		{
			foreach (Card changeDeckCard in changeDeckCards)
			{
				changeDeckCard.SetCardBehavior(new NoInteractionCardBehavior());
			}
			if (needSuffer)
			{
				List<int> sufferCardIDs = new List<int>();
				List<Card> list = new List<Card>();
				foreach (int sufferCardIndex in sufferCardIndexs)
				{
					sufferCardIDs.Add(CardPool[sufferCardIndex].Data().id);
					list.Add(CardPool[sufferCardIndex]);
					CardPool[sufferCardIndex].cardVisual.changeController.SetSelectedState("false");
				}
				StartCoroutine(MoveCardsCoroutine(ChangeCardDeck, PlayerCardDeck, list, list.Count, BloodCardEnum.PlayerRole.SELF, immediately: false, updateImmediately: true, overrideSorting: false, needStep: true, sufferCardIDs, delegate
				{
					handCardIds = GetHandsCardIDs(ChangeCardDeck);
					SendSufferCard(sufferCardIDs.ToArray());
				}, delegate
				{
					AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_up", useStream: false);
				}));
			}
			else
			{
				SendSufferCard(new int[0]);
			}
		}
		if (!isDecidedSuffer)
		{
			SendSufferCard(new int[0]);
		}
		ChangeSelectNumText.transform.parent.gameObject.SetActive(value: false);
		while (!playerSufferDone)
		{
			yield return null;
		}
		stateController.SetSelectedState("gaming");
	}

	public void ReciveSufferResult(int[] cardIDList)
	{
		Debug.Log("ReciveSuffer Result...");
		if (guideIndex != 1)
		{
			if (cardIDList.Length != 0)
			{
				StartCoroutine(MoveCardsCoroutine(PlayerCardDeck, ChangeCardDeck, PlayerCardDeck.cards, cardIDList.Length, BloodCardEnum.PlayerRole.SELF, immediately: false, updateImmediately: true, overrideSorting: true, needStep: true, cardIDList.ToList(), delegate
				{
					handCardIds = GetHandsCardIDs(ChangeCardDeck);
					StartCoroutine(MoveCardsCoroutine(ChangeCardDeck, PlayerCardHand, ChangeCardDeck.cards, ChangeCardDeck.cards.Count, BloodCardEnum.PlayerRole.SELF, immediately: false, updateImmediately: true, overrideSorting: false, needStep: false, handCardIds, delegate
					{
						playerSufferAniDone = true;
					}));
					playerSufferDone = true;
				}, delegate
				{
					AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_down", useStream: false);
				}));
				return;
			}
			handCardIds = GetHandsCardIDs(ChangeCardDeck);
			foreach (Card card in ChangeCardDeck.cards)
			{
				card.SetCardBehavior(new NoInteractionCardBehavior());
				card.cardVisual.changeController.SetSelectedState("false");
			}
			StartCoroutine(MoveCardsCoroutine(ChangeCardDeck, PlayerCardHand, ChangeCardDeck.cards, ChangeCardDeck.cards.Count, BloodCardEnum.PlayerRole.SELF, immediately: false, updateImmediately: true, overrideSorting: false, needStep: false, handCardIds, delegate
			{
				playerSufferAniDone = true;
			}));
			playerSufferDone = true;
		}
		else
		{
			playerSufferDone = true;
			playerSufferAniDone = true;
		}
	}

	[NoToLua]
	public List<int> GetHandsCardIDs(CardHolder cardDeck)
	{
		List<int> list = new List<int>();
		foreach (Card card in cardDeck.cards)
		{
			list.Add(card.Data().id);
		}
		return list;
	}

	public void ReciveEenmySufferHand(int sufferNum)
	{
		Debug.Log("ReciveEenmySuffer Result...");
		StartCoroutine(EnemySufferCard(sufferNum));
	}

	private IEnumerator EnemySufferCard(int sufferNum)
	{
		while (!isEnemyDealCardDone)
		{
			yield return null;
		}
		if (sufferNum > 0)
		{
			StartCoroutine(MoveCardsCoroutine(EnemyCardHand, EnemyCardDeck, EnemyCardHand.cards, sufferNum, BloodCardEnum.PlayerRole.ENEMY, immediately: false, updateImmediately: false, overrideSorting: false, needStep: true, null, delegate
			{
				StartCoroutine(MoveCardsCoroutine(EnemyCardDeck, EnemyCardHand, EnemyCardDeck.cards, sufferNum, BloodCardEnum.PlayerRole.ENEMY, immediately: false, updateImmediately: false, overrideSorting: false, needStep: true, null, delegate
				{
					enemySufferDone = true;
				}, delegate
				{
					AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_down", useStream: false);
				}));
			}, delegate
			{
				AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_up", useStream: false);
			}));
		}
		else
		{
			enemySufferDone = true;
		}
	}

	public void ReciveRoundStart(int round)
	{
		Debug.Log("ReciveRoundStart...");
		gameRound = round;
		StartCoroutine(RoundStart(BloodCardEnum.PlayerRole.SELF));
	}

	private IEnumerator RoundStart(BloodCardEnum.PlayerRole role)
	{
		while (!playerSufferAniDone || !playingEffectDone || turnGo.activeInHierarchy || !enemySufferDone)
		{
			yield return null;
		}
		if (role == BloodCardEnum.PlayerRole.SELF && enemyCantPutCard)
		{
			tipsPopGo.SetActive(value: true);
			tipsStateController.SetSelectedState("tips1");
			yield return new WaitForSeconds(0.5f);
			tipsPopGo.SetActive(value: false);
		}
		if (role == BloodCardEnum.PlayerRole.SELF)
		{
			while (!enemyPlaceCardDone)
			{
				yield return null;
			}
			turnGo.SetActive(value: true);
			turnStateController.SetSelectedState("self", immediately: true);
			yield return new WaitForSeconds(1f);
			turnGo.SetActive(value: false);
			TransitionToNextState(BloodCardEnum.GameStatus.PLAYERROUND);
		}
		else
		{
			while (guideID == 108)
			{
				yield return null;
			}
			turnGo.SetActive(value: true);
			turnStateController.SetSelectedState("enemy", immediately: true);
			yield return new WaitForSeconds(1f);
			turnGo.SetActive(value: false);
			TransitionToNextState(BloodCardEnum.GameStatus.ENEMYROUND);
		}
	}

	public void StartPlayerRound()
	{
		CurrentStatus = BloodCardEnum.GameStatus.PLAYERROUND;
		Debug.Log("Player's round started.");
		selfCantPutCard = false;
		StartCoroutine(PlayerRoundCoroutine());
	}

	public void ReciveDrawCardResult(int[] cardIDList)
	{
		Debug.Log("ReciveDrawCard Result ...");
		StartCoroutine(DrawCardFormDeck(cardIDList.Length, BloodCardEnum.PlayerRole.SELF, cardIDList));
	}

	public void RecevieEndRoundResult()
	{
	}

	private IEnumerator PlayerRoundCoroutine()
	{
		PlayerRemainLeftTime = placeCardTime;
		placingIndex = -1;
		selfPlaceCardDone = false;
		while (!playerSufferAniDone || !playingEffectDone || !enemySufferDone)
		{
			yield return null;
		}
		if (PlayerCardDeck.cards.Count > 0)
		{
			isDrawCardDone = false;
			drawCardTimestamp = (int)(double)LuaHelper.CallFunction("GetServerTime")[0];
			SendDrawCard();
		}
		else
		{
			isDrawCardDone = true;
		}
		while (!isDrawCardDone)
		{
			yield return null;
		}
		if (!CheckCanPlaceCard())
		{
			selfCantPutCard = true;
			tipsPopGo.SetActive(value: true);
			tipsStateController.SetSelectedState("tips2");
			selfPlaceCardDone = true;
			yield return new WaitForSeconds(0.5f);
			tipsPopGo.SetActive(value: false);
			SendJumpRound();
			yield break;
		}
		SetCardRoundBehavior(new PlayerRoundBehavior());
		if (guideIndex == 1 || selfCantPutCard)
		{
			SetBtnFunc(null, null, null, null);
		}
		else
		{
			object[] array = LuaHelper.CallFunction("GetTips", "ACTIVITY_BLOOD_CARD_GAME_JUMP_ROUND");
			SetBtnFunc(SendJumpRound, null, array[0].ToString(), null);
			if (guideIndex != 1 && enemyCantPutCard)
			{
				tipsGO.SetActive(value: true);
			}
		}
		while (PlayerRemainLeftTime > 0f)
		{
			yield return null;
			if (CurrentStatus == BloodCardEnum.GameStatus.PLAYERROUND)
			{
				PlayerRemainLeftTime -= Time.deltaTime;
				timeText.text = PlayerRemainLeftTime.ToString();
			}
		}
		while (PlayerBackupLeftTime > 0f && PlayerRemainLeftTime <= 0f)
		{
			yield return null;
			if (CurrentStatus == BloodCardEnum.GameStatus.PLAYERROUND)
			{
				PlayerBackupLeftTime -= Time.deltaTime;
				timeText.text = PlayerBackupLeftTime.ToString();
			}
		}
		while (PlayerRemainLeftTime <= 0f && PlayerBackupLeftTime <= 0f)
		{
			yield return null;
			if (CurrentStatus == BloodCardEnum.GameStatus.PLAYERROUND)
			{
				if (isMultiGame)
				{
					yield return new WaitForSeconds(0.5f);
					SendJumpRound();
				}
				break;
			}
		}
	}

	public void StartEnemyRound()
	{
		if (CurrentStatus != BloodCardEnum.GameStatus.GAMEOVER)
		{
			CurrentStatus = BloodCardEnum.GameStatus.ENEMYROUND;
		}
		Debug.Log("Enemy's round started.");
	}

	public void ReciveEnemyDrawCard(int round, int drawNum)
	{
		Debug.Log("ReciveEnemyDrawCard...");
		gameRound = round;
		enemyCantPutCard = false;
		StartCoroutine(DrawCardFormDeck(drawNum, BloodCardEnum.PlayerRole.ENEMY));
	}

	public void ReciveEnemyPlaceCard(int round, int cardID, int index, LuaTable influenceList)
	{
		Debug.Log("ReciveEnemyPlaceCard...");
		StartCoroutine(EnemyRoundCourtine(round, cardID, index, influenceList));
	}

	private IEnumerator EnemyRoundCourtine(int round, int cardID, int index, LuaTable influenceList)
	{
		gameRound = round;
		enemyPlaceCardDone = false;
		tipsGO.SetActive(value: false);
		yield return StartCoroutine(RoundStart(BloodCardEnum.PlayerRole.ENEMY));
		if (index != 0)
		{
			while (guideID == 108)
			{
				yield return null;
			}
			CardCell cell = Board.cardCells[index - 1];
			if (cardID != 0)
			{
				int index2 = UnityEngine.Random.Range(0, EnemyCardHand.cards.Count - 1);
				Card card = EnemyCardHand.cards[index2];
				card.SetCardData(LazySingleton<LuaCardLoader>.Instance.GetCardData(cardID));
				if (card.Data().type == 2)
				{
					enemyPlaceOverlayCard = true;
				}
				StartCoroutine(PlaceCardInCell(card, cell, influenceList, BloodCardEnum.PlayerRole.ENEMY));
			}
		}
		else
		{
			enemyPlaceCardDone = true;
			enemyCantPutCard = true;
		}
	}

	private IEnumerator DrawCardFormDeck(int drawNum, BloodCardEnum.PlayerRole role, int[] cardIDList = null)
	{
		switch (role)
		{
		case BloodCardEnum.PlayerRole.SELF:
			isDrawCardDone = false;
			if (PlayerCardDeck.cards.Count > 0)
			{
				AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_draw", useStream: false);
				for (int j = 0; j < drawNum; j++)
				{
					Card card2 = PlayerCardDeck.cards[j];
					card2.SetCardData(LazySingleton<LuaCardLoader>.Instance.GetCardData(cardIDList[j]));
					MoveCardToList(PlayerCardDeck, PlayerCardHand, card2, immediately: false);
				}
				handCardIds = GetHandsCardIDs(PlayerCardHand);
				yield return new WaitForSeconds(1f);
			}
			isDrawCardDone = true;
			break;
		case BloodCardEnum.PlayerRole.ENEMY:
			if (EnemyCardDeck.cards.Count > 0)
			{
				while (guideID == 108)
				{
					yield return null;
				}
				for (int i = 0; i < drawNum; i++)
				{
					Card card = EnemyCardDeck.cards[i];
					AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_draw", useStream: false);
					MoveCardToList(EnemyCardDeck, EnemyCardHand, card, immediately: false);
				}
			}
			break;
		}
	}

	private IEnumerator PlayInfluenceEffect(LuaTable influenceList, BloodCardEnum.PlayerRole role)
	{
		if (influenceList != null && influenceList.Length > 0)
		{
			int infulenceNum = influenceList.Length;
			object[] infulenceArray = influenceList.ToArray();
			for (int i = 0; i < infulenceNum; i++)
			{
				LuaTable obj = infulenceArray[i] as LuaTable;
				int pos = (int)(double)obj["launch_pos"];
				int num = (int)(double)obj["effect_id"];
				int num2 = (int)(double)obj["pos"];
				bool isRemove = (bool)obj["is_remove"];
				TriggerEffect(pos, num, num2, isRemove, role);
				if (num != 0)
				{
					yield return new WaitForSeconds(0.5f);
					continue;
				}
				if (role == BloodCardEnum.PlayerRole.SELF)
				{
					Board.cardCells[num2 - 1].ResetAni(Board.cardCells[num2 - 1].latticeAni);
				}
				else
				{
					Board.cardCells[num2 - 1].ResetAni(Board.cardCells[num2 - 1].EnemylatticeAni);
				}
				Board.cardCells[num2 - 1].enemyLatticeController.SetSelectedState("false");
				Board.cardCells[num2 - 1].latticeController.SetSelectedState("false");
			}
		}
		yield return new WaitForEndOfFrame();
		Board.UpdateBoard();
		if (influenceList != null && influenceList.Length > 0)
		{
			yield return new WaitForSeconds(scoreAniDuration);
		}
		if (role == BloodCardEnum.PlayerRole.SELF)
		{
			SendEndRound();
		}
		playingEffectDone = true;
	}

	private IEnumerator PlaceCardInCell(Card card, CardCell cell, LuaTable influenceList, BloodCardEnum.PlayerRole role)
	{
		while (turnGo.activeInHierarchy || !playingEffectDone || !playerSufferAniDone)
		{
			yield return null;
		}
		while ((role == BloodCardEnum.PlayerRole.ENEMY && CurrentStatus != BloodCardEnum.GameStatus.ENEMYROUND) || (role == BloodCardEnum.PlayerRole.ENEMY && guideID == 108))
		{
			yield return null;
		}
		if (role == BloodCardEnum.PlayerRole.ENEMY && (bool)card)
		{
			LeanTween.moveLocalY(card.gameObject, card.transform.localPosition.y + 20f, 1f).setEase(LeanTweenType.easeInOutBack);
			yield return new WaitForSeconds(1f);
		}
		playingEffectDone = false;
		yield return StartCoroutine(card.PlaceCardCorutine(cell));
		yield return StartCoroutine(PlayInfluenceEffect(influenceList, role));
		foreach (Effect effect in card.Data().effects)
		{
			EffectData effectData = LazySingleton<LuaEffectLoader>.Instance.GetEffectData(effect.id);
			if (effectData.type != 1 || effectData.launchTime != 11)
			{
				continue;
			}
			foreach (Vector2 effectPos in effect.effectPosList)
			{
				int num = ConverPosToIndex(cell.index, effectPos, Board.rows, Board.columns - 2);
				if (num >= 0 && Board.cardCells[num].CurrentCard == null)
				{
					Board.cardCells[num].SetBuffEffectActive(flag: true, card.belongs);
				}
			}
		}
	}

	public void RecivePlaceCardResult(int result, LuaTable influenceList, int useSeconds = -1)
	{
		SetCardRoundBehavior(new EnemyRoundBehavior());
		if (result == 0 && placingIndex != -1)
		{
			StartCoroutine(PlaceCardInCell(placingCard, Board.cardCells[placingIndex], influenceList, BloodCardEnum.PlayerRole.SELF));
		}
		else if (placingIndex == -1)
		{
			SendEndRound();
		}
		if (useSeconds != 0 && (float)useSeconds > placeCardTime)
		{
			PlayerBackupLeftTime -= (float)useSeconds - placeCardTime;
		}
		SetBtnFunc(null, null, null, null);
		placingIndex = -1;
		placingCard = null;
	}

	public void MidPause()
	{
		CurrentStatus = BloodCardEnum.GameStatus.MIDPAUSE;
		Debug.Log("Mid pause...");
	}

	public void ReciveEndGame(int result, int firstPlayerScore, int lastPlayerScore)
	{
		TransitionToNextState(BloodCardEnum.GameStatus.GAMEOVER);
		StartCoroutine(EndGame(result, firstPlayerScore, lastPlayerScore));
	}

	private IEnumerator EndGame(int result, int firstPlayerScore, int lastPlayerScore)
	{
		tipsGO.SetActive(value: false);
		tipsPopGo.SetActive(value: false);
		CurrentStatus = BloodCardEnum.GameStatus.GAMEOVER;
		yield return new WaitForSeconds(1f);
		if (!isAbandon)
		{
			stateController.SetSelectedState("calculate");
			while (guideID == 111)
			{
				yield return null;
			}
			foreach (Card handCard in handCards)
			{
				handCard.isDragging = false;
				handCard.transform.localPosition = Vector3.zero;
				handCard.cardVisual.canvas.overrideSorting = false;
				handCard.SetDragging(dragging: false);
				handCard.GetCanvas().GetComponent<GraphicRaycaster>().enabled = true;
				handCard.GetImageComponent().raycastTarget = true;
				handCard.SetCardSize("big");
			}
			firstPlayerScoreText.text = "0";
			lastPlayerScoreText.text = "0";
			int cachePlayerScore = 0;
			int cacheEnemyScore = 0;
			for (int i = 0; i < 3; i++)
			{
				int score = Board.scoreCells[i].Score;
				int score2 = Board.scoreCells[i + 3].Score;
				if (score > score2)
				{
					Board.scoreCells[i].selfScoreObj.SetActive(value: false);
					Board.scoreCells[i + 3].enemyScoreObj.SetActive(value: false);
					PlayCurveLinePointToPlace(Board.scoreCells[i].transform.position, (isPlayerFirst ? firstPlayerScoreText : lastPlayerScoreText).transform.position);
					yield return new WaitForSeconds(1f);
					AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_gold", useStream: false);
					selfPointEffectGo.SetActive(value: true);
					ParticleSystem[] componentsInChildren = selfPointEffectGo.transform.GetComponentsInChildren<ParticleSystem>();
					foreach (ParticleSystem obj in componentsInChildren)
					{
						ParticleSystem.MainModule main = obj.main;
						main.startLifetime = main.startLifetime.constant;
						obj.Simulate(0f, withChildren: true, restart: true);
						obj.Play();
					}
					yield return StartCoroutine(AnimateScore(firstPlayerScoreText, cachePlayerScore, cachePlayerScore + Board.scoreCells[i].Score, selfPointEffectGo, isResult: true));
					selfPointEffectGo.SetActive(value: false);
					cachePlayerScore += Board.scoreCells[i].Score;
				}
				else if (score2 > score)
				{
					curveLinePoint.transform.position = Board.scoreCells[i + 3].transform.position;
					yield return new WaitForSeconds(1f);
					Board.scoreCells[i].selfScoreObj.SetActive(value: false);
					Board.scoreCells[i + 3].enemyScoreObj.SetActive(value: false);
					PlayCurveLinePointToPlace(Board.scoreCells[i + 3].transform.position, (isPlayerFirst ? lastPlayerScoreText : firstPlayerScoreText).transform.position);
					yield return new WaitForSeconds(1f);
					AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_gold", useStream: false);
					enemyPointEffectGo.SetActive(value: true);
					ParticleSystem[] componentsInChildren = enemyPointEffectGo.transform.GetComponentsInChildren<ParticleSystem>();
					foreach (ParticleSystem obj2 in componentsInChildren)
					{
						ParticleSystem.MainModule main2 = obj2.main;
						main2.startLifetime = main2.startLifetime.constant;
						obj2.Simulate(0f, withChildren: true, restart: true);
						obj2.Play();
					}
					yield return StartCoroutine(AnimateScore(lastPlayerScoreText, cacheEnemyScore, cacheEnemyScore + Board.scoreCells[i + 3].Score, enemyPointEffectGo, isResult: true));
					enemyPointEffectGo.SetActive(value: false);
					cacheEnemyScore += Board.scoreCells[i + 3].Score;
				}
			}
			yield return new WaitForSeconds(0.5f);
		}
		stateController.SetSelectedState("result");
		(isPlayerFirst ? firstResultPlayerScoreText : lastResultPlayerScoreText).text = firstPlayerScore.ToString();
		(isPlayerFirst ? lastResultPlayerScoreText : firstResultPlayerScoreText).text = lastPlayerScore.ToString();
		if (result == 0)
		{
			AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_loss", useStream: false);
			resultStateController.SetSelectedState("draw");
		}
		else if (result == 1 && isPlayerFirst && !isAbandon)
		{
			AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_win", useStream: false);
			resultStateController.SetSelectedState("win");
			yield return new WaitForSeconds(1f);
			selfResultPointEffectGo.SetActive(value: true);
			ParticleSystem[] componentsInChildren = selfResultPointEffectGo.transform.GetComponentsInChildren<ParticleSystem>();
			foreach (ParticleSystem obj3 in componentsInChildren)
			{
				ParticleSystem.MainModule main3 = obj3.main;
				main3.startLifetime = main3.startLifetime.constant;
				obj3.Simulate(0f, withChildren: true, restart: true);
				obj3.Play();
			}
			yield return new WaitForSeconds(0.5f);
			selfResultPointEffectGo.SetActive(value: false);
		}
		else if (isAbandon)
		{
			AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_loss", useStream: false);
			resultStateController.SetSelectedState("out");
		}
		else
		{
			AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_loss", useStream: false);
			resultStateController.SetSelectedState("lose");
			yield return new WaitForSeconds(1f);
			enemyResultPointEffectGo.SetActive(value: true);
			ParticleSystem[] componentsInChildren = enemyResultPointEffectGo.transform.GetComponentsInChildren<ParticleSystem>();
			foreach (ParticleSystem obj4 in componentsInChildren)
			{
				ParticleSystem.MainModule main4 = obj4.main;
				main4.startLifetime = main4.startLifetime.constant;
				obj4.Simulate(0f, withChildren: true, restart: true);
				obj4.Play();
			}
			if (!isAbandon)
			{
				enemyResultPointEffectGo.SetActive(value: true);
			}
			yield return new WaitForSeconds(0.5f);
			enemyResultPointEffectGo.SetActive(value: false);
		}
		yield return new WaitForSeconds(0.5f);
	}

	[NoToLua]
	public IEnumerator AnimateScore(Text scoreText, int cacheScore, int targetScore, GameObject go = null, bool isResult = false)
	{
		int currentScore = cacheScore;
		int incrementAmount = Math.Max((targetScore - cacheScore) / (int)(scoreAniDuration / scoreIncrementTime), 1);
		Animator animator = null;
		if (go != null)
		{
			animator = go.GetComponent<Animator>();
			if (animator != null)
			{
				animator.enabled = true;
			}
		}
		while (currentScore < targetScore)
		{
			if (isResult)
			{
				AudioManager.Instance.Play("effect", CUE_NAME, "minigame_activity_3_10_card_number", useStream: false);
			}
			currentScore += incrementAmount;
			if (currentScore > targetScore)
			{
				currentScore = targetScore;
			}
			scoreText.text = currentScore.ToString();
			if (animator != null)
			{
				animator.Play("UI_ScoreCell");
				animator.Update(0f);
			}
			yield return new WaitForSeconds(scoreIncrementTime);
		}
	}

	public void ResetGame()
	{
		if (hasReset)
		{
			return;
		}
		for (int i = 0; i < CardPool.Count; i++)
		{
			if (CardPool[i] == null)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(slotPrefab, CardPoolDeck.transform);
				CardPool[i] = gameObject.transform.GetComponentInChildren<Card>();
				CardPool[i].index = i;
			}
			MoveCardToList(CardPool[i].holder, CardPoolDeck, CardPool[i], immediately: true);
			CardPool[i].Hide();
			CardPool[i].ResetData();
		}
		StopAllCoroutines();
		isDecidedSuffer = false;
		needSuffer = false;
		playerSufferDone = false;
		enemySufferDone = false;
		enemyCantPutCard = false;
		selfCantPutCard = false;
		playerSufferAniDone = false;
		playingEffectDone = false;
		enemyPlaceCardDone = true;
		Board.ResetBoard();
		tipsGO.SetActive(value: false);
		stateController.SetSelectedState("gaming");
		SetBtnFunc(null, null, null, null);
		hasReset = true;
	}

	public void TransitionToNextState(BloodCardEnum.GameStatus nextState, float waitTime = 0f)
	{
		if (waitTime > 0f)
		{
			CoroutineHelper.WaitForSeconds(this, waitTime, delegate
			{
				TransitionToNextStateFunc(nextState);
			});
		}
		else
		{
			TransitionToNextStateFunc(nextState);
		}
	}

	public void TransitionToNextStateFunc(BloodCardEnum.GameStatus nextState)
	{
		switch (nextState)
		{
		case BloodCardEnum.GameStatus.PREPARE:
			SetBtnFunc(null, null, null, null);
			break;
		case BloodCardEnum.GameStatus.DETERMINEORDER:
			SetCardRoundBehavior(new DetermineOrderBehavior());
			DetermineOrder();
			break;
		case BloodCardEnum.GameStatus.DRAW_INITIAL_HAND:
			SetCardRoundBehavior(new DrawInitialHandBehavior());
			DrawInitialHand();
			break;
		case BloodCardEnum.GameStatus.SHUFFLEHAND:
			SetBtnFunc(null, null, null, null);
			SetCardRoundBehavior(new ShuffleHandBehavior());
			ShuffleHand();
			break;
		case BloodCardEnum.GameStatus.PLAYERROUND:
			StartPlayerRound();
			break;
		case BloodCardEnum.GameStatus.ENEMYROUND:
			SetBtnFunc(null, null, null, null);
			SetCardRoundBehavior(new EnemyRoundBehavior());
			StartEnemyRound();
			break;
		case BloodCardEnum.GameStatus.MIDPAUSE:
			SetCardRoundBehavior(new MidPauseBehavior());
			MidPause();
			break;
		case BloodCardEnum.GameStatus.GAMEOVER:
			SetCardRoundBehavior(new GameOverBehavior());
			break;
		default:
			Debug.Log("Invalid game status transition.");
			break;
		}
	}

	public void SetBtnFunc(UnityAction okAction, UnityAction cancelAction, string okText = "CONFIRM", string cancelText = "CANCEL")
	{
		buttonOk.onClick.RemoveAllListeners();
		buttonCancel.onClick.RemoveAllListeners();
		if (okAction != null)
		{
			buttonOk.onClick.AddListener(okAction);
			buttonOk.gameObject.SetActive(value: true);
			((Text)buttonOk.GetComponentInChildren(typeof(Text))).text = LuaHelper.CallFunction("GetTips", okText)[0].ToString();
		}
		else
		{
			buttonOk.gameObject.SetActive(value: false);
		}
		if (cancelAction != null)
		{
			buttonCancel.onClick.AddListener(cancelAction);
			buttonCancel.gameObject.SetActive(value: true);
			((Text)buttonCancel.GetComponentInChildren(typeof(Text))).text = LuaHelper.CallFunction("GetTips", cancelText)[0].ToString();
		}
		else
		{
			buttonCancel.gameObject.SetActive(value: false);
		}
	}

	private void SetCardRoundBehavior(ICardBehavior behavior)
	{
		foreach (Card item in CardPool)
		{
			item.SetRoundBehavior(behavior);
		}
	}

	[NoToLua]
	public void PlayCurveLinePointToPlace(Vector3 fromPos, Vector3 toPos)
	{
		StartCoroutine(PlayCurveLinePointToPlaceCoroutine(fromPos, toPos));
	}

	private IEnumerator PlayCurveLinePointToPlaceCoroutine(Vector3 fromPos, Vector3 toPos)
	{
		curveLinePoint.transform.position = fromPos;
		curveLinePoint.SetActive(value: true);
		yield return new WaitForEndOfFrame();
		curveLinePoint.SetActive(value: false);
		yield return new WaitForSeconds(0.6f);
		curveLinePoint.SetActive(value: true);
		float num = ((toPos.y > fromPos.y) ? BezierOffset : ((toPos.y != fromPos.y) ? (0f - BezierOffset) : 0f));
		Vector3 controlPoint = new Vector3(fromPos.x + (toPos.x - fromPos.x) / 2f, fromPos.y + (toPos.y - fromPos.y) / 2f + num, 3f);
		float duration = BezierTime;
		float t = 0f;
		while (t < duration)
		{
			t += Time.deltaTime / duration;
			curveLinePoint.transform.position = CalculateQuadraticBezierPoint(t, fromPos, controlPoint, toPos);
			yield return null;
		}
		curveLinePoint.SetActive(value: false);
	}

	[NoToLua]
	public static Vector3 CalculateQuadraticBezierPoint(float t, Vector3 p0, Vector3 p1, Vector3 p2)
	{
		float num = 1f - t;
		float num2 = t * t;
		return num * num * p0 + 2f * num * t * p1 + num2 * p2;
	}

	private void Start()
	{
		CardPool = new List<Card>();
		SendStarGame(groupIndex);
		while (CardPool.Count < InitCardNum)
		{
			CardPool.Add(null);
		}
	}

	protected override void OnDestroy()
	{
		StopAllCoroutines();
		if (CardPool != null)
		{
			foreach (Card item in CardPool)
			{
				if (item != null)
				{
					UnityEngine.Object.Destroy(item.gameObject);
				}
			}
			CardPool.Clear();
		}
		base.OnDestroy();
	}

	public void MoveCardToList(CardHolder from, CardHolder to, Card card, bool immediately, bool updateImmediately = true, bool needRefreshHandIDs = false)
	{
		card.transform.parent.SetParent(to.transform, worldPositionStays: false);
		card.holder = to;
		card.transform.localPosition = Vector3.zero;
		if (immediately)
		{
			card.cardVisual.transform.position = card.transform.position;
		}
		if (to.place == BloodCardEnum.PlaceType.DECK)
		{
			card.ResetData();
		}
		if (updateImmediately)
		{
			if (from != null)
			{
				from.UpdateCards();
			}
			if (to != null)
			{
				to.UpdateCards();
			}
		}
		if (needRefreshHandIDs && to != null)
		{
			handCardIds = GetHandsCardIDs(to);
		}
	}

	public Card GetCardItem()
	{
		foreach (Card item in CardPool)
		{
			if (item.isFree)
			{
				item.Show();
				return item;
			}
		}
		GameObject gameObject = UnityEngine.Object.Instantiate(slotPrefab, CardPoolDeck.transform);
		CardPool.Add(gameObject.transform.GetComponentInChildren<Card>());
		CardPool[CardPool.Count - 1].index = CardPool.Count - 1;
		CardPool[CardPool.Count - 1].Show();
		return CardPool[CardPool.Count - 1];
	}

	private void DestroyIfNotNull(UnityEngine.Object obj)
	{
		if (obj != null)
		{
			UnityEngine.Object.Destroy(obj);
		}
	}

	[NoToLua]
	public int ConverPosToIndex(int pos, Vector2 conPos, int rows, int cols, bool ignoreLimit = false)
	{
		int num = pos / cols;
		int num2 = pos % cols;
		int num3 = num + (int)conPos.y;
		int num4 = num2 + (int)conPos.x * (MonoSingleton<BloodCardManager>.Instance.isPlayerFirst ? 1 : (-1));
		if (ignoreLimit)
		{
			return num3 * cols + num4;
		}
		if (num3 >= 0 && num3 < rows && num4 >= 0 && num4 < cols)
		{
			return num3 * cols + num4;
		}
		return -1;
	}

	public int GetCurrentStatus()
	{
		return (int)CurrentStatus;
	}

	private bool CheckCanPlaceCard()
	{
		List<cardInfo> list = new List<cardInfo>();
		foreach (Card card in PlayerCardHand.cards)
		{
			cardInfo item = new cardInfo
			{
				id = card.Data().id,
				needPoint = card.Data().needPoint,
				type = card.Data().type
			};
			list.Add(item);
		}
		list.Sort(delegate(cardInfo a, cardInfo b)
		{
			if (a.type == 2 && b.type != 2)
			{
				return -1;
			}
			return (b.type == 2 && a.type != 2) ? 1 : a.needPoint.CompareTo(b.needPoint);
		});
		CardCell[] cardCells = Board.cardCells;
		foreach (CardCell cell in cardCells)
		{
			if (cell.CurrentCard != null)
			{
				if (list.Any((cardInfo c) => c.type == 2) && cell.CurrentCard.belongs == BloodCardEnum.PlayerRole.SELF)
				{
					return true;
				}
			}
			else if (list.Any((cardInfo c) => cell.SelfPoint >= c.needPoint && c.type != 2))
			{
				return true;
			}
		}
		return false;
	}

	public bool CheckCell(int index)
	{
		return Board.cardCells[index - 1].CurrentCard != null;
	}

	public void LockCell(bool locked, int unLockIndex = -1)
	{
		CardCell[] cardCells = Board.cardCells;
		foreach (CardCell cardCell in cardCells)
		{
			cardCell.lockPut = locked;
			if (unLockIndex == cardCell.index)
			{
				cardCell.lockPut = false;
			}
		}
	}

	public void LockCardLisener(bool lockCard)
	{
		if (lockCard)
		{
			for (int i = 0; i < changeDeckCards.Count; i++)
			{
				if (i != 2)
				{
					changeDeckCards[i].SetCardBehavior(new NoInteractionCardBehavior());
				}
			}
		}
		needChangeBtn.enabled = !lockCard;
	}

	public void LockHandCard(bool lockCard)
	{
		if (lockCard)
		{
			for (int i = 0; i < handCards.Count; i++)
			{
				if (i != 1)
				{
					handCards[i].SetCardBehavior(new NoInteractionCardBehavior());
				}
				else
				{
					handCards[i].cardVisual.canvas.overrideSorting = true;
				}
			}
			return;
		}
		for (int j = 0; j < handCards.Count; j++)
		{
			if (j != 1)
			{
				handCards[j].SetCardBehavior(new DefaultCardBehavior());
			}
			else
			{
				handCards[j].cardVisual.canvas.overrideSorting = false;
			}
		}
	}

	private void TriggerEffect(int pos, int effectID, int effectPos, bool isRemove, BloodCardEnum.PlayerRole role)
	{
		if (effectID == 0)
		{
			CardCell cardCell = Board.cardCells[effectPos - 1];
			if (role == BloodCardEnum.PlayerRole.SELF)
			{
				cardCell.latticeController.SetSelectedState("true");
				cardCell.PlayAni(cardCell.latticeAni, "UI_set_blink");
			}
			else
			{
				cardCell.enemyLatticeController.SetSelectedState("true");
				cardCell.PlayAni(cardCell.latticeAni, "UI_set_blink");
			}
			cardCell.AddPoint(1, role);
			return;
		}
		EffectData effectData = LazySingleton<LuaEffectLoader>.Instance.GetEffectData(effectID);
		if (effectData == null)
		{
			Debug.LogError("LHL 效果不存在 EffectID" + effectID);
		}
		else if (effectData.type == 1)
		{
			CardCell cardCell2 = Board.cardCells[effectPos - 1];
			Card currentCard = cardCell2.CurrentCard;
			if (currentCard != null)
			{
				int num = effectData.effectParams[0] * ((!isRemove) ? 1 : (-1));
				currentCard.Data().power += num;
				currentCard.PlayChangePower(isRemove, cardCell2);
			}
		}
		else if (effectData.type == 2)
		{
			CardData cardData = LazySingleton<LuaCardLoader>.Instance.GetCardData(effectData.effectParams[0]);
			if (effectData.target == 0)
			{
				Card cardItem = GetCardItem();
				cardItem.SetCardData(cardData);
				if (role == BloodCardEnum.PlayerRole.SELF)
				{
					MoveCardToList(null, PlayerCardHand, cardItem, immediately: true, updateImmediately: true, needRefreshHandIDs: true);
				}
				else
				{
					MoveCardToList(null, EnemyCardHand, cardItem, immediately: true);
				}
			}
			else if (effectData.target == 1)
			{
				Card cardItem2 = GetCardItem();
				cardItem2.SetCardData(cardData);
				if (role == BloodCardEnum.PlayerRole.SELF)
				{
					MoveCardToList(null, EnemyCardHand, cardItem2, immediately: true);
				}
				else
				{
					MoveCardToList(null, PlayerCardHand, cardItem2, immediately: true, updateImmediately: true, needRefreshHandIDs: true);
				}
			}
			else if (effectData.target == 2)
			{
				Card cardItem3 = GetCardItem();
				cardItem3.SetCardData(cardData);
				MoveCardToList(null, PlayerCardHand, cardItem3, immediately: true, updateImmediately: true, needRefreshHandIDs: true);
				cardItem3 = GetCardItem();
				cardItem3.SetCardData(cardData);
				MoveCardToList(null, EnemyCardHand, cardItem3, immediately: true);
			}
		}
		else if (effectData.type == 3)
		{
			CardCell cardCell3 = Board.cardCells[effectPos - 1];
			Card currentCard2 = cardCell3.CurrentCard;
			if (currentCard2 != null)
			{
				currentCard2.PlayBreakCard(cardCell3);
			}
		}
		else if (effectData.type == 4)
		{
			Card currentCard3 = Board.cardCells[effectPos - 1].CurrentCard;
			if (currentCard3 != null)
			{
				int num2 = currentCard3.Data().power * ((!isRemove) ? 1 : (-1));
				Board.cardCells[pos - 1].CurrentCard.Data().power += num2;
			}
		}
		else if (effectData.type == 5)
		{
			CardCell cardCell4 = Board.cardCells[effectPos - 1];
			if (cardCell4.CurrentCard != null)
			{
				int num3 = cardCell4.preCardData.power * ((!isRemove) ? 1 : (-1));
				Board.cardCells[pos - 1].CurrentCard.Data().power += num3;
			}
		}
	}

	public void SendStarGame(int groupIndex)
	{
		Debug.Log("LHL SendStarGame");
		object[] args = new object[1] { groupIndex };
		SendLuaMessage("SendStartBloodardGameRequest", args);
	}

	public void SendSufferCard(int[] sufferCard)
	{
		Debug.Log("LHL SendSufferCard");
		object[] args = new object[1] { sufferCard };
		SendLuaMessage("SendSufferCardRequest", args);
	}

	public void SendDrawCard()
	{
		Debug.Log("LHL SendDrawCard");
		object[] args = new object[0];
		SendLuaMessage("SendDrawCardRequest", args);
	}

	public void SendPlaceCard(int cardID, int index)
	{
		Debug.Log("LHL SendPlaceCard");
		object[] args = new object[2]
		{
			cardID,
			index + 1
		};
		SendLuaMessage("SendPlaceCardRequest", args);
	}

	public void SendJumpRound()
	{
		if (playerSufferAniDone)
		{
			Debug.Log("LHL SendJumpRound");
			object[] args = new object[2] { 0, 0 };
			SendLuaMessage("SendPlaceCardRequest", args);
		}
	}

	public void SendResetGame()
	{
		Debug.Log("LHL SendResetGame");
		object[] args = new object[0];
		SendLuaMessage("SendResetGameRequest", args);
	}

	public void SendEndRound()
	{
		Debug.Log("LHL SendEndRound");
		object[] args = new object[0];
		SendLuaMessage("SendEndRoundRequest", args);
	}

	public void SendLuaMessage(string message, object[] args)
	{
		object[] array = new object[args.Length];
		for (int i = 0; i < args.Length; i++)
		{
			array[i] = ConvertToLuaType(args[i]);
		}
		LuaHelper.CallFunction(message, array);
		Debug.Log("发送消息：" + message);
	}

	private object ConvertToLuaType(object arg)
	{
		if (arg == null)
		{
			return null;
		}
		if (arg is int || arg is float || arg is double || arg is string || arg is bool)
		{
			return arg;
		}
		if (arg is Vector2 vector)
		{
			LuaTable luaTable = luaState.NewTable();
			luaTable["x"] = vector.x;
			luaTable["y"] = vector.y;
			return luaTable;
		}
		if (arg is Vector3 vector2)
		{
			LuaTable luaTable2 = luaState.NewTable();
			luaTable2["x"] = vector2.x;
			luaTable2["y"] = vector2.y;
			luaTable2["z"] = vector2.z;
			return luaTable2;
		}
		if (arg is Vector4 vector3)
		{
			LuaTable luaTable3 = luaState.NewTable();
			luaTable3["x"] = vector3.x;
			luaTable3["y"] = vector3.y;
			luaTable3["z"] = vector3.z;
			luaTable3["w"] = vector3.w;
			return luaTable3;
		}
		if (arg is Quaternion quaternion)
		{
			LuaTable luaTable4 = luaState.NewTable();
			luaTable4["x"] = quaternion.x;
			luaTable4["y"] = quaternion.y;
			luaTable4["z"] = quaternion.z;
			luaTable4["w"] = quaternion.w;
			return luaTable4;
		}
		if (arg is Color color)
		{
			LuaTable luaTable5 = luaState.NewTable();
			luaTable5["r"] = color.r;
			luaTable5["g"] = color.g;
			luaTable5["b"] = color.b;
			luaTable5["a"] = color.a;
			return luaTable5;
		}
		if (arg.GetType().IsArray)
		{
			return ConvertArrayToLuaTable((Array)arg);
		}
		Debug.LogWarning("无法转换的参数类型：" + arg.GetType());
		return null;
	}

	private LuaTable ConvertArrayToLuaTable(Array array)
	{
		LuaTable luaTable = luaState.NewTable();
		for (int i = 0; i < array.Length; i++)
		{
			luaTable[i + 1] = ConvertToLuaType(array.GetValue(i));
		}
		return luaTable;
	}
}

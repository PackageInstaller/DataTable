using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class FlipCardGameController : MonoBehaviour
{
	public enum GameStatus
	{
		Paused,
		Observing,
		Flipping,
		MidPaused,
		GameOver
	}

	public const int ROW_COUNT = 3;

	private const int COLUMN_COUNT = 6;

	private const int CARD_TYPE_COUNT = 9;

	private const float ANI_DURATION = 0.5f;

	private const float OBSERVATION_TIME = 10f;

	private const float TIMER_DURATION = 30f;

	private const float COLUMN_SPACING = 2f;

	private const float ROW_SPACING = 2f;

	private const float FLIP_BACK_DURATION = 0.5f;

	private const string CARD_FACES_PATH = "";

	[Header("卡牌种类设置")]
	[SerializeField]
	private int _rowCount;

	[SerializeField]
	private int _colmnCount;

	[SerializeField]
	private int _cardTypeCount;

	[Header("卡牌设置")]
	[SerializeField]
	private GameObject _cardPrefab;

	[SerializeField]
	private List<Sprite> _cardFaces;

	[SerializeField]
	private List<Sprite> _cardFaceBack;

	[SerializeField]
	private float _columnSpacing;

	[SerializeField]
	private float _rowSpacing;

	[Header("时间设置")]
	[SerializeField]
	private float _aniDuration;

	[SerializeField]
	private float _observationTime;

	[SerializeField]
	private float _timerDuration;

	[SerializeField]
	private float _flipBackDuration;

	[Header("实际时间")]
	[SerializeField]
	private float _remainingObservationTime;

	[SerializeField]
	private float _currentTimeValue;

	[SerializeField]
	private GameStatus _gameState;

	[SerializeField]
	private int _flipCardCount;

	public Transform panel;

	private bool isSuccess;

	private int activityId;

	private int matchCount;

	private bool gameStarted;

	private bool stopObservingCards;

	private CardController faceUpCard;

	private List<int> cardTypes = new List<int>();

	private int[,] cards;

	private List<CardController> cardControllers = new List<CardController>();

	private static Queue<GameStatus> stateQueue = new Queue<GameStatus>();

	private int specialType;

	public static FlipCardGameController Instance { get; private set; }

	public int RowCount
	{
		get
		{
			if (_rowCount != 0)
			{
				return _rowCount;
			}
			return 3;
		}
		set
		{
			_rowCount = value;
		}
	}

	public int ColmnCount
	{
		get
		{
			if (_colmnCount != 0)
			{
				return _colmnCount;
			}
			return 6;
		}
		set
		{
			_colmnCount = value;
		}
	}

	public int CardTypeCount
	{
		get
		{
			return _cardTypeCount = ((RowCount * ColmnCount / 2 == 0) ? 9 : (RowCount * ColmnCount / 2));
		}
		set
		{
			_cardTypeCount = value;
		}
	}

	public GameObject CardPrefab
	{
		get
		{
			return _cardPrefab;
		}
		set
		{
			_cardPrefab = value;
		}
	}

	public List<Sprite> CardFaces
	{
		get
		{
			return _cardFaces;
		}
		set
		{
			_cardFaces = value;
		}
	}

	public List<Sprite> CardFaceBack
	{
		get
		{
			return _cardFaceBack;
		}
		set
		{
			_cardFaceBack = value;
		}
	}

	public float ColumnSpacing
	{
		get
		{
			if (_columnSpacing != 0f)
			{
				return _columnSpacing;
			}
			return 2f;
		}
		set
		{
			_columnSpacing = value;
		}
	}

	public float RowSpacing
	{
		get
		{
			if (_rowSpacing != 0f)
			{
				return _rowSpacing;
			}
			return 2f;
		}
		set
		{
			_rowSpacing = value;
		}
	}

	public float AniDuration
	{
		get
		{
			if (_aniDuration != 0f)
			{
				return _aniDuration;
			}
			return 0.5f;
		}
		set
		{
			_aniDuration = value;
		}
	}

	public float ObservationTime
	{
		get
		{
			if (_observationTime != 0f)
			{
				return _observationTime;
			}
			return 10f;
		}
		set
		{
			_observationTime = value;
		}
	}

	public float TimerDuration
	{
		get
		{
			if (_timerDuration != 0f)
			{
				return _timerDuration;
			}
			return 30f;
		}
		set
		{
			_timerDuration = value;
		}
	}

	public float FlipBackDuration
	{
		get
		{
			if (_flipBackDuration != 0f)
			{
				return _flipBackDuration;
			}
			return 0.5f;
		}
		set
		{
			_flipBackDuration = value;
		}
	}

	public float RemainingObservationTime
	{
		get
		{
			if (!(_remainingObservationTime < 0f))
			{
				return _remainingObservationTime;
			}
			return 0f;
		}
		set
		{
			_remainingObservationTime = value;
		}
	}

	public float CurrentTimeValue
	{
		get
		{
			if (!(_currentTimeValue < 0f))
			{
				return _currentTimeValue;
			}
			return 0f;
		}
		set
		{
			_currentTimeValue = value;
			if (_currentTimeValue <= 0f)
			{
				GameOver(_isSuccess: false);
			}
		}
	}

	public GameStatus GameState
	{
		get
		{
			return _gameState;
		}
		set
		{
			_gameState = value;
		}
	}

	public int FlipCardCount
	{
		get
		{
			return _flipCardCount;
		}
		set
		{
			_flipCardCount = value;
		}
	}

	private void Awake()
	{
		Camera.main.gameObject.AddComponent<PhysicsRaycaster>();
		Instance = this;
	}

	public void InitGame()
	{
		cards = new int[RowCount, ColmnCount];
		CurrentTimeValue = TimerDuration;
		CreateCards();
		ResetCardsData();
	}

	public void StarCheckCardFace()
	{
		StartCoroutine(TurnAllCardsFaceUpCoroutine());
	}

	public void ChangeStatus(GameStatus newStatus)
	{
		switch (newStatus)
		{
		case GameStatus.Paused:
			if (GameState == GameStatus.MidPaused || GameState == GameStatus.GameOver)
			{
				GameState = GameStatus.Paused;
			}
			break;
		case GameStatus.Observing:
			if (GameState == GameStatus.Paused || GameState == GameStatus.MidPaused)
			{
				GameState = GameStatus.Observing;
			}
			break;
		case GameStatus.Flipping:
			if (GameState == GameStatus.Observing || GameState == GameStatus.MidPaused)
			{
				GameState = GameStatus.Flipping;
			}
			break;
		case GameStatus.MidPaused:
			if (GameState == GameStatus.Flipping || GameState == GameStatus.Observing)
			{
				GameState = GameStatus.MidPaused;
			}
			break;
		case GameStatus.GameOver:
			GameState = GameStatus.GameOver;
			break;
		}
	}

	public void ChangeStatus(int state)
	{
		ChangeStatus((GameStatus)state);
	}

	public void StartGame()
	{
		CurrentTimeValue = TimerDuration;
		ChangeStatus(GameStatus.Flipping);
	}

	private void Update()
	{
		if (GameState == GameStatus.Flipping)
		{
			CurrentTimeValue -= Time.deltaTime;
		}
	}

	public void CheckMatch(CardController card)
	{
		if (!faceUpCard)
		{
			faceUpCard = card;
			return;
		}
		FlipCardCount++;
		if (faceUpCard.cardType == card.cardType)
		{
			matchCount++;
			faceUpCard.IsMatched = true;
			card.IsMatched = true;
			faceUpCard = null;
			if (matchCount == CardTypeCount && CurrentTimeValue > 0f)
			{
				GameOver(_isSuccess: true);
			}
		}
		else
		{
			StartCoroutine(HideCards(faceUpCard, card));
			faceUpCard = null;
		}
	}

	public void GameOver(bool _isSuccess)
	{
		StopAllCoroutines();
		isSuccess = _isSuccess;
		gameStarted = false;
		ChangeStatus(GameStatus.GameOver);
	}

	public int GetGameState()
	{
		return (int)GameState;
	}

	public bool GetIsSuccess()
	{
		return isSuccess;
	}

	private void InitCardTypes()
	{
		cardTypes.Clear();
		for (int i = 0; i < CardTypeCount; i++)
		{
			cardTypes.Add(i);
			cardTypes.Add(i);
		}
	}

	private void ShuffleCards()
	{
		System.Random random = new System.Random();
		for (int i = 0; i < RowCount; i++)
		{
			for (int j = 0; j < ColmnCount; j++)
			{
				int index = random.Next(cardTypes.Count);
				int num = cardTypes[index];
				cardTypes.RemoveAt(index);
				cards[i, j] = num;
			}
		}
	}

	private void CreateCards()
	{
		for (int i = 0; i < RowCount; i++)
		{
			for (int j = 0; j < ColmnCount; j++)
			{
				if (cardControllers.Count <= RowCount * ColmnCount)
				{
					CardController component = UnityEngine.Object.Instantiate(CardPrefab, panel).GetComponent<CardController>();
					cardControllers.Add(component);
					component.SetAniDuration(AniDuration);
				}
				cardControllers[i * ColmnCount + j].cardType = cards[i, j];
				cardControllers[i * ColmnCount + j].transform.position = new Vector3((float)j * ColumnSpacing - (float)(ColmnCount - 1) * ColumnSpacing / 2f, (float)i * (0f - RowSpacing) + (float)(RowCount - 1) * RowSpacing / 2f, 0f);
			}
		}
	}

	private void ResetCardsData()
	{
		FlipCardCount = 0;
		matchCount = 0;
		faceUpCard = null;
		InitCardTypes();
		ShuffleCards();
		for (int i = 0; i < RowCount; i++)
		{
			for (int j = 0; j < ColmnCount; j++)
			{
				CardController cardController = cardControllers[i * ColmnCount + j];
				cardController.cardType = cards[i, j];
				cardController.Reset();
			}
		}
	}

	public void GiveUp()
	{
		GameOver(_isSuccess: false);
	}

	public void ResetGame()
	{
		CurrentTimeValue = TimerDuration;
		ResetCardsData();
		ChangeStatus(GameStatus.Paused);
	}

	private IEnumerator HideCards(CardController card1, CardController card2)
	{
		while (card1.IsFlipping && card2.IsFlipping)
		{
			yield return null;
		}
		yield return new WaitForSeconds(FlipBackDuration + AniDuration);
		card1.FlipCardBack();
		card2.FlipCardBack();
	}

	public void StopObservingCards()
	{
		stopObservingCards = true;
	}

	public Sprite GetCardFace(int cardType)
	{
		return CardFaces[cardType];
	}

	public Sprite GetCarFaceBack(bool isSpecial)
	{
		if (CardFaceBack.Count == 1)
		{
			return CardFaceBack[0];
		}
		if (!isSpecial)
		{
			return CardFaceBack[0];
		}
		return CardFaceBack[1];
	}

	public void SetCardFaces(string assetPath, int cardIndex, bool isSpecial)
	{
		Sprite spriteWithoutAtlas = AtlasManager.GetSpriteWithoutAtlas(assetPath + "_" + cardIndex);
		CardFaces.Add(spriteWithoutAtlas);
		if (isSpecial)
		{
			specialType = CardFaces.IndexOf(spriteWithoutAtlas);
		}
	}

	public void SetCardFaceBack(string atlasName, string iconName, bool isAtlas)
	{
		Sprite item = ((!isAtlas) ? AtlasManager.GetSpriteWithoutAtlas(iconName) : AtlasManager.GetSprite(atlasName, iconName));
		CardFaceBack.Add(item);
	}

	private IEnumerator TurnAllCardsFaceUpCoroutine()
	{
		if (gameStarted)
		{
			yield break;
		}
		gameStarted = true;
		stopObservingCards = false;
		_remainingObservationTime = ObservationTime;
		ChangeStatus(GameStatus.Observing);
		List<LTDescr> flipCardTweens = new List<LTDescr>();
		foreach (CardController cardController in cardControllers)
		{
			LTDescr item = LeanTween.rotateAroundLocal(cardController.gameObject, Vector3.up, 180f, AniDuration);
			flipCardTweens.Add(item);
			if (!cardController.IsSettedSprite)
			{
				cardController.FrontImgSpriteRenderer.sprite = Instance.GetCardFace(cardController.cardType);
				cardController.FrontSpriteRenderer.sprite = Instance.GetCarFaceBack(cardController.cardType == specialType);
				cardController.IsSettedSprite = true;
			}
			cardController.IsFlipping = true;
			cardController.canClick = false;
		}
		LeanTween.delayedCall(0f, (Action)delegate
		{
			foreach (LTDescr item3 in flipCardTweens)
			{
				item3.resume();
			}
		});
		yield return new WaitForSeconds(AniDuration / 2f);
		foreach (CardController cardController2 in cardControllers)
		{
			cardController2.IsFaceUp = true;
			cardController2.ToggleVisibility();
		}
		while (_remainingObservationTime > 0f && !stopObservingCards)
		{
			yield return null;
			if (GameState == GameStatus.Observing)
			{
				_remainingObservationTime -= Time.deltaTime;
			}
		}
		StartGame();
		flipCardTweens.Clear();
		foreach (CardController cardController3 in cardControllers)
		{
			LTDescr item2 = LeanTween.rotateAroundLocal(cardController3.gameObject, Vector3.up, -180f, AniDuration);
			flipCardTweens.Add(item2);
		}
		LeanTween.delayedCall(0f, (Action)delegate
		{
			foreach (LTDescr item4 in flipCardTweens)
			{
				item4.resume();
			}
		});
		yield return new WaitForSeconds(AniDuration / 2f);
		foreach (CardController cardController4 in cardControllers)
		{
			cardController4.IsFaceUp = false;
			cardController4.ToggleVisibility();
		}
		yield return new WaitForSeconds(AniDuration / 2f);
		foreach (CardController cardController5 in cardControllers)
		{
			cardController5.IsFlipping = false;
			cardController5.canClick = true;
		}
		gameStarted = false;
	}

	private void OnDestroy()
	{
		if ((bool)Camera.main)
		{
			Camera.main.TryGetComponent<PhysicsRaycaster>(out var component);
			if (component != null)
			{
				UnityEngine.Object.Destroy(component);
			}
		}
	}
}

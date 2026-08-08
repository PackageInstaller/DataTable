using System;
using ControllerExSpace;
using P08.Quiz;
using Unity.Mathematics;
using UnityEngine;

public class CardCell : GridCell
{
	[SerializeField]
	public int index;

	public ControllerExCollection controller;

	[SerializeField]
	private int selfPoint;

	[SerializeField]
	private int enemyPoint;

	[SerializeField]
	private Card currentCard;

	public BloodCardEnum.PlaceType place = BloodCardEnum.PlaceType.BOARD;

	[SerializeField]
	public Animator latticeAni;

	public Animator EnemylatticeAni;

	public GameObject buffEffectGo;

	public GameObject enemyBuffEffectGo;

	public CanvasGroup pointCanvasGroup;

	[HideInInspector]
	public bool lockPut;

	[HideInInspector]
	public CardData preCardData;

	[HideInInspector]
	public ControllerEx pointController;

	[HideInInspector]
	public ControllerEx latticeController;

	[HideInInspector]
	public ControllerEx noController;

	[HideInInspector]
	public ControllerEx selectController;

	[HideInInspector]
	public ControllerEx selfController;

	[HideInInspector]
	public ControllerEx lightController;

	[HideInInspector]
	public ControllerEx enemyLatticeController;

	public int SelfPoint
	{
		get
		{
			return selfPoint;
		}
		protected set
		{
			selfPoint = value;
		}
	}

	public int EnemyPoint
	{
		get
		{
			return enemyPoint;
		}
		protected set
		{
			enemyPoint = value;
		}
	}

	public Card CurrentCard
	{
		get
		{
			return currentCard;
		}
		private set
		{
			currentCard = value;
		}
	}

	public void Awake()
	{
		pointController = controller.GetController("point");
		latticeController = controller.GetController("lattice");
		noController = controller.GetController("no");
		selectController = controller.GetController("set");
		selfController = controller.GetController("self");
		lightController = controller.GetController("light");
		enemyLatticeController = controller.GetController("enemylattice");
	}

	public void ResetState()
	{
		preCardData = null;
		latticeController.SetSelectedState("false");
		noController.SetSelectedState("false");
		selectController.SetSelectedState("false");
		lightController.SetSelectedState("false");
		selfController.SetSelectedState((selfPoint >= enemyPoint) ? "true" : "false");
		pointController.SetSelectedState(math.max(selfPoint, enemyPoint).ToString());
		PlayAni(latticeAni, "empty");
		PlayAni(EnemylatticeAni, "empty");
		if (currentCard != null)
		{
			currentCard.cardVisual.effectGameObjectList[1].SetActive(value: false);
		}
	}

	public void SetBuffEffectActive(bool flag, BloodCardEnum.PlayerRole role)
	{
		switch (role)
		{
		case BloodCardEnum.PlayerRole.SELF:
			buffEffectGo.SetActive(flag);
			break;
		case BloodCardEnum.PlayerRole.ENEMY:
			enemyBuffEffectGo.SetActive(flag);
			break;
		default:
			buffEffectGo.SetActive(flag);
			enemyBuffEffectGo.SetActive(flag);
			break;
		}
		if (flag)
		{
			AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_buff01", useStream: false);
		}
	}

	public bool PlaceCard(Card card)
	{
		if (CurrentCard != null)
		{
			if (card.Data().type == 2)
			{
				preCardData = CurrentCard.Data();
			}
			CurrentCard.Hide();
			MonoSingleton<BloodCardManager>.Instance.MoveCardToList(null, MonoSingleton<BloodCardManager>.Instance.CardPoolDeck, CurrentCard, immediately: true);
		}
		CurrentCard = card;
		card.RemoveAllTagListeners("CardHolder");
		card.transform.parent.SetParent(base.transform);
		card.transform.parent.localPosition = Vector3.zero;
		card.transform.localPosition = Vector3.zero;
		card.holder?.UpdateCards();
		card.cardVisual.SetCardShaking(value: false);
		card.cardVisual.transform.position = card.transform.position;
		card.place = place;
		card.SetCardSize("small");
		card.PlayPlaceEffect();
		if (card.Data().effects.Count > 0)
		{
			AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_putdown02", useStream: false);
		}
		else
		{
			AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_putdown01", useStream: false);
		}
		SetBuffEffectActive(flag: false, BloodCardEnum.PlayerRole.SYSTEM);
		return true;
	}

	public void RemoveCard()
	{
		preCardData = null;
		if (CurrentCard != null)
		{
			if (CurrentCard.Data() != null)
			{
				CardData cardData = LazySingleton<LuaCardLoader>.Instance.GetCardData(CurrentCard.Data().id);
				CurrentCard.Data().power = cardData.power;
			}
			CurrentCard = null;
		}
	}

	private void Start()
	{
		SelfPoint = 0;
	}

	public void SetPoint(int value, BloodCardEnum.PlayerRole role)
	{
		switch (role)
		{
		case BloodCardEnum.PlayerRole.SELF:
			SelfPoint = value;
			selfController.SetSelectedState((selfPoint != 0) ? "true" : "false");
			pointController.SetSelectedState(math.max(selfPoint, enemyPoint).ToString());
			break;
		case BloodCardEnum.PlayerRole.ENEMY:
			EnemyPoint = value;
			selfController.SetSelectedState((enemyPoint != 0) ? "false" : "true");
			pointController.SetSelectedState(math.max(selfPoint, enemyPoint).ToString());
			break;
		}
	}

	public void AddPoint(int value, BloodCardEnum.PlayerRole role)
	{
		switch (role)
		{
		case BloodCardEnum.PlayerRole.SELF:
			SelfPoint += value;
			EnemyPoint = 0;
			selfController.SetSelectedState((selfPoint != 0) ? "true" : "false");
			LeanTween.alphaCanvas(pointCanvasGroup, 0.5f, 0f).setOnComplete((Action)delegate
			{
				pointController.SetSelectedState(math.max(SelfPoint, EnemyPoint).ToString());
				LeanTween.alphaCanvas(pointCanvasGroup, 1f, 0.3f);
			});
			break;
		case BloodCardEnum.PlayerRole.ENEMY:
			EnemyPoint += value;
			SelfPoint = 0;
			selfController.SetSelectedState((selfPoint != 0) ? "true" : "false");
			LeanTween.alphaCanvas(pointCanvasGroup, 0.5f, 0f).setOnComplete((Action)delegate
			{
				pointController.SetSelectedState(math.max(SelfPoint, EnemyPoint).ToString());
				LeanTween.alphaCanvas(pointCanvasGroup, 1f, 0.3f);
			});
			break;
		}
	}

	public void PlayAni(Animator ani, string aniName)
	{
		if (ani.isActiveAndEnabled)
		{
			ani.Play("aniName");
			ani.Update(0f);
		}
	}

	public void ResetAni(Animator ani)
	{
		if (ani.isActiveAndEnabled)
		{
			ani.Play("empty");
		}
	}
}

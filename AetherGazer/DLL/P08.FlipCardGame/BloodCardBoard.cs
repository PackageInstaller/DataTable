using System.Collections.Generic;
using P08.Quiz;
using UnityEngine;

public class BloodCardBoard : MonoBehaviour
{
	public int rows = 3;

	public int columns = 7;

	public GameObject scoreCellPrefab;

	public GameObject cardCellPrefab;

	[HideInInspector]
	public CardCell[] cardCells;

	[HideInInspector]
	public ScoreCell[] scoreCells;

	[HideInInspector]
	public List<CardCell> ConHightLightCells;

	[HideInInspector]
	public List<CardCell> EffectHightLightCells;

	[SerializeField]
	private CardCell hightLightCell;

	public int boardCardNum;

	public CardCell HightLightCell
	{
		get
		{
			return hightLightCell;
		}
		set
		{
			hightLightCell = value;
		}
	}

	private void Start()
	{
		CreateBoard();
	}

	private void CreateBoard()
	{
		cardCells = new CardCell[rows * (columns - 2)];
		scoreCells = new ScoreCell[rows * 2];
		ConHightLightCells = new List<CardCell>();
		EffectHightLightCells = new List<CardCell>();
		for (int i = 0; i < rows; i++)
		{
			for (int j = 0; j < columns; j++)
			{
				GameObject gameObject;
				if (j == 0 || j == columns - 1)
				{
					gameObject = Object.Instantiate(scoreCellPrefab, base.transform);
					scoreCells[(j != 0) ? (i + rows) : i] = gameObject.GetComponent<ScoreCell>();
					scoreCells[(j != 0) ? (i + rows) : i].Initialize();
					scoreCells[(j != 0) ? (i + rows) : i].SetActive(bActive: true);
					if (j == 0)
					{
						scoreCells[(j != 0) ? (i + rows) : i].selfScoreObj.SetActive(value: true);
						scoreCells[(j != 0) ? (i + rows) : i].role = BloodCardEnum.PlayerRole.SELF;
						scoreCells[(j != 0) ? (i + rows) : i].enemyScoreObj.SetActive(value: false);
					}
					else if (j == columns - 1)
					{
						scoreCells[(j != 0) ? (i + rows) : i].selfScoreObj.SetActive(value: false);
						scoreCells[(j != 0) ? (i + rows) : i].role = BloodCardEnum.PlayerRole.ENEMY;
						scoreCells[(j != 0) ? (i + rows) : i].enemyScoreObj.SetActive(value: true);
					}
				}
				else
				{
					gameObject = Object.Instantiate(cardCellPrefab, base.transform);
					int num = j + i * (columns - 2) - 1;
					cardCells[num] = gameObject.GetComponent<CardCell>();
					cardCells[num].index = num;
					cardCells[num].Initialize();
				}
				gameObject.name = "[" + (i + 1) + "," + j + "]";
			}
		}
	}

	public CardCell GetOverlappingCell(Vector3 cardPosition, Vector3 cardSize, Transform placeBoardTransform)
	{
		_ = MonoSingleton<BloodCardManager>.Instance.Board;
		CardCell result = null;
		float num = cardSize.x * cardSize.y / 2f;
		Vector3 vector = placeBoardTransform.InverseTransformPoint(cardPosition);
		Rect rect = new Rect(new Vector2(vector.x - cardSize.x / 2f, vector.y - cardSize.y / 2f), new Vector2(cardSize.x, cardSize.y));
		CardCell[] array = cardCells;
		foreach (CardCell cardCell in array)
		{
			if (!(cardCell != null))
			{
				continue;
			}
			Vector3 vector2 = placeBoardTransform.InverseTransformPoint(cardCell.transform.position);
			Rect rect2 = new Rect(new Vector2(vector2.x - cardCell.Size.x / 2f, vector2.y - cardCell.Size.y / 2f), cardCell.Size);
			if (rect2.Overlaps(rect))
			{
				float num2 = CalculateOverlapArea(rect2, rect);
				if (num2 > num)
				{
					num = num2;
					result = cardCell;
				}
			}
		}
		return result;
	}

	private float CalculateOverlapArea(Rect rect1, Rect rect2)
	{
		float num = Mathf.Max(0f, Mathf.Min(rect1.xMax, rect2.xMax) - Mathf.Max(rect1.xMin, rect2.xMin));
		float num2 = Mathf.Max(0f, Mathf.Min(rect1.yMax, rect2.yMax) - Mathf.Max(rect1.yMin, rect2.yMin));
		return num * num2;
	}

	public void ResetBoard()
	{
		UpdateBoardIndex(isFirstPlay: true);
		for (int i = 0; i < scoreCells.Length; i++)
		{
			if (scoreCells[i] != null)
			{
				scoreCells[i].SetScore(0, needAni: false);
				if (i < 3)
				{
					scoreCells[i].selfScoreObj.SetActive(value: true);
					scoreCells[i].enemyScoreObj.SetActive(value: false);
				}
				else
				{
					scoreCells[i].enemyScoreObj.SetActive(value: true);
					scoreCells[i].selfScoreObj.SetActive(value: false);
				}
			}
		}
		for (int j = 0; j < cardCells.Length; j++)
		{
			cardCells[j].ResetState();
			cardCells[j].SetBuffEffectActive(flag: false, BloodCardEnum.PlayerRole.SYSTEM);
		}
	}

	public void UpdateBoard()
	{
		List<int> list = new List<int>(new int[6]);
		boardCardNum = 0;
		CardCell[] array = cardCells;
		foreach (CardCell obj in array)
		{
			int num = obj.index / 5;
			Card currentCard = obj.CurrentCard;
			if (currentCard != null)
			{
				if (currentCard.belongs == BloodCardEnum.PlayerRole.SELF)
				{
					list[num] += currentCard.Data().power;
				}
				else if (currentCard.belongs == BloodCardEnum.PlayerRole.ENEMY)
				{
					list[num + rows] += currentCard.Data().power;
				}
				boardCardNum++;
			}
		}
		for (int j = 0; j < 6; j++)
		{
			scoreCells[j].SetScore(list[j]);
			bool num2 = j <= 2;
			int num3 = (num2 ? (j + 3) : (j - 3));
			bool flag = scoreCells[j].Score > scoreCells[num3].Score;
			bool flag2 = scoreCells[j].Score == scoreCells[num3].Score;
			if (num2)
			{
				scoreCells[j].fireGo.SetActive(flag);
				scoreCells[j].loopFireGo.SetActive(flag);
			}
			else
			{
				scoreCells[j].enemyFireGo.SetActive(flag);
				scoreCells[j].loopEnemyFireGo.SetActive(flag);
				scoreCells[num3].fireGo.SetActive(!flag && !flag2);
				scoreCells[num3].loopFireGo.SetActive(!flag && !flag2);
			}
			if (flag)
			{
				AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_fire", useStream: false);
			}
		}
	}

	public void UpdateBoardIndex(bool isFirstPlay)
	{
		int num = rows * (columns - 2);
		if (isFirstPlay)
		{
			for (int i = 0; i < num; i++)
			{
				cardCells[i].index = i;
			}
		}
		else
		{
			for (int j = 0; j < rows; j++)
			{
				int num2 = j * (columns - 2);
				int num3 = num2 + (columns - 2) - 1;
				while (num2 < num3)
				{
					CardCell cardCell = cardCells[num2];
					cardCells[num2] = cardCells[num3];
					cardCells[num3] = cardCell;
					cardCells[num2].index = num2;
					cardCells[num3].index = num3;
					num2++;
					num3--;
				}
			}
		}
		UpdatePower(isFirstPlay);
		Debug.Log("Updated Indices:");
		CardCell[] array = cardCells;
		foreach (CardCell cardCell2 in array)
		{
			Debug.Log(cardCell2.name + " - Index: " + cardCell2.index);
		}
	}

	private void UpdatePower(bool isPlayFirst)
	{
		CardCell[] array = cardCells;
		foreach (CardCell cardCell in array)
		{
			if (!(cardCell != null))
			{
				continue;
			}
			cardCell.RemoveCard();
			if (cardCell.index % (columns - 2) == 0 || cardCell.index % (columns - 2) == 4)
			{
				if (cardCell.index % (columns - 2) == 0)
				{
					cardCell.SetPoint(1, (!isPlayFirst) ? BloodCardEnum.PlayerRole.ENEMY : BloodCardEnum.PlayerRole.SELF);
					cardCell.SetPoint(0, isPlayFirst ? BloodCardEnum.PlayerRole.ENEMY : BloodCardEnum.PlayerRole.SELF);
				}
				else if (cardCell.index % (columns - 2) == 4)
				{
					cardCell.SetPoint(0, (!isPlayFirst) ? BloodCardEnum.PlayerRole.ENEMY : BloodCardEnum.PlayerRole.SELF);
					cardCell.SetPoint(1, isPlayFirst ? BloodCardEnum.PlayerRole.ENEMY : BloodCardEnum.PlayerRole.SELF);
				}
			}
			else
			{
				cardCell.SetPoint(0, BloodCardEnum.PlayerRole.SELF);
				cardCell.SetPoint(0, BloodCardEnum.PlayerRole.ENEMY);
			}
		}
	}
}

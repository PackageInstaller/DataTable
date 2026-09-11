using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using LitJson;
using UnityEngine;

public class EatSnakeMain : MonoBehaviour
{
	public class Position
	{
		public int x;

		public int y;

		public int type;

		public Position(int x, int y, int type)
		{
			this.x = x;
			this.y = y;
			this.type = type;
		}
	}

	public enum TYPE
	{
		NONE = 1,
		FLOOR = 2,
		REINFORCE_POINT = 0
	}

	private bool isDie;

	private bool isWin;

	public int step;

	public GameObject snakeHeadGo;

	public EatSnakeHead snakeHead;

	public GameObject bodyPrefab;

	public EatSnakeHead snakeTail;

	public GameObject foodParent;

	public EatSnakeBlock[,] eatSnakeBlocks = new EatSnakeBlock[16, 16];

	public float time;

	public float normalTimer = 0.25f;

	public float rushTimer = 0.17f;

	public float nowMoveTimer;

	public bool haveWall = true;

	public bool isLock;

	public int shiftX;

	public int shiftY;

	public float showTime;

	public List<EatSnakeBody> snakeParts = new List<EatSnakeBody>();

	public bool gamePause;

	private float foodSpawnInterval = 4f;

	private List<EatSnakeFood> foods = new List<EatSnakeFood>();

	private float lastFoodSpawnTime;

	private bool isShowTips;

	private bool isGrow;

	private int timer;

	private int[] targetBlock = new int[2];

	private List<int> removeInexList = new List<int>();

	private EatSnakeBlock lastBlock;

	public bool init;

	public GameObject foodPrefab;

	public float foodLifeTime = 20f;

	public int lastx;

	public int lasty;

	public GameObject bodyParent;

	public int currentIndex;

	public Dictionary<int, EatSnakeBlock> reinforcementDic = new Dictionary<int, EatSnakeBlock>();

	public EatSnakeUI eatSnakeUI;

	public Action winGameAction;

	public Action failGameAction;

	public int redCount;

	public int oriangeCount;

	public int blueCount;

	public static EatSnakeMain Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
		EatSnakeBlock[] componentsInChildren = GetComponentsInChildren<EatSnakeBlock>();
		int num = 0;
		EatSnakeBlock[] array = componentsInChildren;
		foreach (EatSnakeBlock eatSnakeBlock in array)
		{
			eatSnakeBlock.SetPosition(num / 16, num % 16);
			eatSnakeBlocks[num / 16, num % 16] = eatSnakeBlock;
			num++;
		}
	}

	public void LoadGame(string mapId)
	{
		isWin = false;
		isDie = false;
		init = false;
		LoadMap(mapId);
		shiftX = 1;
		shiftY = 0;
		snakeHead.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
		snakeHead.gameObject.SetActive(value: false);
		snakeTail.gameObject.SetActive(value: false);
		currentIndex = 1;
		nowMoveTimer = normalTimer;
		foreach (EatSnakeFood food in foods)
		{
			UnityEngine.Object.Destroy(food.gameObject);
		}
		foods.Clear();
		foreach (EatSnakeBody snakePart in snakeParts)
		{
			UnityEngine.Object.Destroy(snakePart.gameObject);
		}
		redCount = 0;
		oriangeCount = 0;
		blueCount = 0;
		snakeParts.Clear();
		SetReinforcementPoint();
		time = 0f;
		timer = -1;
		eatSnakeUI.Init();
		showTime = 0f;
		lastBlock = null;
	}

	private void Update()
	{
		eatSnakeUI.PrepareStart();
		if (init && !gamePause && !isWin && !isDie)
		{
			time += Time.deltaTime;
			showTime += Time.deltaTime;
			if (time >= nowMoveTimer)
			{
				time -= nowMoveTimer;
				Move();
			}
			HandleFoodSpawning();
			eatSnakeUI.UpdateText();
		}
	}

	private void CheckReinforcementByCoordinates()
	{
		if (isWin || isDie)
		{
			return;
		}
		EatSnakeBlock eatSnakeBlock = reinforcementDic[currentIndex];
		if (snakeHead.x != eatSnakeBlock.x || snakeHead.y != eatSnakeBlock.y)
		{
			return;
		}
		int num = 0;
		foreach (EatSnakeBody snakePart in snakeParts)
		{
			if (!snakePart.isRemoving && snakePart.type == eatSnakeBlock.reinforceNeedType)
			{
				num++;
			}
		}
		if (!isShowTips)
		{
			string text = ((num >= eatSnakeBlock.reinforceNeedCount) ? "SNAKEGAME_COMPLETE_POINT" : "SNAKEGAME_LACK");
			LuaHelper.CallFunction("ShowTips", text);
			isShowTips = true;
		}
		if (num >= eatSnakeBlock.reinforceNeedCount)
		{
			eatSnakeBlock.SetComplete();
			MoveToNextReinforcementPoint(eatSnakeBlock);
			AudioManager.Instance.Play("effect", "minigame_activity_1_3", "minigame_activity_1_3_select", useStream: false);
		}
	}

	private void RemoveSnake()
	{
		LeanTween.cancel(snakeHead.transform.gameObject);
		LeanTween.cancel(snakeTail.transform.gameObject);
		snakeHead.gameObject.SetActive(value: false);
		snakeTail.gameObject.SetActive(value: false);
		foreach (EatSnakeBody snakePart in snakeParts)
		{
			snakePart.Break();
		}
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_snake_die", useStream: false);
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			foreach (EatSnakeBody snakePart2 in snakeParts)
			{
				UnityEngine.Object.Destroy(snakePart2.transform.gameObject);
			}
			snakeParts.Clear();
			timer = -1;
		}, 0.5f, 1);
	}

	private void RemoveSnakeParts(EatSnakeBlock rp)
	{
		if (timer > 0)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
			OnRemoveSnakePart();
			timer = -1;
		}
		lastBlock = rp;
		int num = rp.reinforceNeedCount;
		for (int i = 0; i < snakeParts.Count; i++)
		{
			if (rp.reinforceNeedType == snakeParts[i].type && num > 0)
			{
				num--;
				snakeParts[i].Break();
				removeInexList.Add(i);
			}
		}
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			OnRemoveSnakePart();
			timer = -1;
		}, 0.5f, 1);
	}

	private void OnRemoveSnakePart()
	{
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		List<int> list3 = new List<int>();
		int num = lastBlock.reinforceNeedCount;
		for (int i = 0; i < snakeParts.Count; i++)
		{
			list2.Add(snakeParts[i].x);
			list3.Add(snakeParts[i].y);
			if (lastBlock.reinforceNeedType == snakeParts[i].type && num > 0)
			{
				num--;
			}
			else
			{
				list.Add(snakeParts[i].type);
			}
		}
		EatSnakeBody eatSnakeBody = snakeParts[snakeParts.Count - lastBlock.reinforceNeedCount + 1];
		_ = eatSnakeBody.x;
		_ = eatSnakeBody.y;
		for (int j = 0; j < lastBlock.reinforceNeedCount; j++)
		{
			int index = removeInexList[j] - j;
			LeanTween.cancel(snakeParts[index].gameObject);
			UnityEngine.Object.Destroy(snakeParts[index].gameObject);
			snakeParts.RemoveAt(index);
		}
		for (int k = 0; k < snakeParts.Count; k++)
		{
			snakeParts[k].SetData(list2[k], list3[k], list[k]);
			snakeParts[k].isRemoving = false;
		}
		removeInexList.Clear();
	}

	private void SetReinforcementPoint()
	{
		if (!reinforcementDic.ContainsKey(currentIndex))
		{
			return;
		}
		EatSnakeBlock eatSnakeBlock = reinforcementDic[currentIndex];
		EatSnakeBlock nextRp = ((currentIndex + 1 <= reinforcementDic.Count) ? reinforcementDic[currentIndex + 1] : null);
		for (int i = 0; i < foods.Count; i++)
		{
			if (eatSnakeBlock.x == foods[i].x && eatSnakeBlock.y == foods[i].y)
			{
				UnityEngine.Object.Destroy(foods[i].gameObject);
				foods.RemoveAt(i);
			}
		}
		eatSnakeUI.UpdateReinforce(eatSnakeBlock, nextRp, currentIndex - 1, reinforcementDic.Count);
		eatSnakeBlock.SetType(0);
		eatSnakeBlock.animator.Play(eatSnakeBlock.animationName[eatSnakeBlock.reinforceNeedType - 1]);
	}

	private void MoveToNextReinforcementPoint(EatSnakeBlock rp)
	{
		if (reinforcementDic.ContainsKey(currentIndex + 1))
		{
			currentIndex++;
			SetReinforcementPoint();
			RemoveSnakeParts(rp);
			return;
		}
		isWin = true;
		for (int i = 1; i <= currentIndex; i++)
		{
			EatSnakeBlock eatSnakeBlock = reinforcementDic[i];
			eatSnakeBlock.image.color = new Color(1f, 1f, 1f, 1f);
			eatSnakeBlock.image.sprite = eatSnakeBlock.spriteList[3];
			eatSnakeBlock.animator.Play("cellitem_finish02");
		}
		eatSnakeUI.UpdateReinforce(null, null, reinforcementDic.Count, reinforcementDic.Count);
		RemoveSnake();
		winGameAction();
	}

	private void CheckFoodByCoordinates()
	{
		for (int num = foods.Count - 1; num >= 0; num--)
		{
			if (snakeHead.x == foods[num].x && snakeHead.y == foods[num].y)
			{
				GrowSnake(foods[num]);
				UnityEngine.Object.Destroy(foods[num].gameObject);
				foods.RemoveAt(num);
				break;
			}
		}
	}

	private void GrowSnake(EatSnakeFood food)
	{
		EatSnakeBody component = UnityEngine.Object.Instantiate(bodyPrefab, snakeHead.transform.position, Quaternion.identity).GetComponent<EatSnakeBody>();
		component.transform.SetParent(bodyParent.transform);
		component.transform.SetAsFirstSibling();
		_ = eatSnakeBlocks[lastx, lasty];
		CheckDistance(component.transform, lastx, lasty, isMoveImmediately: true);
		component.SetData(lastx, lasty, food.type);
		snakeParts.Add(component);
		string text = "";
		text = ((food.type == 1) ? "minigame_activity_3_10_snake_red" : ((food.type != 2) ? "minigame_activity_3_10_snake_oringe" : "minigame_activity_3_10_snake_blue"));
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", text, useStream: false);
		isGrow = true;
	}

	private void RemoveExpiredFoods()
	{
		for (int num = foods.Count - 1; num >= 0; num--)
		{
			if (showTime - foods[num].spawnTime >= foodLifeTime)
			{
				UnityEngine.Object.Destroy(foods[num].gameObject);
				foods.RemoveAt(num);
			}
		}
	}

	private void Move()
	{
		if (isDie || isWin)
		{
			return;
		}
		if (CheckDie())
		{
			isDie = true;
			for (int i = 1; i <= currentIndex; i++)
			{
				EatSnakeBlock eatSnakeBlock = reinforcementDic[i];
				eatSnakeBlock.image.sprite = eatSnakeBlock.spriteList[4];
				eatSnakeBlock.text.text = "";
				eatSnakeBlock.image.color = new Color(1f, 1f, 1f, 1f);
				eatSnakeBlock.animator.Play("cellitem_02");
			}
			failGameAction();
			RemoveSnake();
			return;
		}
		isGrow = false;
		CheckFoodByCoordinates();
		RemoveExpiredFoods();
		CheckReinforcementByCoordinates();
		isLock = false;
		isShowTips = false;
		eatSnakeBlocks[snakeHead.x, snakeHead.y].direction[0] = shiftX;
		eatSnakeBlocks[snakeHead.x, snakeHead.y].direction[1] = shiftY;
		TailControl();
		for (int num = snakeParts.Count - 1; num >= 0; num--)
		{
			if (num == 0)
			{
				CheckDistance(snakeParts[num].transform, snakeHead.x, snakeHead.y);
				snakeParts[num].SetData(snakeHead.x, snakeHead.y, snakeParts[num].type);
			}
			else
			{
				CheckDistance(snakeParts[num].transform, snakeParts[num - 1].x, snakeParts[num - 1].y);
				snakeParts[num].SetData(snakeParts[num - 1].x, snakeParts[num - 1].y, snakeParts[num].type);
			}
		}
		CheckDistance(snakeHead.transform, targetBlock[0], targetBlock[1]);
		snakeHead.x = targetBlock[0];
		snakeHead.y = targetBlock[1];
		RotateHead();
	}

	private void TailControl()
	{
		if (!isGrow)
		{
			int num = 0;
			int num2 = 0;
			if (snakeParts.Count > 0)
			{
				num = snakeParts[snakeParts.Count - 1].x;
				num2 = snakeParts[snakeParts.Count - 1].y;
				CheckDistance(snakeTail.transform, num, num2);
			}
			else
			{
				num = snakeHead.x;
				num2 = snakeHead.y;
				CheckDistance(snakeTail.transform, num, num2);
			}
			RotateTail(num, num2);
			snakeTail.x = num;
			snakeTail.y = num2;
		}
	}

	private void RotateTail(int x, int y)
	{
		int num = eatSnakeBlocks[x, y].direction[0];
		int num2 = eatSnakeBlocks[x, y].direction[1];
		int num3 = 0;
		if (num == -1 && num2 == 0)
		{
			num3 = 180;
		}
		else if (num == 1 && num2 == 0)
		{
			num3 = 0;
		}
		else if (num == 0 && num2 == -1)
		{
			num3 = -90;
		}
		else if (num == 0 && num2 == 1)
		{
			num3 = 90;
		}
		LeanTween.rotate(snakeTail.transform.gameObject, new Vector3(0f, 0f, num3), 0.1f);
	}

	private void RotateHead()
	{
		int num = 0;
		if (shiftX == -1 && shiftY == 0)
		{
			num = 180;
		}
		else if (shiftX == 1 && shiftY == 0)
		{
			num = 0;
		}
		else if (shiftX == 0 && shiftY == -1)
		{
			num = -90;
		}
		else if (shiftX == 0 && shiftY == 1)
		{
			num = 90;
		}
		LeanTween.rotate(snakeHead.transform.gameObject, new Vector3(0f, 0f, num), 0.1f);
	}

	private void CheckDistance(Transform trans, int targetX, int targetY, bool isMoveImmediately = false)
	{
		LeanTween.cancel(trans.gameObject);
		Vector3 position = eatSnakeBlocks[targetX, targetY].transform.position;
		if (isMoveImmediately)
		{
			trans.position = new Vector3(position.x, position.y, position.z);
		}
		else if ((double)Vector3.Distance(trans.position, position) > 0.5)
		{
			trans.position = new Vector3(position.x - (float)shiftY * 0.08f, position.y + (float)shiftX * 0.08f, position.z);
			LeanTween.move(trans.gameObject, position, nowMoveTimer);
		}
		else
		{
			LeanTween.move(trans.gameObject, position, nowMoveTimer);
		}
	}

	private bool CheckDie()
	{
		if (snakeParts.Count == 0)
		{
			lastx = snakeHead.x;
			lasty = snakeHead.y;
		}
		else
		{
			lastx = snakeParts[snakeParts.Count - 1].x;
			lasty = snakeParts[snakeParts.Count - 1].y;
		}
		if (haveWall)
		{
			snakeHead.x += shiftX;
			snakeHead.y += shiftY;
			if (snakeHead.x < 0 || snakeHead.x >= 16 || snakeHead.y < 0 || snakeHead.y >= 16)
			{
				return true;
			}
			if (eatSnakeBlocks[snakeHead.x, snakeHead.y].type == EatSnakeBlock.TYPE.NONE)
			{
				return true;
			}
			if (snakeParts.Count <= 4)
			{
				return false;
			}
			for (int num = snakeParts.Count - 1; num > 0; num--)
			{
				if (snakeParts[num].x == snakeHead.x && snakeParts[num].y == snakeHead.y)
				{
					return true;
				}
			}
		}
		else
		{
			targetBlock = FindNext();
			if (snakeParts.Count <= 2)
			{
				return false;
			}
			for (int num2 = snakeParts.Count - 1; num2 > 0; num2--)
			{
				if (snakeParts[num2].x == targetBlock[0] && snakeParts[num2].y == targetBlock[1])
				{
					return true;
				}
			}
		}
		return false;
	}

	private int[] FindNext()
	{
		int num = snakeHead.x;
		int num2 = snakeHead.y;
		do
		{
			num += shiftX;
			num2 += shiftY;
			if (num < 0)
			{
				num = 15;
			}
			if (num >= 16)
			{
				num = 0;
			}
			if (num2 < 0)
			{
				num2 = 15;
			}
			if (num2 >= 16)
			{
				num2 = 0;
			}
		}
		while (eatSnakeBlocks[num, num2].type == EatSnakeBlock.TYPE.NONE);
		return new int[2] { num, num2 };
	}

	private void LoadMap(string mapID)
	{
		TextAsset textAsset = AssetManager.Load<TextAsset>("Map/SnakeMap/" + mapID + ".txt");
		if (textAsset == null)
		{
			return;
		}
		IList<JsonData> list = JsonMapper.ToObject(textAsset.text).toDict()["floorData"].toArray();
		int num = 0;
		EatSnakeBlock[,] array = eatSnakeBlocks;
		foreach (EatSnakeBlock eatSnakeBlock in array)
		{
			string[] array2 = list[num].ToString().Split(",");
			eatSnakeBlock.SetData(int.Parse(array2[0]), int.Parse(array2[1]), int.Parse(array2[2]), int.Parse(array2[3]), int.Parse(array2[4]), int.Parse(array2[5]));
			if (array2[2] == "0")
			{
				reinforcementDic[int.Parse(array2[3])] = eatSnakeBlock;
				if (int.Parse(array2[3]) != 1)
				{
					eatSnakeBlock.SetData(int.Parse(array2[0]), int.Parse(array2[1]), 2, int.Parse(array2[3]), int.Parse(array2[4]), int.Parse(array2[5]));
				}
			}
			num++;
		}
	}

	private void HandleFoodSpawning()
	{
		if (foods.Count == 0 || Time.time - lastFoodSpawnTime >= foodSpawnInterval)
		{
			SpawnFood();
			lastFoodSpawnTime = Time.time;
		}
	}

	private void SpawnFood()
	{
		int num;
		int num2;
		do
		{
			num = UnityEngine.Random.Range(0, 16);
			num2 = UnityEngine.Random.Range(0, 16);
		}
		while (IsPositionCanUse(num, num2));
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_snake_ball_appear", useStream: false);
		int randomFoodType = GetRandomFoodType();
		EatSnakeFood component = UnityEngine.Object.Instantiate(foodPrefab, foodParent.transform).GetComponent<EatSnakeFood>();
		component.SetData(num, num2, randomFoodType, showTime);
		component.transform.position = eatSnakeBlocks[num, num2].transform.position;
		foods.Add(component);
	}

	private bool IsPositionCanUse(int x, int y)
	{
		if (snakeHead.x == x && snakeHead.y == y)
		{
			return true;
		}
		foreach (EatSnakeFood food in foods)
		{
			if (x == food.x && y == food.y)
			{
				return true;
			}
		}
		if (eatSnakeBlocks[x, y].type != EatSnakeBlock.TYPE.FLOOR)
		{
			return true;
		}
		foreach (EatSnakeBody snakePart in snakeParts)
		{
			if (snakePart.x == x && snakePart.y == y)
			{
				return true;
			}
		}
		return false;
	}

	private int GetRandomFoodType()
	{
		//IL_000c: Field data (rva=0x508) could not be found in any section!
		//IL_000c: Field data (rva=0x508) could not be found in any section!
		int[] array = new int[3];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		int[] array2 = array;
		int count = snakeParts.Count;
		if (count < 3)
		{
			return array2[UnityEngine.Random.Range(0, array2.Length)];
		}
		int num = 0;
		int[] array3 = CalculateSnakePartCount();
		int num2 = (int)((float)count * (1f - (float)array3[0] / (float)count));
		int num3 = (int)((float)count * (1f - (float)array3[1] / (float)count));
		int num4 = (int)((float)count * (1f - (float)array3[2] / (float)count));
		int num5 = UnityEngine.Random.Range(0, num2 + num3 + num4);
		num = ((num5 > num2) ? ((num5 > num2 && num5 <= num2 + num3) ? 1 : 2) : 0);
		return array2[num];
	}

	public int[] CalculateSnakePartCount()
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		foreach (EatSnakeBody snakePart in snakeParts)
		{
			if (snakePart.type == 1)
			{
				num++;
			}
			if (snakePart.type == 2)
			{
				num2++;
			}
			if (snakePart.type == 3)
			{
				num3++;
			}
		}
		return new int[3] { num, num2, num3 };
	}

	public void ClearAllBlockStatus()
	{
		reinforcementDic.Clear();
		EatSnakeBlock[,] array = eatSnakeBlocks;
		foreach (EatSnakeBlock eatSnakeBlock in array)
		{
			eatSnakeBlock.animator.Play("none", 0, 0f);
			eatSnakeBlock.image.color = new Color(1f, 1f, 1f, 0f);
		}
	}

	private void OnDestroy()
	{
		if (timer > 0 && FuncTimerManager.inst != null)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
		}
	}
}

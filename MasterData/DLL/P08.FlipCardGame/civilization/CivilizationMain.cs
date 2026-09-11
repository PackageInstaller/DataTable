using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.EventSystems;

namespace civilization;

public class CivilizationMain : MonoBehaviour
{
	[Serializable]
	public class WaitingBlock
	{
		public int x;

		public int y;

		public int kind;

		public int level;

		public int land;
	}

	public GameObject BossEffectGo;

	private CivilizationExchangeData exchangeData;

	public CivilizationSkillData skillData;

	public CivilizationGameUI uiInstance;

	public int seconds;

	public Dictionary<int, int> skillUseDic;

	public List<int> skillUnlockList;

	public Hero hero;

	public int speed;

	public List<CivilizationGameBlock> freeBlocks;

	public CivilizationGameBlock[,] blockCells;

	public int hightLimit;

	public int wideLimit;

	public List<WaitingBlock> appearBlocks;

	public List<CivilizationGameBlock> movingBlocks;

	public List<CivilizationGameBlock> combiningBlocks;

	public List<CivilizationGameBlock> wars;

	public List<CivilizationGameBlock> beasts;

	public List<CivilizationGameBlock> boms;

	public List<CivilizationGameBlock> buildings;

	public List<CivilizationGameSkillBlock> skillBlocks;

	public CivilizationGameBlockBase showingBlock;

	private CivilizationGameBlockBase mouseOnBlock;

	public CivilizationGameMouse mouse;

	private int appearCount;

	public List<int> limits;

	public List<int> lows;

	public bool mapExtension;

	public Dictionary<int, int> skillUseCount;

	public GameObject bossTips;

	public List<Sprite> spriteList;

	public List<int> probability;

	private int poolNumber;

	private List<int> pool;

	private bool specialMask;

	public int beastDestoryCount;

	private bool canDrag;

	public List<int> unlockTech;

	public List<int> source;

	public int haveAddLevel;

	public List<int> factorPool;

	public int foodCost;

	public bool isAragamiCreate;

	public Stage stage;

	public GameType gameType;

	public bool lastYear;

	public int turn;

	public int curTechState;

	public int nextLevelTech;

	public int yearChange;

	public int nextStageYear;

	public int curAge;

	public int curTime;

	public int curHex;

	private int foodLastTurn;

	private int foodLastTurnPool;

	private int foodBonusProbability;

	private int foodBonusNum;

	public int beastBonusProbability;

	public int beastBonusNum;

	public int bomBonusProbability;

	public int bomBonusNum;

	public int moveAdd;

	public int skillCostSub;

	public bool isNotEnemy;

	public bool isTeach;

	[SerializeField]
	public int[,] teachEndPositonArray;

	[SerializeField]
	public int[,] teachStartPositonArray;

	[SerializeField]
	public int teachStep;

	public static CivilizationMain Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
	}

	public void StartGame(int stageID, int heroID, int activityID, GameType gameType)
	{
		exchangeData = new CivilizationExchangeData(activityID, stageID, heroID);
		seconds = GetSecond();
		skillData = new CivilizationSkillData();
		skillUseDic = new Dictionary<int, int>();
		skillUnlockList = new List<int>();
		stage = CivilizationCfg.GetStage(stageID);
		this.gameType = gameType;
		wideLimit = 5;
		hightLimit = 5;
		ResetGame(stageID, heroID);
	}

	public void ResetGame(int stageID, int heroID)
	{
		CivilizationGameBlock[] componentsInChildren = base.transform.Find("panel/middle_adapt/Base/gridContent/nodeParent/box1").gameObject.GetComponentsInChildren<CivilizationGameBlock>();
		int num = 0;
		int num2 = 4;
		lastYear = false;
		hero = CivilizationCfg.GetHero(heroID);
		speed = 1;
		teachStep = 0;
		freeBlocks.Clear();
		appearBlocks.Clear();
		movingBlocks.Clear();
		combiningBlocks.Clear();
		buildings.Clear();
		wars.Clear();
		beasts.Clear();
		boms.Clear();
		skillBlocks.Clear();
		appearCount = 0;
		limits = new List<int> { 1, 1, 1, 1, 1, 1, 1, 1 };
		lows = new List<int> { 1, 1, 1, 1, 1, 1, 1, 1 };
		mapExtension = false;
		isAragamiCreate = false;
		NewPoor();
		skillUseCount.Clear();
		unlockTech.Clear();
		factorPool.Clear();
		haveAddLevel = 0;
		beastDestoryCount = 0;
		foodLastTurn = 0;
		foodLastTurnPool = 0;
		foodBonusProbability = 0;
		foodBonusNum = 0;
		beastBonusProbability = 0;
		beastBonusNum = 0;
		bomBonusNum = 0;
		moveAdd = 0;
		skillCostSub = 0;
		isNotEnemy = false;
		CivilizationGameBlock[] array = componentsInChildren;
		foreach (CivilizationGameBlock civilizationGameBlock in array)
		{
			blockCells[num, num2] = civilizationGameBlock;
			freeBlocks.Add(civilizationGameBlock);
			civilizationGameBlock.ResetBlock();
			civilizationGameBlock.x = num;
			civilizationGameBlock.y = num2;
			civilizationGameBlock.blockGo.SetActive(value: false);
			num++;
			if (num > 4)
			{
				num2--;
				num -= 5;
			}
		}
		base.transform.Find("panel/middle_adapt/Base/gridContent/nodeParent/box2").gameObject.SetActive(value: false);
		CivilizationGameSkillBlock[] componentsInChildren2 = base.transform.Find("panel/middle_adapt/ndBottomRail/ndbottom").gameObject.GetComponentsInChildren<CivilizationGameSkillBlock>();
		foreach (CivilizationGameSkillBlock civilizationGameSkillBlock in componentsInChildren2)
		{
			skillBlocks.Add(civilizationGameSkillBlock);
			civilizationGameSkillBlock.RefreshSkillShow(isShow: false);
		}
		BossEffectGo.SetActive(value: false);
		uiInstance.Reset();
		InitGameData(stageID, heroID);
	}

	public void InitGameData(int stageID, int heroID)
	{
		source.Clear();
		source.Add(0);
		source.AddRange(stage.init_source);
		turn = 1;
		curTechState = 0;
		nextLevelTech = CivilizationCfg.GetNeedTechCost(curTechState);
		curAge = -1;
		foodCost = 1;
		curHex = 0;
		probability.Clear();
		probability.AddRange(stage.init_cell_list);
		NextStageUpdate();
		uiInstance.UpdateSourceText();
		uiInstance.UpdateTimeText();
		int num = 1;
		if (stage.teach_init_list == null || stage.teach_init_list.Length == 0)
		{
			int[] init_cells_location = stage.init_cells_location;
			foreach (int num2 in init_cells_location)
			{
				for (int j = 0; j < num2; j++)
				{
					NewBlock(999, 999, num, 1);
				}
				num++;
			}
		}
		else
		{
			for (int k = 0; k < stage.teach_init_list.Length; k++)
			{
				NewBlock(stage.teach_init_list[k][0], stage.teach_init_list[k][1], stage.teach_init_list[k][2], stage.teach_init_list[k][3]);
			}
		}
		Factor factorByID = CivilizationCfg.GetFactorByID(hero.startTech);
		CheckTech(factorByID.id, factorByID.type, factorByID.params_num);
		for (int l = 0; l < stage.init_factor.Length; l++)
		{
			Factor factorByID2 = CivilizationCfg.GetFactorByID(stage.init_factor[l]);
			CheckTech(factorByID2.id, factorByID2.type, factorByID2.params_num);
		}
		UpdateSkill();
	}

	private void MapExtension()
	{
		int num = 5;
		int num2 = 4;
		wideLimit = 10;
		hightLimit = 5;
		LuaHelper.CallFunction("CivilizationGameToLuaBridge.MapExtension");
		GameObject obj = base.transform.Find("panel/middle_adapt/Base/gridContent/nodeParent/box2").gameObject;
		obj.SetActive(value: true);
		CivilizationGameBlock[] componentsInChildren = obj.GetComponentsInChildren<CivilizationGameBlock>();
		foreach (CivilizationGameBlock civilizationGameBlock in componentsInChildren)
		{
			blockCells[num, num2] = civilizationGameBlock;
			freeBlocks.Add(civilizationGameBlock);
			civilizationGameBlock.ResetBlock();
			civilizationGameBlock.x = num;
			civilizationGameBlock.y = num2;
			civilizationGameBlock.blockGo.SetActive(value: false);
			num++;
			if (num > 9)
			{
				num2--;
				num -= 5;
			}
		}
		for (int j = 0; j < 10; j++)
		{
			NewBlock();
		}
	}

	public void UpdateSkill()
	{
		for (int i = 0; i < skillBlocks.Count; i++)
		{
			CivilizationGameSkillBlock civilizationGameSkillBlock = skillBlocks[i];
			if (i >= skillData.unlockSkillList_.Count)
			{
				civilizationGameSkillBlock.RefreshSkillShow(isShow: false);
			}
			else
			{
				civilizationGameSkillBlock.RefreshSkillShow(isShow: true, skillData.unlockSkillList_[i]);
			}
		}
		RefreshSkillStage();
	}

	public void NewBlock(int x, int y, int kind, int level)
	{
		if (kind == 7)
		{
			isAragamiCreate = true;
			ShowBossTips();
		}
		WaitingBlock waitingBlock = new WaitingBlock();
		waitingBlock.kind = kind;
		waitingBlock.level = level;
		waitingBlock.x = x;
		waitingBlock.y = y;
		appearBlocks.Add(waitingBlock);
		exchangeData.SetBlock(kind);
	}

	private void UpdateSpecialSkillMask()
	{
		if (!specialMask)
		{
			return;
		}
		if (mouseOnBlock == null || mouseOnBlock.IsSkill)
		{
			CivilizationGameBlock[,] array = blockCells;
			foreach (CivilizationGameBlock civilizationGameBlock in array)
			{
				if (civilizationGameBlock != null)
				{
					civilizationGameBlock.SetMask(isMask: true);
				}
			}
		}
		else if ((showingBlock as CivilizationGameSkillBlock).skillID == 1008)
		{
			CivilizationGameBlock[,] array = blockCells;
			foreach (CivilizationGameBlock civilizationGameBlock2 in array)
			{
				if (civilizationGameBlock2 != null)
				{
					civilizationGameBlock2.SetMask(Math.Abs(civilizationGameBlock2.x - mouseOnBlock.x) > 1 || Math.Abs(civilizationGameBlock2.y - mouseOnBlock.y) > 1 || (civilizationGameBlock2.kind != 1 && civilizationGameBlock2.kind != 0));
				}
			}
		}
		else if ((showingBlock as CivilizationGameSkillBlock).skillID == 1009)
		{
			CivilizationGameBlock[,] array = blockCells;
			foreach (CivilizationGameBlock civilizationGameBlock3 in array)
			{
				if (civilizationGameBlock3 != null)
				{
					civilizationGameBlock3.SetMask(Math.Abs(civilizationGameBlock3.x - mouseOnBlock.x) > 2 || Math.Abs(civilizationGameBlock3.y - mouseOnBlock.y) > 2 || (civilizationGameBlock3.kind != 4 && civilizationGameBlock3.kind != 0));
				}
			}
		}
		else
		{
			if ((showingBlock as CivilizationGameSkillBlock).skillID != 1014)
			{
				return;
			}
			CivilizationGameBlock[,] array = blockCells;
			foreach (CivilizationGameBlock civilizationGameBlock4 in array)
			{
				if (civilizationGameBlock4 != null)
				{
					civilizationGameBlock4.SetMask(Math.Abs(civilizationGameBlock4.x - mouseOnBlock.x) > 1 || Math.Abs(civilizationGameBlock4.y - mouseOnBlock.y) > 1 || (civilizationGameBlock4.kind != 3 && civilizationGameBlock4.kind != 0));
				}
			}
		}
	}

	public void RefreshAllBlock()
	{
		CivilizationGameBlock[,] array = blockCells;
		foreach (CivilizationGameBlock civilizationGameBlock in array)
		{
			if (civilizationGameBlock != null && (civilizationGameBlock.kind == 1 || civilizationGameBlock.kind == 2 || civilizationGameBlock.kind == 3))
			{
				int val = civilizationGameBlock.speed;
				civilizationGameBlock.level = Math.Max(civilizationGameBlock.level, lows[civilizationGameBlock.kind]);
				civilizationGameBlock.number = civilizationGameBlock.level;
				civilizationGameBlock.FreshBlock(newBlock: true);
				civilizationGameBlock.speed = Math.Max(val, speed);
				civilizationGameBlock.BigCheckSame();
			}
		}
	}

	public List<int> DetailBuryPointNeedData()
	{
		List<int> list = new List<int>();
		CivilizationGameBlock[,] array = blockCells;
		foreach (CivilizationGameBlock civilizationGameBlock in array)
		{
			if (civilizationGameBlock != null && civilizationGameBlock.kind != 0)
			{
				int item = civilizationGameBlock.kind * 10 + civilizationGameBlock.level;
				list.Add(item);
			}
		}
		return list;
	}

	private bool IsOnUI()
	{
		if (!canDrag || uiInstance.isOpenLuaPage)
		{
			mouseOnBlock = null;
			return false;
		}
		PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
		pointerEventData.position = Input.mousePosition;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(pointerEventData, list);
		if (list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i].gameObject.name == "mask" || list[i].gameObject.name == "Mask" || list[i].gameObject.name == "tipsMask" || list[i].gameObject.name == "infoTipsMask" || list[i].gameObject.name == "infoSourceMask")
				{
					mouseOnBlock = null;
					return false;
				}
				if (list[i].gameObject.name == "civilizationBlockItem")
				{
					mouseOnBlock = list[i].gameObject.transform.GetComponent<CivilizationGameBlock>();
					if (null == mouseOnBlock)
					{
						mouseOnBlock = list[i].gameObject.transform.GetComponent<CivilizationGameSkillBlock>();
					}
					return true;
				}
			}
		}
		mouseOnBlock = null;
		return false;
	}

	private bool NotMoving()
	{
		if (appearBlocks.Count <= 0 && movingBlocks.Count <= 0)
		{
			return combiningBlocks.Count <= 0;
		}
		return false;
	}

	private void Update()
	{
		if (NotMoving() && mapExtension)
		{
			mapExtension = false;
			MapExtension();
		}
		if (IsOnUI() && Input.GetMouseButtonDown(0) && NotMoving() && showingBlock == null)
		{
			if (mouseOnBlock.IsSkill)
			{
				if (gameType == GameType.Teach && teachStep < teachStartPositonArray.GetLength(0) && (!isTeach || (mouseOnBlock as CivilizationGameSkillBlock).skillID != 1002))
				{
					mouseOnBlock = null;
					return;
				}
				if ((mouseOnBlock as CivilizationGameSkillBlock).CanUse(skillData.freeSkillNum1 + skillData.freeSkillNum2))
				{
					StartDrag(mouseOnBlock);
					showingBlock = mouseOnBlock;
					if ((showingBlock as CivilizationGameSkillBlock).CheckSpecialMask())
					{
						specialMask = true;
					}
				}
			}
			else
			{
				if (gameType == GameType.Teach && teachStep < teachStartPositonArray.GetLength(0) && (!isTeach || mouseOnBlock.x != teachStartPositonArray[teachStep, 0] || mouseOnBlock.y != teachStartPositonArray[teachStep, 1]))
				{
					mouseOnBlock = null;
					return;
				}
				if ((mouseOnBlock as CivilizationGameBlock).kind != 0 && !(mouseOnBlock as CivilizationGameBlock).moving && (mouseOnBlock as CivilizationGameBlock).canMove && NotMoving())
				{
					StartDrag(mouseOnBlock);
					showingBlock = mouseOnBlock;
				}
			}
		}
		UpdateSpecialSkillMask();
		if (!Input.GetMouseButtonUp(0) || !(showingBlock != null))
		{
			return;
		}
		if (IsOnUI() && !showingBlock.IsSkill && (showingBlock as CivilizationGameBlock).CheckSpeed(mouseOnBlock.x, mouseOnBlock.y))
		{
			(showingBlock as CivilizationGameBlock).CheckMove(mouseOnBlock.x, mouseOnBlock.y);
		}
		else if (showingBlock.IsSkill && null != mouseOnBlock && !mouseOnBlock.IsSkill && (showingBlock as CivilizationGameSkillBlock).CheckSkill(mouseOnBlock as CivilizationGameBlock, ref skillData.freeSkillNum1, ref skillData.freeSkillNum2))
		{
			int skillID = (showingBlock as CivilizationGameSkillBlock).skillID;
			if (!skillUseDic.ContainsKey(skillID))
			{
				skillUseDic.Add(skillID, 1);
			}
			else
			{
				skillUseDic[skillID]++;
			}
			uiInstance.UpdateHexAni(1002, foodLastTurn);
			showingBlock.FreshBlock(newBlock: false);
			UpdateSkill();
		}
		else
		{
			showingBlock.FreshBlock(newBlock: false);
		}
		EndDrag();
		specialMask = false;
		showingBlock = null;
	}

	private void FixedUpdate()
	{
		if (appearBlocks.Count > 0 && movingBlocks.Count == 0 && combiningBlocks.Count == 0)
		{
			appearCount++;
			if (appearCount >= 5)
			{
				if (freeBlocks.Count > 0)
				{
					WaitingBlock waitingBlock = appearBlocks[0];
					bool flag = false;
					CivilizationGameBlock civilizationGameBlock = null;
					if (waitingBlock.x < 99 && freeBlocks.Contains(blockCells[waitingBlock.x, waitingBlock.y]))
					{
						flag = true;
						civilizationGameBlock = blockCells[waitingBlock.x, waitingBlock.y];
					}
					if (!flag && freeBlocks.Count > 0)
					{
						civilizationGameBlock = freeBlocks[UnityEngine.Random.Range(0, freeBlocks.Count)];
					}
					if (null != civilizationGameBlock)
					{
						appearBlocks.RemoveAt(0);
						freeBlocks.Remove(civilizationGameBlock);
						int level = Math.Max(waitingBlock.level, lows[civilizationGameBlock.kind]);
						civilizationGameBlock.SetBlockValue(waitingBlock.kind, level);
					}
				}
				else
				{
					appearBlocks.Clear();
				}
				appearCount = 0;
			}
		}
		if (NotMoving())
		{
			uiInstance.UpdateLuaPop();
		}
	}

	public bool CheckBlock(int x, int y, int kind)
	{
		if (kind == 0 && blockCells[x, y].CheckIsDestroying())
		{
			return true;
		}
		return blockCells[x, y].kind == kind;
	}

	public void NextYear()
	{
		NewBlock();
		for (int num = wars.Count - 1; num >= 0; num--)
		{
			wars[num].number--;
			wars[num].timeText.text = wars[num].number.ToString();
			if (wars[num].number <= 0)
			{
				wars[num].BeDestroy();
			}
		}
		for (int i = 0; i < buildings.Count; i++)
		{
			buildings[i].PlayAddAni(1, 2);
		}
		turn++;
		ChangeSource(SourceType.FOOD, -foodCost);
		ChangeSource(SourceType.TECH, buildings.Count);
		if (buildings.Count > 0)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_produce", useStream: false);
		}
		skillData.ChangeSkillCd();
		curTime += yearChange;
		if (!lastYear && curTime >= nextStageYear)
		{
			NextStageUpdate();
		}
		uiInstance.UpdateTimeText();
	}

	public int GetSkillCD(int skillID)
	{
		return skillData.GetSkillCd(skillID);
	}

	public void NextStageUpdate()
	{
		curAge++;
		if (curAge >= CivilizationCfg.age.Count - 1)
		{
			lastYear = true;
			nextStageYear = -1;
		}
		else
		{
			Age age = CivilizationCfg.age[curAge + 1];
			nextStageYear = age.startAge;
		}
		_ = foodCost;
		Age age2 = CivilizationCfg.age[curAge];
		foodCost += age2.foodCostChange;
		if (curAge == 0)
		{
			curTime = age2.startAge;
		}
		CheckEnemyProbability(probability);
		for (int i = 0; i < probability.Count; i++)
		{
			if (i != 4 || !isNotEnemy)
			{
				probability[i] += age2.sourceChange[i];
			}
		}
		NewPoor();
		CheckEnemyProbability(probability);
		mapExtension = age2.mapExtension;
		yearChange = age2.turnChange;
		if (curAge >= 1)
		{
			Age age3 = CivilizationCfg.age[curAge - 1];
			uiInstance.UpdateStageUI(curAge, age3.id);
		}
		if (age2.hex)
		{
			ChooseHex(curHex);
			curHex++;
		}
	}

	private int CheckEnemyProbability(List<int> probability)
	{
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < probability.Count; i++)
		{
			if (i > 2)
			{
				num2 += probability[i];
			}
			num += probability[i];
		}
		return Convert.ToInt32((float)num2 / (float)num * 100f);
	}

	private void ChooseHex(int hexIndex)
	{
		uiInstance.UpdateHexUI(hexIndex, hero.id);
	}

	public void StartDrag(CivilizationGameBlockBase block)
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_pick", useStream: false);
		block.StartDrag();
		mouse.SetMouseBlock(block);
		ShowMask(block);
	}

	private void ShowMask(CivilizationGameBlockBase b)
	{
		if (b.IsSkill && !(b as CivilizationGameSkillBlock).CheckSpecialMask())
		{
			int count = 0;
			CivilizationGameBlock[,] array = blockCells;
			foreach (CivilizationGameBlock block in array)
			{
				(b as CivilizationGameSkillBlock).CheckMask(block, ref count);
			}
		}
		else
		{
			if (b.IsSkill)
			{
				return;
			}
			int count2 = 0;
			CivilizationGameBlock[,] array = blockCells;
			foreach (CivilizationGameBlock block2 in array)
			{
				(b as CivilizationGameBlock).CheckMask(block2, ref count2);
			}
		}
	}

	private void HideMask()
	{
		CivilizationGameBlock[,] array = blockCells;
		foreach (CivilizationGameBlock civilizationGameBlock in array)
		{
			if (civilizationGameBlock != null)
			{
				civilizationGameBlock.SetMask(isMask: false);
			}
		}
	}

	public void RefreshSkillStage()
	{
		for (int i = 0; i < skillBlocks.Count; i++)
		{
			CivilizationGameSkillBlock civilizationGameSkillBlock = skillBlocks[i];
			if (i < skillData.unlockSkillList_.Count)
			{
				civilizationGameSkillBlock.FreshSkillCost();
			}
		}
	}

	public void EndDrag()
	{
		mouse.HideBlock();
		HideMask();
	}

	public void NewBlock()
	{
		if (stage.teach_create_list != null && stage.teach_create_list.Length != 0)
		{
			int num = turn - 1;
			if (num < stage.teach_create_list.Length)
			{
				NewBlock(stage.teach_create_list[num][0], stage.teach_create_list[num][1], stage.teach_create_list[num][2], stage.teach_create_list[num][3]);
				return;
			}
		}
		bool flag = false;
		while (!flag)
		{
			if (poolNumber >= pool.Count)
			{
				NewPoor();
			}
			int num2 = pool[poolNumber];
			poolNumber++;
			if (num2 != 7 || !isAragamiCreate)
			{
				flag = true;
				NewBlock(999, 999, num2, lows[num2]);
				break;
			}
		}
	}

	public void NewPoor()
	{
		pool.Clear();
		List<int> list = new List<int>();
		for (int i = 0; i < probability.Count; i++)
		{
			for (int j = 0; j < probability[i]; j++)
			{
				if ((i + 1 != 7 || !isAragamiCreate) && (i + 1 != 4 || !isNotEnemy))
				{
					list.Add(i + 1);
				}
			}
		}
		int count = list.Count;
		for (int k = 0; k < count; k++)
		{
			int index = UnityEngine.Random.Range(0, list.Count);
			pool.Add(list[index]);
			list.RemoveAt(index);
		}
		poolNumber = 0;
	}

	public void CheckTech(int id, int type, int[] numParams)
	{
		unlockTech.Add(id);
		switch (type)
		{
		case 1:
		{
			for (int num5 = 0; num5 < numParams.Length - 1; num5++)
			{
				skillData.ChangeSkillCost(numParams[num5], numParams[numParams.Length - 1]);
			}
			UpdateSkill();
			break;
		}
		case 2:
			foodLastTurnPool = numParams[0];
			break;
		case 3:
			foodBonusProbability = numParams[0];
			foodBonusNum = numParams[1];
			break;
		case 4:
			switch (id)
			{
			case 1004:
				skillData.freeSkillNum1 = numParams[0];
				uiInstance.UpdateHexAni(1004, skillData.freeSkillNum1);
				break;
			case 1006:
				skillData.freeSkillNum2 = numParams[0];
				uiInstance.UpdateHexAni(1006, skillData.freeSkillNum2);
				break;
			default:
				skillData.freeSkillNum2 = numParams[0];
				uiInstance.UpdateHexAni(2007, skillData.freeSkillNum2);
				break;
			}
			RefreshSkillStage();
			break;
		case 5:
			ChangeSource((SourceType)numParams[1], source[numParams[0]]);
			break;
		case 6:
		{
			int count = buildings.Count;
			ChangeSource((SourceType)numParams[0], numParams[1] * count);
			{
				foreach (CivilizationGameBlock building in buildings)
				{
					building.PlayAnimation("UI_shanshuo");
					building.PlayAddAni(numParams[1], numParams[0]);
				}
				break;
			}
		}
		case 7:
			beastBonusProbability = numParams[0];
			beastBonusNum = numParams[1];
			break;
		case 8:
		{
			for (int num6 = 0; num6 < numParams.Length; num6++)
			{
				skillData.ChangeSkillCost(numParams[num6], -999);
				skillData.isAttackFree = true;
			}
			UpdateSkill();
			break;
		}
		case 9:
			moveAdd = numParams[0];
			moveAdd = numParams[0];
			break;
		case 10:
			bomBonusNum = numParams[0];
			uiInstance.UpdateHexAni(2006, numParams[0]);
			break;
		case 11:
			skillData.UnlockSkill(numParams[0]);
			UpdateSkill();
			break;
		case 12:
			limits[numParams[0]] = numParams[1];
			break;
		case 13:
		{
			int num2 = numParams[0];
			int num3 = numParams[1];
			lows[num2] = num3;
			for (int m = 0; m < hightLimit; m++)
			{
				for (int n = 0; n < wideLimit; n++)
				{
					if (blockCells[n, m].kind == num2 && blockCells[n, m].level < num3)
					{
						blockCells[n, m].level = num3;
						blockCells[n, m].FreshBlock(newBlock: true);
					}
				}
			}
			for (int num4 = 0; num4 < appearBlocks.Count; num4++)
			{
				if (appearBlocks[num4].kind == num2 && appearBlocks[num4].level < num3)
				{
					appearBlocks[num4].level = num3;
				}
			}
			break;
		}
		case 14:
			skillData.ChangeSkill(numParams[1], numParams[0]);
			UpdateSkill();
			break;
		case 15:
			skillData.ChangeSkillCost(numParams[0]);
			UpdateSkill();
			break;
		case 16:
		{
			probability[4] = 0;
			isNotEnemy = true;
			NewPoor();
			skillData.DeleteSkill(1009);
			UpdateSkill();
			for (int k = 0; k < hightLimit; k++)
			{
				for (int l = 0; l < wideLimit; l++)
				{
					if (blockCells[l, k].kind == 4)
					{
						blockCells[l, k].BeDestroy();
					}
				}
			}
			break;
		}
		case 17:
		{
			int num = (speed += numParams[0]);
			for (int i = 0; i < hightLimit; i++)
			{
				for (int j = 0; j < wideLimit; j++)
				{
					if (blockCells[j, i].speed != num)
					{
						blockCells[j, i].speed = num;
					}
				}
			}
			break;
		}
		}
	}

	public void UnlockTech(int techID, bool isHex)
	{
		Factor factorByID = CivilizationCfg.GetFactorByID(techID);
		CheckTech(techID, factorByID.type, factorByID.params_num);
		exchangeData.SetTech(techID, isHex);
	}

	public void ChangeSource(SourceType type, int num)
	{
		if (type == SourceType.FOOD)
		{
			if (num < 0)
			{
				if (source[(int)type] + num <= 0)
				{
					if (foodLastTurnPool > 0 && foodLastTurn <= 0)
					{
						foodLastTurn += foodLastTurnPool;
						foodLastTurnPool = 0;
					}
					if (foodLastTurn > 0)
					{
						foodLastTurn--;
						uiInstance.UpdateHexAni(1002, foodLastTurn);
						return;
					}
				}
			}
			else if (num > 0 && foodBonusProbability > 0 && UnityEngine.Random.Range(1, 101) <= foodBonusProbability)
			{
				num += foodBonusNum;
				uiInstance.UpdateHexAni(1003, foodBonusNum);
			}
		}
		source[(int)type] += num;
		AfterChangeSource(type, num);
	}

	private void BeforeChangeSource(SourceType type, int num)
	{
	}

	private void AfterChangeSource(SourceType type, int num)
	{
		switch (type)
		{
		case SourceType.FOOD:
			if (source[(int)type] <= 0)
			{
				GameOver(isWin: false);
			}
			break;
		case SourceType.POP:
			RefreshSkillStage();
			break;
		case SourceType.TECH:
			while (source[2] >= nextLevelTech)
			{
				source[2] -= nextLevelTech;
				curTechState++;
				UpdateFactorPool(curTechState);
				uiInstance.UpdateUpGradeUI(curTechState);
				nextLevelTech = CivilizationCfg.GetNeedTechCost(curTechState);
			}
			break;
		}
		uiInstance.UpdateSourceText();
	}

	public bool IsLastState()
	{
		return curTechState >= CivilizationCfg.techCost.Count;
	}

	public void UpdateFactorPool(int level)
	{
		while (haveAddLevel < level)
		{
			haveAddLevel++;
			factorPool.AddRange(CivilizationCfg.techCost.Find((TechLevel t) => t.level == level).techList);
		}
	}

	public void ShowBossTips()
	{
		bossTips.SetActive(value: true);
		SetCanDrag(canDrag: false);
		FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			SetCanDrag(canDrag: true);
			bossTips.SetActive(value: false);
		}, 1f, 1);
	}

	public int[] GetCanChooseFactor(int curTechState)
	{
		int[] array = factorPool.ToArray();
		List<int> list = new List<int>();
		for (int i = 0; i < array.Length; i++)
		{
			if (CivilizationCfg.IsTechShow(curTechState, array[i]))
			{
				list.Add(array[i]);
			}
		}
		if (list.Count > 3)
		{
			return list.GetRange(0, 3).ToArray();
		}
		return list.ToArray();
	}

	public void OnChooseTech(int id)
	{
		factorPool.Remove(id);
	}

	public void SetCanDrag(bool canDrag)
	{
		this.canDrag = canDrag;
	}

	public void GameOver(bool isWin, bool isCancel = false)
	{
		int second = GetSecond();
		exchangeData.SetFinalData(isWin, isCancel, curAge, turn, second - seconds, blockCells, source, wideLimit, hightLimit, skillUseDic, skillUnlockList);
		LuaHelper.CallFunction("CivilizationGameToLuaBridge.GameOver", isWin, exchangeData);
	}

	private int GetSecond()
	{
		return (int)(double)LuaHelper.CallFunction("GetServerTime")[0];
	}

	public CivilizationMain()
	{
		//IL_00ca: Field data (rva=0x518) could not be found in any section!
		//IL_00ca: Field data (rva=0x518) could not be found in any section!
		freeBlocks = new List<CivilizationGameBlock>();
		blockCells = new CivilizationGameBlock[10, 5];
		appearBlocks = new List<WaitingBlock>();
		movingBlocks = new List<CivilizationGameBlock>();
		combiningBlocks = new List<CivilizationGameBlock>();
		wars = new List<CivilizationGameBlock>();
		beasts = new List<CivilizationGameBlock>();
		boms = new List<CivilizationGameBlock>();
		buildings = new List<CivilizationGameBlock>();
		skillBlocks = new List<CivilizationGameSkillBlock>();
		skillUseCount = new Dictionary<int, int>();
		spriteList = new List<Sprite>(7);
		probability = new List<int>(7);
		pool = new List<int>();
		canDrag = true;
		unlockTech = new List<int>();
		factorPool = new List<int>();
		int[,] array = new int[4, 2];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		teachEndPositonArray = array;
		teachStartPositonArray = new int[4, 2]
		{
			{ 1633115237, 1349674356 },
			{ 1197830249, 1550151009 },
			{ 1769104211, 1297904752 },
			{ 1734438497, 1465676389 }
		};
		base._002Ector();
	}
}

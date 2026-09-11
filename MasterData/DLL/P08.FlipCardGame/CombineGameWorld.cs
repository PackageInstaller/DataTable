using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.EventSystems;

public class CombineGameWorld : MonoBehaviour
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

	[Serializable]
	private enum SkillID
	{
		Skill_1 = 1001,
		Skill_2,
		Skill_3,
		Skill_4,
		Skill_5,
		Skill_6,
		Skill_7,
		Skill_8,
		Skill_9
	}

	[Serializable]
	public enum BlockType
	{
		NONE,
		FOOD,
		ROCK,
		TECH,
		BEAST,
		WAR,
		BUILD
	}

	[SerializeField]
	public int speed;

	[SerializeField]
	public List<CombineGameBlock> freeBlocks;

	[SerializeField]
	public CombineGameBlock[,] blockCells;

	[SerializeField]
	public int hightLimit;

	[SerializeField]
	public int wideLimit;

	[SerializeField]
	public int rock;

	[SerializeField]
	public List<WaitingBlock> appearBlocks;

	[SerializeField]
	public List<CombineGameBlock> movingBlocks;

	[SerializeField]
	public List<CombineGameBlock> combiningBlocks;

	[SerializeField]
	public List<CombineGameBlock> wars;

	[SerializeField]
	public List<CombineGameBlock> buildings;

	[SerializeField]
	public List<CombineGameBlock> skillBlocks;

	[SerializeField]
	public CombineGameBlock showingBlock;

	[SerializeField]
	public CombineGameBlock movingBlock;

	[SerializeField]
	public CombineGameMouse mouse;

	[SerializeField]
	private CombineGameBlock mouseOnBlock;

	[SerializeField]
	private int appearCount;

	[SerializeField]
	public Action nextYearAction;

	[SerializeField]
	public Action mapExtensionAction;

	[SerializeField]
	public Action startGameAction;

	[SerializeField]
	public Action newTechAction;

	[SerializeField]
	public Action<int, int> newResourceAction;

	[SerializeField]
	public Action<int, int> buildResourceAction;

	[SerializeField]
	public Action<int, int, Transform> informationAction;

	[SerializeField]
	public int maxLevel;

	[SerializeField]
	public int minLevel;

	[SerializeField]
	public bool mapExtension;

	[SerializeField]
	public Dictionary<int, int> skillUseCount;

	[SerializeField]
	public List<Sprite> spriteList;

	[SerializeField]
	public Dictionary<int, Sprite> skillSprites;

	[SerializeField]
	public List<int> gailv;

	[SerializeField]
	private int poolNumber;

	[SerializeField]
	private List<int> pool;

	[SerializeField]
	private bool specialMask;

	[SerializeField]
	public bool isTeach;

	[SerializeField]
	public int beastDestoryCount;

	[SerializeField]
	public bool canDrag;

	[SerializeField]
	public List<List<int>> initPoolList;

	[SerializeField]
	private int[,] teachEndPositonArray;

	[SerializeField]
	private int[,] teachStartPositonArray;

	[SerializeField]
	private int techStep;

	[SerializeField]
	public static CombineGameWorld Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
	}

	public void SetNextAction(Action action)
	{
		nextYearAction = action;
	}

	public void StartGame()
	{
		mouse = base.transform.Find("panel/mouse").GetComponent<CombineGameMouse>();
		wideLimit = 5;
		hightLimit = 5;
		ResetGame();
		startGameAction();
	}

	public void ResetGame()
	{
		CombineGameBlock[] componentsInChildren = base.transform.Find("panel/right/box/box1").gameObject.GetComponentsInChildren<CombineGameBlock>();
		int num = 0;
		int num2 = 4;
		freeBlocks.Clear();
		appearBlocks.Clear();
		movingBlocks.Clear();
		combiningBlocks.Clear();
		buildings.Clear();
		wars.Clear();
		NewPoor();
		skillUseCount.Clear();
		beastDestoryCount = 0;
		techStep = 0;
		CombineGameBlock[] array = componentsInChildren;
		foreach (CombineGameBlock combineGameBlock in array)
		{
			blockCells[num, num2] = combineGameBlock;
			freeBlocks.Add(combineGameBlock);
			combineGameBlock.ResetBlock();
			combineGameBlock.x = num;
			combineGameBlock.y = num2;
			combineGameBlock.world = this;
			combineGameBlock.blockGo.SetActive(value: false);
			num++;
			if (num > 4)
			{
				num2--;
				num -= 5;
			}
		}
		base.transform.Find("panel/right/box/box2").gameObject.SetActive(value: false);
		foreach (CombineGameBlock skillBlock in skillBlocks)
		{
			skillBlock.gameObject.SetActive(value: true);
		}
		skillBlocks.Clear();
		array = base.transform.Find("panel/right/skill").gameObject.GetComponentsInChildren<CombineGameBlock>();
		foreach (CombineGameBlock combineGameBlock2 in array)
		{
			skillBlocks.Add(combineGameBlock2);
			combineGameBlock2.skill = true;
			combineGameBlock2.gameObject.SetActive(value: false);
		}
	}

	private void MapExtension()
	{
		int num = 5;
		int num2 = 4;
		wideLimit = 10;
		hightLimit = 5;
		GameObject obj = base.transform.Find("panel/right/box/box2").gameObject;
		obj.SetActive(value: true);
		CombineGameBlock[] componentsInChildren = obj.GetComponentsInChildren<CombineGameBlock>();
		foreach (CombineGameBlock combineGameBlock in componentsInChildren)
		{
			blockCells[num, num2] = combineGameBlock;
			freeBlocks.Add(combineGameBlock);
			combineGameBlock.ResetBlock();
			combineGameBlock.x = num;
			combineGameBlock.y = num2;
			combineGameBlock.world = this;
			combineGameBlock.blockGo.SetActive(value: false);
			num++;
			if (num > 9)
			{
				num2--;
				num -= 5;
			}
		}
	}

	public void UpdateSkill(int index, int type, int cost, int cd)
	{
		CombineGameBlock block = skillBlocks[index];
		block.skillID = type;
		block.cost = cost;
		block.cd = cd;
		block.remainCd = 0;
		block.kind = 999;
		block.world = this;
		block.gameObject.SetActive(value: true);
		block.FreshBlock(newBlock: true);
		block.button.onClick.RemoveAllListeners();
		block.button.onClick.AddListener(delegate
		{
			informationAction(block.skillID, block.kind, block.tipsGo.transform);
		});
		RefreshSkillStage();
	}

	public void NewBlock(int x, int y, int kind, int level)
	{
		WaitingBlock waitingBlock = new WaitingBlock();
		waitingBlock.kind = kind;
		waitingBlock.level = level;
		waitingBlock.x = x;
		waitingBlock.y = y;
		appearBlocks.Add(waitingBlock);
	}

	private void UpdateSpecialSkillMask()
	{
		if (!specialMask)
		{
			return;
		}
		if (mouseOnBlock == null || mouseOnBlock.skill)
		{
			CombineGameBlock[,] array = blockCells;
			foreach (CombineGameBlock combineGameBlock in array)
			{
				if (combineGameBlock != null)
				{
					combineGameBlock.maskGo.SetActive(value: true);
				}
			}
		}
		else if (showingBlock.skillID == 1006)
		{
			CombineGameBlock[,] array = blockCells;
			foreach (CombineGameBlock combineGameBlock2 in array)
			{
				if (combineGameBlock2 != null)
				{
					combineGameBlock2.maskGo.SetActive(combineGameBlock2.x != mouseOnBlock.x);
				}
			}
		}
		else
		{
			if (showingBlock.skillID != 1007)
			{
				return;
			}
			CombineGameBlock[,] array = blockCells;
			foreach (CombineGameBlock combineGameBlock3 in array)
			{
				if (combineGameBlock3 != null)
				{
					combineGameBlock3.maskGo.SetActive(Math.Abs(combineGameBlock3.x - mouseOnBlock.x) > 1 || Math.Abs(combineGameBlock3.y - mouseOnBlock.y) > 1);
				}
			}
		}
	}

	private void Update()
	{
		if (appearBlocks.Count <= 0 && movingBlocks.Count <= 0 && combiningBlocks.Count <= 0 && mapExtension)
		{
			mapExtension = false;
			MapExtension();
			mapExtensionAction();
		}
		if (IsOnUI() && Input.GetMouseButtonDown(0) && CanUseSkill() && mouseOnBlock.kind != 0 && !mouseOnBlock.moving && mouseOnBlock.canMove && appearBlocks.Count <= 0 && movingBlocks.Count <= 0 && combiningBlocks.Count <= 0)
		{
			if (isTeach && (techStep >= teachStartPositonArray.Length / 2 || mouseOnBlock.x != teachStartPositonArray[techStep, 0] || mouseOnBlock.y != teachStartPositonArray[techStep, 1]) && (!mouseOnBlock.skill || techStep != 3 || mouseOnBlock.skillID != 1001) && (techStep != 4 || mouseOnBlock.skillID != 1002))
			{
				mouseOnBlock = null;
				return;
			}
			mouseOnBlock.StartDrag();
			showingBlock = mouseOnBlock;
			if (showingBlock.skill && (showingBlock.skillID == 1006 || showingBlock.skillID == 1007))
			{
				specialMask = true;
			}
		}
		UpdateSpecialSkillMask();
		if (Input.GetMouseButtonUp(0) && showingBlock != null)
		{
			if (IsOnUI() && CheckSpeed(showingBlock, mouseOnBlock.x, mouseOnBlock.y))
			{
				showingBlock.EndDrag(mouseOnBlock.x, mouseOnBlock.y);
			}
			else if (CheckSkill(showingBlock, mouseOnBlock))
			{
				showingBlock.FreshBlock(newBlock: false);
			}
			else
			{
				showingBlock.FreshBlock(newBlock: false);
			}
			EndDrag();
			specialMask = false;
			mouse.block.blockGo.SetActive(value: false);
			showingBlock = null;
		}
	}

	public void RefreshAllBlock()
	{
		CombineGameBlock[,] array = blockCells;
		foreach (CombineGameBlock combineGameBlock in array)
		{
			if (combineGameBlock != null && (combineGameBlock.kind == 1 || combineGameBlock.kind == 2 || combineGameBlock.kind == 3))
			{
				int val = combineGameBlock.speed;
				combineGameBlock.level = Math.Max(combineGameBlock.level, minLevel);
				combineGameBlock.number = combineGameBlock.level;
				combineGameBlock.FreshBlock(newBlock: true);
				combineGameBlock.speed = Math.Max(val, speed);
				combineGameBlock.BigCheckSame();
			}
		}
	}

	public List<int> DetailBuryPointNeedData()
	{
		List<int> list = new List<int>();
		CombineGameBlock[,] array = blockCells;
		foreach (CombineGameBlock combineGameBlock in array)
		{
			if (combineGameBlock != null && combineGameBlock.kind != 0)
			{
				int item = combineGameBlock.kind * 10 + combineGameBlock.level;
				list.Add(item);
			}
		}
		return list;
	}

	private bool CheckSkill(CombineGameBlock block, CombineGameBlock mouseOnBlock)
	{
		if (!block.skill || mouseOnBlock == null || rock < block.cost || mouseOnBlock.skill)
		{
			return false;
		}
		bool flag = false;
		switch (block.skillID)
		{
		case 1001:
			if (mouseOnBlock.kind == 4)
			{
				if (isTeach)
				{
					techStep++;
				}
				object[] array2 = LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 2017);
				int num = 3;
				if ((bool)array2[0])
				{
					object[] array3 = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 2017);
					newResourceAction(1, int.Parse(array3[0].ToString()));
				}
				if ((bool)LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 3011)[0])
				{
					object[] array4 = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 3011);
					num += int.Parse(array4[0].ToString());
				}
				newResourceAction(1, num);
				mouseOnBlock.PlayAddAni(num, 1);
				freeBlocks.Add(mouseOnBlock);
				mouseOnBlock.animator.Play("monster", -1, 0f);
				mouseOnBlock.BeDestroy();
				LuaHelper.CallFunction("CombineGameFactory.PlayEffect", 5);
				beastDestoryCount++;
				flag = true;
			}
			break;
		case 1002:
			if (mouseOnBlock.kind == 5)
			{
				if (isTeach)
				{
					techStep++;
				}
				mouseOnBlock.number -= 6;
				mouseOnBlock.numberText.text = mouseOnBlock.number.ToString();
				if (mouseOnBlock.number <= 0)
				{
					mouseOnBlock.number = 0;
					mouseOnBlock.numberText.text = showingBlock.number.ToString();
					mouseOnBlock.BeDestroy();
					wars.Remove(mouseOnBlock);
					freeBlocks.Add(mouseOnBlock);
				}
				mouseOnBlock.PlayAddAni(2, 3);
				newResourceAction(3, 2);
				flag = true;
			}
			break;
		case 1003:
			if (mouseOnBlock.kind == 0)
			{
				NewBlock(mouseOnBlock.x, mouseOnBlock.y, 6, 1);
				buildings.Add(mouseOnBlock);
				flag = true;
			}
			break;
		case 1004:
			if (mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3)
			{
				newResourceAction(mouseOnBlock.kind, mouseOnBlock.level);
				mouseOnBlock.PlayAddAni(mouseOnBlock.level);
				flag = true;
			}
			break;
		case 1005:
			if ((mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3) && mouseOnBlock.level < maxLevel)
			{
				mouseOnBlock.level = Math.Min(++mouseOnBlock.level, maxLevel);
				int val = mouseOnBlock.speed;
				mouseOnBlock.FreshBlock(newBlock: true);
				mouseOnBlock.speed = Math.Max(val, mouseOnBlock.speed);
				flag = true;
			}
			break;
		case 1006:
		{
			if (mouseOnBlock.x < 0 || mouseOnBlock.x > wideLimit || mouseOnBlock.y < 0 || mouseOnBlock.y > hightLimit)
			{
				break;
			}
			for (int i = 0; i < hightLimit; i++)
			{
				CombineGameBlock combineGameBlock = blockCells[mouseOnBlock.x, i];
				if (combineGameBlock.kind == 1 || combineGameBlock.kind == 2 || combineGameBlock.kind == 3)
				{
					newResourceAction(combineGameBlock.kind, combineGameBlock.level);
					combineGameBlock.PlayAddAni(combineGameBlock.level);
					freeBlocks.Add(combineGameBlock);
					combineGameBlock.BeDestroy();
				}
			}
			flag = true;
			break;
		}
		case 1007:
		{
			CombineGameBlock[,] array5 = blockCells;
			foreach (CombineGameBlock combineGameBlock2 in array5)
			{
				if (combineGameBlock2 != null && Math.Abs(combineGameBlock2.x - mouseOnBlock.x) <= 1 && Math.Abs(combineGameBlock2.y - mouseOnBlock.y) <= 1 && (combineGameBlock2.kind == 1 || combineGameBlock2.kind == 2 || combineGameBlock2.kind == 3))
				{
					newResourceAction(combineGameBlock2.kind, combineGameBlock2.level);
					combineGameBlock2.PlayAddAni(combineGameBlock2.level);
					freeBlocks.Add(combineGameBlock2);
					combineGameBlock2.BeDestroy();
				}
			}
			flag = true;
			break;
		}
		case 1008:
			if (mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3)
			{
				mouseOnBlock.speed += 3;
				if ((bool)LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 2018)[0])
				{
					object[] array = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 2018);
					mouseOnBlock.speed += int.Parse(array[0].ToString());
				}
				flag = true;
			}
			break;
		case 1009:
			if (mouseOnBlock.kind == 0)
			{
				NewBlock(mouseOnBlock.x, mouseOnBlock.y, 1, minLevel);
				flag = true;
			}
			break;
		}
		if (flag)
		{
			newResourceAction(2, -block.cost);
			if (skillUseCount.ContainsKey(block.skillID))
			{
				skillUseCount[block.skillID]++;
			}
			else
			{
				skillUseCount[block.skillID] = 1;
			}
			block.remainCd = block.cd;
			block.FreshBlock(newBlock: false);
			LuaHelper.CallFunction("CombineGameFactory.PlayEffect", 4);
		}
		return flag;
	}

	private bool CanUseSkill()
	{
		if (!mouseOnBlock.skill)
		{
			return true;
		}
		if (mouseOnBlock.remainCd == 0 && rock >= mouseOnBlock.cost)
		{
			return true;
		}
		if (mouseOnBlock.remainCd > 0)
		{
			LuaHelper.CallFunction("ShowTips", "ACTIVITY_COMBINE_GAME_SKILL_COOLING_DOWN");
			return false;
		}
		if (rock < mouseOnBlock.cost)
		{
			LuaHelper.CallFunction("ShowTips", "ACTIVITY_COMBINE_GAME_SKILL_COST_NOT_ENOUGH");
			return false;
		}
		return false;
	}

	private bool IsOnUI()
	{
		if (!canDrag)
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
				if (list[i].gameObject.name == "mask")
				{
					mouseOnBlock = null;
					return false;
				}
				if (list[i].gameObject.name == "empty")
				{
					mouseOnBlock = list[i].gameObject.transform.GetComponent<CombineGameBlock>();
					return true;
				}
			}
		}
		mouseOnBlock = null;
		return false;
	}

	private void FixedUpdate()
	{
		if (appearBlocks.Count <= 0 || movingBlocks.Count != 0 || combiningBlocks.Count != 0)
		{
			return;
		}
		appearCount++;
		if (appearCount < 5)
		{
			return;
		}
		if (freeBlocks.Count > 0)
		{
			LuaHelper.CallFunction("CombineGameFactory.PlayEffect", 3);
			WaitingBlock waitingBlock = appearBlocks[0];
			bool flag = false;
			if (waitingBlock.x < 99 && freeBlocks.Contains(blockCells[waitingBlock.x, waitingBlock.y]))
			{
				flag = true;
				CombineGameBlock combineGameBlock = blockCells[waitingBlock.x, waitingBlock.y];
				freeBlocks.Remove(combineGameBlock);
				combineGameBlock.kind = waitingBlock.kind;
				combineGameBlock.level = Math.Max(waitingBlock.level, minLevel);
				appearBlocks.RemoveAt(0);
				combineGameBlock.FreshBlock(newBlock: true);
				combineGameBlock.animator.Play("GameUI_enter", -1, 0f);
			}
			if (!flag && freeBlocks.Count > 0)
			{
				CombineGameBlock combineGameBlock2 = freeBlocks[UnityEngine.Random.Range(0, freeBlocks.Count)];
				freeBlocks.Remove(combineGameBlock2);
				combineGameBlock2.kind = waitingBlock.kind;
				combineGameBlock2.level = Math.Max(waitingBlock.level, minLevel);
				waitingBlock.x = combineGameBlock2.x;
				waitingBlock.y = combineGameBlock2.y;
				appearBlocks.RemoveAt(0);
				combineGameBlock2.FreshBlock(newBlock: true);
				combineGameBlock2.animator.Play("GameUI_enter", -1, 0f);
			}
		}
		else
		{
			appearBlocks.Clear();
		}
		appearCount = 0;
	}

	private bool CheckSpeed(CombineGameBlock block, int x, int y)
	{
		if (block.skill)
		{
			return false;
		}
		if (isTeach)
		{
			bool result = false;
			if (techStep >= teachEndPositonArray.Length / 2)
			{
				return true;
			}
			if (x == teachEndPositonArray[techStep, 0] && y == teachEndPositonArray[techStep, 1])
			{
				techStep++;
				result = true;
			}
			return result;
		}
		int num = Math.Max(speed, block.speed);
		return 0 + Math.Abs(block.x - x) + Math.Abs(block.y - y) <= num;
	}

	public void NextYear()
	{
		NewBlock();
		for (int i = 0; i < wars.Count; i++)
		{
			wars[i].number--;
			wars[i].numberText.text = wars[i].number.ToString();
			if (wars[i].number <= 0)
			{
				freeBlocks.Add(wars[i]);
				wars[i].BeDestroy();
				wars.RemoveAt(i);
				i--;
			}
		}
		for (int j = 0; j < skillBlocks.Count; j++)
		{
			skillBlocks[j].remainCd = Math.Max(skillBlocks[j].remainCd - 1, 0);
			skillBlocks[j].cdMaskGo.SetActive(skillBlocks[j].remainCd != 0);
			skillBlocks[j].cdText.text = skillBlocks[j].remainCd.ToString();
		}
		int num = 0;
		object[] array = LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 3010);
		for (int k = 0; k < buildings.Count; k++)
		{
			buildings[k].PlayAddAni(1);
		}
		if ((bool)array[0])
		{
			object[] array2 = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 3010);
			num += int.Parse(array2[0].ToString());
		}
		buildResourceAction(1 + num, buildings.Count);
		nextYearAction();
	}

	public void StartDrag(CombineGameBlock b)
	{
		movingBlock = b;
		mouse.block.kind = b.kind;
		mouse.block.number = b.number;
		mouse.block.level = b.level;
		mouse.block.skill = b.skill;
		mouse.block.skillID = b.skillID;
		mouse.block.world = this;
		mouse.block.FreshBlock(newBlock: false, isMouse: true);
		mouse.block.transform.parent.gameObject.SetActive(value: true);
		ShowMask(b);
	}

	private void ShowMask(CombineGameBlock b)
	{
		CombineGameBlock[,] array;
		if (b.skill)
		{
			int num = 0;
			array = blockCells;
			foreach (CombineGameBlock combineGameBlock in array)
			{
				if (!(combineGameBlock != null))
				{
					continue;
				}
				switch (b.skillID)
				{
				case 1001:
					combineGameBlock.maskGo.SetActive(combineGameBlock.kind != 4);
					if (combineGameBlock.kind == 4)
					{
						num++;
					}
					break;
				case 1002:
					combineGameBlock.maskGo.SetActive(combineGameBlock.kind != 5);
					if (combineGameBlock.kind == 5)
					{
						num++;
					}
					break;
				case 1003:
					combineGameBlock.maskGo.SetActive(combineGameBlock.kind != 0);
					if (combineGameBlock.kind == 0)
					{
						num++;
					}
					break;
				case 1004:
					combineGameBlock.maskGo.SetActive(combineGameBlock.kind != 1 && combineGameBlock.kind != 3 && combineGameBlock.kind != 2);
					if (combineGameBlock.kind == 1 || combineGameBlock.kind == 3 || combineGameBlock.kind == 2)
					{
						num++;
					}
					break;
				case 1005:
					combineGameBlock.maskGo.SetActive((combineGameBlock.kind != 1 && combineGameBlock.kind != 3 && combineGameBlock.kind != 2) || combineGameBlock.level >= maxLevel);
					if ((combineGameBlock.kind == 1 || combineGameBlock.kind == 3 || combineGameBlock.kind == 2) && combineGameBlock.level < maxLevel)
					{
						num++;
					}
					break;
				case 1006:
					combineGameBlock.maskGo.SetActive(combineGameBlock.x < 0 || combineGameBlock.x >= wideLimit || combineGameBlock.y < 0 || combineGameBlock.y >= hightLimit);
					break;
				case 1007:
					combineGameBlock.maskGo.SetActive(combineGameBlock.x <= 0 || combineGameBlock.x >= wideLimit - 1 || combineGameBlock.y <= 0 || combineGameBlock.y >= hightLimit - 1);
					break;
				case 1008:
					combineGameBlock.maskGo.SetActive(combineGameBlock.kind != 1 && combineGameBlock.kind != 3 && combineGameBlock.kind != 2);
					if (combineGameBlock.kind == 1 || combineGameBlock.kind == 3 || combineGameBlock.kind == 2)
					{
						num++;
					}
					break;
				case 1009:
					combineGameBlock.maskGo.SetActive(combineGameBlock.kind != 0);
					if (combineGameBlock.kind == 0)
					{
						num++;
					}
					break;
				}
			}
			if (num == 0 && b.skillID != 1006 && b.skillID != 1007)
			{
				LuaHelper.CallFunction("ShowTips", "ACTIVITY_COMBINE_GAME_SKILL_NO_USE_RANGE");
			}
			return;
		}
		array = blockCells;
		foreach (CombineGameBlock combineGameBlock2 in array)
		{
			if (combineGameBlock2 != null)
			{
				int num2 = 0;
				int num3 = Math.Max(speed, b.speed);
				num2 += Math.Abs(combineGameBlock2.x - b.x);
				num2 += Math.Abs(combineGameBlock2.y - b.y);
				combineGameBlock2.maskGo.SetActive(num2 > num3 || !combineGameBlock2.canMove);
			}
		}
	}

	private void HideMask()
	{
		CombineGameBlock[,] array = blockCells;
		foreach (CombineGameBlock combineGameBlock in array)
		{
			if (combineGameBlock != null)
			{
				combineGameBlock.maskGo.SetActive(value: false);
			}
		}
	}

	public bool CheckBlock(int x, int y, int kind)
	{
		return blockCells[x, y].kind == kind;
	}

	public void AddInitList(int x, int y, int kind)
	{
		List<int> list = new List<int>(3);
		list.Add(x);
		list.Add(y);
		list.Add(kind);
		initPoolList.Add(list);
	}

	public void RefreshSkillStage()
	{
		foreach (CombineGameBlock skillBlock in skillBlocks)
		{
			if (rock >= skillBlock.cost)
			{
				skillBlock.skillCost.color = new Color(1f, 1f, 1f);
			}
			else
			{
				skillBlock.skillCost.color = new Color(0.66f, 0.27f, 0.22f);
			}
		}
	}

	public void EndDrag()
	{
		LuaHelper.CallFunction("CombineGameFactory.PlayEffect", 2);
		mouse.block.transform.parent.gameObject.SetActive(value: false);
		HideMask();
	}

	public void NewBlock()
	{
		if (initPoolList.Count > 0 && isTeach)
		{
			List<int> list = initPoolList[0];
			NewBlock(list[0], list[1], list[2], minLevel);
			initPoolList.RemoveAt(0);
			return;
		}
		if (poolNumber >= pool.Count)
		{
			NewPoor();
		}
		int kind = pool[poolNumber];
		poolNumber++;
		NewBlock(999, 999, kind, minLevel);
	}

	public void NewPoor()
	{
		pool.Clear();
		List<int> list = new List<int>();
		for (int i = 0; i < gailv.Count; i++)
		{
			for (int j = 0; j < gailv[i]; j++)
			{
				list.Add(i);
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

	public CombineGameWorld()
	{
		//IL_00b4: Field data (rva=0x4f0) could not be found in any section!
		//IL_00b4: Field data (rva=0x4f0) could not be found in any section!
		freeBlocks = new List<CombineGameBlock>();
		blockCells = new CombineGameBlock[10, 5];
		appearBlocks = new List<WaitingBlock>();
		movingBlocks = new List<CombineGameBlock>();
		combiningBlocks = new List<CombineGameBlock>();
		wars = new List<CombineGameBlock>();
		buildings = new List<CombineGameBlock>();
		skillBlocks = new List<CombineGameBlock>();
		skillUseCount = new Dictionary<int, int>();
		spriteList = new List<Sprite>(7);
		skillSprites = new Dictionary<int, Sprite>();
		gailv = new List<int>(6);
		pool = new List<int>();
		canDrag = true;
		initPoolList = new List<List<int>>();
		int[,] array = new int[3, 2];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		teachEndPositonArray = array;
		teachStartPositonArray = new int[3, 2]
		{
			{ 1551066471, 778923875 },
			{ 1714713465, 1882091125 },
			{ 1714305072, 1601203305 }
		};
		base._002Ector();
	}
}

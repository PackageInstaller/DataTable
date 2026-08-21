using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CombineGameBlock : MonoBehaviour
{
	public CombineGameWorld world;

	public int kind;

	public int level;

	public int number;

	public int speed;

	public Vector3 aimPosition;

	public int x;

	public int y;

	public bool canMove;

	public bool moving;

	public bool combining;

	public bool skill;

	public float moveTime;

	public int skillID;

	public int cost;

	public int cd;

	public int remainCd;

	public List<CombineGameBlock> sameBlock = new List<CombineGameBlock>();

	public GameObject blockGo;

	public Image image;

	public GameObject skillGo;

	public Text skillCost;

	public GameObject cdMaskGo;

	public Text cdText;

	public Text numberText;

	public Button button;

	public GameObject maskGo;

	public GameObject tipsGo;

	public Animator animator;

	public Text aniText;

	private void Awake()
	{
	}

	public void StartMove(float time)
	{
		moving = true;
		moveTime = time;
		if (!world.movingBlocks.Contains(this))
		{
			world.movingBlocks.Add(this);
		}
	}

	private void FixedUpdate()
	{
		if (moving)
		{
			LTDescr lTDescr = LeanTween.move(base.transform.gameObject, aimPosition, moveTime);
			moving = false;
			LuaHelper.CallFunction("CombineGameFactory.PlayEffect", 1);
			lTDescr.setOnComplete((Action)delegate
			{
				RectTransform component = base.transform.GetComponent<RectTransform>();
				component.offsetMax = new Vector2(0f, 0f);
				component.offsetMin = new Vector2(0f, 0f);
				world.movingBlocks.Remove(this);
				if (moveTime > 0.4f)
				{
					base.transform.GetComponent<RectTransform>().anchoredPosition = new Vector2(0f, 0f);
					CheckNull();
				}
				else
				{
					BigCheckSame();
				}
			});
		}
		if (combining && world.movingBlocks.Count == 0)
		{
			combining = false;
			Combine();
		}
	}

	private void Combine()
	{
		if (level < world.maxLevel)
		{
			level++;
		}
		world.NewBlock();
		object[] array = LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 2008);
		int num = number;
		if ((bool)array[0])
		{
			object[] array2 = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 2008);
			num += int.Parse(array2[0].ToString());
		}
		world.newResourceAction(kind, num);
		FreshBlock(newBlock: true);
	}

	public void ResetBlock()
	{
		kind = 0;
		level = 0;
		number = 0;
		speed = 0;
		x = 0;
		y = 0;
		canMove = false;
		moving = false;
		combining = false;
		skill = false;
		moveTime = 0f;
		FreshBlock(newBlock: false);
	}

	public void FreshBlock(bool newBlock, bool isMouse = false)
	{
		blockGo.SetActive(value: true);
		canMove = true;
		skillGo.SetActive(skill);
		numberText.transform.parent.gameObject.SetActive(value: true);
		blockGo.transform.localPosition = new Vector3(0f, 0f, 0f);
		if (skill)
		{
			cdMaskGo.SetActive(remainCd != 0);
			cdText.text = remainCd.ToString();
			skillCost.text = cost.ToString();
			numberText.transform.parent.gameObject.SetActive(value: false);
			image.sprite = world.skillSprites[skillID];
			return;
		}
		if (newBlock)
		{
			speed = world.speed;
			if (kind != 0)
			{
				number = level;
			}
		}
		if (kind != 0)
		{
			image.sprite = world.spriteList[kind];
		}
		if (kind == 5)
		{
			level = 1;
			number = level + UnityEngine.Random.Range(6, 12);
			if (world.isTeach)
			{
				number = 6;
			}
			if (!world.wars.Contains(this))
			{
				world.wars.Add(this);
			}
			canMove = false;
		}
		if (kind == 4)
		{
			canMove = false;
			numberText.transform.parent.gameObject.SetActive(value: false);
		}
		else
		{
			numberText.text = number.ToString();
		}
		if (kind == 6)
		{
			numberText.transform.parent.gameObject.SetActive(value: false);
		}
		if (newBlock)
		{
			BigCheckSame();
		}
	}

	public void EndAnimator()
	{
	}

	public void EndWar()
	{
		if (kind == 5 || kind == 0)
		{
			blockGo.SetActive(value: false);
		}
		animator.Play("GameUI_enter", -1, 0f);
	}

	public void StartDrag()
	{
		blockGo.SetActive(value: false);
		world.StartDrag(this);
	}

	public void EndDrag(int x, int y)
	{
		world.showingBlock = world.blockCells[x, y];
		world.EndDrag();
		if (world.movingBlock == null)
		{
			return;
		}
		if (world.showingBlock == null || world.showingBlock == this || !world.showingBlock.canMove || world.showingBlock.x >= world.wideLimit || world.showingBlock.y >= world.hightLimit)
		{
			blockGo.SetActive(value: true);
		}
		else
		{
			CombineGameBlock showingBlock = world.showingBlock;
			List<int> list = new List<int>();
			list.Add(showingBlock.kind);
			list.Add(showingBlock.number);
			list.Add(showingBlock.level);
			showingBlock.kind = kind;
			showingBlock.number = number;
			showingBlock.level = level;
			showingBlock.speed = world.speed;
			kind = list[0];
			number = list[1];
			level = list[2];
			showingBlock.transform.SetAsLastSibling();
			showingBlock.speed = world.speed;
			speed = world.speed;
			showingBlock.CheckNull();
			CheckNull();
			showingBlock.BigCheckSame();
			if (kind != 0)
			{
				aimPosition = base.transform.position;
				base.transform.position = showingBlock.transform.position;
				StartMove(0.3f);
			}
			if (world.buildings.Contains(this))
			{
				world.buildings.Remove(this);
			}
			if (world.buildings.Contains(showingBlock))
			{
				world.buildings.Remove(showingBlock);
			}
			if (kind == 6)
			{
				world.buildings.Add(this);
			}
			if (showingBlock.kind == 6)
			{
				world.buildings.Add(showingBlock);
			}
			world.NextYear();
		}
		world.movingBlock = null;
	}

	public void CheckNull()
	{
		if (kind == 0)
		{
			if (!world.freeBlocks.Contains(this))
			{
				world.freeBlocks.Add(this);
			}
			blockGo.SetActive(value: false);
			speed = world.speed;
		}
		else
		{
			if (world.freeBlocks.Contains(this))
			{
				world.freeBlocks.Remove(this);
			}
			number = level;
			FreshBlock(newBlock: false);
		}
	}

	public bool BigCheckSame()
	{
		if (kind == 0 || kind > 3)
		{
			return false;
		}
		sameBlock.Clear();
		sameBlock.Add(this);
		int num = 1;
		int num2 = 1;
		do
		{
			num2 = num;
			for (int i = 0; i < num2; i++)
			{
				MiddleCheckSame(sameBlock[i]);
			}
			num = sameBlock.Count;
		}
		while (num > num2);
		if (sameBlock.Count > 2)
		{
			StartCombine();
			return true;
		}
		return false;
	}

	private void MiddleCheckSame(CombineGameBlock b)
	{
		SmallCheckSame(b.x - 1, b.y);
		SmallCheckSame(b.x + 1, b.y);
		SmallCheckSame(b.x, b.y + 1);
		SmallCheckSame(b.x, b.y - 1);
	}

	private void SmallCheckSame(int xx, int yy)
	{
		if (xx >= 0 && yy >= 0 && xx < world.wideLimit && yy < world.hightLimit && !sameBlock.Contains(world.blockCells[xx, yy]) && (kind == 1 || kind == 2 || kind == 3) && world.blockCells[xx, yy].kind == kind && world.blockCells[xx, yy].level == level)
		{
			sameBlock.Add(world.blockCells[xx, yy]);
		}
	}

	public void StartCombine()
	{
		if (!world.combiningBlocks.Contains(this))
		{
			world.combiningBlocks.Add(this);
		}
		for (int i = 1; i < sameBlock.Count; i++)
		{
			sameBlock[i].kind = 0;
			sameBlock[i].sameBlock.Clear();
			sameBlock[i].aimPosition = base.transform.position;
			sameBlock[i].StartMove(0.45f);
			number += sameBlock[i].number;
		}
		object[] array = LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 2008);
		int num = number;
		if ((bool)array[0])
		{
			object[] array2 = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 2008);
			num += int.Parse(array2[0].ToString());
		}
		PlayAddAni(num);
		combining = true;
		base.transform.SetAsLastSibling();
		animator.StopPlayback();
		animator.Play("merge", -1, 0f);
		for (int j = 0; j < world.appearBlocks.Count; j++)
		{
			if (world.appearBlocks[j].x == x && world.appearBlocks[j].y == y)
			{
				world.appearBlocks.RemoveAt(j);
				break;
			}
		}
		world.combiningBlocks.Remove(this);
		BigCheckSame();
		if (kind != 0)
		{
			world.freeBlocks.Remove(this);
		}
	}

	public void PlayAddAni(int count, int targetKind = 99)
	{
		if (targetKind == 99)
		{
			targetKind = kind;
		}
		if (targetKind == 6 && (bool)LuaHelper.CallFunction("CombineGameFactory.CheckFactor", 3010)[0])
		{
			object[] array = LuaHelper.CallFunction("CombineGameFactory.GetFactorPara", 3010);
			count += int.Parse(array[0].ToString());
		}
		int num = ((targetKind == 6) ? 3 : targetKind);
		count = int.Parse(LuaHelper.CallFunction("CombineGameFactory.ChangeResource", num, count)[0].ToString());
		aniText.text = ((count >= 0) ? ("+" + count) : count.ToString());
		aniText.gameObject.SetActive(value: true);
		Animator component = aniText.transform.GetComponent<Animator>();
		LuaHelper.CallFunction("CombineGameFactory.PlayAni", component, "block_text", aniText.gameObject);
	}

	public void BeDestroy()
	{
		if (kind == 5)
		{
			animator.Play("battle", -1, 0f);
			LuaHelper.CallFunction("CombineGameFactory.PlayEffect", 6);
		}
		else
		{
			blockGo.SetActive(value: false);
		}
		kind = 0;
		canMove = true;
	}
}

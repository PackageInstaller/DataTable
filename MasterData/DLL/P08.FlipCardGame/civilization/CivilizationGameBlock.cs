using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace civilization;

public class CivilizationGameBlock : CivilizationGameBlockBase
{
	public int kind;

	public int level;

	public int number;

	public int speed;

	public Vector3 aimPosition;

	public bool canMove;

	public bool moving;

	public bool combining;

	public float moveTime;

	public List<CivilizationGameBlock> sameBlock = new List<CivilizationGameBlock>();

	public Button button;

	public GameObject maskGo;

	public GameObject maskEmptyGo;

	public Animator animator;

	public Animator textAnimator;

	[Header("资源格等级")]
	public GameObject numberGo;

	public Text numberText;

	[Header("敌对格剩余时间")]
	public GameObject timeGo;

	public Text timeText;

	[Header("飘字")]
	public Image aniIcon;

	public Text aniText;

	[Header("锚点封锁")]
	public GameObject skillGo;

	public GameObject normalGo;

	public GameObject lockIconGo;

	public GameObject buffIconGo;

	public override bool IsSkill => false;

	public void StartMove(float time)
	{
		moving = true;
		moveTime = time;
		if (!CivilizationMain.Instance.movingBlocks.Contains(this))
		{
			CivilizationMain.Instance.movingBlocks.Add(this);
		}
	}

	private void FixedUpdate()
	{
		if (moving)
		{
			LTDescr lTDescr = LeanTween.move(base.transform.gameObject, aimPosition, moveTime);
			moving = false;
			lTDescr.setOnComplete((Action)delegate
			{
				RectTransform component = base.transform.GetComponent<RectTransform>();
				component.offsetMax = new Vector2(0f, 0f);
				component.offsetMin = new Vector2(0f, 0f);
				CivilizationMain.Instance.movingBlocks.Remove(this);
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
		if (combining && CivilizationMain.Instance.movingBlocks.Count == 0)
		{
			combining = false;
			Combine();
		}
	}

	private void Combine()
	{
		if (level < CivilizationMain.Instance.limits[kind])
		{
			level++;
		}
		if (CivilizationMain.Instance.gameType == GameType.Normal)
		{
			CivilizationMain.Instance.NewBlock();
		}
		FreshBlock(newBlock: true);
	}

	public override void ResetBlock()
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
		moveTime = 0f;
		FreshBlock(newBlock: false);
	}

	public void SetBlockValue(int kind, int level)
	{
		this.kind = kind;
		this.level = level;
		FreshBlock(newBlock: true);
	}

	public override void FreshBlock(bool newBlock, bool isMouse = false)
	{
		blockGo.SetActive(value: true);
		canMove = true;
		blockGo.transform.localPosition = new Vector3(0f, 0f, 0f);
		if (newBlock)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_appear", useStream: false);
			speed = CivilizationMain.Instance.speed;
			if (kind != 0)
			{
				number = level;
			}
		}
		buffIconGo.SetActive((speed > CivilizationMain.Instance.speed) ? true : false);
		if (kind != 0)
		{
			image.sprite = CivilizationMain.Instance.spriteList[kind];
		}
		if (kind == 5)
		{
			numberGo.SetActive(value: false);
			timeGo.SetActive(value: true);
			if (!CivilizationMain.Instance.wars.Contains(this))
			{
				level = 1;
				number = level + UnityEngine.Random.Range(6, 12);
				CivilizationMain.Instance.wars.Add(this);
			}
			timeText.text = number.ToString();
			canMove = false;
		}
		if (kind == 4)
		{
			canMove = false;
			numberGo.SetActive(value: false);
			timeGo.SetActive(value: false);
			if (!CivilizationMain.Instance.beasts.Contains(this))
			{
				CivilizationMain.Instance.beasts.Add(this);
			}
		}
		if (kind == 6)
		{
			canMove = false;
			numberGo.SetActive(value: false);
			timeGo.SetActive(value: false);
			if (!CivilizationMain.Instance.boms.Contains(this))
			{
				CivilizationMain.Instance.boms.Add(this);
			}
		}
		if (kind == 7)
		{
			canMove = false;
			numberGo.SetActive(value: false);
			timeGo.SetActive(value: false);
			PlayAnimation("UI_boss_cx");
		}
		if (kind == 8)
		{
			numberGo.SetActive(value: false);
			timeGo.SetActive(value: false);
		}
		if (kind == 1 || kind == 3 || kind == 2)
		{
			numberGo.SetActive(value: true);
			timeGo.SetActive(value: false);
			numberText.text = level.ToString();
		}
		lockIconGo.SetActive(!canMove);
		if (newBlock)
		{
			BigCheckSame();
		}
	}

	public void SetBuff()
	{
		PlayAnimation("UI_buff");
		AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_buff01", useStream: false);
		buffIconGo.SetActive(value: true);
	}

	public void CheckMove(int x, int y)
	{
		CivilizationGameBlock civilizationGameBlock = CivilizationMain.Instance.blockCells[x, y];
		if (civilizationGameBlock == null || civilizationGameBlock == this || !civilizationGameBlock.canMove || civilizationGameBlock.x >= CivilizationMain.Instance.wideLimit || civilizationGameBlock.y >= CivilizationMain.Instance.hightLimit)
		{
			blockGo.SetActive(value: true);
			return;
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_down", useStream: false);
		List<int> list = new List<int> { civilizationGameBlock.kind, civilizationGameBlock.number, civilizationGameBlock.level };
		civilizationGameBlock.kind = kind;
		civilizationGameBlock.number = number;
		civilizationGameBlock.level = level;
		civilizationGameBlock.speed = CivilizationMain.Instance.speed;
		kind = list[0];
		number = list[1];
		level = list[2];
		civilizationGameBlock.speed = CivilizationMain.Instance.speed;
		speed = CivilizationMain.Instance.speed;
		civilizationGameBlock.CheckNull();
		CheckNull();
		civilizationGameBlock.BigCheckSame();
		if (kind != 0)
		{
			aimPosition = base.transform.position;
			base.transform.position = civilizationGameBlock.transform.position;
			StartMove(0.3f);
		}
		if (CivilizationMain.Instance.buildings.Contains(this))
		{
			CivilizationMain.Instance.buildings.Remove(this);
		}
		if (CivilizationMain.Instance.buildings.Contains(civilizationGameBlock))
		{
			CivilizationMain.Instance.buildings.Remove(civilizationGameBlock);
		}
		if (kind == 8)
		{
			CivilizationMain.Instance.buildings.Add(this);
		}
		if (civilizationGameBlock.kind == 8)
		{
			CivilizationMain.Instance.buildings.Add(civilizationGameBlock);
		}
		CivilizationMain.Instance.NextYear();
	}

	public void CheckNull()
	{
		if (kind == 0)
		{
			if (!CivilizationMain.Instance.freeBlocks.Contains(this))
			{
				CivilizationMain.Instance.freeBlocks.Add(this);
			}
			blockGo.SetActive(value: false);
			speed = CivilizationMain.Instance.speed;
		}
		else
		{
			if (CivilizationMain.Instance.freeBlocks.Contains(this))
			{
				CivilizationMain.Instance.freeBlocks.Remove(this);
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

	private void MiddleCheckSame(CivilizationGameBlock b)
	{
		SmallCheckSame(b.x - 1, b.y);
		SmallCheckSame(b.x + 1, b.y);
		SmallCheckSame(b.x, b.y + 1);
		SmallCheckSame(b.x, b.y - 1);
	}

	private void SmallCheckSame(int xx, int yy)
	{
		if (xx >= 0 && yy >= 0 && xx < CivilizationMain.Instance.wideLimit && yy < CivilizationMain.Instance.hightLimit && !sameBlock.Contains(CivilizationMain.Instance.blockCells[xx, yy]) && (kind == 1 || kind == 2 || kind == 3) && CivilizationMain.Instance.blockCells[xx, yy].kind == kind && CivilizationMain.Instance.blockCells[xx, yy].level == level)
		{
			sameBlock.Add(CivilizationMain.Instance.blockCells[xx, yy]);
		}
	}

	public void StartCombine()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_mix", useStream: false);
		if (!CivilizationMain.Instance.combiningBlocks.Contains(this))
		{
			CivilizationMain.Instance.combiningBlocks.Add(this);
		}
		for (int i = 1; i < sameBlock.Count; i++)
		{
			sameBlock[i].kind = 0;
			sameBlock[i].sameBlock.Clear();
			sameBlock[i].aimPosition = base.transform.position;
			sameBlock[i].StartMove(0.45f);
			number += sameBlock[i].number;
		}
		int num = number;
		CivilizationMain.Instance.ChangeSource((SourceType)kind, num);
		CivilizationMain.Instance.uiInstance.UpdateSourceText();
		PlayAddAni(num);
		combining = true;
		PlayAnimation("UI_hecheng");
		for (int j = 0; j < CivilizationMain.Instance.appearBlocks.Count; j++)
		{
			if (CivilizationMain.Instance.appearBlocks[j].x == x && CivilizationMain.Instance.appearBlocks[j].y == y)
			{
				CivilizationMain.Instance.appearBlocks.RemoveAt(j);
				break;
			}
		}
		CivilizationMain.Instance.combiningBlocks.Remove(this);
		BigCheckSame();
		if (kind != 0)
		{
			CivilizationMain.Instance.freeBlocks.Remove(this);
		}
	}

	public void PlayAddAni(int count, int targetKind = 99)
	{
		if (targetKind == 99)
		{
			targetKind = kind;
		}
		aniText.text = count.ToString("+#;-#;0");
		aniIcon.sprite = CivilizationMain.Instance.spriteList[targetKind];
		textAnimator.Update(0f);
		textAnimator.Play("UI_text_cx", -1, 0f);
	}

	public void EndDestroy()
	{
		switch (kind)
		{
		case 4:
			CivilizationMain.Instance.beasts.Remove(this);
			break;
		case 5:
			CivilizationMain.Instance.wars.Remove(this);
			break;
		case 6:
			CivilizationMain.Instance.boms.Remove(this);
			break;
		}
		if (!CivilizationMain.Instance.freeBlocks.Contains(this))
		{
			CivilizationMain.Instance.freeBlocks.Add(this);
		}
		DestoryBlock();
		PlayAnimation("UI_emty");
	}

	public void BeDestroy(bool needAni = false)
	{
		CivilizationMain.Instance.SetCanDrag(canDrag: false);
		if (kind == 4 || kind == 6)
		{
			PlayAnimation("UI_xiaochu_01");
			AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_destroy01", useStream: false);
		}
		else if (kind == 5 || kind == 7)
		{
			PlayAnimation("UI_xiaochu_02");
			AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_destroy02", useStream: false);
		}
		else if (needAni)
		{
			PlayAnimation("UI_xiaochu_01");
			AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_destroy01", useStream: false);
		}
		else
		{
			EndDestroy();
		}
	}

	public void UseBuildSkill()
	{
		skillGo.SetActive(value: true);
		CivilizationMain.Instance.SetCanDrag(canDrag: false);
		AudioManager.Instance.Play("effect", "minigame_activity_4_2", "minigame_activity_4_2_grid_buff02", useStream: false);
		FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			CivilizationMain.Instance.SetCanDrag(canDrag: true);
			skillGo.SetActive(value: false);
		}, 0.5f, 1);
	}

	private void DestoryBlock()
	{
		blockGo.SetActive(value: false);
		kind = 0;
		canMove = true;
		CivilizationMain.Instance.SetCanDrag(canDrag: true);
	}

	public bool CheckIsDestroying()
	{
		AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
		if (currentAnimatorStateInfo.IsName("UI_xiaochu_01") || currentAnimatorStateInfo.IsName("UI_xiaochu_02"))
		{
			return true;
		}
		return false;
	}

	public override void CheckMask(CivilizationGameBlock block, ref int count)
	{
		if (block != null)
		{
			int num = 0;
			int num2 = Math.Max(CivilizationMain.Instance.speed, speed);
			num += Math.Abs(block.x - x);
			num += Math.Abs(block.y - y);
			block.SetMask(num > num2 || !block.canMove);
		}
	}

	public void SetMask(bool isMask)
	{
		maskGo.SetActive(isMask);
		maskEmptyGo.SetActive(isMask);
	}

	public bool CheckSpeed(int x, int y)
	{
		if (CivilizationMain.Instance.gameType == GameType.Teach && CivilizationMain.Instance.isTeach)
		{
			bool result = false;
			if (x == CivilizationMain.Instance.teachEndPositonArray[CivilizationMain.Instance.teachStep, 0] && y == CivilizationMain.Instance.teachEndPositonArray[CivilizationMain.Instance.teachStep, 1])
			{
				CivilizationMain.Instance.teachStep++;
				result = true;
			}
			return result;
		}
		int num = Math.Max(CivilizationMain.Instance.speed, speed);
		return 0 + Math.Abs(base.x - x) + Math.Abs(base.y - y) <= num;
	}

	public void PlayAnimation(string aniName)
	{
		animator.Play(aniName, 0, 0f);
	}

	public void PlayBossAnimation()
	{
		CivilizationMain.Instance.BossEffectGo.SetActive(value: true);
		CivilizationMain.Instance.BossEffectGo.transform.position = base.gameObject.transform.position;
	}
}

using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class EatSnakeUI : MonoBehaviour
{
	public Text timeText;

	public Text type1Text;

	public Text type2Text;

	public Text type3Text;

	public EatSnakeMain eatSnakeMain;

	public List<Sprite> foodSpriteList = new List<Sprite>();

	public List<Sprite> reinforceSpriteList = new List<Sprite>();

	public Text countDownTxt;

	public GameObject countDownGo;

	public GameObject startGo;

	public Animator rushAnim;

	public Animator countDownAnim;

	public Text titleTxt;

	public Image nowImg;

	public Image nextImg;

	public Text nowText;

	public Text nextText;

	public ControllerExCollection controller;

	private ControllerEx titleController;

	private void Start()
	{
		titleController = controller.GetController("title");
	}

	public void OnUpPointDown()
	{
		if (eatSnakeMain.init && eatSnakeMain.shiftX != 1 && !eatSnakeMain.isLock)
		{
			eatSnakeMain.isLock = true;
			eatSnakeMain.shiftX = -1;
			eatSnakeMain.shiftY = 0;
		}
	}

	public void OnDownPointDown()
	{
		if (eatSnakeMain.init && eatSnakeMain.shiftX != -1 && !eatSnakeMain.isLock)
		{
			eatSnakeMain.isLock = true;
			eatSnakeMain.shiftX = 1;
			eatSnakeMain.shiftY = 0;
		}
	}

	public void OnLeftPointDown()
	{
		if (eatSnakeMain.init && eatSnakeMain.shiftY != 1 && !eatSnakeMain.isLock)
		{
			eatSnakeMain.isLock = true;
			eatSnakeMain.shiftX = 0;
			eatSnakeMain.shiftY = -1;
		}
	}

	public void OnRightPointDown()
	{
		if (eatSnakeMain.init && eatSnakeMain.shiftY != -1 && !eatSnakeMain.isLock)
		{
			eatSnakeMain.isLock = true;
			eatSnakeMain.shiftX = 0;
			eatSnakeMain.shiftY = 1;
		}
	}

	public void OnRushPointDown()
	{
		eatSnakeMain.nowMoveTimer = eatSnakeMain.rushTimer;
		rushAnim.Play("SpeedUp", -1, 0f);
		rushAnim.Update(0f);
	}

	public void OnRushPointUp()
	{
		eatSnakeMain.nowMoveTimer = eatSnakeMain.normalTimer;
	}

	private void Update()
	{
	}

	public void PrepareStart()
	{
		if (eatSnakeMain.init)
		{
			return;
		}
		countDownAnim.speed = ((!eatSnakeMain.gamePause) ? 1 : 0);
		if (!eatSnakeMain.gamePause)
		{
			titleController.SetSelectedState("need");
			eatSnakeMain.showTime += Time.deltaTime;
			if (eatSnakeMain.showTime < 3f)
			{
				countDownGo.SetActive(value: true);
				countDownTxt.text = (3f - Mathf.Floor(eatSnakeMain.showTime)).ToString();
				startGo.SetActive(value: false);
				return;
			}
			if (eatSnakeMain.showTime >= 3f && eatSnakeMain.showTime < 4f)
			{
				countDownGo.SetActive(value: false);
				startGo.SetActive(value: true);
				return;
			}
			eatSnakeMain.showTime = 0f;
			eatSnakeMain.init = true;
			Transform transform = eatSnakeMain.eatSnakeBlocks[8, 8].transform;
			Transform transform2 = eatSnakeMain.eatSnakeBlocks[7, 8].transform;
			eatSnakeMain.snakeHead.transform.position = transform.position;
			eatSnakeMain.snakeTail.transform.position = transform2.position;
			eatSnakeMain.snakeHead.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
			eatSnakeMain.snakeTail.transform.localRotation = Quaternion.Euler(0f, 0f, 0f);
			eatSnakeMain.snakeHead.x = 8;
			eatSnakeMain.snakeHead.y = 8;
			eatSnakeMain.eatSnakeBlocks[8, 8].direction[0] = 1;
			eatSnakeMain.eatSnakeBlocks[8, 8].direction[1] = 0;
			eatSnakeMain.snakeHead.gameObject.SetActive(value: true);
			eatSnakeMain.snakeTail.gameObject.SetActive(value: true);
			countDownGo.SetActive(value: false);
			startGo.SetActive(value: false);
		}
	}

	public void Init()
	{
		timeText.text = eatSnakeMain.time.ToString();
		type1Text.text = "0";
		type1Text.text = "0";
		type1Text.text = "0";
		countDownAnim.Play("ui_CountDownUI_cx 1", -1, 0f);
		countDownAnim.Update(0f);
	}

	public void UpdateText()
	{
		timeText.text = Mathf.Floor(eatSnakeMain.showTime).ToString();
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		for (int i = 0; i <= eatSnakeMain.snakeParts.Count - 1; i++)
		{
			EatSnakeBody eatSnakeBody = eatSnakeMain.snakeParts[i];
			if (eatSnakeBody.type == 1)
			{
				num++;
			}
			if (eatSnakeBody.type == 2)
			{
				num2++;
			}
			if (eatSnakeBody.type == 3)
			{
				num3++;
			}
		}
		type1Text.text = num2.ToString();
		type2Text.text = num.ToString();
		type3Text.text = num3.ToString();
	}

	public void UpdateReinforce(EatSnakeBlock nowRp, EatSnakeBlock nextRp, int currentIndex, int totalNum)
	{
		titleTxt.text = $"{currentIndex}/{totalNum}";
		if (nowRp != null)
		{
			nowImg.sprite = reinforceSpriteList[nowRp.reinforceNeedType - 1];
			nowText.text = nowRp.reinforceNeedCount.ToString();
		}
		if ((bool)nextRp && currentIndex <= totalNum)
		{
			nextImg.sprite = reinforceSpriteList[nextRp.reinforceNeedType - 1];
			nextText.text = nextRp.reinforceNeedCount.ToString();
		}
		else
		{
			titleController.SetSelectedState("last");
		}
	}
}

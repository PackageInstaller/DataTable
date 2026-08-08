using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class DodgeFoodItem : MonoBehaviour
{
	[NonSerialized]
	public DodgeFireBallGameManager gameManager;

	[NonSerialized]
	public DodgeFireBallGameStep config;

	public Image foodImage;

	public Image progressImage;

	public ControllerExCollection controllerEx;

	private ControllerEx statusController;

	private ControllerEx heatingController;

	public Animator invincibleAnimator;

	private bool isStatusDirty;

	private CookingGameConst.DogeFireBallFoodStatus _status;

	private bool _isHeating;

	private float _curProgress;

	private bool isProgressDirty;

	private float invincibleTime;

	private bool _isInvincible;

	private TablePos pos;

	private bool isPosDirty;

	private bool isPlayingInvincible;

	public CookingGameConst.DogeFireBallFoodStatus status
	{
		get
		{
			return _status;
		}
		private set
		{
			isStatusDirty = isStatusDirty || status != value;
			_status = value;
		}
	}

	public bool isHeating
	{
		get
		{
			return _isHeating;
		}
		set
		{
			isStatusDirty = isStatusDirty || _isHeating != value;
			_isHeating = value;
		}
	}

	public float curProgress
	{
		get
		{
			return _curProgress;
		}
		private set
		{
			isProgressDirty = true;
			_curProgress = value;
		}
	}

	public bool isInvincible
	{
		get
		{
			return _isInvincible;
		}
		set
		{
			isStatusDirty = isStatusDirty || isInvincible != value;
			_isInvincible = value;
			invincibleTime = (value ? config.invincibleTime : 0f);
		}
	}

	public int row
	{
		get
		{
			return pos.row;
		}
		set
		{
			isPosDirty = isPosDirty || pos.row != value;
			pos.row = value;
		}
	}

	public int col
	{
		get
		{
			return pos.col;
		}
		set
		{
			isPosDirty = isPosDirty || pos.col != value;
			pos.col = value;
		}
	}

	public void Init()
	{
		statusController = controllerEx.GetController("status");
		heatingController = controllerEx.GetController("heating");
	}

	public void InitGame(DodgeFireBallGameManager gameManager, DodgeFireBallGameStep config)
	{
		this.gameManager = gameManager;
		this.config = config;
		status = CookingGameConst.DogeFireBallFoodStatus.NORMAL;
		row = config.foodInitPos.row;
		col = config.foodInitPos.col;
		isHeating = false;
		isInvincible = false;
		invincibleTime = 0f;
		curProgress = 0f;
		isStatusDirty = true;
		isPosDirty = true;
		isProgressDirty = true;
		isPlayingInvincible = false;
	}

	public void UpdateLogic()
	{
		UpdateInvincibleTime();
		UpdateHeating();
		UpdateStatus();
	}

	public void UpdateInvincibleTime()
	{
		if (isInvincible)
		{
			invincibleTime -= Time.deltaTime;
			if (invincibleTime <= 0f)
			{
				isInvincible = false;
			}
		}
	}

	public void UpdateHeating()
	{
		CookingGameConst.DogFireBallTableStatus tableItemStatus = gameManager.GetTableItemStatus(row, col);
		isHeating = tableItemStatus == CookingGameConst.DogFireBallTableStatus.WARM;
		if (isHeating)
		{
			curProgress += config.progressRisingRate * Time.deltaTime;
		}
	}

	public void UpdateStatus()
	{
		if (gameManager.curProgress >= config.maxProgress)
		{
			status = CookingGameConst.DogeFireBallFoodStatus.COMPLETED;
		}
		else if (gameManager.curBlood <= 0)
		{
			status = CookingGameConst.DogeFireBallFoodStatus.CHARRED;
		}
		else
		{
			status = CookingGameConst.DogeFireBallFoodStatus.NORMAL;
		}
	}

	public void Hurt()
	{
		isInvincible = true;
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_done01", useStream: false);
	}

	public void UpdateRender()
	{
		if (isPosDirty)
		{
			isPosDirty = false;
			RenderPos();
		}
		if (isProgressDirty)
		{
			isProgressDirty = false;
			RenderProgress();
		}
		if (isStatusDirty)
		{
			isStatusDirty = false;
			RenderStatus();
			RenderHeating();
			RenderInvincible();
			RenderImage();
		}
	}

	public void RenderPos()
	{
		Vector2 tableScreenPos = gameManager.GetTableScreenPos(row, col);
		RectTransformUtility.ScreenPointToLocalPointInRectangle((RectTransform)base.transform.parent, tableScreenPos, gameManager.uiCamera, out var localPoint);
		base.transform.localPosition = localPoint;
	}

	public void RenderProgress()
	{
		progressImage.fillAmount = curProgress / config.maxProgress;
	}

	public void RenderStatus()
	{
		switch (status)
		{
		case CookingGameConst.DogeFireBallFoodStatus.NORMAL:
			statusController.SetSelectedState("normal");
			break;
		case CookingGameConst.DogeFireBallFoodStatus.COMPLETED:
			statusController.SetSelectedState("completed");
			break;
		case CookingGameConst.DogeFireBallFoodStatus.CHARRED:
			statusController.SetSelectedState("charred");
			break;
		}
	}

	public void RenderHeating()
	{
		if (isHeating && status == CookingGameConst.DogeFireBallFoodStatus.NORMAL)
		{
			heatingController.SetSelectedState("true");
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_sizzle02", useStream: false);
		}
		else
		{
			heatingController.SetSelectedState("false");
		}
	}

	public void RenderImage()
	{
		switch (status)
		{
		case CookingGameConst.DogeFireBallFoodStatus.NORMAL:
			foodImage.sprite = config.normalSprite;
			break;
		case CookingGameConst.DogeFireBallFoodStatus.COMPLETED:
			foodImage.sprite = config.completedSprite;
			break;
		case CookingGameConst.DogeFireBallFoodStatus.CHARRED:
			foodImage.sprite = config.charredSprite;
			break;
		}
	}

	public void RenderInvincible()
	{
		if (isInvincible && status == CookingGameConst.DogeFireBallFoodStatus.NORMAL)
		{
			if (!isPlayingInvincible)
			{
				PlayInvincibleAnim();
			}
		}
		else if (isPlayingInvincible)
		{
			StopInvincibleAnim();
		}
	}

	private void PlayInvincibleAnim()
	{
		isPlayingInvincible = true;
		invincibleAnimator.enabled = true;
		invincibleAnimator.Play("dishContainer", 0, 0f);
		invincibleAnimator.Update(0f);
	}

	private void StopInvincibleAnim()
	{
		isPlayingInvincible = false;
		invincibleAnimator.enabled = false;
		invincibleAnimator.Play("dishContainer", 0, 0f);
		invincibleAnimator.Update(0f);
	}
}

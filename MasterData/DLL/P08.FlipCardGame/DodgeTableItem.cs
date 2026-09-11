using System;
using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;

public class DodgeTableItem : MonoBehaviour
{
	[NonSerialized]
	public DodgeFireBallGameManager gameManager;

	[NonSerialized]
	public DodgeFireBallGameStep config;

	public ControllerExCollection controllerEx;

	private ControllerEx statusController;

	private ControllerEx warningController;

	private ControllerEx fireBallDropController;

	public RectTransform fireballTrans;

	public Animator warningAnimator;

	public Animator fireBallAnimator;

	public Animator burnAnimator;

	public Animator burnDownAnimator;

	public TablePos pos;

	private CookingGameConst.DogFireBallTableStatus _status;

	private DodgeFireBallEvent curFireBallEvent;

	private HashSet<DodgeFireBallEvent> waitFireBallEventSet = new HashSet<DodgeFireBallEvent>();

	private bool needFireballDrop;

	private bool needWarning;

	private bool needBurn;

	private float warningEndTime;

	private float fireBallDropDurationTime;

	private float fireBallDropEndTime;

	private float burnDownDurationTime;

	private float burnEndTime;

	private float warmEndTime;

	private bool isStatusDirty;

	private bool isPlayingWarning;

	private bool isPlayingFireBallDrop;

	private bool isPlayingBurn;

	private bool isPlayingBurnDown;

	public CookingGameConst.DogFireBallTableStatus status
	{
		get
		{
			return _status;
		}
		private set
		{
			isStatusDirty = isStatusDirty || _status != value;
			_status = value;
		}
	}

	public void Init(int row, int col)
	{
		pos = default(TablePos);
		pos.row = row;
		pos.col = col;
		statusController = controllerEx.GetController("status");
		warningController = controllerEx.GetController("warning");
		fireBallDropController = controllerEx.GetController("fireBallDrop");
		fireBallDropDurationTime = fireBallAnimator.GetClipLength(0, "fireball");
		burnDownDurationTime = burnDownAnimator.GetClipLength(0, "BurnDown");
	}

	public void InitGame(DodgeFireBallGameManager gameManager, DodgeFireBallGameStep config)
	{
		this.gameManager = gameManager;
		this.config = config;
		status = CookingGameConst.DogFireBallTableStatus.NORMAL;
		isStatusDirty = true;
		waitFireBallEventSet.Clear();
		curFireBallEvent = null;
		warningEndTime = 0f;
		fireBallDropEndTime = 0f;
		burnEndTime = 0f;
		warmEndTime = 0f;
		needFireballDrop = false;
		needWarning = false;
		needBurn = false;
	}

	public void UpdateLogic()
	{
		UpdateCurFireBallEvent();
		UpdateStatus();
		UpdateGuideTrigger();
	}

	private void UpdateCurFireBallEvent()
	{
		List<DodgeFireBallEvent> list = new List<DodgeFireBallEvent>();
		bool flag = false;
		bool flag2 = false;
		foreach (DodgeFireBallEvent item in waitFireBallEventSet)
		{
			if (gameManager.playTime < item.warningEndTime)
			{
				flag = true;
				warningEndTime = item.warningEndTime;
				continue;
			}
			flag2 = true;
			fireBallDropEndTime = gameManager.playTime + fireBallDropDurationTime;
			burnEndTime = fireBallDropEndTime + config.redFireDurationTime;
			warmEndTime = burnEndTime + item.fireBallDropEventConfig.yellowFireDurationTime;
			list.Add(item);
		}
		needWarning = flag;
		needFireballDrop = flag2;
		foreach (DodgeFireBallEvent item2 in list)
		{
			waitFireBallEventSet.Remove(item2);
		}
	}

	public void UpdateStatus()
	{
		if (gameManager.playTime > fireBallDropEndTime && gameManager.playTime <= burnEndTime)
		{
			status = CookingGameConst.DogFireBallTableStatus.BURN;
		}
		else if (gameManager.playTime > burnEndTime && gameManager.playTime <= warmEndTime)
		{
			status = CookingGameConst.DogFireBallTableStatus.WARM;
		}
		else
		{
			status = CookingGameConst.DogFireBallTableStatus.NORMAL;
		}
	}

	public void UpdateGuideTrigger()
	{
		if (needWarning)
		{
			gameManager.TriggerWarning();
		}
		if (status == CookingGameConst.DogFireBallTableStatus.BURN)
		{
			gameManager.TriggerBurn();
		}
		else if (status == CookingGameConst.DogFireBallTableStatus.WARM)
		{
			gameManager.TriggerWarm();
		}
	}

	public void AddFireBallEvent(DodgeFireBallEvent fireBallEvent)
	{
		waitFireBallEventSet.Add(fireBallEvent);
	}

	public void UpdateRender()
	{
		if (isStatusDirty)
		{
			isStatusDirty = false;
			RenderStatus();
		}
		RenderWarning();
		RenderFireBall();
		RenderBurnStatus();
	}

	public void RenderStatus()
	{
		switch (status)
		{
		case CookingGameConst.DogFireBallTableStatus.BURN:
			statusController.SetSelectedState("burn");
			needBurn = true;
			break;
		case CookingGameConst.DogFireBallTableStatus.NORMAL:
			statusController.SetSelectedState("normal");
			break;
		case CookingGameConst.DogFireBallTableStatus.WARM:
			statusController.SetSelectedState("warm");
			break;
		}
	}

	public void RenderWarning()
	{
		if (needWarning && !isPlayingWarning)
		{
			needWarning = false;
			PlayWarningAnim();
		}
		else if (gameManager.playTime > warningEndTime && isPlayingWarning)
		{
			StopWarningAnim();
		}
	}

	public void RenderFireBall()
	{
		if (needFireballDrop && !isPlayingFireBallDrop)
		{
			needFireballDrop = false;
			fireballTrans.SetParent(gameManager.fireBallContainerTrans);
			PlayFireBallDropAnim();
		}
		else if (gameManager.playTime > fireBallDropEndTime && isPlayingFireBallDrop)
		{
			StopFireBallDropAnim();
		}
	}

	public void RenderBurnStatus()
	{
		if (needBurn && !isPlayingBurn)
		{
			needBurn = false;
			PlayBurnAnim();
		}
		else if (isPlayingBurn && gameManager.playTime > burnEndTime - burnDownDurationTime)
		{
			StopBurnAnim();
			if (!isPlayingBurnDown)
			{
				PlayBurnDownAnim();
			}
		}
		if (isPlayingBurnDown && gameManager.playTime > burnEndTime)
		{
			StopBurnDownAnim();
		}
	}

	public void PauseAnim()
	{
		warningAnimator.speed = 0f;
		fireBallAnimator.speed = 0f;
		burnAnimator.speed = 0f;
		burnDownAnimator.speed = 0f;
	}

	public void ResumeAnim()
	{
		warningAnimator.speed = 1f;
		fireBallAnimator.speed = 1f;
		burnAnimator.speed = 1f;
		burnDownAnimator.speed = 1f;
	}

	private void PlayWarningAnim()
	{
		isPlayingWarning = true;
		PlayAnim(warningAnimator, "warning");
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_warning", useStream: false);
	}

	private void StopWarningAnim()
	{
		isPlayingWarning = false;
		StopAnim(warningAnimator);
	}

	private void PlayFireBallDropAnim()
	{
		isPlayingFireBallDrop = true;
		PlayAnim(fireBallAnimator, "fireball");
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_fireball", useStream: false);
	}

	private void StopFireBallDropAnim()
	{
		isPlayingFireBallDrop = false;
		StopAnim(fireBallAnimator);
	}

	private void PlayBurnAnim()
	{
		isPlayingBurn = true;
		PlayAnim(burnAnimator, "burn");
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_brun", useStream: false);
	}

	private void StopBurnAnim()
	{
		isPlayingBurn = false;
		StopAnim(burnAnimator);
	}

	private void PlayBurnDownAnim()
	{
		isPlayingBurnDown = true;
		PlayAnim(burnDownAnimator, "BurnDown");
	}

	private void StopBurnDownAnim()
	{
		isPlayingBurnDown = false;
		StopAnim(burnDownAnimator);
	}

	private void PlayAnim(Animator animator, string clipName)
	{
		animator.SetActive(bActive: true);
		animator.enabled = true;
		animator.Play(clipName, 0, 0f);
		animator.Update(0f);
	}

	private void StopAnim(Animator animator)
	{
		animator.enabled = false;
		animator.SetActive(bActive: false);
	}

	public bool isInWarning()
	{
		return isPlayingWarning;
	}

	public bool isInBurn()
	{
		return status == CookingGameConst.DogFireBallTableStatus.BURN;
	}

	public bool isWarm()
	{
		return status == CookingGameConst.DogFireBallTableStatus.WARM;
	}
}

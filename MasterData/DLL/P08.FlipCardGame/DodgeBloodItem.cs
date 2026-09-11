using System;
using ControllerExSpace;
using UnityEngine;

public class DodgeBloodItem : MonoBehaviour
{
	[NonSerialized]
	public DodgeFireBallGameManager gameManager;

	[NonSerialized]
	public DodgeFireBallGameStep config;

	public ControllerExCollection controllerEx;

	private ControllerEx statusController;

	public Animator hurtAnimator;

	private int bloodIndex;

	private bool _hurt;

	private bool isDirty;

	private bool hurt
	{
		get
		{
			return _hurt;
		}
		set
		{
			isDirty = _hurt != value;
			_hurt = value;
		}
	}

	public void Init(int bloodIndex)
	{
		this.bloodIndex = bloodIndex;
		statusController = controllerEx.GetController("status");
	}

	public void InitGame(DodgeFireBallGameManager gameManager, DodgeFireBallGameStep config)
	{
		this.gameManager = gameManager;
		this.config = config;
		hurt = false;
		isDirty = true;
	}

	public void UpdateLogic()
	{
		int num = config.bloodCount - gameManager.curBlood;
		hurt = num >= bloodIndex;
	}

	public void UpdateRender()
	{
		if (isDirty)
		{
			isDirty = false;
			statusController.SetSelectedState(hurt ? "scorch" : "normal");
			if (hurt)
			{
				PlayHurtAnim();
			}
		}
	}

	private void PlayHurtAnim()
	{
		hurtAnimator.enabled = true;
		hurtAnimator.Play("bloodItem", 0, 0f);
		hurtAnimator.Update(0f);
	}
}

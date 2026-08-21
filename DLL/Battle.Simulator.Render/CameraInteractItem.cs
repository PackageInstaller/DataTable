using System;
using Cinemachine;
using UnityEngine;

public class CameraInteractItem : MonoBehaviour
{
	public CinemachineVirtualCamera virtualCamera;

	public string animatorStateInteractName;

	public string animatorStateFoundName;

	public string animatorStateChosedName;

	public Animator animator;

	public int nameBattleTips = 1;

	public int desBattleTips = 2;

	public string iconPath;

	[HideInInspector]
	public int triggerID;

	private Action<int> action;

	private Action<int> actionFound;

	public bool found;

	public void Init(int triggerID, Action<int> action, Action<int> actionFound)
	{
		this.triggerID = triggerID;
		this.action = action;
		this.actionFound = actionFound;
	}

	public void Interact()
	{
		if (animator != null && !string.IsNullOrEmpty(animatorStateInteractName))
		{
			animator.Play(animatorStateInteractName);
		}
		if (action != null)
		{
			action(triggerID);
		}
	}

	public void FoundedState()
	{
		if (animator != null && !string.IsNullOrEmpty(animatorStateFoundName))
		{
			animator.Play(animatorStateFoundName);
		}
		found = true;
		if (actionFound != null)
		{
			actionFound(triggerID);
		}
	}

	public void ChosedState()
	{
		if (animator != null && !string.IsNullOrEmpty(animatorStateChosedName))
		{
			animator.Play(animatorStateChosedName);
		}
	}
}

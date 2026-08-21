using System;
using UnityEngine;
using UnityEngine.UI;

[Serializable]
public class BattleUIPortraitItem
{
	private bool running;

	private float time;

	public Transform transform;

	public Image image;

	public Animator animator;

	public string appearAnimationStateName;

	public string disappearAnimationStateName;

	public void Update(float deltaTime)
	{
		if (!running)
		{
			return;
		}
		time -= deltaTime;
		if (time <= 0f)
		{
			running = false;
			if (animator != null && !string.IsNullOrEmpty(disappearAnimationStateName))
			{
				animator.Play(disappearAnimationStateName);
			}
		}
	}

	public bool IsRunning()
	{
		return running;
	}

	public void Play(Sprite sprite, float time)
	{
		running = true;
		image.sprite = sprite;
		this.time = time;
		if (transform != null)
		{
			transform.SetSiblingIndex(1);
			transform.gameObject.SetActive(value: true);
		}
		if (animator != null && !string.IsNullOrEmpty(appearAnimationStateName))
		{
			animator.Play(appearAnimationStateName, 0, 0f);
		}
	}
}

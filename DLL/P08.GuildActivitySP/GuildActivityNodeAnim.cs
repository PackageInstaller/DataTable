using System;
using UnityEngine;

public class GuildActivityNodeAnim : MonoBehaviour
{
	public new string name;

	public Animator animator;

	private Action _onComplete;

	public GuildActivitySPWarFieldNode node;

	private int _fromNodeId;

	private void Awake()
	{
		animator.enabled = false;
	}

	public void Play(int fromNodeId, int action, Action onComplete, float aniTime)
	{
		_fromNodeId = fromNodeId;
		_onComplete = onComplete;
		GuildActivitySPManager.GetInstance().MoveCameraToNode(node.id, aniTime, 0f, delegate
		{
			if (animator == null)
			{
				AfterAnimation(aniTime);
			}
			else if (action == 0)
			{
				Invoke("AfterAnimation", 1f);
			}
			else
			{
				Invoke("Play", 1f);
			}
		});
	}

	private void Play()
	{
		animator.enabled = true;
		animator.Play(name);
	}

	private void Update()
	{
		if (animator != null && animator.enabled && animator.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f)
		{
			animator.enabled = false;
			AfterAnimation();
		}
	}

	private void AfterAnimation(float time = 2f)
	{
		GuildActivitySPManager.GetInstance().MoveCameraToNode(_fromNodeId, time, 0.2f, _onComplete);
	}
}

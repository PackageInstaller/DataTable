using System.Collections;
using RootMotion.FinalIK;
using UnityEngine;

public class DialogueCharacter : MonoBehaviour
{
	public Transform head;

	public LookAtIK headIK;

	public LookAtIK eyesIK;

	public Animator animator;

	private void Start()
	{
		animator = GetComponent<Animator>();
	}

	private void OnEnable()
	{
		if (!animator)
		{
			animator = GetComponent<Animator>();
		}
	}

	private IEnumerator Blink()
	{
		if (animator == null)
		{
			yield break;
		}
		int layer = animator.GetLayerIndex("Eyes");
		if (layer < 0)
		{
			yield break;
		}
		while (true)
		{
			yield return new WaitForSeconds(Random.Range(5, 12));
			if (animator.GetLayerWeight(layer) > 0.99f)
			{
				animator.SetTrigger("eyes_zhayan");
			}
		}
	}
}

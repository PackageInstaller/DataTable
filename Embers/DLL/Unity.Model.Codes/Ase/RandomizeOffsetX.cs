using UnityEngine;

namespace Ase;

public class RandomizeOffsetX : MonoBehaviour
{
	public string offsetParamName = "offsetX";

	public Animator animator;

	[SerializeField]
	private bool _autoPlay;

	private void OnEnable()
	{
		if (_autoPlay)
		{
			animator.SetFloat(offsetParamName, Random.value);
		}
	}

	public void PlayAnim(int stateHash = 0)
	{
		animator.SetFloat(offsetParamName, Random.value);
		animator.Play(stateHash);
	}
}

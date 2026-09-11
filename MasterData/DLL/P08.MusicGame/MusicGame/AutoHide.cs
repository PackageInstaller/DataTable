using UnityEngine;

namespace MusicGame;

internal class AutoHide : MonoBehaviour
{
	public float duration = 1f;

	private float time;

	private void OnEnable()
	{
		time = 0f;
	}

	private void Update()
	{
		if (time > duration)
		{
			base.gameObject.SetActive(value: false);
		}
		else
		{
			time += Time.deltaTime;
		}
	}
}

using System;
using System.Collections;
using UnityEngine;

public static class CoroutineHelper
{
	public static void WaitForSeconds(MonoBehaviour monoBehaviour, float seconds, Action onComplete)
	{
		monoBehaviour.StartCoroutine(WaitForSecondsRoutine(seconds, onComplete));
	}

	private static IEnumerator WaitForSecondsRoutine(float seconds, Action onComplete)
	{
		yield return new WaitForSeconds(seconds);
		onComplete?.Invoke();
	}
}

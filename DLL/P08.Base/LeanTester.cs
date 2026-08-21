using System.Collections;
using UnityEngine;

public class LeanTester : MonoBehaviour
{
	public float timeout = 15f;

	public void Start()
	{
		StartCoroutine(timeoutCheck());
	}

	private IEnumerator timeoutCheck()
	{
		float pauseEndTime = Time.realtimeSinceStartup + timeout;
		while (Time.realtimeSinceStartup < pauseEndTime)
		{
			yield return 0;
		}
		if (!LeanTest.testsFinished)
		{
			Debug.Log(LeanTest.formatB("Tests timed out!"));
			LeanTest.overview();
		}
	}
}

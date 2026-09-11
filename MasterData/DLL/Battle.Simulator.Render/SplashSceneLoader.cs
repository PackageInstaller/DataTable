using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SplashSceneLoader : NScene
{
	public override void ShowLoadUI()
	{
	}

	public override void CloseLoadUI()
	{
	}

	public override void OnSceneEnter()
	{
	}

	public override IEnumerator OnLoadCoroutine()
	{
		AsyncOperation ao = SceneManager.LoadSceneAsync("splash");
		while (!ao.isDone)
		{
			yield return 1;
		}
	}

	public override void OnSceneLoaded()
	{
	}
}

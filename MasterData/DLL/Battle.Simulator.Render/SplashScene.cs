using System.Collections;

public class SplashScene : SplashSceneLoader
{
	private void Awake()
	{
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
	}

	public override void OnSceneLoaded()
	{
		base.OnSceneLoaded();
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		yield return 0;
	}

	public override void OnSceneReady()
	{
	}

	public override void CloseLoadUI()
	{
		base.CloseLoadUI();
	}

	public override void OnSceneExit(NScene nextScene)
	{
	}

	private void Update()
	{
	}
}

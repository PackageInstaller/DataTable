using System.Collections;

public interface ISceneLoader
{
	float Progress { get; set; }

	void OnSceneEnter();

	IEnumerator OnLoadCoroutine();

	void OnSceneExit(NScene scene);

	void OnSceneLoaded();

	void OnSceneReady();

	IEnumerator OnSceneReadyCoroutine();
}

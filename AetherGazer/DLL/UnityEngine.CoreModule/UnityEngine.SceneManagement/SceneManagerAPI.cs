namespace UnityEngine.SceneManagement;

public class SceneManagerAPI
{
	private static SceneManagerAPI s_DefaultAPI = new SceneManagerAPI();

	internal static SceneManagerAPI ActiveAPI => overrideAPI ?? s_DefaultAPI;

	public static SceneManagerAPI overrideAPI { get; }

	protected internal SceneManagerAPI()
	{
	}

	protected internal virtual int GetNumScenesInBuildSettings()
	{
		return SceneManagerAPIInternal.GetNumScenesInBuildSettings();
	}

	protected internal virtual Scene GetSceneByBuildIndex(int buildIndex)
	{
		return SceneManagerAPIInternal.GetSceneByBuildIndex(buildIndex);
	}

	protected internal virtual AsyncOperation LoadSceneAsyncByNameOrIndex(string sceneName, int sceneBuildIndex, LoadSceneParameters parameters, bool mustCompleteNextFrame)
	{
		return SceneManagerAPIInternal.LoadSceneAsyncNameIndexInternal(sceneName, sceneBuildIndex, parameters, mustCompleteNextFrame);
	}

	protected internal virtual AsyncOperation UnloadSceneAsyncByNameOrIndex(string sceneName, int sceneBuildIndex, bool immediately, UnloadSceneOptions options, out bool outSuccess)
	{
		return SceneManagerAPIInternal.UnloadSceneNameIndexInternal(sceneName, sceneBuildIndex, immediately, options, out outSuccess);
	}

	protected internal virtual AsyncOperation LoadFirstScene(bool mustLoadAsync)
	{
		return null;
	}
}

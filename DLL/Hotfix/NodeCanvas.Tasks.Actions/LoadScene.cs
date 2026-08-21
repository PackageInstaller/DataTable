using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.SceneManagement;

namespace NodeCanvas.Tasks.Actions;

[Category("Application")]
public class LoadScene : ActionTask
{
	[RequiredField]
	public BBParameter<string> sceneName;

	public BBParameter<LoadSceneMode> mode;

	protected override string info => $"Load Scene {sceneName}";

	protected override void OnExecute()
	{
		SceneManager.LoadScene(sceneName.value, mode.value);
		EndAction();
	}
}

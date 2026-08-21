using System.Collections;
using Cinemachine;
using UnityEngine;

namespace P08.Quiz;

public class QuizSceneLoader : NScene
{
	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	protected void SetUIProgress(float value)
	{
		LoadingUIManager.inst.SetUIProgress(value);
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		if (sceneName == null)
		{
			Debug.LogError("需要加载的场景信息为空");
			yield return null;
		}
		IEnumerator task = LoadLevelAsync(sceneName);
		while (task.MoveNext())
		{
			yield return task.Current;
		}
	}

	public IEnumerator OnAfterLevelLoad()
	{
		U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject).m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
		yield return null;
		GamepadManager.Instance.UseController();
	}

	public IEnumerator LoadLevelAsync(string sceneName)
	{
		AssetBundleLoadOperation op = Asset.LoadLevelAsync("Levels/" + sceneName, isAddtive: true);
		while (!op.IsDone())
		{
			yield return null;
		}
		IEnumerator enumerator = OnAfterLevelLoad();
		while (enumerator.MoveNext())
		{
			yield return null;
		}
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}
}

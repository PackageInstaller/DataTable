using System.Collections;
using BilliardGame.Runtime;
using Cinemachine;
using P08Main.Loading;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace BilliardGame;

public class BilliardGameSceneLoader : NScene
{
	public override float ShowLoadUIDuration()
	{
		return 1f;
	}

	public override float EndLoadUIDuration()
	{
		return 1f;
	}

	public override float CloseLoadUIDuration()
	{
		return 0.5f;
	}

	public override void ShowLoadUI()
	{
		if (BilliardGameDataManager.IsBallGame())
		{
			CustomLoadingManager.inst.ShowLoadUI(LoadingImpl.BilliardGame_Loading);
		}
		else
		{
			LoadingUIManager.inst.ShowLoadUI();
		}
	}

	public override void CloseLoadUI()
	{
		if (BilliardGameDataManager.IsBallGame())
		{
			CustomLoadingManager.inst.CloseLoadUI(LoadingImpl.BilliardGame_Loading);
		}
		else
		{
			LoadingUIManager.inst.CloseLoadUI();
		}
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/BilliardGame", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Scene sceneByName = SceneManager.GetSceneByName("Common");
		if (sceneByName.IsValid())
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		else
		{
			Debug.LogError("can't find scene by name: " + scenePath);
		}
		U3DUtil.Get<CinemachineBrain>(Camera.main.gameObject).m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 0.3f);
		BilliardGameManager.Instance.LoadBilliardMap();
		yield return null;
	}
}

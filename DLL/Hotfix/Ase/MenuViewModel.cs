using GameFramework.Resource;
using GameFramework.Runtime;
using UnityEngine.SceneManagement;

namespace Ase;

public class MenuViewModel : OptionBase
{
	private SimpleCommand openLoginWindowCmd;

	public SimpleCommand OpenLoginWindowCmd => openLoginWindowCmd;

	public MenuViewModel()
	{
		openLoginWindowCmd = new SimpleCommand(OnOuter);
	}

	public async void OnOuter()
	{
		openLoginWindowCmd.Enabled = false;
		await GameEntry.UI.OpenWindow<StartupWindow>("Start/StartupWindow", new StartupViewModel());
		dismissRequest.Raise();
	}

	public async void OnBattleTest()
	{
		await GameEntry.UI.OpenWindow<ModeSelectionWindow>("Test/ModeSelectionWindow", new ModeSelectionViewModel());
		dismissRequest.Raise();
	}

	public async void OnEffectBtn()
	{
		GameEntry.Scene.LoadScene(AssetUtility.GetSceneAsset("Default/EffectTest"), LoadSceneMode.Additive, new LoadSceneCallbacks(LoadSceneSuccessCallBack));
		dismissRequest.Raise();
	}

	private void LoadSceneSuccessCallBack(string sceneAssetName, float duration, object userdata)
	{
	}
}

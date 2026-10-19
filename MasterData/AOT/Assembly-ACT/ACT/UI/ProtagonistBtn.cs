using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ProtagonistBtn : MonoBehaviour, IBattleMainComponent
{
	[SerializeField]
	private ActButton _actButton;

	public void Initialize(MonoBattleMainBaseView view)
	{
		_actButton.SetBtnClick(OpenProtagonistExitView);
		Model<BattleMainModel>.Interface.OnProtagonistBtnDisabledChangeEventHandler += OnPlayerControlStateChange;
		OnPlayerControlStateChange();
	}

	private void OpenProtagonistExitView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPPROTAGONISTEXITVIEW);
	}

	private void OnPlayerControlStateChange()
	{
		gameObject.SetActive(Singleton<ProtagonistManager>.instance.IsProtagonist);
	}

	public void UnInitialize()
	{
		_actButton.OnClick.RemoveAllListeners();
		Model<BattleMainModel>.Interface.OnProtagonistBtnDisabledChangeEventHandler -= OnPlayerControlStateChange;
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}
}

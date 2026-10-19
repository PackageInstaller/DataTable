using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class BattleMainLeftTopAllEscItemRoot : MonoBehaviour, IBattleMainComponent
{
	public void Initialize(MonoBattleMainBaseView view)
	{
		Model<BattleMainModel>.Interface.OnLeftTopMenuRootDisabledChangeEventHandler += OnLeftTopMenuRootDisabledChangeEventHandler;
		OnLeftTopMenuRootDisabledChangeEventHandler();
	}

	private void OnLeftTopMenuRootDisabledChangeEventHandler()
	{
		gameObject.SetActive(!Model<BattleMainModel>.Interface.LeftTopMenuRootDisabled);
	}

	public void UnInitialize()
	{
		Model<BattleMainModel>.Interface.OnLeftTopMenuRootDisabledChangeEventHandler -= OnLeftTopMenuRootDisabledChangeEventHandler;
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

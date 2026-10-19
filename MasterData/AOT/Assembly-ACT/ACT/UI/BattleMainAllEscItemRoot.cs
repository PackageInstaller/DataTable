using ACT.Model;
using UnityEngine;

namespace ACT.UI;

public class BattleMainAllEscItemRoot : MonoBehaviour, IBattleMainComponent
{
	public void Initialize(MonoBattleMainBaseView view)
	{
		Model<BattleMainModel>.Interface.OnMenuRootDisabledChangeEventHandler += OnMenuRootDisabledChangeEventHandler;
		OnMenuRootDisabledChangeEventHandler();
	}

	private void OnMenuRootDisabledChangeEventHandler()
	{
		gameObject.SetActive(!Model<BattleMainModel>.Interface.MenuRootDisabled);
	}

	public void UnInitialize()
	{
		Model<BattleMainModel>.Interface.OnMenuRootDisabledChangeEventHandler -= OnMenuRootDisabledChangeEventHandler;
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

using System.Collections.Generic;
using ACT.Battle;
using ACT.UI;

namespace ACT.Model;

public class ClientModuleModel : Model<ClientModuleModel>, IClientModuleModelNtfCall
{
	public enum ClientModuleEnum
	{
		BattleMainUI,
		Input
	}

	private Dictionary<ClientModuleEnum, Dictionary<int, bool>> m_ClientModuleStates = new Dictionary<ClientModuleEnum, Dictionary<int, bool>>();

	protected override void Init()
	{
	}

	protected override void UnInit()
	{
		m_ClientModuleStates.Clear();
	}

	public bool GetClientModule(ClientModuleEnum module, int key)
	{
		if (!m_ClientModuleStates.TryGetValue(module, out var value))
		{
			return true;
		}
		return value.GetValueOrDefault(key, defaultValue: true);
	}

	void IClientModuleModelNtfCall.SetModuleState(ClientModuleEnum module, int key, bool state)
	{
		if (!m_ClientModuleStates.TryGetValue(module, out var value))
		{
			value = (m_ClientModuleStates[module] = new Dictionary<int, bool>());
		}
		value[key] = state;
		switch (module)
		{
		case ClientModuleEnum.BattleMainUI:
			if (Model<BattleMainModel>.HasInstance())
			{
				Model<BattleMainModel>.Interface.RefreshUIModuleState((UIMode)key);
			}
			break;
		case ClientModuleEnum.Input:
			if ((bool)MonoECS.instance)
			{
				MonoECS.instance?.InputActive((InputKey)key, state);
			}
			break;
		}
	}
}

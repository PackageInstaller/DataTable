using System.Collections.Generic;

namespace Ase;

public class PlayerInfoFunctionViewModel : OptionBase
{
	private List<TabItemNormalData> functionList;

	private bool isOpen;

	public List<TabItemNormalData> FunctionList
	{
		get
		{
			return functionList;
		}
		private set
		{
			Set(ref functionList, value, "FunctionList");
		}
	}

	public bool IsOpen
	{
		get
		{
			return isOpen;
		}
		private set
		{
			Set(ref isOpen, value, "IsOpen");
		}
	}

	public PlayerInfoFunctionViewModel(OptionBase parent)
	{
		base.parent = parent;
		functionList = new List<TabItemNormalData>();
	}

	public void SetFunctionList(PlayerInfoViewModel vm)
	{
		FunctionList = vm.FunctionList;
		IsOpen = true;
	}

	public void CloseView()
	{
		IsOpen = false;
	}
}

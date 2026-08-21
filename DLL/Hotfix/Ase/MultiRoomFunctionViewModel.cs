using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MultiRoomFunctionViewModel : OptionBase
{
	private List<TabItemNormalData> functionList;

	private bool isOpen;

	private Vector2 position;

	private InteractionRequest refreshFunctionRequest;

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

	public Vector2 Position
	{
		get
		{
			return position;
		}
		private set
		{
			Set(ref position, value, "Position");
		}
	}

	public InteractionRequest RefreshFunctionRequest => refreshFunctionRequest;

	public MultiRoomFunctionViewModel(OptionBase parent)
	{
		base.parent = parent;
		functionList = new List<TabItemNormalData>();
		refreshFunctionRequest = new InteractionRequest();
	}

	public void SetFunctionList(MultiRoomPlayerViewModel vm)
	{
		FunctionList = vm.FunctionList;
		Position = vm.FunctionPos;
		IsOpen = true;
		refreshFunctionRequest.Raise();
	}

	public void CloseView()
	{
		IsOpen = false;
	}
}

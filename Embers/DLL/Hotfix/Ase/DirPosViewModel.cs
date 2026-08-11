using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DirPosViewModel : OptionBase, IUpdateActorPos
{
	private List<BattleTaskUIPosViewModel> battleTaskUIPosViewModels = new List<BattleTaskUIPosViewModel>(4);

	private InteractionRequest updateDirUIPosRequest = new InteractionRequest();

	private Vector3 actorPos;

	private int index;

	public List<BattleTaskUIPosViewModel> BattleTaskUIPosViewModels => battleTaskUIPosViewModels;

	public IInteractionRequest UpdateDirUIPosRequest => updateDirUIPosRequest;

	public int AddDirUI(string iconName, Vector3 pos)
	{
		index++;
		BattleTaskUIPosViewModel item = new BattleTaskUIPosViewModel(this, pos, 3f, index, iconName);
		battleTaskUIPosViewModels.Add(item);
		updateDirUIPosRequest.Raise();
		return index;
	}

	public void RemoveDirUI(int index)
	{
		for (int i = 0; i < battleTaskUIPosViewModels.Count; i++)
		{
			if (battleTaskUIPosViewModels[i].Index == index)
			{
				battleTaskUIPosViewModels.RemoveAt(i);
				updateDirUIPosRequest.Raise();
				break;
			}
		}
	}

	public void UpdateActorPos(Vector3 playerPos)
	{
		actorPos = playerPos;
	}

	public Vector3 GetActorPos()
	{
		return actorPos;
	}

	public void RemoveAllDirUI()
	{
		battleTaskUIPosViewModels.Clear();
		updateDirUIPosRequest.Raise();
	}
}

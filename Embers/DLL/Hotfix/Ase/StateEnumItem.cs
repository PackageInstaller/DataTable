#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class StateEnumItem : MonoBehaviour
{
	public bool activeAtLast;

	public List<StateEnumItemConfig> stateConfigs;

	private StateEnumConfig curState;

	public StateEnumConfig CurState
	{
		get
		{
			return curState;
		}
		set
		{
			curState = value;
			UpdateStateItem();
		}
	}

	public void SetCurState(StateEnumConfig enumConfig)
	{
		CurState = enumConfig;
	}

	private void UpdateStateItem()
	{
		if (activeAtLast)
		{
			ActiveAtLast();
			return;
		}
		foreach (StateEnumItemConfig stateConfig in stateConfigs)
		{
			if (stateConfig == null)
			{
				Log.Error("StateItem引用丢失，请检查！");
			}
			else if (stateConfig.stateId == curState)
			{
				stateConfig.gameObject.SetActive(value: true);
			}
			else
			{
				stateConfig.gameObject.SetActive(value: false);
			}
		}
	}

	private void ActiveAtLast()
	{
		List<int> list = new List<int>();
		for (int i = 0; i < stateConfigs.Count; i++)
		{
			if (!(stateConfigs[i] == null))
			{
				if (stateConfigs[i].stateId == curState)
				{
					list.Add(i);
				}
				else
				{
					stateConfigs[i].gameObject.SetActive(value: false);
				}
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			stateConfigs[list[j]].gameObject.SetActive(value: true);
		}
	}
}

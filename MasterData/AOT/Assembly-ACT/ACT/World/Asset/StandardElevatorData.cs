using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Sound;
using ACT.World.Behave;
using Sirenix.OdinInspector;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class StandardElevatorData : StateWorldAssetData
{
	[SerializeField]
	public List<StandardElevatorLayer> layers = new List<StandardElevatorLayer>();

	[SerializeField]
	private List<RunChangeStateObject> _runStartChangeStateObjects = new List<RunChangeStateObject>();

	[SerializeField]
	private List<RunChangeStateObject> _runStopChangeStateObjects = new List<RunChangeStateObject>();

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	[Header("开始运行音效")]
	private AudioEventReference _audioStartSound;

	[SerializeField]
	[Header("停止运行音效")]
	private AudioEventReference _audioStopSound;

	[SerializeField]
	[Header("运行中循环音效")]
	private AudioEventReference _audioRunLoopSound;

	public ElevBehaveCustomData obstacle;

	public const string ELEVATOR_REF_NAME = "Elevator";

	public const string ELEVATOR_LAYER = "ElevatorLayer";

	public const string ELEVATOR_LAYER_SWUID = "ElevatorLayerSwuid";

	public List<RunChangeStateObject> RunStartChangeStateObjects => _runStartChangeStateObjects;

	public List<RunChangeStateObject> RunStopChangeStateObjects => _runStopChangeStateObjects;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public AudioEventReference AudioStartSound => _audioStartSound;

	public AudioEventReference AudioStopSound => _audioStopSound;

	public AudioEventReference AudioRunLoopSound => _audioRunLoopSound;

	private IEnumerable<ValueDropdownItem<int>> GetInitialStateIds()
	{
		for (int i = 0; i < layers.Count; i++)
		{
			StandardElevatorLayer standardElevatorLayer = layers[i];
			yield return new ValueDropdownItem<int>($"状态 {i} | 实际 {standardElevatorLayer.layerID} 层 | 显示按钮", i);
		}
		for (int i = 0; i < layers.Count; i++)
		{
			StandardElevatorLayer standardElevatorLayer2 = layers[i];
			int num = layers.Count + i;
			yield return new ValueDropdownItem<int>($"状态 {num} | 实际 {standardElevatorLayer2.layerID} 层 | 隐藏按钮", num);
		}
	}

	public int GetLayerIndex(int stateId)
	{
		if (layers.Count != 0)
		{
			return stateId % layers.Count;
		}
		return -1;
	}

	public bool ShouldShowLayerButtons(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId < layers.Count;
		}
		return false;
	}

	public bool ShouldShowButtonsOnArrival(int layerIndex)
	{
		if (layerIndex < 0 || layerIndex >= layers.Count)
		{
			return true;
		}
		StandardElevatorLayer standardElevatorLayer = layers[layerIndex];
		if (!standardElevatorLayer.NeedCheckButtonVisibility)
		{
			return true;
		}
		int num = MonoECS.instance.ruleManager.SharedGetState(standardElevatorLayer.ButtonVisibilityCondition);
		if (ContainsState(standardElevatorLayer.HideButtonStates, num))
		{
			return false;
		}
		ContainsState(standardElevatorLayer.ShowButtonStates, num);
		return true;
	}

	public int GetArrivalStateId(int layerIndex)
	{
		if (!ShouldShowButtonsOnArrival(layerIndex))
		{
			return layers.Count + layerIndex;
		}
		return layerIndex;
	}

	private static bool ContainsState(IReadOnlyList<int> states, int stateId)
	{
		for (int i = 0; i < states.Count; i++)
		{
			if (states[i] == stateId)
			{
				return true;
			}
		}
		return false;
	}
}

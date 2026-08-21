using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class VerityServerFrameData : IReference
{
	private SortedDictionary<int, MsgPlayerInput> _frameInputData = new SortedDictionary<int, MsgPlayerInput>();

	private SortedDictionary<int, SingleBattleFrameMessage> _frameAIData = new SortedDictionary<int, SingleBattleFrameMessage>();

	private bool _isCanExecuteCommand;

	private int _currentTickCommandNumber;

	public SortedDictionary<int, MsgPlayerInput> FrameInputData => _frameInputData;

	public SortedDictionary<int, SingleBattleFrameMessage> FrameAIData => _frameAIData;

	public bool IsCanExecuteCommand => _isCanExecuteCommand;

	public void Clear()
	{
		_isCanExecuteCommand = false;
		_currentTickCommandNumber = 0;
		foreach (MsgPlayerInput value in FrameInputData.Values)
		{
			ReferencePool.Release(value);
		}
		_frameInputData.Clear();
		_frameAIData.Clear();
	}

	public void SetCommandNumber(int number)
	{
		_currentTickCommandNumber = number;
		if (_currentTickCommandNumber == 0)
		{
			_isCanExecuteCommand = true;
		}
	}

	public void SetData(MsgPlayerInput inputData)
	{
		if (!_frameInputData.ContainsKey(inputData.Actor))
		{
			_frameInputData.Add(inputData.Actor, inputData);
			if (_currentTickCommandNumber == _frameInputData.Count)
			{
				_isCanExecuteCommand = true;
			}
		}
	}

	public void SetData(SingleBattleFrameMessage packet)
	{
		MsgPlayerInput msgPlayerInput = ReferencePool.Acquire<MsgPlayerInput>();
		msgPlayerInput.RefreshData(packet, packet.Tick);
		SetData(msgPlayerInput);
		if (!string.IsNullOrEmpty(packet.ParadoxParamKey) && !_frameAIData.ContainsKey(packet.Actor))
		{
			_frameAIData.Add(packet.Actor, packet);
			if (_currentTickCommandNumber == _frameAIData.Count)
			{
				_isCanExecuteCommand = true;
			}
		}
	}
}

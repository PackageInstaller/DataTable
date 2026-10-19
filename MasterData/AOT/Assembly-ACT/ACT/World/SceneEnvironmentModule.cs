using System;
using System.Collections.Generic;
using ACT.World.Asset;
using ACT.World.Modules;

namespace ACT.World;

internal class SceneEnvironmentModule : WorldModuleBase
{
	private EnvironmentElementData _environmentElementData;

	private List<EnvironmentElementData> _environmentElementInfos = new List<EnvironmentElementData>();

	private Action<EnvironmentElementData> _onEnvironmentElementEnter;

	private Action<EnvironmentElementData> _onEnvironmentElementExit;

	private Action<EnvironmentElementData, EnvironmentElementData> _onEnvironmentElementChanged;

	internal override bool NeedGotChunkChange { get; }

	public EnvironmentElementData EnvironmentElementData => _environmentElementData;

	public event Action<EnvironmentElementData> OnEnvironmentElementEnter
	{
		add
		{
			_onEnvironmentElementEnter = (Action<EnvironmentElementData>)Delegate.Combine(_onEnvironmentElementEnter, value);
		}
		remove
		{
			_onEnvironmentElementEnter = (Action<EnvironmentElementData>)Delegate.Remove(_onEnvironmentElementEnter, value);
		}
	}

	public event Action<EnvironmentElementData> OnEnvironmentElementExit
	{
		add
		{
			_onEnvironmentElementExit = (Action<EnvironmentElementData>)Delegate.Combine(_onEnvironmentElementExit, value);
		}
		remove
		{
			_onEnvironmentElementExit = (Action<EnvironmentElementData>)Delegate.Remove(_onEnvironmentElementExit, value);
		}
	}

	public event Action<EnvironmentElementData, EnvironmentElementData> OnEnvironmentElementChanged
	{
		add
		{
			_onEnvironmentElementChanged = (Action<EnvironmentElementData, EnvironmentElementData>)Delegate.Combine(_onEnvironmentElementChanged, value);
		}
		remove
		{
			_onEnvironmentElementChanged = (Action<EnvironmentElementData, EnvironmentElementData>)Delegate.Remove(_onEnvironmentElementChanged, value);
		}
	}

	public void EnterEnvironmentElement(EnvironmentElementData data)
	{
		if (_environmentElementData != data)
		{
			EnvironmentElementData environmentElementData = _environmentElementData;
			_environmentElementData = new EnvironmentElementData(data);
			_onEnvironmentElementChanged?.Invoke(environmentElementData, _environmentElementData);
		}
	}

	public void ExitEnvironmentElement(EnvironmentElementData data)
	{
		_environmentElementInfos.Contains(data);
	}

	private void UpdateEnvironmentElementInfo()
	{
		object environmentElementData;
		if (_environmentElementInfos.Count <= 0)
		{
			environmentElementData = null;
		}
		else
		{
			List<EnvironmentElementData> environmentElementInfos = _environmentElementInfos;
			environmentElementData = environmentElementInfos[environmentElementInfos.Count - 1];
		}
		_environmentElementData = (EnvironmentElementData)environmentElementData;
	}
}

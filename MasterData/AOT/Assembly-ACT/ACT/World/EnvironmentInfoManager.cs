using System.Collections.Generic;
using ACT.World.Function;
using Fundamental;

namespace ACT.World;

public class EnvironmentInfoManager : Singleton<EnvironmentInfoManager>
{
	private List<EnvironmentInfoBase> _environmentInfoColliders;

	private EnvironmentState _environmentState;

	public EnvironmentState environmentState => _environmentState;

	public override void Init()
	{
		_environmentState = EnvironmentState.None;
		if (_environmentInfoColliders == null)
		{
			_environmentInfoColliders = new List<EnvironmentInfoBase>();
		}
	}

	public override void UnInit()
	{
		_environmentInfoColliders.Clear();
	}

	public void AddEnvironmentInfoCollider(EnvironmentInfoBase infoCollider)
	{
		if (!_environmentInfoColliders.Contains(infoCollider))
		{
			_environmentInfoColliders.Add(infoCollider);
			RefershEnvironmentState();
		}
	}

	public void RemoveEnvironmentInfoCollider(EnvironmentInfoBase infoCollider)
	{
		if (_environmentInfoColliders.Contains(infoCollider))
		{
			_environmentInfoColliders.Remove(infoCollider);
			RefershEnvironmentState();
		}
	}

	private void RefershEnvironmentState()
	{
		EnvironmentState environmentState = EnvironmentState.None;
		foreach (EnvironmentInfoBase environmentInfoCollider in _environmentInfoColliders)
		{
			environmentState |= environmentInfoCollider.states;
		}
		_environmentState = environmentState;
	}
}

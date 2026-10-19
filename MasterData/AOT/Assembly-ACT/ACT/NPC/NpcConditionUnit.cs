using System;
using ACT.Condition.Interface;

namespace ACT.NPC;

[Serializable]
public abstract class NpcConditionUnit : ICondition
{
	public bool inverse;

	[NonSerialized]
	public NpcConditionGroup parent;

	protected bool _isPassed;

	public abstract int ConditionId { get; }

	public bool IsPassed
	{
		get
		{
			return _isPassed;
		}
		private set
		{
			if (_isPassed != value)
			{
				_isPassed = value;
				parent?.IsPass();
			}
		}
	}

	public bool IsPass()
	{
		ClearEditorForcedState();
		IsPassed = (inverse ? (!CheckCondition()) : CheckCondition());
		return IsPassed;
	}

	protected abstract bool CheckCondition();

	public abstract void RegisterToConditionModel();

	public abstract void UnRegisterToConditionModel();

	public void ClearCache()
	{
		_isPassed = false;
	}

	private void ClearEditorForcedState()
	{
	}
}

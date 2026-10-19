using UnityEngine;
using UnityEngine.Events;

namespace ACT.NPC.Animation;

public sealed class NpcAnimationRuntime
{
	private Animator _animator;

	private UnityAction<bool> _onConditionValueChanged;

	private bool _conditionBound;

	public NpcAnimationCollection Config { get; }

	public Animator Animator => _animator;

	public NpcAnimationRuntime(NpcAnimationCollection config)
	{
		Config = config;
	}

	public void Bind(Animator animator)
	{
		if (_animator == animator)
		{
			return;
		}
		Unbind();
		if (!animator)
		{
			return;
		}
		_animator = animator;
		NpcCondition npcCondition = Config?.condition;
		if (npcCondition != null)
		{
			if (_onConditionValueChanged == null)
			{
				_onConditionValueChanged = OnConditionValueChanged;
			}
			npcCondition.OnValueChanged += _onConditionValueChanged;
			npcCondition.BindRuntimeContext();
			_conditionBound = true;
			npcCondition.IsPassWithoutCache();
		}
	}

	public void Unbind()
	{
		if (_conditionBound)
		{
			_conditionBound = false;
			NpcCondition npcCondition = Config?.condition;
			if (npcCondition != null)
			{
				npcCondition.OnValueChanged -= _onConditionValueChanged;
				npcCondition.FreeRuntimeContext();
			}
		}
		_animator = null;
	}

	public void ApplyIfConditionPassed()
	{
		if ((bool)_animator && Config != null)
		{
			NpcCondition condition = Config.condition;
			if (condition != null && condition.IsPassWithoutCache())
			{
				Config.ApplyToAnimator(_animator);
			}
		}
	}

	private void OnConditionValueChanged(bool isMet)
	{
		if ((bool)_animator && Config != null)
		{
			if (isMet)
			{
				Config.ApplyToAnimator(_animator);
			}
			else
			{
				Config.ResetOnAnimator(_animator);
			}
		}
	}
}

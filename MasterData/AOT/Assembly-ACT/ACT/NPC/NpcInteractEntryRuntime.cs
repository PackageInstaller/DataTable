using System;
using System.Collections.Generic;
using ACT.NPC.Animation;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.NPC;

public sealed class NpcInteractEntryRuntime
{
	private readonly List<NpcAnimationRuntime> _animationRuntimes = new List<NpcAnimationRuntime>();

	private UnityAction<bool> _onConditionValueChanged;

	private Action<NpcInteractEntryRuntime, bool> _conditionChangedCallback;

	private bool _conditionBound;

	public NpcInteractEntryConfig Config { get; }

	public Entity Owner { get; private set; }

	public NpcInteractEntryRuntime(NpcInteractEntryConfig config)
	{
		Config = config;
		List<NpcAnimationCollection> list = config?.animationCollections;
		if (list == null)
		{
			return;
		}
		foreach (NpcAnimationCollection item in list)
		{
			if (item != null)
			{
				_animationRuntimes.Add(new NpcAnimationRuntime(item));
			}
		}
	}

	public void BindCondition(Entity owner, Action<NpcInteractEntryRuntime, bool> onConditionChanged)
	{
		UnbindCondition();
		Owner = owner;
		_conditionChangedCallback = onConditionChanged;
		NpcCondition npcCondition = Config?.interactEntryCondition;
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

	public void UnbindCondition()
	{
		if (_conditionBound)
		{
			_conditionBound = false;
			NpcCondition npcCondition = Config?.interactEntryCondition;
			if (npcCondition != null)
			{
				npcCondition.OnValueChanged -= _onConditionValueChanged;
				npcCondition.FreeRuntimeContext();
			}
		}
		Owner = default;
		_conditionChangedCallback = null;
	}

	private void OnConditionValueChanged(bool isMet)
	{
		_conditionChangedCallback?.Invoke(this, isMet);
	}

	public bool HasAnimationActions()
	{
		for (int i = 0; i < _animationRuntimes.Count; i++)
		{
			if (_animationRuntimes[i].Config != null)
			{
				return true;
			}
		}
		return false;
	}

	public bool ShouldUseAnimationSnap()
	{
		return Config?.ShouldUseAnimationSnap() ?? true;
	}

	public void BindAnimator(Animator animator)
	{
		for (int i = 0; i < _animationRuntimes.Count; i++)
		{
			_animationRuntimes[i].Bind(animator);
		}
	}

	public void UnbindAnimator()
	{
		for (int i = 0; i < _animationRuntimes.Count; i++)
		{
			_animationRuntimes[i].Unbind();
		}
	}

	public void RestoreAnimatorState(Animator animator)
	{
		for (int i = 0; i < _animationRuntimes.Count; i++)
		{
			NpcAnimationRuntime npcAnimationRuntime = _animationRuntimes[i];
			npcAnimationRuntime.Bind(animator);
			npcAnimationRuntime.ApplyIfConditionPassed();
		}
	}
}

using System.Collections.Generic;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class AbilityDuration
{
	private string _name;

	private Entity _entity;

	private int _characterId;

	private int _maxStackCount;

	private List<float> _durationStack;

	private List<float> _maxDurationStack;

	public int StackCount => _durationStack.Count;

	public AbilityDuration()
	{
		_durationStack = new List<float>();
		_maxDurationStack = new List<float>();
	}

	public void Initialize(string abilityName, int characterId, int maxStackCount, int initialStack, float initialDuration, Entity entity)
	{
		_name = abilityName;
		_characterId = characterId;
		_entity = entity;
		_maxStackCount = maxStackCount;
		_durationStack.Clear();
		_maxDurationStack.Clear();
		for (int i = 0; i < maxStackCount; i++)
		{
			_durationStack.Add((i < initialStack) ? initialDuration : 0f);
			_maxDurationStack.Add(initialDuration);
		}
	}

	public void Reset()
	{
		_name = null;
		_characterId = 0;
		_entity = default;
		_maxStackCount = 0;
		_durationStack.Clear();
		_maxDurationStack.Clear();
	}

	public void SetVal(int index, float newVal)
	{
		if (index >= 0 && index < _maxStackCount)
		{
			_durationStack[index] = newVal;
			if (newVal > _maxDurationStack[index])
			{
				_maxDurationStack[index] = newVal;
			}
			DispatchDurationChangeEvt(index);
		}
	}

	public float GetVal(int index)
	{
		if (index < 0 || index >= _maxStackCount)
		{
			return 0f;
		}
		return _durationStack[index];
	}

	public float GetMaxVal(int index)
	{
		if (index < 0 || index >= _maxStackCount)
		{
			return 0f;
		}
		return _maxDurationStack[index];
	}

	public float GetPercent()
	{
		return _durationStack[StackCount] / _maxDurationStack[StackCount];
	}

	private void DispatchDurationChangeEvt(int index)
	{
		AbilityDurationChangeEvt evt = Singleton<EventManager>.instance.GetEvt<AbilityDurationChangeEvt>();
		evt.characterId = _characterId;
		evt.abilityName = _name;
		evt.curDuration = _durationStack[index];
		evt.maxDuration = _maxDurationStack[index];
		evt.entity = _entity;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Battle_Ability_DurationChange, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}

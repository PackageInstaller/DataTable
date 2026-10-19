using System;
using ACT.Condition.Interface;

namespace ACT.DialogueSystem;

[Serializable]
public abstract class BaseCondition : ICondition
{
	public abstract bool Check();

	public abstract BaseCondition Clone();

	public abstract bool IsPass();
}
[Serializable]
public abstract class BaseCondition<T> : BaseCondition where T : BaseCondition<T>, new()
{
	public sealed override BaseCondition Clone()
	{
		T val = new T();
		OnClone(val);
		return val;
	}

	public virtual void OnClone(T clone)
	{
	}
}

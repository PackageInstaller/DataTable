using System;

namespace Unity.VisualScripting;

public abstract class Cloner<T> : ICloner
{
	public abstract bool Handles(Type type);

	void ICloner.BeforeClone(Type type, object original)
	{
		BeforeClone(type, (T)original);
	}

	public virtual void BeforeClone(Type type, T original)
	{
	}

	object ICloner.ConstructClone(Type type, object original)
	{
		return ConstructClone(type, (T)original);
	}

	public virtual T ConstructClone(Type type, T original)
	{
		return (T)Activator.CreateInstance(type, nonPublic: true);
	}

	void ICloner.FillClone(Type type, ref object clone, object original, CloningContext context)
	{
		T clone2 = (T)clone;
		FillClone(type, ref clone2, (T)original, context);
		clone = clone2;
	}

	public virtual void FillClone(Type type, ref T clone, T original, CloningContext context)
	{
	}

	void ICloner.AfterClone(Type type, object clone)
	{
		AfterClone(type, (T)clone);
	}

	public virtual void AfterClone(Type type, T clone)
	{
	}
}

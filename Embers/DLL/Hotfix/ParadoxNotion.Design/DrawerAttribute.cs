using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public abstract class DrawerAttribute : Attribute
{
	public virtual int priority => int.MaxValue;

	public virtual bool isDecorator => false;
}

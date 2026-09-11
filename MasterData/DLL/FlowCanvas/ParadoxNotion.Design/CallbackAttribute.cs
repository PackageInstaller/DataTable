using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class CallbackAttribute : DrawerAttribute
{
	public readonly string methodName;

	public override int priority => 2;

	public CallbackAttribute(string methodName)
	{
		this.methodName = methodName;
	}
}

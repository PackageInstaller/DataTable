using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class CallbackAttribute : DrawerAttribute
{
	public readonly string methodName;

	public override bool isDecorator => true;

	public override int priority => 4;

	public CallbackAttribute(string methodName)
	{
		this.methodName = methodName;
	}
}

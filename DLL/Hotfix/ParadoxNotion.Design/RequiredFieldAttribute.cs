using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class RequiredFieldAttribute : DrawerAttribute
{
	public override bool isDecorator => false;

	public override int priority => 2;
}

using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class DimIfDefaultAttribute : DrawerAttribute
{
	public override bool isDecorator => true;

	public override int priority => 0;
}

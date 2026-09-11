using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class RequiredFieldAttribute : DrawerAttribute
{
	public override int priority => 1;
}

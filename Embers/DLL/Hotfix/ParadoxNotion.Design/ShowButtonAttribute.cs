using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class ShowButtonAttribute : DrawerAttribute
{
	public readonly string buttonTitle;

	public readonly string methodName;

	public override bool isDecorator => true;

	public override int priority => 3;

	public ShowButtonAttribute(string buttonTitle, string methodnameCallback)
	{
		this.buttonTitle = buttonTitle;
		methodName = methodnameCallback;
	}
}

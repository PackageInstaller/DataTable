using System;

namespace ParadoxNotion.Design;

[AttributeUsage(AttributeTargets.Field)]
public class ShowButtonAttribute : DrawerAttribute
{
	public readonly string buttonTitle;

	public readonly string methodnameCallback;

	public ShowButtonAttribute(string buttonTitle, string methodnameCallback)
	{
		this.buttonTitle = buttonTitle;
		this.methodnameCallback = methodnameCallback;
	}
}

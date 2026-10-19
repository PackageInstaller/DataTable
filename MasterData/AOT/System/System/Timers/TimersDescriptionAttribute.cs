using System.ComponentModel;

namespace System.Timers;

[AttributeUsage(AttributeTargets.All)]
public class TimersDescriptionAttribute : DescriptionAttribute
{
	private bool replaced;

	public override string Description
	{
		get
		{
			if (!replaced)
			{
				replaced = true;
				DescriptionValue = SR.GetString(base.Description);
			}
			return base.Description;
		}
	}

	public TimersDescriptionAttribute(string description)
		: base(description)
	{
	}
}

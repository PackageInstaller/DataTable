using System;

[Flags]
public enum HoverAnimStateFlag
{
	Idle = 1,
	Hover = 2,
	Click = 4,
	ClickIdle = 8
}

using System;

namespace ACT.Event;

[Obsolete]
public class CustomInteractEvent : BaseEventContent
{
	public int swid;

	public VarName eventName;
}

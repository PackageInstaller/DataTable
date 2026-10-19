using System.Collections.Generic;
using ACT.BluePrint;
using Unity.VisualScripting;

namespace ACT.Event;

public class LocalizedStringValue
{
	[Inspectable]
	public LocalizedStringParams _Key;

	[Inspectable]
	public List<string> _ValueList;
}

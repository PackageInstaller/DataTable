using System.Collections.Generic;
using Unity.VisualScripting;

namespace ACT.Event;

[Inspectable]
public class LocalizedStringData : BaseEventContent
{
	[Inspectable]
	public List<LocalizedStringValue> _stringKeyList;
}

using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Support.Internal.IDefinedEventTriggerUnit")]
internal interface IDefinedEventTriggerNode
{
	List<ValueInput> inputPorts { get; }
}

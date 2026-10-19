using System.Collections.Generic;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.DefinedEvents.Support.Internal.IDefinedEventUnit")]
internal interface IDefinedEventNode
{
	List<ValueOutput> outputPorts { get; }
}

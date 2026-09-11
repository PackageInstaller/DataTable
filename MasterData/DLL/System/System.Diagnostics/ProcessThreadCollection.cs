using System.Collections;
using System.Reflection;

namespace System.Diagnostics;

[DefaultMember("Item")]
public class ProcessThreadCollection : ReadOnlyCollectionBase
{
	public ProcessThreadCollection(ProcessThread[] processThreads)
	{
		base.InnerList.AddRange(processThreads);
	}
}

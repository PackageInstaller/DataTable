using System.Collections;

namespace System.Diagnostics;

public class ProcessModuleCollection : ReadOnlyCollectionBase
{
	public ProcessModule this[int index] => (ProcessModule)base.InnerList[index];

	public ProcessModuleCollection(ProcessModule[] processModules)
	{
		base.InnerList.AddRange(processModules);
	}
}

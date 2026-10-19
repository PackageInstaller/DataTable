using System.Collections;

namespace System.Diagnostics;

public class ProcessModuleCollection : ReadOnlyCollectionBase
{
	public ProcessModule this[int index] => (ProcessModule)InnerList[index];

	public ProcessModuleCollection(ProcessModule[] processModules)
	{
		InnerList.AddRange(processModules);
	}
}

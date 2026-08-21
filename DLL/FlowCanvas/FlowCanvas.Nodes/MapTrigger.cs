using System.Collections.Generic;
using NodeCanvas.Framework;

namespace FlowCanvas.Nodes;

public class MapTrigger
{
	public int id;

	public List<FlowScriptController> flowScripts;

	public IBlackboard blackboard;

	public List<string> types;
}

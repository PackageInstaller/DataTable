using System;
using System.Collections.Generic;

[Serializable]
public class EntityData
{
	public string name;

	public string prefab;

	public int id;

	public string blackboard;

	public byte[] binBlackboard;

	public List<FlowScriptMeta> flowScript = new List<FlowScriptMeta>();
}

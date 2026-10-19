using System;

namespace ACT.Config;

[Serializable]
public class MissionConditionActionEnum
{
	public readonly int id;

	public readonly string desc = "";

	public readonly string paramDesc = "";

	public readonly bool serverTrigger;

	public readonly string editorShowName = "";

	public MissionConditionActionEnum(int id, string desc, string paramDesc, bool serverTrigger, string editorShowName)
	{
		this.id = id;
		this.desc = desc;
		this.paramDesc = paramDesc;
		this.serverTrigger = serverTrigger;
		this.editorShowName = editorShowName;
	}
}

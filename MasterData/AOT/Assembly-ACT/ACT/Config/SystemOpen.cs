using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class SystemOpen
{
	public readonly int id;

	public readonly int localNameId;

	public readonly int missionId;

	public readonly List<ItemKv> preconditionParam;

	public readonly int openTime;

	public readonly int descriptionBefore;

	public readonly int descriptionAfter;

	public readonly int iconId;

	public readonly bool isNeedAnimal;

	public readonly bool systemUnlockPrompts;

	public readonly string redPoint = "";

	public SystemOpen(int id, int localNameId, int missionId, List<ItemKv> preconditionParam, int openTime, int descriptionBefore, int descriptionAfter, int iconId, bool isNeedAnimal, bool systemUnlockPrompts, string redPoint)
	{
		this.id = id;
		this.localNameId = localNameId;
		this.missionId = missionId;
		this.preconditionParam = preconditionParam;
		this.openTime = openTime;
		this.descriptionBefore = descriptionBefore;
		this.descriptionAfter = descriptionAfter;
		this.iconId = iconId;
		this.isNeedAnimal = isNeedAnimal;
		this.systemUnlockPrompts = systemUnlockPrompts;
		this.redPoint = redPoint;
	}
}

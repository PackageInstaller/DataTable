using System;

namespace ACT.Config;

[Serializable]
public class RogueTableStageCard
{
	public readonly int id;

	public readonly int stageCardName;

	public readonly int icon;

	public readonly string tableCloth = "";

	public readonly int stageCardDesc;

	public readonly string idEnvironmentEffect = "";

	public readonly int[] stageCardNameparm = new int[0];

	public RogueTableStageCard(int id, int stageCardName, int icon, string tableCloth, int stageCardDesc, string idEnvironmentEffect, int[] stageCardNameparm)
	{
		this.id = id;
		this.stageCardName = stageCardName;
		this.icon = icon;
		this.tableCloth = tableCloth;
		this.stageCardDesc = stageCardDesc;
		this.idEnvironmentEffect = idEnvironmentEffect;
		this.stageCardNameparm = stageCardNameparm;
	}
}

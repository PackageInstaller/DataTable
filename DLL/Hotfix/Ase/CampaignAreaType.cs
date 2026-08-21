using System.ComponentModel;

namespace Ase;

public enum CampaignAreaType
{
	None,
	[Description("建筑")]
	Building,
	[Description("指挥部任务")]
	Task,
	[Description("精英怪物")]
	EliteMonster,
	[Description("领主怪物")]
	LordMonster,
	[Description("世界Boss")]
	WorldBoss
}

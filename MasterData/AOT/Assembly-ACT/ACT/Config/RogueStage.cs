using System;

namespace ACT.Config;

[Serializable]
public class RogueStage
{
	public readonly int id;

	public readonly int name;

	public readonly int stageTicket;

	public readonly int unlockPrecondition;

	public readonly int banner;

	public readonly int relicLimit;

	public readonly int stepGroup;

	public readonly int seasonGroup;

	public readonly int tableStageEffect;

	public readonly int StageEffectGroup;

	public readonly int BuffGroup;

	public RogueStage(int id, int name, int stageTicket, int unlockPrecondition, int banner, int relicLimit, int stepGroup, int seasonGroup, int tableStageEffect, int StageEffectGroup, int BuffGroup)
	{
		this.id = id;
		this.name = name;
		this.stageTicket = stageTicket;
		this.unlockPrecondition = unlockPrecondition;
		this.banner = banner;
		this.relicLimit = relicLimit;
		this.stepGroup = stepGroup;
		this.seasonGroup = seasonGroup;
		this.tableStageEffect = tableStageEffect;
		this.StageEffectGroup = StageEffectGroup;
		this.BuffGroup = BuffGroup;
	}
}

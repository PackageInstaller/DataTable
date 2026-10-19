using System;

namespace ACT.Config;

[Serializable]
public class MissionDetail
{
	public readonly int id;

	public readonly int[] acceptCondition = new int[0];

	public readonly int acceptConditionOrAnd;

	public readonly int[] acceptAction = new int[0];

	public readonly int acceptActionMode;

	public readonly int[][] finishCondition = new int[0][];

	public readonly int[] finishConditionOrAnd = new int[0];

	public readonly int[][] conditionFinishAction = new int[0][];

	public readonly int[] conditionFinishActionMode = new int[0];

	public readonly int[] failureCondition = new int[0];

	public readonly int failureConditionOrAnd;

	public readonly int[] failureAction = new int[0];

	public readonly int failureActionMode;

	public readonly string flow = "";

	public MissionDetail(int id, int[] acceptCondition, int acceptConditionOrAnd, int[] acceptAction, int acceptActionMode, int[][] finishCondition, int[] finishConditionOrAnd, int[][] conditionFinishAction, int[] conditionFinishActionMode, int[] failureCondition, int failureConditionOrAnd, int[] failureAction, int failureActionMode, string flow)
	{
		this.id = id;
		this.acceptCondition = acceptCondition;
		this.acceptConditionOrAnd = acceptConditionOrAnd;
		this.acceptAction = acceptAction;
		this.acceptActionMode = acceptActionMode;
		this.finishCondition = finishCondition;
		this.finishConditionOrAnd = finishConditionOrAnd;
		this.conditionFinishAction = conditionFinishAction;
		this.conditionFinishActionMode = conditionFinishActionMode;
		this.failureCondition = failureCondition;
		this.failureConditionOrAnd = failureConditionOrAnd;
		this.failureAction = failureAction;
		this.failureActionMode = failureActionMode;
		this.flow = flow;
	}
}

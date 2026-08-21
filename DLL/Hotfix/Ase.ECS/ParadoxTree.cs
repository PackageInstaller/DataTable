using NodeCanvas.BehaviourTrees;
using NodeCanvas.Framework;

namespace Ase.ECS;

public class ParadoxTree : BaseParadox
{
	public BehaviourTreeOwner tree;

	public override void Execute()
	{
		base.Execute();
		tree.StartBehaviour(Finish);
	}

	public override void Pause()
	{
		if (!(tree == null))
		{
			tree.graph?.Pause();
		}
	}

	public override void Resume()
	{
		if (!(tree == null))
		{
			tree.graph?.Resume();
		}
	}

	public override void UpdateGraph(float deltaTime, float frozenSpeed)
	{
		tree.TickTime = deltaTime;
		tree.FrozenSpeed = frozenSpeed;
		tree.UpdateBehaviour();
	}

	public override void SetVariableValue<T>(string key, T data)
	{
		if (!(tree == null) && tree.blackboard != null)
		{
			tree.blackboard.SetVariableValue(key, data);
		}
	}

	public override T GetVariableValues<T>(string key)
	{
		if (tree == null || tree.blackboard == null)
		{
			return default(T);
		}
		return tree.blackboard.GetVariableValue<T>(key);
	}

	public override void Finish(bool finish)
	{
		if (!(tree == null))
		{
			endAction?.Invoke(finish);
			treePlayEnd?.Invoke(this);
		}
	}

	protected override void DoStop(bool isExecuteStopLogic = true)
	{
		base.DoStop(isExecuteStopLogic);
		if (tree != null)
		{
			tree.StopBehaviour(success: true, isExecuteStopLogic, OnStopIsReleaseAssets);
			tree.blackboard?.RefreshVariables();
		}
	}

	public override void RefreshBlack()
	{
		base.RefreshBlack();
		if (tree != null)
		{
			tree.blackboard?.RefreshVariables();
		}
	}

	public override void Clear()
	{
		base.Clear();
		tree = null;
	}
}

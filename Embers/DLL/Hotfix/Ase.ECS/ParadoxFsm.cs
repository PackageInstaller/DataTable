using NodeCanvas.Framework;
using NodeCanvas.StateMachines;

namespace Ase.ECS;

public class ParadoxFsm : BaseParadox
{
	public FSMOwner fsm;

	public override void Execute()
	{
		base.Execute();
		fsm?.StartBehaviour(Finish);
		if (!(fsm.graph == null))
		{
			fsm.graph.InitReferencesBlackboardCopyVariables();
		}
	}

	public override void Pause()
	{
		if (!(fsm == null))
		{
			fsm.graph?.Pause();
		}
	}

	public override void Resume()
	{
		if (!(fsm == null))
		{
			fsm.graph?.Resume();
		}
	}

	public override void UpdateGraph(float deltaTime, float frozenSpeed)
	{
		fsm.TickTime = deltaTime;
		fsm.FrozenSpeed = frozenSpeed;
		fsm.UpdateBehaviour();
	}

	public override void SetVariableValue<T>(string key, T data)
	{
		if (!(fsm == null) && fsm.blackboard != null)
		{
			fsm.blackboard.SetVariableValue(key, data);
		}
	}

	public override T GetVariableValues<T>(string key)
	{
		if (fsm == null || fsm.blackboard == null)
		{
			return default(T);
		}
		return fsm.blackboard.GetVariableValue<T>(key);
	}

	public override void Finish(bool finish)
	{
		if (!(fsm == null))
		{
			endAction?.Invoke(finish);
			treePlayEnd?.Invoke(this);
		}
	}

	protected override void DoStop(bool isExecuteStopLogic = true)
	{
		base.DoStop(isExecuteStopLogic);
		if (fsm != null)
		{
			fsm.StopBehaviour(success: true, isExecuteStopLogic, OnStopIsReleaseAssets);
			fsm.blackboard?.RefreshVariables();
			if (fsm.graph != null)
			{
				fsm.graph.RefreshReferencesBlackboard();
			}
		}
	}

	public override void RefreshBlack()
	{
		base.RefreshBlack();
		if (fsm != null)
		{
			fsm.blackboard?.RefreshVariables();
			if (fsm.graph != null)
			{
				fsm.graph.RefreshReferencesBlackboard();
			}
		}
	}

	public override void Clear()
	{
		base.Clear();
		fsm = null;
	}
}

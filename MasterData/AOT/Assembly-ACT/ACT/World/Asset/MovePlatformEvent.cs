using ACT.Battle;
using ACT.World.Behave;
using ACT.World.StateObject;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.Asset;

public class MovePlatformEvent : EventActionBase
{
	public StateWorldUid tarSwid = int.MinValue;

	public int startState;

	public int endState;

	public Pos endPos;

	private int m_CurrPoint;

	private InteractElevator m_Elevator;

	private Transform m_CacheTran => m_Elevator.transform;

	public override void Enter(BehaveControlBaseBehaveEvent behave)
	{
		base.Enter(behave);
		m_CurrPoint = 0;
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(tarSwid, out var asset);
		m_Elevator = asset.stateObjectBase as InteractElevator;
	}

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		int currentStateId = m_Elevator.currentStateId;
		switch (m_CurrPoint)
		{
		case 0:
			if (currentStateId == startState && m_Elevator.elevator.phase == 0)
			{
				behave.SetTarPos(m_CacheTran.position);
				if (behave.RefreshMove())
				{
					m_CurrPoint++;
				}
			}
			else
			{
				behave.StopMove();
			}
			break;
		case 1:
			if (currentStateId == endState && m_Elevator.elevator.phase == 0)
			{
				behave.SetTarPos(endPos);
				return behave.RefreshMove();
			}
			behave.StopMove();
			break;
		}
		return Mathf.Abs(behave.Entity.GetCompTransform().physicsPosition.y - endPos.value.y) < 1f;
	}

	public override void Exit(BehaveControlBaseBehaveEvent behave)
	{
		base.Exit(behave);
		m_CurrPoint = 0;
	}
}

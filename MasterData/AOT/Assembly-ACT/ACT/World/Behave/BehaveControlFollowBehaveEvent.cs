using ACT.Battle;
using ACT.World.Asset;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/BehaveControlFollowBehaveEvent")]
public class BehaveControlFollowBehaveEvent : InteractControlBaseBehaveEvent
{
	private FollowBehaveConfig m_FollowBehaveConfig;

	private Entity m_TarEntity;

	private BehaveControlHandleBehaveEvent m_TarHandle;

	private float distance => m_FollowBehaveConfig.tpDistance;

	public override void Init(int state)
	{
		base.Init(state);
		m_FollowBehaveConfig = data.behaveConfig as FollowBehaveConfig;
		MonoECS.instance.ruleManager.TryGetWorldStateAsset(m_FollowBehaveConfig.tarSwid, out var asset);
		InteractBehaveControl interactBehaveControl = asset.stateObjectBase as InteractBehaveControl;
		m_TarEntity = interactBehaveControl.ControlEb;
		m_TarHandle = interactBehaveControl.behave as BehaveControlHandleBehaveEvent;
	}

	public override void RefreshRunState(int state)
	{
		base.RefreshRunState(state);
		if (state == 1)
		{
			RefreshTarPos();
		}
	}

	public override void FinishRun()
	{
		base.FinishRun();
		StopMove();
	}

	public override bool HandleBehaveEvent()
	{
		if (m_TarHandle == null)
		{
			return false;
		}
		RefreshTarPos();
		if (Vector2.Distance(endPos, Entity.GetCompTransform().physicsPosition) > distance)
		{
			Entity.Teleport(new Vector3(endPos.x + StopDistance, endPos.y, Entity.GetCompTransform().physicsPosition.z), testCollision: true);
		}
		if ((m_TarHandle.interactBehaveControl.currentStateId == 2 || m_TarHandle.interactBehaveControl.currentStateId == -1) && RefreshMove())
		{
			FinishRun();
		}
		if (!base.HandleBehaveEvent())
		{
			return false;
		}
		if (m_TarHandle.isHaveCharacter && !m_TarHandle.isHaveMonster)
		{
			m_FollowBehaveConfig.monsterExitAndCharacterEnter?.Handle(this);
			RefreshMove();
			return false;
		}
		m_FollowBehaveConfig.monsterEnterOrCharacterExit?.Handle(this);
		StopMove();
		return true;
	}

	public override void RefreshTarPos()
	{
		if (!(m_TarHandle == null))
		{
			SetTarPos(m_TarEntity.GetCompTransform().physicsPosition);
		}
	}
}

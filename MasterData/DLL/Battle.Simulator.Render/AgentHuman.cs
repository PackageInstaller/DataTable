using System;
using Config;
using UnityEngine;

public class AgentHuman : NAgent
{
	private bool IsAliveInternal = true;

	[HideInInspector]
	public ComponentPlayerSound SoundEffectComponent { get; protected set; }

	[HideInInspector]
	public ComponentSkillLauncher skillLauncher { get; set; }

	[HideInInspector]
	public ComponentEnemyView ComponentEnemyView { get; private set; }

	[HideInInspector]
	public ComponentHealth HealthComponent { get; protected set; }

	[HideInInspector]
	public ComponentCrawlState ComponentCrawlState { get; protected set; }

	public override bool IsAlive => IsAliveInternal;

	public override bool IsVisible => true;

	public override bool IsInvulnerable => false;

	public override Vector3 ChestPosition => base.Transform.position + base.transform.up * 1.5f;

	public RoleTalkPanel RoleTalkPanel { get; set; }

	public override bool IsEnemy(NAgent target)
	{
		return false;
	}

	public override void Spawn(EntitySpawnedEvent data)
	{
		IsAliveInternal = true;
		IsLocalPlayer = data.mIsPlayer;
		base.AgentHeight = 2f;
		Blackboard = U3DUtil.Get<BBHumanoid>(base.gameObject);
		Blackboard.HeroGuid = data.mGuid;
		Blackboard.Initialize();
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(data.mConfigId);
		RoleRenderConfig role = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().GetRole(data.mConfigId);
		BBHumanoid obj = Blackboard as BBHumanoid;
		obj.RoleLogicConfig = config;
		obj.RoleRenderConfig = role;
		obj.IdleID = config.Idle;
		obj.RelaxID = config.RelaxID;
		obj.BattleIdleID = config.BattleIdle;
		base.AgentConfigID = data.mConfigId;
		base.AgentSkinID = data.mSkinID;
		BBCommom blackboard = Blackboard;
		blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(handleAction));
		HealthComponent = U3DUtil.Get<ComponentHealth>(base.gameObject);
		HealthComponent.HpStripCount = data.hpStripCount;
		base.ComponentTimeline = U3DUtil.Get<ComponentTimeline>(base.gameObject);
		base.ComponentTimeline.m_componentPendant = U3DUtil.Get<ComponentPendant>(base.gameObject);
		base.AttachPointSetup = base.gameObject.GetComponent<AttachPointSetup>();
		ComponentCrawlState = U3DUtil.Get<ComponentCrawlState>(base.gameObject);
		if (IsLocalPlayer)
		{
			base.ComponentTimeline.m_componentIndicator = U3DUtil.Get<ComponentIndicator>(base.gameObject);
		}
		else
		{
			ComponentEnemyView = U3DUtil.Get<ComponentEnemyView>(base.gameObject);
			ComponentIndicator component = base.gameObject.GetComponent<ComponentIndicator>();
			if (component != null)
			{
				UnityEngine.Object.DestroyImmediate(component);
			}
		}
		base.Initialize();
	}

	private void handleAction(AgentAction action)
	{
		if (!(action is AgentActionHurt))
		{
			_ = action is AgentActionDead;
		}
	}

	public override void ShowModel(bool show)
	{
	}

	public override void ResetAgent()
	{
		RoleTalkPanel = null;
		IsLocalPlayer = false;
		IsAliveInternal = false;
		base.ResetAgent();
	}
}

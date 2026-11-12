using System;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

[RequireComponent(typeof(InteractiveNpc))]
public class NPCAdventureActor : AdventureActor
{
	public AdventureLevelObjPoolMgr.PoolObj spawnPoolObj;

	private InteractiveNpc interactiveNPC;

	private TriggerCom[] triggerComs;

	public int npcID { get; private set; }

	protected override void OnInit()
	{
		base.OnInit();
		DeterministicCollider deterministicCollider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		if (dtCollider != null)
		{
			dtCollider.collisionListener = this;
		}
		SetupComponents();
		InitializePrimeState();
		InitializeVisual();
		gameObject.layer = 8;
		if (dtCollider != null)
		{
			dtCollider.layer = 10;
		}
		dtCollider.priority = 4;
		dtCollider.IgnoreCollision = false;
		_smooth = AddOrGetMonoLogicComponent<VisualSmooth>();
		interactiveNPC = GetComponent<InteractiveNpc>();
		triggerComs = GetComponents<TriggerCom>();
	}

	protected override void OnActive()
	{
		ActorScaleInfo actorScaleInfo = base.actorScaleInfo;
		actorScaleInfo.onModelScaleChagned = (Action)Delegate.Combine(actorScaleInfo.onModelScaleChagned, new Action(OnModelScaleChanged));
		ActorScaleInfo actorScaleInfo2 = base.actorScaleInfo;
		actorScaleInfo2.onColliderScalerChanged = (Action)Delegate.Combine(actorScaleInfo2.onColliderScalerChanged, new Action(OnColliderScaleChanged));
	}

	protected override void OnDeactive()
	{
		ActorScaleInfo actorScaleInfo = base.actorScaleInfo;
		actorScaleInfo.onModelScaleChagned = (Action)Delegate.Remove(actorScaleInfo.onModelScaleChagned, new Action(OnModelScaleChanged));
		ActorScaleInfo actorScaleInfo2 = base.actorScaleInfo;
		actorScaleInfo2.onColliderScalerChanged = (Action)Delegate.Remove(actorScaleInfo2.onColliderScalerChanged, new Action(OnColliderScaleChanged));
		TriggerCom[] array = triggerComs;
		if (array != null && array.Length > 0)
		{
			for (int i = 0; i < triggerComs.Length; i++)
			{
				Singleton<TriggerManager>.Instance?.SetTrigger(triggerComs[i], iAdd: false);
			}
		}
	}

	public void SyncNPCInfo(NPCConfig npcConfig, NPCSkin skin)
	{
		npcID = npcConfig.Id;
		if (null != interactiveNPC)
		{
			interactiveNPC._npcID = npcID;
			interactiveNPC.npcSkin = skin;
			interactiveNPC.SyncPosition(transform.position);
			MonoSingleton<LuaManager>.Instance.FireEvent("LevelNpcSpawned", Id, npcID, transform);
		}
		TriggerCom[] array = triggerComs;
		if (array != null && array.Length > 0)
		{
			for (int i = 0; i < triggerComs.Length; i++)
			{
				triggerComs[i].RestState();
				Singleton<TriggerManager>.Instance.SetTrigger(triggerComs[i], iAdd: true);
			}
		}
		actorScaleInfo = AddOrGetLogicComponent<ActorScaleInfo>();
		actorScaleInfo.originModelScale = FP.FromMyriad(skin.ModelScale);
		actorScaleInfo.modelScale = actorScaleInfo.originModelScale;
		actorScaleInfo.originColliderScale = FP.FromMyriad(skin.ModelScale);
		actorScaleInfo.colliderScale = actorScaleInfo.originColliderScale;
		SetupVisualComponents((float)dtCollider.Radius, (float)dtCollider.ColliderHeight);
	}

	public virtual void Recycle()
	{
		if (GroupId != null)
		{
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(GroupId)?.RemoveMember(this);
		}
		if (spawnPoolObj == null)
		{
			Debug.LogError("回收角色时poolObj为空");
			return;
		}
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_Player(spawnPoolObj);
		spawnPoolObj = null;
	}

	protected override void SetupVisualComponents(float visibleRadius, float visibleHeight)
	{
		base.SetupVisualComponents(visibleRadius, visibleHeight);
		visualControl.SetupBasicActorVisualComponents(visibleRadius, visibleHeight);
		visualControl.occlusionRendererOccludee.occlusionVisibleDetectEnabled = false;
	}
}

using System;
using System.Collections.Generic;
using Config;
using UnityEngine;

public class AgentManager : IGameModule
{
	private class IntComparer : IEqualityComparer<int>
	{
		public bool Equals(int x, int y)
		{
			return x == y;
		}

		public int GetHashCode(int obj)
		{
			return obj;
		}
	}

	private class UIntComparer : IEqualityComparer<uint>
	{
		public bool Equals(uint x, uint y)
		{
			return x == y;
		}

		public int GetHashCode(uint obj)
		{
			return (int)obj;
		}
	}

	public Dictionary<int, NAgent> mAgentsCreatedThisFrame = new Dictionary<int, NAgent>(100, new IntComparer());

	private Dictionary<int, NAgent> mAgentsRemovedThisFrame = new Dictionary<int, NAgent>(100, new IntComparer());

	private Dictionary<uint, List<NAgent>> mAgentTypeTable = new Dictionary<uint, List<NAgent>>(100, new UIntComparer());

	private List<NAgent> mAllEntities = new List<NAgent>(100);

	public int mPlayerAgentID;

	public int mFirstAgentID;

	public int mSecondAgentID;

	public int mThirdAgentID;

	public List<int> mPlayerList = new List<int>(10);

	public Dictionary<MemberPosition, int> mMemberSeats = new Dictionary<MemberPosition, int>();

	public SimStateFrame stateFrame;

	public static OnVoidHandler<EntitySpawnedEvent> SpawnHandler;

	public static OnVoidHandler<NAgent, EntitySpawnedEvent> OnSpawnHandler;

	public static OnVoidHandler<EntityDespawnedEvent, NAgent> OnDesSpawnHandler;

	public Action<int, int, int> TransfigurationRenderEvent;

	public Action<PlayHitEffectData> BeforePlayHitEffect;

	private List<int> mThisFrameMembers = new List<int>(100);

	private EntityDespawnedEvent _mEntityDespawnedEvent = new EntityDespawnedEvent();

	private EntitySpawnedEvent _mEntitySpawnedEvent = new EntitySpawnedEvent();

	public List<NAgent> Entities => mAllEntities;

	public Action<int, int, int> OnTimelinePlay { get; set; }

	public Action<int, int, int, int> OnTimelineTick { get; set; }

	public Action<int, AnimationEvent> OnCustomAnimationEvent { get; set; }

	public Action<int> ModifySkillButtonUIDataEvent { get; set; }

	public void Initialize()
	{
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntityDespawnedEvent>(OnUnitDespawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntitySpawnedEvent>(OnSimUnitSpawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<EntityEquipWeaponEvent>(OnEquipWeaponInSim);
		ClientSimulator.Instance.GetSimToPresentation().AddHandler<PlayerChangeEvent>(OnPlayerChange);
	}

	private void OnPlayerChange(PlayerChangeEvent eventReceived)
	{
		int mToEntity = eventReceived.mToEntity;
		NAgent agent = GetAgent(mToEntity);
		if (!(agent == null))
		{
			NAgent playerAgent = GetPlayerAgent();
			if (!eventReceived.mMorePlayerAgent)
			{
				playerAgent.IsLocalPlayer = false;
			}
			mPlayerAgentID = mToEntity;
			agent.IsLocalPlayer = true;
			BattleUI battleUI = BattleUI.GetBattleUI();
			battleUI.BattleTalkPanel.OnPlayerChange(agent, playerAgent);
			battleUI.GradeUI.OnMainPlayerUpdate(agent);
			battleUI.PlayerInfoUI.OnMainPlayerUpdate(agent);
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.virtualCameraParam != null && battleScene.virtualCameraParam.virtualCamera != null && battleScene.virtualCameraParam.targetGroup != null)
			{
				battleScene.virtualCameraParam.virtualCamera.Follow = agent.transform;
				battleScene.virtualCameraParam.targetGroup.m_Targets[0].target = agent.transform;
			}
		}
	}

	private void OnSimUnitSpawnedInSim(EntitySpawnedEvent ev)
	{
		if (ev.mIsPlayer)
		{
			mPlayerAgentID = ev.NewEntity;
		}
		switch (ev.mRolePosition)
		{
		case MemberPosition.First:
			mFirstAgentID = ev.NewEntity;
			break;
		case MemberPosition.Second:
			mSecondAgentID = ev.NewEntity;
			break;
		case MemberPosition.Third:
			mThirdAgentID = ev.NewEntity;
			break;
		}
		if (ev.mRolePosition != MemberPosition.None && !mPlayerList.Contains(ev.NewEntity))
		{
			mPlayerList.Add(ev.NewEntity);
			mMemberSeats[ev.mRolePosition] = ev.NewEntity;
		}
		if (SpawnHandler != null)
		{
			SpawnHandler(ev);
		}
	}

	private void OnEquipWeaponInSim(EntityEquipWeaponEvent eventReceived)
	{
	}

	private void OnUnitDespawnedInSim(EntityDespawnedEvent ev)
	{
		NAgent value = null;
		if (mAgentsCreatedThisFrame.TryGetValue(ev.DestroyedEntity, out value))
		{
			if (OnDesSpawnHandler != null)
			{
				OnDesSpawnHandler(ev, value);
			}
			value.Despawn(ev);
			mAllEntities.Remove(value);
			mAgentsCreatedThisFrame.Remove(ev.DestroyedEntity);
			List<NAgent> value2 = null;
			if (mAgentTypeTable.TryGetValue(value.Camp, out value2))
			{
				value2.Remove(value);
			}
		}
		if (mPlayerList.Contains(ev.DestroyedEntity))
		{
			mPlayerList.Remove(ev.DestroyedEntity);
		}
	}

	public void JoinAgent(NAgent go, EntitySpawnedEvent ev)
	{
		mAgentsCreatedThisFrame.Add(ev.NewEntity, go);
		mAllEntities.Add(go);
		List<NAgent> value = null;
		uint camp = RoleCampProcessor.GetCamp(ev.mAgentCamp);
		if (mAgentTypeTable.TryGetValue(camp, out value))
		{
			mAgentTypeTable[camp].Add(go);
		}
		else
		{
			mAgentTypeTable.Add(camp, new List<NAgent>());
			mAgentTypeTable[camp].Add(go);
		}
		go.transform.position = (Vector3)ev.mSpawnPoint;
		go.transform.forward = (Vector3)ev.mSpawnForward;
		go.Spawn(ev);
		if (OnSpawnHandler != null)
		{
			OnSpawnHandler(go, ev);
		}
	}

	public NAgent GetAgent(int agentID)
	{
		NAgent value = null;
		mAgentsCreatedThisFrame.TryGetValue(agentID, out value);
		return value;
	}

	public List<NAgent> GetCampAgent(uint camp)
	{
		mAgentTypeTable.TryGetValue(camp, out var value);
		return value;
	}

	public NAgent GetAgentByMemberPostion(MemberPosition seat)
	{
		if (mMemberSeats.TryGetValue(seat, out var value))
		{
			return GetAgent(value);
		}
		return null;
	}

	public NAgent GetPlayerAgent()
	{
		NAgent value = null;
		if (mPlayerAgentID > 0)
		{
			mAgentsCreatedThisFrame.TryGetValue(mPlayerAgentID, out value);
		}
		return value;
	}

	public int GetAgentIDByMemberPosition(MemberPosition memberPosition)
	{
		return memberPosition switch
		{
			MemberPosition.First => mFirstAgentID, 
			MemberPosition.Second => mSecondAgentID, 
			MemberPosition.Third => mThirdAgentID, 
			_ => 0, 
		};
	}

	public MemberPosition GetMemberPositionByAgentID(int agentID)
	{
		if (agentID == mFirstAgentID)
		{
			return MemberPosition.First;
		}
		if (agentID == mSecondAgentID)
		{
			return MemberPosition.Second;
		}
		if (agentID == mThirdAgentID)
		{
			return MemberPosition.Third;
		}
		return MemberPosition.None;
	}

	public static AgentManager GetAgentManager()
	{
		if (SceneDirector.Instance == null)
		{
			return null;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene == null)
		{
			return null;
		}
		if (battleScene.GetBattleSimulatorSystem() == null)
		{
			return null;
		}
		return battleScene.GetAgentManager();
	}

	public bool ChangeAgent(NAgent agent, int newRoleID)
	{
		int agentID = agent.AgentID;
		BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
		if (bBHumanoid == null || bBHumanoid.m_LastSimFrameData == null || bBHumanoid.m_NextSimFrameData == null)
		{
			return false;
		}
		long hP = bBHumanoid.HP;
		long maxHP = bBHumanoid.MaxHP;
		int mEntityConfigID = bBHumanoid.m_LastSimFrameData.mEntityConfigID;
		_mEntityDespawnedEvent.DestroyedEntity = agentID;
		_mEntitySpawnedEvent.NewEntity = agentID;
		_mEntitySpawnedEvent.mIsPlayer = agent.IsLocalPlayer;
		_mEntitySpawnedEvent.mAgentCamp = agent.Camp;
		_mEntitySpawnedEvent.mConfigId = newRoleID;
		Skin config = ConfigHelper.GetInstance().GetConfig<Skin>(agent.AgentSkinID);
		if (config != null && config.Transfiguration != 0)
		{
			_mEntitySpawnedEvent.mSkinID = config.Transfiguration;
		}
		else
		{
			_mEntitySpawnedEvent.mSkinID = newRoleID;
		}
		MemberPosition mRolePosition = MemberPosition.None;
		WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
		if (worldStateManager != null)
		{
			mRolePosition = worldStateManager.GetMemberPosition(agentID);
		}
		_mEntitySpawnedEvent.mRolePosition = mRolePosition;
		_mEntitySpawnedEvent.mSpawnType = E_SpawnType.ROLE;
		_mEntitySpawnedEvent.hpStripCount = (agent as AgentHuman).HealthComponent.HpStripCount;
		_mEntitySpawnedEvent.mSpawnPoint = (Int3)agent.Position;
		_mEntitySpawnedEvent.mSpawnForward = (Int3)agent.Forward;
		if (OnDesSpawnHandler != null)
		{
			OnDesSpawnHandler(_mEntityDespawnedEvent, agent);
		}
		agent.Despawn(_mEntityDespawnedEvent);
		mAllEntities.Remove(agent);
		mAgentsCreatedThisFrame.Remove(_mEntityDespawnedEvent.DestroyedEntity);
		List<NAgent> value = null;
		if (mAgentTypeTable.TryGetValue(agent.Camp, out value))
		{
			value.Remove(agent);
		}
		if (SpawnHandler != null)
		{
			SpawnHandler(_mEntitySpawnedEvent);
		}
		mAgentsCreatedThisFrame.TryGetValue(agentID, out var value2);
		if (TransfigurationRenderEvent != null)
		{
			TransfigurationRenderEvent(agentID, mEntityConfigID, newRoleID);
		}
		bBHumanoid = value2.Blackboard as BBHumanoid;
		bBHumanoid.m_NextSimFrameData.HP = hP;
		bBHumanoid.m_NextSimFrameData.MaxHP = maxHP;
		return true;
	}

	public void UpdateLogic(SimStateFrame stateFrame)
	{
		if (stateFrame == null)
		{
			return;
		}
		this.stateFrame = stateFrame;
		int count = stateFrame.AllEntityStates.Count;
		mThisFrameMembers.Clear();
		for (int i = 0; i < count; i++)
		{
			if (stateFrame.AllEntityStates[i] is UnitState { mLocalFlag: not false })
			{
				continue;
			}
			int entityID = stateFrame.AllEntityStates[i].EntityID;
			if (!mThisFrameMembers.Contains(entityID))
			{
				mThisFrameMembers.Add(entityID);
				NAgent value = null;
				if (mAgentsCreatedThisFrame.TryGetValue(entityID, out value))
				{
					value.StartUpdateAgentLogic();
				}
			}
		}
		for (int j = 0; j < count; j++)
		{
			int entityID2 = stateFrame.AllEntityStates[j].EntityID;
			if (!(stateFrame.AllEntityStates[j] is UnitState { mLocalFlag: not false }))
			{
				NAgent value2 = null;
				if (mAgentsCreatedThisFrame.TryGetValue(entityID2, out value2))
				{
					value2.Blackboard.FrameCount = stateFrame.FrameNumber;
					value2.Blackboard.IsPrediction = stateFrame.IsPrediction;
					value2.UpdateAgentLogic(stateFrame.AllEntityStates[j]);
					value2.LateUpdateAgentLogic(stateFrame.AllEntityStates[j]);
				}
			}
		}
		for (int k = 0; k < mThisFrameMembers.Count; k++)
		{
			int key = mThisFrameMembers[k];
			NAgent value3 = null;
			if (!mAgentsCreatedThisFrame.TryGetValue(key, out value3))
			{
				continue;
			}
			value3.EndUpdateAgentLogic();
			BBHumanoid bBHumanoid = value3.Blackboard as BBHumanoid;
			if (!(bBHumanoid == null) && bBHumanoid.m_LastSimFrameData != null && bBHumanoid.m_NextSimFrameData != null)
			{
				int mEntityConfigID = bBHumanoid.m_LastSimFrameData.mEntityConfigID;
				int num = ((bBHumanoid.m_NextSimFrameData.mNewRoleID != 0) ? bBHumanoid.m_NextSimFrameData.mNewRoleID : bBHumanoid.m_NextSimFrameData.mEntityConfigID);
				if (mEntityConfigID != num && mEntityConfigID != 0)
				{
					ChangeAgent(value3, num);
				}
			}
		}
		mThisFrameMembers.Clear();
	}

	public void FixedUpdate()
	{
		for (int i = 0; i < mAllEntities.Count; i++)
		{
			mAllEntities[i].FixedUpdateAgent();
		}
	}

	public void Update()
	{
		for (int i = 0; i < mAllEntities.Count; i++)
		{
			mAllEntities[i].UpdateAgent();
		}
	}

	public void LateUpdate()
	{
		for (int i = 0; i < mAllEntities.Count; i++)
		{
			mAllEntities[i].LateUpdateAgent();
		}
	}

	public void Reset()
	{
		mAgentsCreatedThisFrame.Clear();
		mAgentsRemovedThisFrame.Clear();
		mAllEntities.Clear();
		mPlayerList.Clear();
	}

	public void Shutdown()
	{
		Dictionary<int, NAgent>.Enumerator enumerator = mAgentsCreatedThisFrame.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator.Current.Value != null)
			{
				enumerator.Current.Value.Despawn(null);
			}
		}
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntityDespawnedEvent>(OnUnitDespawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntitySpawnedEvent>(OnSimUnitSpawnedInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<EntityEquipWeaponEvent>(OnEquipWeaponInSim);
		ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<PlayerChangeEvent>(OnPlayerChange);
		mAgentsCreatedThisFrame.Clear();
		mAgentsRemovedThisFrame.Clear();
		mAllEntities.Clear();
		mAgentsCreatedThisFrame = null;
		mAgentsRemovedThisFrame = null;
		mAllEntities = null;
		SpawnHandler = null;
		OnSpawnHandler = null;
		OnDesSpawnHandler = null;
		BeforePlayHitEffect = null;
		OnTimelinePlay = null;
		OnTimelineTick = null;
		TransfigurationRenderEvent = null;
	}
}

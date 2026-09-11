public sealed class EntitySpawnedEvent : NEventBase, IPostToSimulation, IPostToPreliminaryPresentation
{
	public enum SimUnitReadyState
	{
		SpawnedInWorld
	}

	public bool mNeedRVO;

	public bool mIsPlayer;

	public bool mLockWhenNotMoving;

	public MemberPosition mRolePosition = MemberPosition.None;

	public Int3 mSpawnPoint;

	public Int3 mSpawnForward;

	public Int3 mSpawnSize;

	public uint mAgentCamp;

	public int mConfigId;

	public int mGuid;

	public long mPlayerID;

	public E_SpawnType mSpawnType;

	public ProtoEntityData mTriggerData;

	public int AIID;

	public int hpStripCount;

	public int mSkinID;

	public int NewEntity { get; set; }

	public SimUnitReadyState State { get; set; }

	public EntitySpawnedEvent()
	{
	}

	public EntitySpawnedEvent(int newEntity, uint agentCamp, SimUnitReadyState state, bool needRVO, Int3 spawnPoint, Int3 spawnForward, bool lockWhenNotMoving, int mConfigId, bool isPlayer, long playerID, int hpStripCount, int skinID)
	{
		NewEntity = newEntity;
		State = state;
		mNeedRVO = needRVO;
		mSpawnPoint = spawnPoint;
		mSpawnForward = spawnForward;
		mAgentCamp = agentCamp;
		this.mConfigId = mConfigId;
		mSpawnType = E_SpawnType.ROLE;
		mLockWhenNotMoving = lockWhenNotMoving;
		mIsPlayer = isPlayer;
		mPlayerID = playerID;
		this.hpStripCount = hpStripCount;
		mSkinID = skinID;
	}

	public EntitySpawnedEvent(int newEntity, Int3 spawnPoint, Int3 spawnForward, Int3 spawnSize, E_SpawnType spawnType = E_SpawnType.AIR_WALL)
	{
		NewEntity = newEntity;
		mSpawnPoint = spawnPoint;
		mSpawnForward = spawnForward;
		mSpawnType = spawnType;
		mSpawnSize = spawnSize;
	}

	public EntitySpawnedEvent(int newEntity, uint agentCamp, Int3 spawnPoint, Int3 spawnForward, E_SpawnType spawnType = E_SpawnType.THROWN)
	{
		NewEntity = newEntity;
		mSpawnPoint = spawnPoint;
		mSpawnForward = spawnForward;
		mSpawnType = spawnType;
	}

	public static EntitySpawnedEvent Claim(int newEntity, uint agentCamp, SimUnitReadyState state, bool needRVO, Int3 spawnPoint, Int3 spawnForward, bool lockWhenNotMoving, int mConfigId, bool isPlayer, long playerID, int hpStripCount, int skinID)
	{
		EntitySpawnedEvent entitySpawnedEvent = FrameObjectPool<EntitySpawnedEvent>.Claim();
		entitySpawnedEvent.NewEntity = newEntity;
		entitySpawnedEvent.State = state;
		entitySpawnedEvent.mNeedRVO = needRVO;
		entitySpawnedEvent.mSpawnPoint = spawnPoint;
		entitySpawnedEvent.mSpawnForward = spawnForward;
		entitySpawnedEvent.mAgentCamp = agentCamp;
		entitySpawnedEvent.mConfigId = mConfigId;
		entitySpawnedEvent.mSpawnType = E_SpawnType.ROLE;
		entitySpawnedEvent.mLockWhenNotMoving = lockWhenNotMoving;
		entitySpawnedEvent.mIsPlayer = isPlayer;
		entitySpawnedEvent.mPlayerID = playerID;
		entitySpawnedEvent.hpStripCount = hpStripCount;
		entitySpawnedEvent.mSkinID = skinID;
		return entitySpawnedEvent;
	}

	public static EntitySpawnedEvent ClaimTrigger(int newEntity, ProtoEntityData triggerData)
	{
		EntitySpawnedEvent entitySpawnedEvent = FrameObjectPool<EntitySpawnedEvent>.Claim();
		entitySpawnedEvent.NewEntity = newEntity;
		entitySpawnedEvent.mSpawnType = E_SpawnType.TRIGGER;
		entitySpawnedEvent.mTriggerData = triggerData;
		entitySpawnedEvent.mRolePosition = MemberPosition.None;
		return entitySpawnedEvent;
	}

	public override void Release()
	{
		mAgentCamp = 0u;
		mRolePosition = MemberPosition.None;
	}

	public override void OnEnterPool()
	{
		FrameObjectPool<EntitySpawnedEvent>.Release(this);
	}
}

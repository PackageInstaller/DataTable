using Config;
using Google.Protobuf;

public class CreateUnitCommand : Command
{
	public Int3 mSpawnPoint;

	public Int3 mSpawnDirection;

	public bool mIsRVO;

	public SimShapeType mShapeType;

	public RoleType mCamp;

	public override int Opcode => 0;

	public override void ReleaseCommand()
	{
	}

	public CreateUnitCommand(int commanderID, Int3 spawnPoint, bool isRVO, SimShapeType shapeType, RoleType camp)
		: base(commanderID)
	{
		mSpawnPoint = spawnPoint;
		mIsRVO = isRVO;
		mShapeType = shapeType;
		mCamp = camp;
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity simEntity = mSimContext.CreateEntity();
		XLogger.Debug("创建生成@" + simEntity.isEnabled);
		uint roleCamp = 0u;
		RoleType layer = mCamp;
		switch (mCamp)
		{
		case RoleType.Player:
			RoleCampProcessor.Set(ref roleCamp, 1u);
			break;
		case RoleType.Enemy:
			RoleCampProcessor.Set(ref roleCamp, 2u);
			break;
		case RoleType.Neutral:
			RoleCampProcessor.Set(ref roleCamp, 4u);
			break;
		}
		simEntity.AddEntityPositon(mSpawnPoint, new Int3(0, 0, 1), 0, new Int3(0, 1, 0), newIsTeleport: false);
		RoleConfig roleConfig = simEntity.entityConfig.mConfig as RoleConfig;
		switch (mShapeType)
		{
		case SimShapeType.Box:
			simEntity.AddEntityShape(Int3.zero, ShapePartType.Body, SimShapeProcessor.CreateSimBox(simEntity.creationIndex, mSpawnPoint, new Int3(1000, 200, 200), Int3.forward, layer), roleCamp, roleConfig.Weight, default(ShapePartInfo));
			break;
		case SimShapeType.Sphere:
			simEntity.AddEntityShape(Int3.zero, ShapePartType.Body, SimShapeProcessor.CreateSimSphere(simEntity.creationIndex, mSpawnPoint, 500, 200, Int3.forward, layer), roleCamp, roleConfig.Weight, default(ShapePartInfo));
			break;
		case SimShapeType.CylinderSector:
			simEntity.AddEntityShape(Int3.zero, ShapePartType.Body, null, roleCamp, roleConfig.Weight, default(ShapePartInfo));
			break;
		}
		simEntity.AddEntityCamp(roleCamp);
		XLogger.Debug("创建生成事件@" + frameNum);
		mSimContext.PostEvent(EntitySpawnedEvent.Claim(simEntity.creationIndex, simEntity.entityCamp.mRoleTypeCamp, EntitySpawnedEvent.SimUnitReadyState.SpawnedInWorld, mIsRVO, mSpawnPoint, simEntity.entityPositon.mForward, lockWhenNotMoving: false, 1, isPlayer: true, 0L, 1, 0));
		return true;
	}

	protected override void OnRead(CodedInputStream stream)
	{
	}

	protected override bool OnValidateAgainstFrame()
	{
		return true;
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return false;
	}
}

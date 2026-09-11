using System;
using Config;
using Google.Protobuf;

public class SubJoystickCommand : Command
{
	public int mTimelineID;

	public int mCommandCode;

	public override int Opcode => 120;

	public override void ReleaseCommand()
	{
		mTimelineID = 0;
		mCommandCode = 0;
		FrameObjectPool<SubJoystickCommand>.Release(this);
	}

	public override bool RunCommand(long frameNum)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(mOwner);
		if (entityWithEntityID == null)
		{
			return false;
		}
		if (entityWithEntityID.hasEntityActionSubJoystick)
		{
			entityWithEntityID.ReplaceEntityActionSubJoystick(mCommandCode, mTimelineID);
		}
		else
		{
			entityWithEntityID.AddEntityActionSubJoystick(mCommandCode, mTimelineID);
		}
		if (entityWithEntityID.hasEntityBlackboard && entityWithEntityID.hasEntityPositon)
		{
			Int3 point = CommandCodeToLocalPosition(mCommandCode, mTimelineID);
			entityWithEntityID.entityBlackboard.var.mBeaconPosition = IntMath.Transform(point, entityWithEntityID.entityPositon.mForward, entityWithEntityID.entityPositon.mPosition);
			entityWithEntityID.entityBlackboard.var.mBeaconForward = entityWithEntityID.entityPositon.mForward;
		}
		return true;
	}

	public override bool RunPredictionCommand(long frameNum)
	{
		return false;
	}

	public void SetData(int entityID, int code, int timelineID)
	{
		mOwner = entityID;
		mCommandCode = code;
		mTimelineID = timelineID;
	}

	protected override void OnWrite(CodedOutputStream stream)
	{
		stream.WriteInt32(mCommandCode);
		stream.WriteInt32(mTimelineID);
	}

	protected override void OnRead(CodedInputStream stream)
	{
		mCommandCode = stream.ReadInt32();
		mTimelineID = stream.ReadInt32();
	}

	protected override bool OnValidateAgainstFrame()
	{
		throw new NotImplementedException();
	}

	public static int PositionToCommandCode(Int3 center, Int3 forward, Int3 aimPosition, int timelineID)
	{
		Int3 @int = IntMath.InvertTransfrom(aimPosition, forward, center);
		Int3 int2 = @int;
		int i = IntMath.AngleOfVector(int2.NormalizeTo(1000)).i;
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(timelineID);
		int range = config.Range;
		int num = 1000;
		if (@int.sqrMagnitude < (float)(range * range))
		{
			num = (int)((float)num * (@int.magnitude / (float)range));
		}
		return BuildCommandCode(i, num);
	}

	public static Int3 CommandCodeToLocalPosition(int code, int timelineID)
	{
		TryParseCommandCode(code, out var angle, out var rate);
		return SubJoystickParamsToLocalPosition(angle, rate, timelineID);
	}

	public static Int3 SubJoystickParamsToLocalPosition(int angle, int rate, int timelineID)
	{
		public_skill config = ConfigHelper.GetInstance().GetConfig<public_skill>(timelineID);
		return IntMath.VectorOfAngle(new Int(angle)).NormalizeTo(IntMath.Divide(config.Range * rate, 1000));
	}

	public static int BuildCommandCode(int angle, int rate)
	{
		return (angle << 12) | (rate << 2);
	}

	public static bool TryParseCommandCode(int commandCode, out int angle, out int rate)
	{
		angle = commandCode >> 12;
		rate = (commandCode >> 2) & 0x3FF;
		return true;
	}
}

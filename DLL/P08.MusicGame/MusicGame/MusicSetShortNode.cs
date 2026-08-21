using UnityEngine;

namespace MusicGame;

public class MusicSetShortNode : BaseNode
{
	private int _round;

	public void StartNode(int round, int mEndTime)
	{
		_round = round;
		reachTime = mEndTime;
	}

	public void NormalTrack(int currentTime)
	{
		float y = (float)(reachTime - currentTime) * MusicSetController.nodeSpeed;
		base.transform.localPosition = new Vector3(0f, y, 0f);
	}

	private void ConstantTrack(int currentTime)
	{
		float positionConstant = MusicSetController.context.GetPositionConstant(currentTime, reachTime);
		base.transform.localPosition = new Vector3(0f, positionConstant, 0f);
	}

	private void ConstantNewTrack(int currentTime)
	{
		float mixRange = MusicSetController.mixRange;
		float num = MusicSetController.context.GetPositionConstant(currentTime, reachTime);
		if (num > 0f)
		{
			num = (1f - mixRange) * num + mixRange * (float)(reachTime - currentTime) * MusicSetController.nodeSpeed;
		}
		base.transform.localPosition = new Vector3(0f, num, 0f);
	}

	public override void Process(int currentTime)
	{
		if (MusicSetController.trackType == MusicTrackType.Constant_Slope)
		{
			ConstantNewTrack(currentTime);
		}
		else
		{
			NormalTrack(currentTime);
		}
	}

	public override bool Check(int currentTime, int musicLength)
	{
		if (reachTime + MusicSetController.goodArea < currentTime)
		{
			MusicSetTrack.MusicNodeHit(MusicNodeHitRating.Miss, MusicNodeHitType.None);
			return true;
		}
		return false;
	}

	public override NodeType GetNodeType()
	{
		return NodeType.Short;
	}
}

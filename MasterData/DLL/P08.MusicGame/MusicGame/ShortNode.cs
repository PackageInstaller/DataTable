using UnityEngine;

namespace MusicGame;

internal class ShortNode : BaseNode
{
	public void StartNode(int endTime)
	{
		reachTime = endTime;
	}

	private void NormalTrack(int currentTime)
	{
		float y = MusicController.GetNodePosition(reachTime) - MusicController.GetNodePosition(currentTime);
		base.transform.localPosition = new Vector3(0f, y, 0f);
	}

	private void ConstantTrack(int currentTime)
	{
		float newPositionConstant = MusicController.GetNewPositionConstant(currentTime, reachTime);
		base.transform.localPosition = new Vector3(0f, newPositionConstant, 0f);
	}

	public override void Process(int currentTime)
	{
		if (MusicController.isConstant)
		{
			ConstantTrack(currentTime);
		}
		else
		{
			NormalTrack(currentTime);
		}
	}

	public override bool Check(int currentTime, int musicLength)
	{
		if (reachTime + MusicController.goodArea < currentTime || currentTime > musicLength + MusicController.goodArea)
		{
			Track.MusicNodeHit(MusicNodeHitRating.Miss, MusicNodeHitType.None);
			return true;
		}
		return false;
	}

	public override NodeType GetNodeType()
	{
		return NodeType.Short;
	}
}

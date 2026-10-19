using ACT.Game.Data;
using UnityEngine;

namespace ACT.Model;

public sealed class BloodstainData
{
	public string BloodstainId;

	public long OwnerPlayerUid;

	public int ChunkId;

	public Vector3 Position;

	public Quaternion Rotation;

	public long CreateTs;

	public BloodstainState State;

	public bool ClaimedByLocalPlayer;

	public BloodstainData Clone()
	{
		return new BloodstainData
		{
			BloodstainId = BloodstainId,
			OwnerPlayerUid = OwnerPlayerUid,
			ChunkId = ChunkId,
			Position = Position,
			Rotation = Rotation,
			CreateTs = CreateTs,
			State = State,
			ClaimedByLocalPlayer = ClaimedByLocalPlayer
		};
	}
}

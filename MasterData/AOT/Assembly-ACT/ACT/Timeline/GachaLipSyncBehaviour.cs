using UnityEngine.Playables;
using uLipSync;

namespace ACT.Timeline;

public sealed class GachaLipSyncBehaviour : PlayableBehaviour
{
	public GachaLipSyncClip asset;

	public BakedFrame frame { get; private set; } = BakedFrame.zero;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (asset == null || asset.bakedData == null)
		{
			frame = BakedFrame.zero;
		}
		else
		{
			frame = asset.bakedData.GetFrame((float)playable.GetTime() + asset.timeOffset);
		}
	}
}

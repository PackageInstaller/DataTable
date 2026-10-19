using System.Linq;
using ACT.Battle.Configs;
using ACT.Model;
using Runtime.Model;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class BattleTimeline : TimelineBase
{
	public uint battleTimelineAssetId;

	public override YooAssetReference AssetReferenceAssetID => ConfigBattleTimeline.Instance.battleTimelineItems.FirstOrDefault((BattleTimelineItem x) => x.id == battleTimelineAssetId).timeLineReferenceAssetID;

	public override int Id => (int)battleTimelineAssetId;

	public override PlayableDirector GetTimelineObject()
	{
		return Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(AssetReferenceAssetID);
	}

	public override void ReleaseTimelineObject()
	{
		Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(AssetReferenceAssetID);
	}
}

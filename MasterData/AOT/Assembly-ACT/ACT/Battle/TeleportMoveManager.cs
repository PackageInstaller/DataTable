using ACT.Model;
using ACT.UI;
using Bamboo.Precache;
using Fundamental;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Battle;

public class TeleportMoveManager : Singleton<TeleportMoveManager>
{
	public Vector3 PathCenter { get; private set; }

	public Vector3 SitPosition { get; private set; }

	public int Swid { get; private set; }

	public bool TimelineRespawnAndTpMove { get; private set; }

	public bool IsWebberCabinFlow { get; private set; }

	public bool ForcePathCenterSync { get; private set; }

	public override void Init()
	{
		base.Init();
		IsWebberCabinFlow = false;
		PrecacheManager.Instance.Preload(GameLoader.meta.TeleportMoveInteractTimeline.GUID);
		PrecacheManager.Instance.Preload(GameLoader.meta.TeleportMoveTpAndRespawnTimeline.GUID);
	}

	public void SetData(Vector3 pathCenter, Vector3 sitPosition, int swid)
	{
		Swid = swid;
		PathCenter = pathCenter;
		SitPosition = sitPosition;
	}

	public void SetForcePathCenterSync(bool force)
	{
		ForcePathCenterSync = force;
	}

	public void BeginWebberCabinFlow()
	{
		IsWebberCabinFlow = true;
	}

	public void EndWebberCabinFlow()
	{
		IsWebberCabinFlow = false;
	}

	public void PlayRespawnAndTpMoveTimeline()
	{
		TimelineRespawnAndTpMove = false;
		Singleton<NewUIManager>.instance.BlackScreen.SetBlackScreen(1f);
		PlayableDirector timeline = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(GameLoader.meta.TeleportMoveTpAndRespawnTimeline);
		timeline.gameObject.transform.position = PathCenter;
		timeline.Play();
		timeline.stopped += SetTimelineRespawnAndTpMove;
		void SetTimelineRespawnAndTpMove(PlayableDirector obj)
		{
			timeline.stopped -= SetTimelineRespawnAndTpMove;
			TimelineRespawnAndTpMove = true;
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(GameLoader.meta.TeleportMoveTpAndRespawnTimeline);
		}
	}

	public void RespawnAndTpMoveTimelineComplete()
	{
		TimelineRespawnAndTpMove = false;
	}

	public void PlayInteractTimeline()
	{
		PlayableDirector timeline = Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(GameLoader.meta.TeleportMoveInteractTimeline);
		timeline.gameObject.transform.position = PathCenter;
		timeline.Play();
		timeline.stopped += SetTimelineInteract;
		void SetTimelineInteract(PlayableDirector obj)
		{
			timeline.stopped -= SetTimelineInteract;
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(GameLoader.meta.TeleportMoveInteractTimeline);
		}
	}
}

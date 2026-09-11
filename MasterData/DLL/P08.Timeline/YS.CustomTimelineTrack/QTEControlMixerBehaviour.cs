using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class QTEControlMixerBehaviour : PlayableBehaviour
{
	public Dictionary<string, double> markerClips;

	private PlayableDirector pd;

	public override void OnPlayableCreate(Playable playable)
	{
		pd = playable.GetGraph().GetResolver() as PlayableDirector;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		int inputCount = playable.GetInputCount();
		for (int i = 0; i < inputCount; i++)
		{
			float inputWeight = playable.GetInputWeight(i);
			QTEControlNodeBehaviour behaviour = ((ScriptPlayable<QTEControlNodeBehaviour>)playable.GetInput(i)).GetBehaviour();
			if (!(inputWeight > 0f))
			{
				continue;
			}
			if (behaviour.nodeType == QTEControlNode.ENodeType.Activator)
			{
				if (behaviour.isActiveSubGameObject && !string.IsNullOrEmpty(behaviour.activeSubGameObjectName) && (behaviour.subTimelineCache == null || !behaviour.subTimelineCache.activeSelf) && pd != null)
				{
					Transform transform = pd.transform.Find(behaviour.activeSubGameObjectName);
					if (transform != null)
					{
						behaviour.subTimelineCache = transform.gameObject;
						behaviour.subTimelineCache.SetActive(value: true);
					}
				}
			}
			else
			{
				if (behaviour.nodeType != QTEControlNode.ENodeType.Processor)
				{
					continue;
				}
				bool flag = false;
				if (behaviour.compareType == EQTECompare.Equal)
				{
					flag = QTEContext.GetInstance().status == behaviour.compareToStatus;
				}
				else if (behaviour.compareType == EQTECompare.NotEqual)
				{
					flag = QTEContext.GetInstance().status != behaviour.compareToStatus;
				}
				if (!flag)
				{
					continue;
				}
				if (behaviour.canJump)
				{
					switch (behaviour.jumpType)
					{
					case EJumpType.ByMarker:
					{
						double time = markerClips[behaviour.markerToJumpto];
						pd.time = time;
						break;
					}
					case EJumpType.ByFrame:
						pd.time = (double)behaviour.frameToJumpto / 30.0;
						break;
					case EJumpType.ByTime:
						pd.time = behaviour.timeToJumpto;
						break;
					}
				}
				if (behaviour.isInactiveSubGameObject)
				{
					Transform transform2 = pd.transform.Find(behaviour.inactiveSubGameObjectName);
					if (transform2 != null)
					{
						transform2.gameObject.SetActive(value: false);
					}
				}
				if (behaviour.isActiveSubGameObjectWhenPass)
				{
					Transform transform3 = pd.transform.Find(behaviour.activeSubGameObjectNameWhenPass);
					if (transform3 != null)
					{
						transform3.gameObject.SetActive(value: true);
					}
				}
			}
		}
	}
}

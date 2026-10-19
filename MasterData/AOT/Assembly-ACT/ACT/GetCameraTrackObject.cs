using System;
using ACT.Battle;
using ACT.Game;
using ACT.Utility;
using Bamboo.ECS;
using Cinemachine;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public class GetCameraTrackObject : GetTrackObjectBase
{
	public override void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = null;
		if (!(type == typeof(CinemachineBrain)))
		{
			return;
		}
		trackObject = pd.GetGenericBinding(pb.sourceObject);
		if (trackObject == null)
		{
			trackObject = CinemachineCore.Instance.GetActiveBrain(0);
		}
		pd.Play();
		CinemachineTrack cinemachineTrack = pb.sourceObject as CinemachineTrack;
		if (cinemachineTrack != null)
		{
			ICinemachineCamera activeVirtualCamera = GameUtility.mainCamera.GetComponent<CinemachineBrain>().ActiveVirtualCamera;
			foreach (TimelineClip clip in cinemachineTrack.GetClips())
			{
				CinemachineShot cinemachineShot = clip.asset as CinemachineShot;
				if (!(cinemachineShot != null))
				{
					continue;
				}
				if (cinemachineShot.VirtualCamera.defaultValue == null)
				{
					cinemachineShot.VirtualCamera.defaultValue = activeVirtualCamera as CinemachineVirtualCameraBase;
					continue;
				}
				CinemachineVirtualCameraBase cinemachineVirtualCameraBase = cinemachineShot.VirtualCamera.Resolve(pd.playableGraph.GetResolver());
				if (cinemachineVirtualCameraBase == null || string.IsNullOrEmpty(trackData))
				{
					continue;
				}
				bool flag = int.TryParse(trackData, out var result);
				Transform transform = null;
				if (flag)
				{
					if (result != 0)
					{
						Entity entity = default;
						if (result == -1)
						{
							entity = MonoECS.instance.mainEntity;
						}
						else
						{
							EntityHelper.TryGetBattleEntityByCharacter(G.localPlayer.GetCharacter(result), out entity);
						}
						if (entity.IsValid)
						{
							transform = entity.GetRootTransform();
						}
					}
				}
				else
				{
					GameObject gameObject = GameObject.Find(trackData);
					if (gameObject != null)
					{
						transform = gameObject.transform;
					}
				}
				if (transform != null)
				{
					if (cinemachineVirtualCameraBase.LookAt == null)
					{
						cinemachineVirtualCameraBase.LookAt = transform;
					}
					if (cinemachineVirtualCameraBase.Follow == null)
					{
						cinemachineVirtualCameraBase.Follow = transform;
					}
				}
			}
		}
		pd.Pause();
	}
}

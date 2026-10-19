using System;
using System.Collections.Generic;
using ACT;
using ACT.Battle;
using ACT.Game;
using ACT.Utility;
using Bamboo.ECS;
using Cinemachine;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class OldTimelineTrackBinding
{
	public static void SetTrackBinding(PlayableDirector pd, Dictionary<string, string> trackBindingAssets)
	{
		Dictionary<string, (PlayableBinding, int)> dictionary = new Dictionary<string, (PlayableBinding, int)>();
		int num = 0;
		foreach (PlayableBinding output in pd.playableAsset.outputs)
		{
			if (trackBindingAssets.ContainsKey(output.streamName) && !dictionary.ContainsKey(output.streamName))
			{
				dictionary.Add(output.streamName, (output, num));
			}
			if (output.streamName != "Markers")
			{
				num++;
			}
		}
		foreach (KeyValuePair<string, string> trackBindingAsset in trackBindingAssets)
		{
			if (!string.IsNullOrEmpty(trackBindingAsset.Value) && dictionary.TryGetValue(trackBindingAsset.Key, out var value))
			{
				UnityEngine.Object assetObject = GetAssetObject(pd, value.Item1, trackBindingAsset.Value, value.Item2);
				pd.SetGenericBinding(value.Item1.sourceObject, assetObject);
			}
		}
	}

	private static UnityEngine.Object GetAssetObject(PlayableDirector pd, PlayableBinding pb, string value, int outputIndex)
	{
		Type outputTargetType = pb.outputTargetType;
		UnityEngine.Object obj = pd.GetGenericBinding(pb.sourceObject);
		int result = 0;
		if (outputTargetType == typeof(CinemachineBrain))
		{
			ICinemachineCamera activeVirtualCamera = GameUtility.mainCamera.GetComponent<CinemachineBrain>().ActiveVirtualCamera;
			if (obj == null)
			{
				obj = CinemachineCore.Instance.GetActiveBrain(0);
			}
			pd.Play();
			foreach (TimelineClip clip in (pb.sourceObject as CinemachineTrack).GetClips())
			{
				CinemachineShot cinemachineShot = clip.asset as CinemachineShot;
				if (cinemachineShot.VirtualCamera.defaultValue == null)
				{
					cinemachineShot.VirtualCamera.defaultValue = activeVirtualCamera as CinemachineVirtualCameraBase;
					continue;
				}
				CinemachineVirtualCameraBase cinemachineVirtualCameraBase = cinemachineShot.VirtualCamera.Resolve(pd.playableGraph.GetResolver());
				if (cinemachineVirtualCameraBase == null)
				{
					continue;
				}
				string target = cinemachineVirtualCameraBase.target;
				if (string.IsNullOrEmpty(target))
				{
					continue;
				}
				bool flag = int.TryParse(target, out result);
				Transform transform = null;
				if (flag)
				{
					Entity entity = default;
					if (result == 0)
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
				else
				{
					GameObject gameObject = GameObject.Find(target);
					if (gameObject == null)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogError("没有找到名字为" + target + "的物体");
						}
						return null;
					}
					transform = gameObject.transform;
				}
				if (cinemachineVirtualCameraBase.LookAt == null)
				{
					cinemachineVirtualCameraBase.LookAt = transform;
				}
				if (cinemachineVirtualCameraBase.Follow == null)
				{
					cinemachineVirtualCameraBase.Follow = transform;
				}
			}
			pd.Pause();
		}
		if (int.TryParse(value, out result))
		{
			if (result == -1)
			{
				return obj;
			}
			string text = pb.streamName.ToUpper();
			Entity entity2 = default;
			if (result == 0)
			{
				entity2 = MonoECS.instance.mainEntity;
			}
			else if (result == 10000 || text.Contains("ROBOT"))
			{
				entity2 = MonoECS.instance.localPlayer.robotEntity;
			}
			else if (text.Contains("PLAYER"))
			{
				EntityHelper.TryGetBattleEntityByCharacter(G.localPlayer.GetCharacter(result), out entity2);
			}
			if (outputTargetType == typeof(CinemachineBrain))
			{
				if (!entity2.IsValid)
				{
					return obj;
				}
				pd.Play();
				Transform rootTransform = entity2.GetRootTransform();
				foreach (TimelineClip clip2 in (pb.sourceObject as CinemachineTrack).GetClips())
				{
					CinemachineVirtualCameraBase cinemachineVirtualCameraBase2 = (clip2.asset as CinemachineShot).VirtualCamera.Resolve(pd.playableGraph.GetResolver());
					if (cinemachineVirtualCameraBase2.LookAt == null)
					{
						cinemachineVirtualCameraBase2.LookAt = rootTransform;
					}
					if (cinemachineVirtualCameraBase2.Follow == null)
					{
						cinemachineVirtualCameraBase2.Follow = rootTransform;
					}
				}
				pd.Pause();
			}
			if (obj != null)
			{
				return obj;
			}
			if (outputTargetType == typeof(Animator))
			{
				pd.Play();
				if (entity2 == null)
				{
					if (!text.Contains("NPC"))
					{
					}
				}
				else
				{
					((Animator)(obj = entity2.GetCompBehave().Animator)).applyRootMotion = true;
				}
				if (pd.playableGraph.GetOutput(outputIndex).IsPlayableOutputOfType<AnimationPlayableOutput>())
				{
					((AnimationPlayableOutput)pd.playableGraph.GetOutput(outputIndex)).SetTarget((Animator)obj);
				}
				pd.Pause();
			}
			else if (outputTargetType == typeof(Transform))
			{
				if (!(entity2 == null))
				{
					obj = ((result != 10000 && !text.Contains("ROBOT")) ? entity2.GetRootTransform() : MonoECS.instance.localPlayer.robotEntity.GetModelTrans());
				}
				else if (!text.Contains("NPC"))
				{
				}
			}
			else if (outputTargetType == typeof(GameObject))
			{
				if (!(entity2 == null))
				{
					obj = ((result != 10000 && !text.Contains("ROBOT")) ? entity2.GetModel() : MonoECS.instance.localPlayer.robotEntity.GetModel());
				}
				else if (!text.Contains("NPC"))
				{
				}
			}
			else if (outputTargetType == typeof(SignalReceiver))
			{
				obj = entity2.GetRoot().GetComponentInChildren<SignalReceiver>();
			}
		}
		else
		{
			GameObject gameObject2 = GameObject.Find(value);
			if (gameObject2 == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("没有找到名字为" + value + "的物体");
				}
				return null;
			}
			if (outputTargetType == typeof(CinemachineBrain))
			{
				pd.Play();
				Transform transform2 = gameObject2.transform;
				foreach (TimelineClip clip3 in (pb.sourceObject as CinemachineTrack).GetClips())
				{
					CinemachineVirtualCameraBase cinemachineVirtualCameraBase3 = (clip3.asset as CinemachineShot).VirtualCamera.Resolve(pd.playableGraph.GetResolver());
					if (cinemachineVirtualCameraBase3.LookAt == null)
					{
						cinemachineVirtualCameraBase3.LookAt = transform2;
					}
					if (cinemachineVirtualCameraBase3.Follow == null)
					{
						cinemachineVirtualCameraBase3.Follow = transform2;
					}
				}
				pd.Pause();
			}
			if (obj != null)
			{
				return obj;
			}
			if (!(outputTargetType == typeof(Animator)))
			{
				if (outputTargetType == typeof(Transform))
				{
					obj = gameObject2.transform;
				}
				else
				{
					obj = ((!(outputTargetType == typeof(SignalReceiver))) ? ((UnityEngine.Object)gameObject2) : ((UnityEngine.Object)gameObject2.GetComponentInChildren<SignalReceiver>()));
				}
			}
			else
			{
				pd.Play();
				obj = gameObject2.GetComponent<Animator>();
				int num = 0;
				foreach (PlayableBinding output in pd.playableAsset.outputs)
				{
					if (num == outputIndex)
					{
						UnityEngine.Object genericBinding = pd.GetGenericBinding(output.sourceObject);
						pd.SetGenericBinding(genericBinding, obj);
					}
					num++;
				}
				pd.Pause();
			}
		}
		return obj;
	}
}

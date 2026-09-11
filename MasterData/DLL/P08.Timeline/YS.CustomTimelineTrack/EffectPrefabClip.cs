using System;
using System.Linq;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

[Serializable]
public class EffectPrefabClip : PlayableAsset
{
	public GameObject effectPrefab;

	public Vector3 localPosition = Vector3.zero;

	public Vector3 localEulerAngles = Vector3.zero;

	public Vector3 localScale = Vector3.one;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<EffectPrefabBehaviour> scriptPlayable = ScriptPlayable<EffectPrefabBehaviour>.Create(graph);
		EffectPrefabBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.effectPrefab = effectPrefab;
		behaviour.localPosition = localPosition;
		behaviour.localEulerAngles = localEulerAngles;
		behaviour.localScale = localScale;
		return scriptPlayable;
	}

	public static double GetSuggestedDuration(GameObject effectPrefab)
	{
		if (effectPrefab == null)
		{
			return 1.0;
		}
		EffectController component = effectPrefab.GetComponent<EffectController>();
		if (component != null && component.TotalTime > 0f)
		{
			return component.TotalTime;
		}
		double num = 0.0;
		ParticleSystem[] componentsInChildren = effectPrefab.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			ParticleSystem.MainModule main = componentsInChildren[i].main;
			if (!main.loop)
			{
				num = Math.Max(num, main.duration + GetLifetime(main.startLifetime));
			}
		}
		Animation[] componentsInChildren2 = effectPrefab.GetComponentsInChildren<Animation>(includeInactive: true);
		for (int j = 0; j < componentsInChildren2.Length; j++)
		{
			AnimationClip clip = componentsInChildren2[j].clip;
			if (clip != null)
			{
				num = Math.Max(num, clip.length);
			}
		}
		Animator[] componentsInChildren3 = effectPrefab.GetComponentsInChildren<Animator>(includeInactive: true);
		for (int k = 0; k < componentsInChildren3.Length; k++)
		{
			RuntimeAnimatorController runtimeAnimatorController = componentsInChildren3[k].runtimeAnimatorController;
			if (runtimeAnimatorController == null)
			{
				continue;
			}
			AnimationClip[] animationClips = runtimeAnimatorController.animationClips;
			for (int l = 0; l < animationClips.Length; l++)
			{
				if (animationClips[l] != null)
				{
					num = Math.Max(num, animationClips[l].length);
				}
			}
		}
		if (!(num > 0.0))
		{
			return 1.0;
		}
		return num;
	}

	private static float GetLifetime(ParticleSystem.MinMaxCurve lifetimeCurve)
	{
		return lifetimeCurve.mode switch
		{
			ParticleSystemCurveMode.TwoConstants => lifetimeCurve.constantMax, 
			ParticleSystemCurveMode.TwoCurves => Mathf.Max((lifetimeCurve.curveMax != null) ? lifetimeCurve.curveMax.keys.LastOrDefault().value : 0f, (lifetimeCurve.curveMin != null) ? lifetimeCurve.curveMin.keys.LastOrDefault().value : 0f) * lifetimeCurve.curveMultiplier, 
			ParticleSystemCurveMode.Curve => ((lifetimeCurve.curve != null) ? lifetimeCurve.curve.keys.LastOrDefault().value : 0f) * lifetimeCurve.curveMultiplier, 
			_ => lifetimeCurve.constant, 
		};
	}
}

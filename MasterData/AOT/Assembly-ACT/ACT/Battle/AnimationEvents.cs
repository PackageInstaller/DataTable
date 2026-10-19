using System;
using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("ACT/AnimationEvents")]
public class AnimationEvents : MonoBehaviour
{
	[Serializable]
	public struct NoiseData
	{
		[Tooltip("震屏效果预制体")]
		[SerializeField]
		public YooAssetReference noiseReferenceAssetID;

		[Tooltip("震屏效果相对于播放点的偏移量，一般只有Y轴才有用")]
		public Vector3 velocity;

		[Tooltip("持续时间 0就是默认0.2")]
		public float duration;

		[Tooltip("强度 0就是默认1")]
		public float force;
	}

	public MonoEntity monoEntity;

	public List<NoiseData> noiseList;

	public void AddAbility(string ability)
	{
		if (monoEntity.entity.IsLogicAvailable())
		{
			Entity caster = monoEntity.entity.GetCompProduct()?.caster ?? monoEntity.entity;
			monoEntity.entity.GetCompAbility().AddAbility(caster, ability, AbilitySource.Ability, default, 1);
		}
	}

	public void RemoveAbility(string ability)
	{
		if (monoEntity.entity.IsLogicAvailable())
		{
			monoEntity.entity.GetCompAbility().RemoveAbility(ability);
		}
	}

	public void StopAnimation()
	{
		GetComponent<Animator>().speed = 0f;
	}

	public void RestartAnimation()
	{
		GetComponent<Animator>().speed = 1f;
	}

	public void EnableAnimation()
	{
		GetComponent<Animator>().enabled = true;
	}

	public void DisableAnimation()
	{
		GetComponent<Animator>().enabled = false;
	}

	public void FireCameraNoise(int i)
	{
		float sustainTime = ((noiseList[i].duration == 0f) ? 0.2f : noiseList[i].duration);
		float force = ((noiseList[i].force == 0f) ? 1f : noiseList[i].force);
		Singleton<CameraNoiseManager>.instance.TriggerCameraNoise(CameraNoiseType.LevelTrigger, MonoECS.instance.mainEntity.GetModelTrans().position, noiseList[i].noiseReferenceAssetID, noiseList[i].velocity, sustainTime, force, changeVelocityXZ: false, overLay: true, unloadAfterPlaying: true);
	}
}

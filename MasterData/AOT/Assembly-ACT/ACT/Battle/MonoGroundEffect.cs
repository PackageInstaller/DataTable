using System.Collections;
using System.Collections.Generic;
using Bamboo.ECS;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;
using UnityEngine.VFX;

namespace ACT.Battle;

public class MonoGroundEffect : MonoBehaviour
{
	private struct GroundEffect
	{
		public Entity entity;

		public InstanceHandle instanceHandle;

		public VisualEffect vfx;

		public bool isPlaying;
	}

	[Tooltip("特效地址")]
	public YooAssetReference assetRefrenceAssetID;

	[Tooltip("粒子贴图")]
	public Texture texture;

	[Tooltip("粒子初始速度")]
	public float velocity;

	[Tooltip("粒子生命周期")]
	public float lifeTime;

	[Tooltip("粒子产生速率")]
	public uint spawnRate;

	[Tooltip("粒子出现速度阈值")]
	public float minSpeed;

	[Tooltip("阻力")]
	public float drag;

	[Tooltip("额外速度")]
	public Vector3 extraVelocity;

	private List<GroundEffect> m_GroundEffects;

	private void Start()
	{
		m_GroundEffects = ListPool<GroundEffect>.Get();
	}

	private void Update()
	{
		if (m_GroundEffects.Count != 0)
		{
			SpawnParticles();
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (component != null)
		{
			GroundEffect effect = new GroundEffect
			{
				entity = component.entity,
				isPlaying = false
			};
			PrecacheManager.Instance.GetInstanceHandle(assetRefrenceAssetID.GUID).Completed += (InstanceHandle l) =>
			{
				effect.instanceHandle = l;
				effect.vfx = l.Result.GetComponent<VisualEffect>();
				m_GroundEffects.Add(effect);
			};
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity monoEntity = other.GetComponent<MonoEntity>();
		if (monoEntity != null)
		{
			GroundEffect effect = m_GroundEffects.Find((GroundEffect l) => l.entity == monoEntity.entity);
			StartCoroutine(ReleaseLater(effect));
		}
	}

	private IEnumerator ReleaseLater(GroundEffect effect)
	{
		VisualEffect vfx = effect.vfx;
		vfx.SendEvent("OnPause");
		m_GroundEffects.Remove(effect);
		yield return new WaitUntil(() => vfx.aliveParticleCount == 0);
		PrecacheManager.Instance.ReleaseInstanceHandle(effect.instanceHandle);
	}

	private void SpawnParticles()
	{
		for (int num = m_GroundEffects.Count - 1; num >= 0; num--)
		{
			GroundEffect groundEffect = m_GroundEffects[num];
			Entity entity = groundEffect.entity;
			VisualEffect vfx = groundEffect.vfx;
			bool isPlaying = groundEffect.isPlaying;
			if (!entity.IsValid)
			{
				StartCoroutine(ReleaseLater(groundEffect));
			}
			else
			{
				CompPhysics compPhysics = entity.GetCompPhysics();
				if (compPhysics.isGrounded && compPhysics.rawVelocity.x > minSpeed)
				{
					if (!isPlaying)
					{
						vfx.SendEvent("OnPlay");
						groundEffect.isPlaying = true;
					}
					vfx.SetUInt("AmountPerFrame", spawnRate);
					vfx.SetFloat("LifeTime", lifeTime);
					vfx.SetFloat("Drag", drag);
					vfx.SetVector3("GlobalPosition", entity.GetRootTransform().position);
					vfx.SetVector3("Velocity", compPhysics.faceDirRot * Vector3.forward * velocity + extraVelocity);
					vfx.SetTexture("MainTex", texture);
				}
				else if (isPlaying)
				{
					vfx.SendEvent("OnPause");
					groundEffect.isPlaying = false;
				}
				m_GroundEffects[num] = groundEffect;
			}
		}
	}

	private void OnDestroy()
	{
		ListPool<GroundEffect>.Release(m_GroundEffects);
	}
}

using UnityEngine;

public class MathParkourProjectile : MonoBehaviour
{
	[SerializeField]
	[Min(0.01f)]
	private float moveSpeed = 12f;

	[SerializeField]
	[Min(0.01f)]
	private float lifeTime = 3f;

	[SerializeField]
	private Collider hitCollider;

	[SerializeField]
	private MathParkourTimedFx hitFxPrefab;

	private MathParkourLevelController levelController;

	private int buffId;

	private float damage;

	private MathParkourDamageSource damageSource;

	private float remainingLifeTime;

	private bool hasHit;

	private ParticleSystem[] particleSystems;

	private bool[] particleWasPlayingBeforePause;

	private bool isVisualPaused;

	public void Init(MathParkourLevelController controller, int buffId, float damage, MathParkourDamageSource damageSource = MathParkourDamageSource.ActorAProjectile)
	{
		levelController = controller;
		this.buffId = buffId;
		this.damage = damage;
		this.damageSource = damageSource;
		remainingLifeTime = lifeTime;
		hasHit = false;
		isVisualPaused = false;
		particleWasPlayingBeforePause = null;
		particleSystems = GetComponentsInChildren<ParticleSystem>(includeInactive: true);
	}

	private void Update()
	{
		if (levelController == null)
		{
			return;
		}
		SetVisualPaused(levelController.IsGameplayPaused);
		if (levelController.IsGameplayAvailable)
		{
			transform.position += transform.forward * (moveSpeed * Time.deltaTime);
			remainingLifeTime -= Time.deltaTime;
			if (remainingLifeTime <= 0f)
			{
				Object.Destroy(gameObject);
			}
		}
	}

	private void SetVisualPaused(bool paused)
	{
		if (isVisualPaused == paused)
		{
			return;
		}
		isVisualPaused = paused;
		if (particleSystems == null)
		{
			particleSystems = GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		}
		if (paused)
		{
			particleWasPlayingBeforePause = new bool[particleSystems.Length];
			for (int i = 0; i < particleSystems.Length; i++)
			{
				ParticleSystem particleSystem = particleSystems[i];
				if (!(particleSystem == null))
				{
					particleWasPlayingBeforePause[i] = particleSystem.isPlaying;
					if (particleWasPlayingBeforePause[i])
					{
						particleSystem.Pause(withChildren: true);
					}
				}
			}
			return;
		}
		for (int j = 0; j < particleSystems.Length; j++)
		{
			if (particleSystems[j] != null && particleWasPlayingBeforePause != null && j < particleWasPlayingBeforePause.Length && particleWasPlayingBeforePause[j])
			{
				particleSystems[j].Play(withChildren: true);
			}
		}
	}

	private void OnTriggerEnter(Collider other)
	{
		if (hasHit || levelController == null || !levelController.IsGameplayAvailable)
		{
			return;
		}
		MathParkourCombatEntity componentInParent = other.GetComponentInParent<MathParkourCombatEntity>();
		if (!(componentInParent == null))
		{
			hasHit = true;
			if (hitCollider != null)
			{
				hitCollider.enabled = false;
			}
			levelController.ApplyDamageToTarget(componentInParent, damage, damageSource);
			levelController.PlayBuffFx(buffId, hitFxPrefab, transform.position, transform.rotation);
			Object.Destroy(gameObject);
		}
	}
}

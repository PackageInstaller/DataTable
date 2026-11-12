using UnityEngine;

public class MathParkourTimedFx : MonoBehaviour
{
	[SerializeField]
	[Min(0.01f)]
	private float lifeTime = 1f;

	[SerializeField]
	private ParticleSystem[] particleSystems;

	[SerializeField]
	private Animator animator;

	private MathParkourLevelController levelController;

	private float remainingLifeTime;

	private bool shouldAutoDestroy;

	private bool isVisualPaused;

	private bool[] particleWasPlayingBeforePause;

	private float animatorSpeedBeforePause;

	public float LifeTime => lifeTime;

	public void Play(MathParkourLevelController controller, bool autoDestroy = true)
	{
		levelController = controller;
		remainingLifeTime = lifeTime;
		shouldAutoDestroy = autoDestroy;
		if (particleSystems == null || particleSystems.Length == 0)
		{
			particleSystems = GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		}
		for (int i = 0; i < particleSystems.Length; i++)
		{
			if (particleSystems[i] != null)
			{
				particleSystems[i].Play(withChildren: true);
			}
		}
		if (animator != null)
		{
			animator.Rebind();
			animator.Update(0f);
		}
	}

	private void Update()
	{
		if (levelController == null)
		{
			return;
		}
		SetVisualPaused(levelController.IsGameplayPaused);
		if (shouldAutoDestroy && !levelController.IsGameplayPaused)
		{
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
			if (animator != null)
			{
				animatorSpeedBeforePause = animator.speed;
				animator.speed = 0f;
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
		if (animator != null)
		{
			animator.speed = animatorSpeedBeforePause;
		}
	}
}

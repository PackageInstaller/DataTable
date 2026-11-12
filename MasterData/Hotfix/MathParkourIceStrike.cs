using System.Collections;
using UnityEngine;

public class MathParkourIceStrike : MonoBehaviour
{
	[SerializeField]
	[Min(0f)]
	private float warningDuration = 0.5f;

	[SerializeField]
	private MathParkourTimedFx impactFxPrefab;

	private MathParkourLevelController levelController;

	private ParticleSystem[] particleSystems;

	private bool[] particleWasPlayingBeforePause;

	private bool isVisualPaused;

	public void Init(MathParkourLevelController controller, int buffId, float rangeRadius, int damage)
	{
		levelController = controller;
		particleSystems = GetComponentsInChildren<ParticleSystem>(includeInactive: true);
		particleWasPlayingBeforePause = null;
		isVisualPaused = false;
		gameObject.SetActive(value: true);
		StartCoroutine(StrikeCoroutine(controller, buffId, rangeRadius, damage));
	}

	private void Update()
	{
		if (levelController != null)
		{
			SetVisualPaused(levelController.IsGameplayPaused);
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

	private IEnumerator StrikeCoroutine(MathParkourLevelController controller, int buffId, float rangeRadius, int damage)
	{
		if (controller == null)
		{
			Object.Destroy(gameObject);
			yield break;
		}
		yield return controller.WaitForGameplaySeconds(warningDuration);
		if (controller == null || (!controller.IsGameplayAvailable && !controller.IsGameplayPaused))
		{
			Object.Destroy(gameObject);
			yield break;
		}
		while (controller != null && controller.IsGameplayPaused)
		{
			yield return null;
		}
		if (controller == null || !controller.IsGameplayAvailable)
		{
			Object.Destroy(gameObject);
			yield break;
		}
		controller.PlayBuffFx(buffId, impactFxPrefab, transform.position, transform.rotation);
		yield return controller.WaitForGameplaySeconds(0.5f);
		controller.ApplyDamageInRange(transform.position, rangeRadius, damage, MathParkourDamageSource.ActorCFinalIce);
		Object.Destroy(gameObject);
	}
}

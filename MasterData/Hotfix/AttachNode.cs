using TrueSync;

public class AttachNode
{
	public bool FirstSyn;

	public MonsterAdventureActor attachEntity;

	public FP attachOffsetRot;

	private static string fadeOut = "FadeOut";

	private static string fadeIn = "FadeIn";

	private bool fadeOutComplete;

	private bool fadeInComplete;

	public void ResetAtkTarget()
	{
		if (attachEntity != null)
		{
			attachEntity.InterruptAttack(force: true);
			attachEntity.monsterTarget = null;
		}
	}

	public void FadeOut()
	{
		fadeOutComplete = false;
		attachEntity?.PlayComboByKey(fadeOut, () =>
		{
			fadeOutComplete = true;
		}, () =>
		{
			fadeOutComplete = true;
		});
	}

	public bool CheckFadeOutComplete()
	{
		return fadeOutComplete;
	}

	public void FadeIn()
	{
		fadeInComplete = false;
		attachEntity?.PlayComboByKey(fadeIn, () =>
		{
			fadeInComplete = true;
		}, () =>
		{
			fadeInComplete = true;
		});
	}

	public bool CheckFadeInComplete()
	{
		return fadeInComplete;
	}

	public bool CheckSpawnComplete()
	{
		if (attachEntity == null)
		{
			return false;
		}
		return attachEntity.state != ActorState.Spawn;
	}

	public void Finish()
	{
		attachEntity?.DestroySelf(forceDestory: true);
		attachEntity = null;
	}
}

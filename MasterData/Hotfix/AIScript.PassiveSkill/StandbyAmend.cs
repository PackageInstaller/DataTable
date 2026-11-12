using System.Collections;
using TrueSync;

namespace AIScript.PassiveSkill;

public class StandbyAmend : PassiveSkillBase
{
	private int atkAmendBuffId;

	private FP addBuffTimeThreshold = 3f;

	private FP moveTimeInterval = 1f;

	private FP moveEnergyLoss = 5;

	private CoroutineNode mainCoroutine;

	private FP standbyTimer = 0f;

	private FP moveTimer = 0f;

	private bool buffAdded;

	protected override void OnSkillEnable()
	{
		standbyTimer = 0;
		moveTimer = 0;
		buffAdded = false;
		StartCoroutine(ref mainCoroutine, Main());
	}

	protected override void OnSkillDisable()
	{
		StopCoroutine(ref mainCoroutine);
	}

	private IEnumerator Main()
	{
		while (true)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
			{
				standbyTimer += _actor.LogicDeltaTime;
				moveTimer = 0;
				if (standbyTimer >= addBuffTimeThreshold && !buffAdded)
				{
					_actor.buffComponent.AddBuff(atkAmendBuffId, _actor);
					buffAdded = true;
				}
			}
			else
			{
				standbyTimer = 0;
				moveTimer += _actor.LogicDeltaTime;
				if (buffAdded)
				{
					_actor.buffComponent.RemoveBuffByBuffId(atkAmendBuffId);
					buffAdded = false;
				}
				if (moveTimer >= moveTimeInterval)
				{
					moveTimer = 0;
					if (_actor is PlayerAdventureActor playerAdventureActor)
					{
						playerAdventureActor.playerSkillCd.AddEnergy(-moveEnergyLoss);
					}
				}
			}
			yield return null;
		}
	}
}

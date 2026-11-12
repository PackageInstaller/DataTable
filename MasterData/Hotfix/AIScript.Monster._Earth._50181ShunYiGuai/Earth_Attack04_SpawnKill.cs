using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Earth._50181ShunYiGuai;

public class Earth_Attack04_SpawnKill : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack04 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.D,
		ComboInputBuffer.ActionKey._2
	};

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Enemy = GetCurrentPlayer();
		BeginAttack(1, Attack04, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(22);
		if (GetBuffNum(_actor, 501810002) >= 1)
		{
			if (GetBuffNum(_actor, 501810001) >= 1)
			{
				AimAtTarget(Enemy, 90);
				for (int Times = 0; Times <= 110; Times++)
				{
					if (Distance(GetPosition(), GetEntityPositionObsoleted(Enemy)) > 3)
					{
						BeginTrace(Enemy, 3, -1, 10);
					}
					yield return WaitFrame(1);
				}
				StopTrace();
				CancelAim();
				CancelAttack();
				yield return WaitFrame(40);
				ClearActors(new List<LogicEntity> { _actor });
			}
			else
			{
				AimAtTarget(Enemy, 30);
				yield return WaitFrame(110);
				CancelAim();
				CancelAttack();
				yield return WaitFrame(40);
				ClearActors(new List<LogicEntity> { _actor });
			}
		}
		else
		{
			AimAtTarget(Enemy, 30);
			yield return WaitFrame(110);
			CancelAim();
			CancelAttack();
			yield return WaitFrame(40);
			ClearActors(new List<LogicEntity> { _actor });
		}
	}
}

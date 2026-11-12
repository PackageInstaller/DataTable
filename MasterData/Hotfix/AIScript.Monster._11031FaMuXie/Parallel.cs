using System.Collections.Generic;
using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._11031FaMuXie;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private readonly int dropItemId = 120;

	private readonly Dictionary<FP, int> dropInfoDic = new Dictionary<FP, int>
	{
		[75] = 1,
		[50] = 1,
		[30] = 1
	};

	private FP _lastHpPercent;

	public override void OnStart()
	{
		base.OnStart();
		_lastHpPercent = (FP)_actor.actorHealthInfo.hpPercentage * 100;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}

	private void OnHpChanged(IEvent evt)
	{
		if (!(evt is AdventureActorHpChangedEvent { sender: MonsterAdventureActor sender } adventureActorHpChangedEvent) || !(sender == _actor))
		{
			return;
		}
		FDP fDP = adventureActorHpChangedEvent.currentHp / adventureActorHpChangedEvent.maxHp;
		fDP *= (FDP)100;
		if (!adventureActorHpChangedEvent.isCovery)
		{
			foreach (KeyValuePair<FP, int> item in dropInfoDic)
			{
				FP key = item.Key;
				if (_lastHpPercent > key && fDP <= key)
				{
					int value = item.Value;
					AdventureActor owner = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
					for (int i = 0; i < value; i++)
					{
						SceneSingleton<DropsManager>.Instance.PlayDropsByDropId(owner, dropItemId, _actor.tsTransform.Position);
					}
				}
			}
		}
		_lastHpPercent = (FP)fDP;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChanged);
	}
}

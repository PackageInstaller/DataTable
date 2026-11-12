using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Parallel_XiaoMoXiang : Parallel
{
	private readonly FP bossEnergyInterval = 1;

	private static readonly FP[] bossEnergyDeltas = new FP[6] { 0, 0, 0, 0, 1.2, 1.8 };

	private CoroutineNode corAddBossEnergy;

	private AdventureActor cachedJuXing;

	private PlayFX _shieldUpFx;

	private MonsterAdventureActor actor => _actor as MonsterAdventureActor;

	public override void OnStart()
	{
		base.OnStart();
		StartCoroutine(ref corAddBossEnergy, DoAddBossEnergy());
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	private void OnGetBuff(IEvent iEvent)
	{
		if (iEvent is AdventureActorGetBuff adventureActorGetBuff && !(adventureActorGetBuff.sender as AdventureActor != _actor))
		{
			SyncBossBuffChangeIfMatch(adventureActorGetBuff.eventInfo.buffId);
		}
	}

	private void OnRemoveBuff(IEvent iEvent)
	{
		if (iEvent is AdventureActorRemoveBuff adventureActorRemoveBuff && !(adventureActorRemoveBuff.sender as AdventureActor != _actor))
		{
			SyncBossBuffChangeIfMatch(adventureActorRemoveBuff.eventInfo.buffId);
		}
	}

	private void SyncBossBuffChangeIfMatch(int buffId)
	{
		int level = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
		int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.damageReductionBuffIds);
		int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(level, Config_XiaoMoXiang.vulnerableBuffIds);
		if (buffId == monsterIdByLevel || buffId == monsterIdByLevel2)
		{
			Common_73001.SyncBossBuffChange(_actor, monsterIdByLevel, monsterIdByLevel2);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		StopCoroutine(ref corAddBossEnergy);
		ILRuntimeAPI.ClearPlayFX(_shieldUpFx);
	}

	private IEnumerator DoAddBossEnergy()
	{
		FP timer = 0;
		while (true)
		{
			if (timer >= bossEnergyInterval)
			{
				AdventureActor juXingActor = GetJuXingActor();
				if (juXingActor != null)
				{
					FP fP = CommonUtils_MonsterAPI.GetLogicTagFpValue(juXingActor, Common_73001.EnergyTag);
					if (fP < 100)
					{
						int num = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
						if (num < 0)
						{
							num = 0;
						}
						if (num >= bossEnergyDeltas.Length)
						{
							num = bossEnergyDeltas.Length - 1;
						}
						FP fP2 = fP;
						fP += bossEnergyDeltas[num];
						if (fP > 100)
						{
							fP = 100;
						}
						CommonUtils_MonsterAPI.SetLogicTagFpValue(juXingActor, Common_73001.EnergyTag, fP);
						Common_73001.SyncBossEnergyChange(_actor, fP.AsInt());
						if (CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Common_73001.EnergyToReductionEnabledTag) == 1)
						{
							int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(num, Config_XiaoMoXiang.damageReductionBuffIds);
							int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(num, Config_XiaoMoXiang.vulnerableBuffIds);
							if (Common_73001.TryAddDamageReductionByEnergyGain(_actor, fP - fP2, monsterIdByLevel, monsterIdByLevel2, 8))
							{
								ILRuntimeAPI.PlayFX(ref _shieldUpFx, _actor, null, "fx_m72011_base_Shield", default, _actor.tsTransform.Position, TSVector2.zero);
							}
						}
					}
				}
				timer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
		}
	}

	private AdventureActor GetJuXingActor()
	{
		if (cachedJuXing != null && !cachedJuXing.IsDead())
		{
			return cachedJuXing;
		}
		cachedJuXing = null;
		int num = (int)(long)CommonUtils_MonsterAPI.GetLogicTagFpValue(_actor, Config_JuXingMoXiang.SelfDataIdTag);
		if (num <= 0)
		{
			return null;
		}
		List<LogicEntity> targetByDataID = CommonUtils_MonsterAPI.GetTargetByDataID(num);
		if (targetByDataID == null || targetByDataID.Count <= 0)
		{
			return null;
		}
		cachedJuXing = targetByDataID.get_Item(0) as AdventureActor;
		return cachedJuXing;
	}
}

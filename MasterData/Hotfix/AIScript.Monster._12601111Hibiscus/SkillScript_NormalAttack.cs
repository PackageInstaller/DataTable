using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._12601111Hibiscus;

public class SkillScript_NormalAttack : SkillSimpleBase
{
	private Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Atk1",
		[2] = "Atk2",
		[3] = "Atk3"
	};

	private const int perkId_3 = 512603;

	private const int buffId_3 = 12650311;

	private Dictionary<int, string> dicKey_3 = new Dictionary<int, string>
	{
		[1] = "Atk1_P03",
		[2] = "Atk2_P03",
		[3] = "Atk3_P03"
	};

	private const int perkId_10 = 512610;

	private Dictionary<int, string> dicKey_10 = new Dictionary<int, string>
	{
		[1] = "Atk1_P10",
		[2] = "Atk2_P10",
		[3] = "Atk3_P10"
	};

	private Dictionary<int, string> dicKey_3_10 = new Dictionary<int, string>
	{
		[1] = "Atk1_P03_P10",
		[2] = "Atk2_P03_P10",
		[3] = "Atk3_P03_P10"
	};

	private Dictionary<int, string> tmpKey = new Dictionary<int, string>();

	private PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
		if (GetPerkLv(512603, out var lv) && !GetPerkLv(512610, out lv))
		{
			if (_summoner.buffComponent.CheckBuffByBuffID(12650311))
			{
				tmpKey = dicKey_3;
			}
			else
			{
				tmpKey = dicKey;
			}
		}
		else if (!GetPerkLv(512603, out lv) && GetPerkLv(512610, out lv))
		{
			tmpKey = dicKey_10;
		}
		else if (GetPerkLv(512603, out lv) && GetPerkLv(512610, out lv))
		{
			if (_summoner.buffComponent.CheckBuffByBuffID(12650311))
			{
				tmpKey = dicKey_3_10;
			}
			else
			{
				tmpKey = dicKey_10;
			}
		}
		else
		{
			tmpKey = dicKey;
		}
	}

	private string GetAtkTag()
	{
		int key = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		return tmpKey.get_Item(key);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, GetAtkTag(), flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isRecoveryBegin);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		if (_summoner == null)
		{
			lv = 0;
			return false;
		}
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_summoner.dataID, perkId, out lv);
	}
}

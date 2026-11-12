using System;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Character._12601;

public class SkillScript_NormalAttack : SkillAdvancedBase
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

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		if (GetPerkLv(512603, out var lv) && !GetPerkLv(512610, out lv))
		{
			if (_actor.buffComponent.CheckBuffByBuffID(12650311))
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
			if (_actor.buffComponent.CheckBuffByBuffID(12650311))
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
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null || _actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAttackRange(_actor))
		{
			comboAttack?.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		int key = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string actionTag = tmpKey.get_Item(key);
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}

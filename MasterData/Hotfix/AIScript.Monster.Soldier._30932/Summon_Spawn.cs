using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._30932;

public class Summon_Spawn : SkillSimpleBase
{
	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.ShaXieYongBingTuan;

	private const int levelThreshold = 2;

	private readonly string comboTag = "Spawn";

	private readonly string spawnFxAlias = "fx_m30391_base_change_1";

	private readonly string spawnFxAliasEnhanced = "fx_m30931_base_Taunt";

	private readonly FP spawnDelay = 1.8;

	private readonly FP tauntRadius = 10;

	private static readonly string[] SoldierFormNodes = new string[11]
	{
		"body", "DaChui_01", "DaChui_02", "face", "hair", "Root", "weapon1", "weapon2", "weapon003", "weapon004",
		"_slot_mark"
	};

	private static readonly string[] ShaJuRenNodes = new string[2] { "ShaJuRen", "ShaJuRen_trans" };

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public new void OnStart()
	{
		HideAllNodesForSpawn();
		string fxAlias = spawnFxAlias;
		TSVector2 position = GetPosition();
		PlayEffect(fxAlias, 1f, default, position);
		_actor.attackTarget = FindNearestEnemy();
		_actor.StartLogicCoroutine(RevealAndPlayCombo());
	}

	private IEnumerator RevealAndPlayCombo()
	{
		yield return _actor.WaitTime(spawnDelay);
		for (int i = 0; i < ShaJuRenNodes.Length; i++)
		{
			ModelNodeShow(ShaJuRenNodes[i], isShow: true);
		}
		if (GetPartnerLevel() >= 2)
		{
			Summon_Spawn summon_Spawn = this;
			string fxAlias = spawnFxAliasEnhanced;
			TSVector2 position = GetPosition();
			summon_Spawn.PlayEffect(fxAlias, 1f, default, position);
			ApplyTauntInRange();
		}
		_actor.attackTarget = FindNearestEnemy();
		if (_actor.attackTarget != null && _actor.attackTarget.tsTransform != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		BeginAttack(1, comboTag, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_searchBuffer.Clear();
	}

	private void HideAllNodesForSpawn()
	{
		for (int i = 0; i < SoldierFormNodes.Length; i++)
		{
			ModelNodeShow(SoldierFormNodes[i], isShow: false);
		}
		for (int j = 0; j < ShaJuRenNodes.Length; j++)
		{
			ModelNodeShow(ShaJuRenNodes[j], isShow: false);
		}
	}

	private int GetPartnerLevel()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (soldierLevelController == null)
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(partnerTypes);
	}

	private LogicEntity FindNearestEnemy()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return _searchBuffer.get_Item(i);
			}
		}
		return _actor.attackTarget;
	}

	private void ApplyTauntInRange()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, tauntRadius, isConfront: true, includeSelf: false, _searchBuffer);
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }) && adventureActor.stateAttributeList != null)
			{
				if (adventureActor.stateAttributeList.CanEnable(HotfixEnum.stateAttributeType.TAUNT))
				{
					adventureActor.stateAttributeList.Disable(HotfixEnum.stateAttributeType.TAUNT);
					adventureActor.tauntFromActor = _actor;
					adventureActor.stateAttributeList.Enable(HotfixEnum.stateAttributeType.TAUNT);
				}
				else
				{
					adventureActor.EnterTauntWeakened();
				}
			}
		}
	}
}

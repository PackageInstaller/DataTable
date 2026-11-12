using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72014KuiLeiShiTi;

public class Skill_QiangHuaJuNu : SkillSimpleBase
{
	public const int qiangHuaBuffId = 720140120;

	private const string combo_Buff = "Chongneng";

	private const int loopCount = 1;

	private FP linkStopDelay = 0.3f;

	private FP linkStartDelay = 0.2f;

	private const string linkFxAlias = "fx_m72011_loop_Skill5_link_3";

	private int _currentLoopCount;

	private PlayFX _linkFx;

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity lookTarget = null;
		List<LogicEntity> targetByDataID = GetTargetByDataID(1900706);
		if (targetByDataID != null && targetByDataID.Count > 0)
		{
			lookTarget = targetByDataID.get_Item(0);
		}
		if (lookTarget != null)
		{
			BeginLookAtByPos(GetEntityPosition(lookTarget), 0.3, 2000);
		}
		_currentLoopCount = 0;
		BeginAttack(1, "Chongneng", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(linkStartDelay);
		StartLinkFx(lookTarget);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		List<LogicEntity> targetByDataID2 = GetTargetByDataID(1900706);
		if (targetByDataID2 == null)
		{
			yield break;
		}
		for (int i = 0; i < targetByDataID2.Count; i++)
		{
			LogicEntity logicEntity = targetByDataID2.get_Item(i);
			if (logicEntity != null)
			{
				AddBuffToTarget(logicEntity, 720140120);
			}
		}
	}

	private void StartLinkFx(LogicEntity target)
	{
		if (!(target == null))
		{
			GameObject gameObject = (target as AdventureActor)?.gameObject;
			if (!(gameObject == null))
			{
				_linkFx = PlayLinkFX("fx_m72011_loop_Skill5_link_3", useCustomSource: false, _actor.gameObject, TSVector.zero, 0, gameObject, TSVector.zero, 0);
				_linkFx?.fxInstance?.Bind(_actor.gameObject);
			}
		}
	}

	private void StopLinkFx()
	{
		_linkFx?.Stop(dontPlaySubFX: true);
		_linkFx?.Clear();
		_linkFx = null;
	}

	protected override void OnSkillDisable()
	{
		StopLinkFx();
		base.OnSkillDisable();
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 1)
		{
			_currentLoopCount++;
			if (_currentLoopCount >= 1)
			{
				CancelAttack();
				StartCor(StopLinkFxDelayed());
			}
		}
	}

	private IEnumerator StopLinkFxDelayed()
	{
		yield return WaitTime(linkStopDelay);
		StopLinkFx();
	}
}

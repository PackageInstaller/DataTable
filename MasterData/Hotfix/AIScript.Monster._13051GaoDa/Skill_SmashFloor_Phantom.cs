using System.Collections;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_SmashFloor_Phantom : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private string warningFxAlias = "Warning";

	private string HitFxAliasL = "PunchHitEffectL";

	private string HitFxAliasR = "PunchHitEffectR";

	private string customEventName_HitEffect = "HitEffect";

	private string customEventName_HideSelf = "HideSelf";

	private FP blinkDuration = 1;

	private string HitFxAlias;

	private TSVector2 originalPosition;

	private TSVector2 TargetPosition;

	private TSVector2 SelectPosition;

	private string WaitingMessage;

	protected override void OnSkillEnable()
	{
		StartCor(GetAttackTargetPosition());
		if (_actor.dataID == GetTeammateIdByIndex(4))
		{
			WaitingMessage = "LeftPhantomAttack";
		}
		else
		{
			WaitingMessage = "RightPhantomAttack";
		}
		SetLogicTagStringValue(_actor, "AttackMessage", "");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys_1, flushInputedKeys: true);
		yield return WaitCustomEvent(customEventName_HideSelf);
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		while (true)
		{
			if (GetLogicTagStringValue(_actor, "AttackMessage") != WaitingMessage)
			{
				yield return null;
				continue;
			}
			SelectPosition = TargetPosition;
			Skill_SmashFloor_Phantom skill_SmashFloor_Phantom = this;
			string fxAlias = warningFxAlias;
			TSVector2 selectPosition = SelectPosition;
			long WarningEffectID = skill_SmashFloor_Phantom.PlayEffect(fxAlias, 1f, default, selectPosition, default, 2.4f);
			yield return Blink(null, SelectPosition, blinkDuration, "", 0, "", 0, SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor);
			BeginLookAtByPos(originalPosition, 0, 999);
			StopEffect(WarningEffectID);
			yield return WaitTime(0.2);
			BeginAttack(2, actionKeys_2, flushInputedKeys: true);
			InterruptHideModel();
			yield return WaitCustomEvent(customEventName_HitEffect);
			if (_actor.dataID == GetTeammateIdByIndex(4))
			{
				HitFxAlias = HitFxAliasL;
			}
			else
			{
				HitFxAlias = HitFxAliasR;
			}
			Skill_SmashFloor_Phantom skill_SmashFloor_Phantom2 = this;
			string hitFxAlias = HitFxAlias;
			selectPosition = GetPosition();
			long HitEffectFXID = skill_SmashFloor_Phantom2.PlayEffect(hitFxAlias, 1f, default, selectPosition, default, 1.2f);
			PlayEffect("fx_10010_base_dead_mat", 10f);
			yield return WaitTime(0.25);
			StopEffect(HitEffectFXID);
			yield return WaitTime(0.4);
			SetHideModelEnable();
			CancelAttack();
			yield return WaitTime(3);
		}
	}

	private IEnumerator GetAttackTargetPosition()
	{
		TargetPosition = new TSVector2(0, -32.2);
		while (true)
		{
			LogicEntity attackTargetWithOwnerTauntFrom = GetAttackTargetWithOwnerTauntFrom(GetTargetByTeammateIndex(0).get_Item(0).Id);
			if (CheckTargetIsValid(attackTargetWithOwnerTauntFrom))
			{
				TargetPosition = GetEntityPositionObsoleted(attackTargetWithOwnerTauntFrom);
			}
			yield return null;
		}
	}
}

using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string key_Ultra_TLON = "161_Ultra_TL";

	private const string key_Ultra_TLOFF = "161_Ultra_NoTL";

	private const string evt_UltraArea = "UltraArea";

	private const string areaEffect_Ultra = "AreaEffect_16101_Ultra";

	private const int perkId_42 = 516142;

	private const string areaEffect_Ultra_42 = "AreaEffect_16101_Ultra_P42";

	private const int perkId_43 = 516143;

	private const string areaEffect_Ultra_43 = "AreaEffect_16101_Ultra_P43";

	private TSVector2 ultraPos;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private string actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			DoMainLogic();
		}, () =>
		{
			ParseKey(timeline: false);
			DoMainLogic();
		});
	}

	private void ParseKey(bool timeline)
	{
		actionKey = (timeline ? "161_Ultra_TL" : "161_Ultra_NoTL");
	}

	private void DoMainLogic()
	{
		ultraPos = _actor.tsTransform.Position;
		string actionTag = actionKey;
		LogicEntity attackTarget = _actor.attackTarget;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, attackTarget, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("UltraArea"))
		{
			string fxAlias = (GetPerk(516142) ? "AreaEffect_16101_Ultra_P42" : "AreaEffect_16101_Ultra");
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			if (GetPerk(516143))
			{
				TSVector2 position = (_actor.attackTarget ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16101_Ultra_P43", position, _actor.tsTransform.Rotation);
			}
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}
}

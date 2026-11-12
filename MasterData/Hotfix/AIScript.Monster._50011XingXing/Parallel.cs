using AIScript.Monster.Template;
using AIScript.Utils;

namespace AIScript.Monster._50011XingXing;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private readonly int skill_hit_tag = CommonHelper.StringToHash("AchievementHitTag");

	private bool XingXing_001;

	private bool XingXing_002;

	private bool beHit;

	public static bool beDisable;

	public override void OnStart()
	{
		base.OnStart();
		beDisable = false;
		beHit = false;
		XingXing_001 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.XingXing_001);
		XingXing_002 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.XingXing_002);
		if (!XingXing_002)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		if (!XingXing_002)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!beHit && _actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.to == _player && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, skill_hit_tag))
		{
			beHit = true;
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		base.OnActorDied(e);
		if (e is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.Id == _actor.Id && !(adventureActorDiedEvent.killer == null) && adventureActorDiedEvent.killer.Id != _actor.Id && !beHit && !XingXing_002)
		{
			ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.XingXing_002);
		}
	}

	public void OnUpdate()
	{
		if (!XingXing_001 && beDisable)
		{
			XingXing_001 = true;
			ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.XingXing_001);
		}
	}
}

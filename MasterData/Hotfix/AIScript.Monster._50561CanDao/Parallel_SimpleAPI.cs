using AIScript.Monster.Template;

namespace AIScript.Monster._50561CanDao;

public class Parallel_SimpleAPI : AIScript.Monster.Template.Parallel
{
	private static readonly string bulletTag = "MonsterWeapon";

	public override void OnStart()
	{
		base.OnStart();
		_actor.logicVariable.ToggleLogicTag("haveBullet", value: true);
		_actor.logicVariable.ToggleLogicTag("isCatchBullet", value: false);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CHECK_BROKENLINE_BULLET_SUCCESS", OnActorCheckSuccess);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CHECK_BROKENLINE_BULLET_SUCCESS", OnActorCheckSuccess);
	}

	private void OnActorCheckSuccess(IEvent e)
	{
		if (e is AdventureActorCheckBrokenBulletSuccessEvent adventureActorCheckBrokenBulletSuccessEvent && adventureActorCheckBrokenBulletSuccessEvent.entity.Id == _actor.Id && adventureActorCheckBrokenBulletSuccessEvent.tag.Equals(bulletTag) && _actor.logicVariable != null)
		{
			if (_actor.state == ActorState.Action && !_actor.logicVariable.GetLogicTagToggle("haveBullet"))
			{
				_actor.logicVariable.ToggleLogicTag("isCatchBullet", value: true);
				_actor.actorSkillManage.DestoryAllSkill();
				_actor.logicVariable.ToggleLogicTag("needReload", value: false);
			}
			else if (_actor.state == ActorState.LostControl)
			{
				_actor.logicVariable.ToggleLogicTag("needReload", value: true);
			}
		}
	}

	private void OnBulletFinish(IEvent e)
	{
		if (e is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner.Id == _actor.Id && adventureBulletFinishEvent.tag.Equals(bulletTag) && !adventureBulletFinishEvent.catched && _actor.logicVariable != null)
		{
			_actor.logicVariable.ToggleLogicTag("getBullet", value: true);
		}
	}
}

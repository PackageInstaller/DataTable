using System.Collections;

namespace AIScript.Monster._13051GaoDa;

public class Death_GaoDa : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Death_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		_actor.inDying = true;
		AdventureActor adventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID((int)(long)_actor.logicVariable.GetLogicTagValue("leftHandId")) as AdventureActor;
		if (adventureActor != null && adventureActor.actorHealthInfo.isAlive)
		{
			adventureActor.DestroySelf();
		}
		adventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID((int)(long)_actor.logicVariable.GetLogicTagValue("rightHandId")) as AdventureActor;
		if (adventureActor != null && adventureActor.actorHealthInfo.isAlive)
		{
			adventureActor.DestroySelf();
		}
		BeginAttack(1, Death_Combo);
		yield return WaitCustomEvent("Hide");
		SetHideModelEnable();
		yield return WaitTime(2);
		CancelAttack();
		yield return WaitTime(0.1);
	}
}

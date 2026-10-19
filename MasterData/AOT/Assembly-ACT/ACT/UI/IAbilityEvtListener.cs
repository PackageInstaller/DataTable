using ACT.Event;

namespace ACT.UI;

public interface IAbilityEvtListener
{
	void OnAbilityAdd(AbilityAddEvt abilityAddEvt);

	void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt);

	void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt);

	void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt);
}

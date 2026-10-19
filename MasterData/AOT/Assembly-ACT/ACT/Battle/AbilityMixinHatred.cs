using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinHatred : BaseAbilityMixin
{
	public AbilityMixinHatred(Ability ab, byte index)
		: base(ab, index)
	{
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtAttacked), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtAttacked), this);
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtAttacked evtAttacked) || (object)owner.GetBTree() == null)
		{
			return;
		}
		Entity entity = evtAttacked.attacker;
		if (entity.TryGetCompProduct(out CompProduct component))
		{
			entity = component.productOwner;
		}
		if (entity.IsAlive())
		{
			CompHatred? compHatred = owner.GetCompHatred();
			compHatred.lastAttacker = entity;
			if (!compHatred.GetHatred().IsValid)
			{
				owner.SetHatred(entity);
			}
			owner.GetBTree()?.SendEvent("attacked");
		}
	}
}

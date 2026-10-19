using Bamboo.ECS;

namespace ACT.Battle;

public class AbilityMixinRecordHatred : BaseAbilityMixin
{
	public AbilityMixinRecordHatred(Ability ab, byte index)
		: base(ab, index)
	{
	}

	internal override void OnAdd()
	{
		owner.GetCompAbility().AddListener(typeof(EvtDamaged), this);
	}

	internal override void OnRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtDamaged), this);
		owner.GetCompHatred().hatredDateList.Clear();
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (!(evt is EvtDamaged evtDamaged))
		{
			return;
		}
		Entity attacker = evtDamaged.attackData.attacker;
		if (attacker.TryGetCompProduct(out CompProduct component))
		{
			attacker = component.productOwner;
		}
		if (attacker.IsAlive())
		{
			CompHatred compHatred = owner.GetCompHatred();
			int actualDamage = evtDamaged.attackData.actualDamage;
			int num = compHatred.hatredDateList.FindIndex((HatredData x) => x.attacker == attacker.Id);
			if (num < 0)
			{
				compHatred.hatredDateList.Add(new HatredData
				{
					attacker = attacker.Id,
					totoalDamge = actualDamage
				});
			}
			else
			{
				HatredData value = compHatred.hatredDateList[num];
				value.totoalDamge += actualDamage;
				compHatred.hatredDateList[num] = value;
			}
		}
	}
}

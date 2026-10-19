using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.World.Behave;

public class DamageAndReCallBehaveEvents : MonoBehaviour
{
	public DarkCoreStoneBehaveEvents stoneBehaveEvents;

	public string abilityName;

	public int damage = 10;

	public Color color;

	public void OnTriggerEnter(Collider other)
	{
		if (!MonoECS.instance.running || stoneBehaveEvents.phase != 2)
		{
			return;
		}
		MonoEntity component = other.gameObject.GetComponent<MonoEntity>();
		if (component.entity.IsLogicAvailable())
		{
			Entity entity = component.entity;
			if (entity.IsCharacter())
			{
				Entity entity2 = stoneBehaveEvents.interactDarkCoreStone.entity;
				CompAbility? compAbility = entity.GetCompAbility();
				int value = compAbility.hp - damage;
				compAbility.ServerSetHP(value);
				compAbility.AddAbility(entity2, abilityName, AbilitySource.Ability, default, 1);
			}
			if (entity.IsMonster())
			{
				entity.KillEntity();
			}
		}
	}
}

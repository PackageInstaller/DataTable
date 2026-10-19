using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改武器AnimatorParam", "Action", new string[] { "change", "weapon", "animator", "param" })]
public class ActionChangeWeaponAnimatorParam : ConfigAction
{
	[Tooltip("填Animator的parameter")]
	public string name;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	public override void Do(ActionMemory memory)
	{
		GameObject gameObject = memory.target.entity.GetMono()?.weaponModel;
		if ((object)gameObject != null)
		{
			Animator component = gameObject.GetComponent<Animator>();
			switch (type)
			{
			case ConfigAnimParameterType.Float:
				component.SetFloat(name, defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				component.SetInteger(name, defaultInt);
				break;
			case ConfigAnimParameterType.Bool:
				component.SetBool(name, defaultBool);
				break;
			case ConfigAnimParameterType.Trigger:
				component.SetTrigger(name);
				break;
			}
		}
	}
}

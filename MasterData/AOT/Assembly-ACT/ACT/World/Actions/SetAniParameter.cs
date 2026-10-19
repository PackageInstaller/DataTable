using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class SetAniParameter : InteractAction
{
	public bool self;

	public Animator Ani;

	public string parameterName;

	public ConfigAnimParameterType type;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (self)
		{
			switch (type)
			{
			case ConfigAnimParameterType.Float:
				behave.SetFloat(parameterName, defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				behave.SetInt(parameterName, defaultInt);
				break;
			case ConfigAnimParameterType.Bool:
				behave.SetBool(parameterName, defaultBool);
				break;
			case ConfigAnimParameterType.Trigger:
				behave.SetTrigger(parameterName);
				break;
			}
		}
		else if ((bool)Ani && (bool)Ani.gameObject)
		{
			switch (type)
			{
			case ConfigAnimParameterType.Float:
				Ani.SetFloat(parameterName, defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				Ani.SetInteger(parameterName, defaultInt);
				break;
			case ConfigAnimParameterType.Bool:
				Ani.SetBool(parameterName, defaultBool);
				break;
			case ConfigAnimParameterType.Trigger:
				Ani.SetTrigger(parameterName);
				break;
			}
		}
		return UniTask.CompletedTask;
	}
}

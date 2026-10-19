using ACT.Battle.Configs;
using ACT.World.Behave;
using Bamboo.ECS;

namespace ACT.World.Asset;

public class SetAnimParameterEvent : DoActionBase
{
	public bool animator;

	public ConfigAnimParameterType type = ConfigAnimParameterType.Bool;

	public float defaultFloat;

	public int defaultInt;

	public bool defaultBool;

	public string parameterName;

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		switch (type)
		{
		case ConfigAnimParameterType.Float:
			if (animator)
			{
				behave.Anim.SetFloat(parameterName, defaultFloat);
			}
			else
			{
				behave.Entity.SetFloat(parameterName, defaultFloat);
			}
			break;
		case ConfigAnimParameterType.Int:
			if (animator)
			{
				behave.Anim.SetInteger(parameterName, defaultInt);
			}
			else
			{
				behave.Entity.SetInt(parameterName, defaultInt);
			}
			break;
		case ConfigAnimParameterType.Bool:
			if (animator)
			{
				behave.Anim.SetBool(parameterName, defaultBool);
			}
			else
			{
				behave.Entity.SetBool(parameterName, defaultBool);
			}
			break;
		case ConfigAnimParameterType.Trigger:
			if (animator)
			{
				behave.Anim.SetTrigger(parameterName);
			}
			else
			{
				behave.Entity.SetTrigger(parameterName);
			}
			break;
		}
		return true;
	}
}

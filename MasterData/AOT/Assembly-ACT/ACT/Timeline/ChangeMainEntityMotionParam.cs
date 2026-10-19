using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ChangeMainEntityMotionParam : ISignalAction
{
	[SerializeField]
	private string _parameterName;

	[SerializeField]
	private ConfigAnimParameterType _type;

	[SerializeField]
	private float _defaultFloat;

	[SerializeField]
	private int _defaultInt;

	[SerializeField]
	private bool _defaultBool;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity.IsLogicAvailable())
		{
			switch (_type)
			{
			case ConfigAnimParameterType.Float:
				mainEntity.SetFloat(_parameterName, _defaultFloat);
				break;
			case ConfigAnimParameterType.Int:
				mainEntity.SetInt(_parameterName, _defaultInt);
				break;
			case ConfigAnimParameterType.Bool:
				mainEntity.SetBool(_parameterName, _defaultBool);
				break;
			case ConfigAnimParameterType.Trigger:
				mainEntity.SetTrigger(_parameterName);
				break;
			}
		}
		return UniTask.CompletedTask;
	}
}

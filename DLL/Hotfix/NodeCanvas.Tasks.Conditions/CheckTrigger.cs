using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("System Events")]
[DoNotList]
public class CheckTrigger : ConditionTask<Collider>
{
	public TriggerTypes checkType;

	public bool specifiedTagOnly;

	[TagField]
	[ShowIf("specifiedTagOnly", 1)]
	public string objectTag = "Untagged";

	[BlackboardOnly]
	public BBParameter<GameObject> saveGameObjectAs;

	private bool stay;

	protected override string info => checkType.ToString() + (specifiedTagOnly ? (" '" + objectTag + "' tag") : "");

	protected override bool OnCheck()
	{
		if (checkType == TriggerTypes.TriggerStay)
		{
			return stay;
		}
		return false;
	}

	protected override void OnEnable()
	{
		base.router.onTriggerEnter += OnTriggerEnter;
		base.router.onTriggerExit += OnTriggerExit;
	}

	protected override void OnDisable()
	{
		base.router.onTriggerEnter -= OnTriggerEnter;
		base.router.onTriggerExit -= OnTriggerExit;
	}

	public void OnTriggerEnter(EventData<Collider> data)
	{
		if (!specifiedTagOnly || ((Component)(object)data.value).gameObject.CompareTag(objectTag))
		{
			stay = true;
			if (checkType == TriggerTypes.TriggerEnter || checkType == TriggerTypes.TriggerStay)
			{
				saveGameObjectAs.value = ((Component)(object)data.value).gameObject;
				YieldReturn(value: true);
			}
		}
	}

	public void OnTriggerExit(EventData<Collider> data)
	{
		if (!specifiedTagOnly || ((Component)(object)data.value).gameObject.CompareTag(objectTag))
		{
			stay = false;
			if (checkType == TriggerTypes.TriggerExit)
			{
				saveGameObjectAs.value = ((Component)(object)data.value).gameObject;
				YieldReturn(value: true);
			}
		}
	}
}

using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("System Events")]
[Name("Check Trigger 2D", 0)]
[DoNotList]
public class CheckTrigger2D : ConditionTask<Collider2D>
{
	public TriggerTypes CheckType;

	public bool specifiedTagOnly;

	[TagField]
	public string objectTag = "Untagged";

	[BlackboardOnly]
	public BBParameter<GameObject> saveGameObjectAs;

	private bool stay;

	protected override string info => CheckType.ToString() + (specifiedTagOnly ? (" '" + objectTag + "' tag") : "");

	protected override bool OnCheck()
	{
		if (CheckType != TriggerTypes.TriggerStay)
		{
			return false;
		}
		return stay;
	}

	protected override void OnEnable()
	{
		base.router.onTriggerEnter2D += OnTriggerEnter2D;
		base.router.onTriggerExit2D += OnTriggerExit2D;
	}

	protected override void OnDisable()
	{
		base.router.onTriggerEnter2D -= OnTriggerEnter2D;
		base.router.onTriggerExit2D -= OnTriggerExit2D;
	}

	public void OnTriggerEnter2D(EventData<Collider2D> data)
	{
		if (!specifiedTagOnly || ((Component)(object)data.value).gameObject.CompareTag(objectTag))
		{
			stay = true;
			if (CheckType == TriggerTypes.TriggerEnter || CheckType == TriggerTypes.TriggerStay)
			{
				saveGameObjectAs.value = ((Component)(object)data.value).gameObject;
				YieldReturn(value: true);
			}
		}
	}

	public void OnTriggerExit2D(EventData<Collider2D> data)
	{
		if (!specifiedTagOnly || ((Component)(object)data.value).gameObject.CompareTag(objectTag))
		{
			stay = false;
			if (CheckType == TriggerTypes.TriggerExit)
			{
				saveGameObjectAs.value = ((Component)(object)data.value).gameObject;
				YieldReturn(value: true);
			}
		}
	}
}

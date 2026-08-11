using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("System Events")]
[Name("Check Collision", 0)]
public class CheckCollision_Rigidbody : ConditionTask<Rigidbody>
{
	public CollisionTypes checkType;

	public bool specifiedTagOnly;

	[TagField]
	public string objectTag = "Untagged";

	[BlackboardOnly]
	public BBParameter<GameObject> saveGameObjectAs;

	[BlackboardOnly]
	public BBParameter<Vector3> saveContactPoint;

	[BlackboardOnly]
	public BBParameter<Vector3> saveContactNormal;

	private bool stay;

	protected override string info => checkType.ToString() + (specifiedTagOnly ? (" '" + objectTag + "' tag") : "");

	protected override void OnEnable()
	{
		base.router.onCollisionEnter += OnCollisionEnter;
		base.router.onCollisionExit += OnCollisionExit;
	}

	protected override void OnDisable()
	{
		base.router.onCollisionEnter -= OnCollisionEnter;
		base.router.onCollisionExit -= OnCollisionExit;
	}

	protected override bool OnCheck()
	{
		if (checkType != CollisionTypes.CollisionStay)
		{
			return false;
		}
		return stay;
	}

	public void OnCollisionEnter(EventData<Collision> data)
	{
		if (!specifiedTagOnly || data.value.gameObject.CompareTag(objectTag))
		{
			stay = true;
			if (checkType == CollisionTypes.CollisionEnter || checkType == CollisionTypes.CollisionStay)
			{
				saveGameObjectAs.value = data.value.gameObject;
				saveContactPoint.value = ((ContactPoint)(ref data.value.contacts[0])).point;
				saveContactNormal.value = ((ContactPoint)(ref data.value.contacts[0])).normal;
				YieldReturn(value: true);
			}
		}
	}

	public void OnCollisionExit(EventData<Collision> data)
	{
		if (!specifiedTagOnly || data.value.gameObject.CompareTag(objectTag))
		{
			stay = false;
			if (checkType == CollisionTypes.CollisionExit)
			{
				saveGameObjectAs.value = data.value.gameObject;
				YieldReturn(value: true);
			}
		}
	}
}

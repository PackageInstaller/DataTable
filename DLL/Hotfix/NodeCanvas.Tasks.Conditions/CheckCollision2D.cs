using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("System Events")]
[Name("Check Collision 2D", 0)]
[DoNotList]
public class CheckCollision2D : ConditionTask<Collider2D>
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

	protected override bool OnCheck()
	{
		if (checkType != CollisionTypes.CollisionStay)
		{
			return false;
		}
		return stay;
	}

	protected override void OnEnable()
	{
		base.router.onCollisionEnter2D += OnCollisionEnter2D;
		base.router.onCollisionExit2D += OnCollisionExit2D;
	}

	protected override void OnDisable()
	{
		base.router.onCollisionEnter2D -= OnCollisionEnter2D;
		base.router.onCollisionExit2D -= OnCollisionExit2D;
	}

	private void OnCollisionEnter2D(EventData<Collision2D> data)
	{
		if (!specifiedTagOnly || data.value.gameObject.CompareTag(objectTag))
		{
			stay = true;
			if (checkType == CollisionTypes.CollisionEnter || checkType == CollisionTypes.CollisionStay)
			{
				saveGameObjectAs.value = data.value.gameObject;
				saveContactPoint.value = ((ContactPoint2D)(ref data.value.contacts[0])).point;
				saveContactNormal.value = ((ContactPoint2D)(ref data.value.contacts[0])).normal;
				YieldReturn(value: true);
			}
		}
	}

	private void OnCollisionExit2D(EventData<Collision2D> data)
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

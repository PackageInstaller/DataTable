using UnityEngine;

namespace Ase;

public class MathSphereTrigger : MathTriggerBase
{
	[SerializeField]
	private float _radius = 1f;

	private float scaledRadius;

	private Bounds cachedBounds;

	public float radius
	{
		get
		{
			return _radius;
		}
		set
		{
			_radius = value;
		}
	}

	protected override void OnInit()
	{
		scaledRadius = radius * Mathf.Max(base.Scale.x, base.Scale.y, base.Scale.z);
		cachedBounds = new Bounds(base.Position + base.center, Vector3.one * scaledRadius * 2f);
	}

	public override bool Contains(Vector3 point)
	{
		if (base.Dynamic)
		{
			scaledRadius = radius * Mathf.Max(base.Scale.x, base.Scale.y, base.Scale.z);
		}
		return Vector3.Distance(base.Position + base.center, point) <= scaledRadius;
	}

	public override bool Intersects(Bounds bounds)
	{
		if (base.Dynamic)
		{
			Vector3 scale = base.Scale;
			scaledRadius = radius * Mathf.Max(scale.x, scale.y, scale.z);
		}
		Vector3 vector = base.Position + base.center;
		Vector3 vector2 = bounds.ClosestPoint(vector);
		return (vector - vector2).sqrMagnitude <= scaledRadius * scaledRadius;
	}

	public override Bounds Bounds()
	{
		return cachedBounds;
	}

	protected override void OnDrawGizmosSelected()
	{
		base.OnDrawGizmosSelected();
		float num = radius * Mathf.Max(base.Scale.x, base.Scale.y, base.Scale.z);
		Gizmos.DrawWireSphere(Vector3.zero, num);
	}
}

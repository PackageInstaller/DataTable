using Pathfinding;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Collider/Obstacle")]
public class AdventureObstacle : LogicEntity
{
	public bool preventNormalAttack = true;

	[Space]
	public HeightClass heightClass = HeightClass.Medium;

	public NavmeshCut navmeshCut;

	public Collider collider;

	public DestructibleStateSingle _destructibleStateObj;

	public DeterministicCollider dtCollider { get; protected set; }

	private void OnValidate()
	{
		if (navmeshCut == null)
		{
			navmeshCut = GetComponent<NavmeshCut>();
		}
		bool isRC = false;
		if (navmeshCut != null)
		{
			isRC = navmeshCut.type == NavmeshCut.MeshType.Rectangle;
		}
		DeterministicCollider deterministicCollider = null;
		this.SetDeterministicCollider(ref collider, ref deterministicCollider, isRC);
		dtCollider = deterministicCollider;
	}

	protected override void OnInit()
	{
		if (navmeshCut == null)
		{
			navmeshCut = GetComponent<NavmeshCut>();
		}
		if (_destructibleStateObj == null)
		{
			_destructibleStateObj = GetComponent<DestructibleStateSingle>();
		}
		DeterministicCollider deterministicCollider = null;
		if (_destructibleStateObj != null)
		{
			return;
		}
		this.SetDeterministicCollider(ref collider, ref deterministicCollider);
		dtCollider = deterministicCollider;
		gameObject.layer = 12;
		if (dtCollider != null)
		{
			dtCollider.layer = 12;
			dtCollider.priority = 5;
		}
		if (navmeshCut != null && !checkIsInteractive())
		{
			switch (navmeshCut.type)
			{
			case NavmeshCut.MeshType.Rectangle:
				navmeshCut.rectangleSize = new TSVector2(1f / transform.localScale.x + 1f, 1f / transform.localScale.z + 1f);
				break;
			case NavmeshCut.MeshType.Circle:
				navmeshCut.circleRadius = 0.5f / transform.localScale.x + 0.5f;
				navmeshCut.circleResolution = 8;
				break;
			}
		}
	}

	private bool checkIsInteractive()
	{
		if (transform.parent == null)
		{
			return false;
		}
		return transform.parent.GetComponent<InteractiveBase>() != null;
	}

	public void initData()
	{
		DeterministicCollider dc = null;
		_destructibleStateObj.SetDeterministicCollider(ref collider, ref dc);
		dtCollider = dc;
		_destructibleStateObj.setDc(dc);
		if (dtCollider != null)
		{
			dtCollider.priority = 5;
		}
	}

	protected override void OnActive()
	{
		if (null != dtCollider && null != dtCollider.tsTransform)
		{
			dtCollider.tsTransform.Dirty = true;
		}
	}

	protected override void OnDeactive()
	{
	}
}

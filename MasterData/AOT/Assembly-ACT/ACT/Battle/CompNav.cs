using PathFinding2D.Runtime.Models;
using UnityEngine;
using UnityEngine.AI;

namespace ACT.Battle;

public class CompNav : EcsComponent
{
	private ACTNavMeshAgent _navMeshAgent;

	public bool isAir;

	public NavigationMoveCapability moveCapability;

	private bool _manual;

	private Vector3 _destination;

	private bool _isStopped;

	public NavMeshPath path { get; private set; }

	public ACTNavMeshAgent navMeshAgent
	{
		get
		{
			return _navMeshAgent;
		}
		set
		{
			isStopped = true;
			_navMeshAgent = value;
		}
	}

	public float sqrStoppingDistance
	{
		get
		{
			if (!(_navMeshAgent != null))
			{
				return 0.04f;
			}
			return _navMeshAgent.sqrStoppingDistance;
		}
	}

	public bool manual
	{
		get
		{
			return _manual;
		}
		set
		{
			_manual = value;
			destination = navPosition;
		}
	}

	public Vector3 destination
	{
		get
		{
			return _destination;
		}
		set
		{
			_destination = value;
		}
	}

	public Vector3 navPosition { get; set; }

	public bool isStopped
	{
		get
		{
			return _isStopped;
		}
		set
		{
			_isStopped = value;
			if (value)
			{
				destination = navPosition;
			}
		}
	}

	public bool isArrived
	{
		get
		{
			if (!isAir)
			{
				if (!CheckArrived(_navMeshAgent.transform.position, _destination))
				{
					return _navMeshAgent.isArrived;
				}
				return true;
			}
			return CheckArrived(_navMeshAgent.transform.position, _destination);
		}
	}

	public NavMeshPathStatus pathStatus => path.status;

	public int areaMask => _navMeshAgent.areaMask;

	public void SetManualKeepDestination(bool value)
	{
		_manual = value;
	}

	public bool CheckArrived(Vector3 sourcePosition, Vector3 targetPosition)
	{
		return Vector3.Scale(sourcePosition - targetPosition, new Vector3(1f, 1f, 0f)).sqrMagnitude <= sqrStoppingDistance;
	}

	protected override void OnGet()
	{
		path = new NavMeshPath();
		moveCapability = NavigationMoveCapability.WalkAndDrop;
	}

	protected override void OnRelease()
	{
		_navMeshAgent = null;
		_manual = false;
		_destination = Vector3.zero;
		path = null;
		moveCapability = NavigationMoveCapability.WalkAndDrop;
	}
}

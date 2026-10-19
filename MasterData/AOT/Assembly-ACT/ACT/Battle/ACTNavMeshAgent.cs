using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using PathFinding2D.Runtime;
using PathFinding2D.Runtime.Models;
using UnityEngine;
using UnityEngine.AI;

namespace ACT.Battle;

[AddComponentMenu("ACT/ACTNavMeshAgent")]
public class ACTNavMeshAgent : LuminSerializedMonoBehaviour
{
	private const float SAMPLE_DISTANCE = 1000f;

	[SerializeField]
	private int m_AreaMask = -1;

	[SerializeField]
	private bool m_UsePathFinding2D;

	private List<Waypoint> pathWaypoints;

	private int currentWaypointIndex;

	private Vector3 m_NavPosition;

	private Vector3 m_Destination;

	private NavMeshPath m_Path;

	private NavMeshPath m_NextPath;

	[SerializeField]
	[HideInInspector]
	private float m_SqrStoppingDistance;

	private bool m_IsStopped = true;

	public bool hasAttackToken = true;

	private bool m_IsArrived;

	private Vector3 m_FirstCorner;

	private int index;

	[SerializeField]
	private Vector3 CheckMask = new Vector3(1f, 1f, 0f);

	private float lastCalculateTime;

	private CancellationTokenSource cancellationTokenSource;

	public int areaMask
	{
		get
		{
			return m_AreaMask;
		}
		set
		{
			m_AreaMask = value;
		}
	}

	public bool usePathFinding2D
	{
		get
		{
			if (m_UsePathFinding2D && NavigationRuntime.IsInstantiated)
			{
				return NavigationRuntime.Instance.Map != null;
			}
			return false;
		}
	}

	public WaypointLayerMask waypointLayerMask => areaMask;

	public NavigationMoveCapability moveCapability { get; set; }

	public Vector3 navPosition
	{
		get
		{
			return m_NavPosition;
		}
		set
		{
			Vector3 vector = m_NavPosition;
			if (usePathFinding2D)
			{
				m_NavPosition = value;
				return;
			}
			if (NavMesh.SamplePosition(value, out var hit, 1000f, m_AreaMask))
			{
				m_NavPosition = hit.position;
			}
			if ((vector - firstCorner).sqrMagnitude < (m_NavPosition - firstCorner).sqrMagnitude)
			{
				CalculatePath();
			}
		}
	}

	public Vector3 destination
	{
		get
		{
			return m_Destination;
		}
		set
		{
			if (usePathFinding2D)
			{
				m_Destination = value;
				CalculatePath2D();
				return;
			}
			if (NavMesh.SamplePosition(value, out var hit, 1000f, m_AreaMask))
			{
				m_Destination = hit.position;
			}
			if (index == path.corners.Length - 1 && !CheckArrived(m_Destination, path.corners[path.corners.Length - 1]))
			{
				CalculatePath();
			}
		}
	}

	private NavMeshPath path
	{
		get
		{
			if (m_Path == null)
			{
				m_Path = new NavMeshPath();
			}
			return m_Path;
		}
		set
		{
			m_Path = value;
		}
	}

	public NavMeshPath nextPath
	{
		get
		{
			if (m_NextPath == null)
			{
				m_NextPath = new NavMeshPath();
			}
			return m_NextPath;
		}
		set
		{
			m_NextPath = value;
		}
	}

	public NavMeshPathStatus pathStatus
	{
		get
		{
			if (usePathFinding2D)
			{
				if (pathWaypoints == null || pathWaypoints.Count <= 0)
				{
					return NavMeshPathStatus.PathInvalid;
				}
				return NavMeshPathStatus.PathComplete;
			}
			return path.status;
		}
	}

	public bool hasPath
	{
		get
		{
			if (usePathFinding2D)
			{
				if (pathWaypoints != null)
				{
					return pathWaypoints.Count > 0;
				}
				return false;
			}
			if (path != null && path.corners != null)
			{
				return path.corners.Length != 0;
			}
			return false;
		}
	}

	public float stoppingDistance
	{
		get
		{
			return Mathf.Sqrt(m_SqrStoppingDistance);
		}
		set
		{
			m_SqrStoppingDistance = value * value;
		}
	}

	public float sqrStoppingDistance => m_SqrStoppingDistance;

	public bool isStopped
	{
		get
		{
			return m_IsStopped;
		}
		set
		{
			m_IsStopped = value;
			if (!value)
			{
				CalculatePath();
			}
		}
	}

	public bool isArrived
	{
		get
		{
			if (usePathFinding2D)
			{
				if (pathWaypoints != null)
				{
					return currentWaypointIndex >= pathWaypoints.Count;
				}
				return true;
			}
			return m_IsArrived;
		}
		private set
		{
			m_IsArrived = value;
		}
	}

	public bool isOnNavMesh { get; private set; } = true;

	public Vector3 firstCorner
	{
		get
		{
			if (usePathFinding2D)
			{
				if (pathWaypoints != null && currentWaypointIndex < pathWaypoints.Count)
				{
					return pathWaypoints[currentWaypointIndex].Position;
				}
				return navPosition;
			}
			return m_FirstCorner;
		}
		private set
		{
			m_FirstCorner = value;
		}
	}

	public bool CheckArrived(Vector3 sourcePosition, Vector3 targetPosition)
	{
		return Vector3.Scale(sourcePosition - targetPosition, CheckMask).sqrMagnitude <= m_SqrStoppingDistance;
	}

	public void CalculatePath()
	{
		if (usePathFinding2D)
		{
			CalculatePath2D();
			return;
		}
		if (cancellationTokenSource != null)
		{
			cancellationTokenSource.Cancel();
			cancellationTokenSource.Dispose();
		}
		cancellationTokenSource = new CancellationTokenSource();
		Calculate(cancellationTokenSource.Token).Forget();
	}

	private void CalculatePath2D()
	{
		NavigationMap map = NavigationRuntime.Instance.Map;
		if (map != null)
		{
			pathWaypoints = map.Navigate(navPosition, destination, waypointLayerMask, moveCapability);
			currentWaypointIndex = 0;
			if (pathWaypoints != null && pathWaypoints.Count > 0)
			{
				m_FirstCorner = pathWaypoints[0].Position;
				m_IsArrived = false;
				lastCalculateTime = Time.time;
			}
			else
			{
				m_IsArrived = true;
			}
		}
	}

	private async UniTaskVoid Calculate(CancellationToken cancellationToken)
	{
		isOnNavMesh = NavMesh.CalculatePath(navPosition, destination, m_AreaMask, nextPath);
		if (!isOnNavMesh)
		{
			return;
		}
		await UniTask.WaitUntil(IsPathComplete, PlayerLoopTiming.Update, cancellationToken);
		if (!cancellationToken.IsCancellationRequested)
		{
			NavMeshPath navMeshPath = path;
			path = nextPath;
			nextPath = navMeshPath;
			if (path.corners.Length > 1)
			{
				firstCorner = path.corners[1];
				index = 1;
				isArrived = false;
			}
			else
			{
				firstCorner = path.corners[0];
				index = 0;
				isArrived = true;
			}
			lastCalculateTime = Time.time;
		}
	}

	private bool IsPathComplete()
	{
		return nextPath.status == NavMeshPathStatus.PathComplete;
	}

	public void ReCalculatePath(Vector3 lastPosition, Vector3 newPosition)
	{
		if (!CheckArrived(lastPosition, newPosition))
		{
			CalculatePath();
		}
	}

	public static bool CanNavigateBetween(Vector3 start, Vector3 end, int areaMask, NavigationMoveCapability capability = NavigationMoveCapability.WalkAndDrop)
	{
		NavMeshPath navMeshPath = new NavMeshPath();
		if (NavMesh.CalculatePath(start, end, areaMask, navMeshPath) && navMeshPath.status == NavMeshPathStatus.PathComplete)
		{
			return true;
		}
		if (NavigationRuntime.IsInstantiated && NavigationRuntime.Instance.Map != null)
		{
			WaypointLayerMask layerMask = areaMask;
			return NavigationRuntime.Instance.Map.CanNavigate(start, end, layerMask, capability);
		}
		return false;
	}
}

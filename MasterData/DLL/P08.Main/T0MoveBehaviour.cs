using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Cinemachine;
using P08.T0World.Locomotion;
using Pathfinding;
using Sirenix.OdinInspector;
using UnityEngine;

public abstract class T0MoveBehaviour : SerializedMonoBehaviour
{
	public CancellationTokenSource cancel;

	public abstract bool IsReadyToMove { get; }

	private void OnDestroy()
	{
		if (cancel != null)
		{
			cancel.Cancel();
		}
	}

	public abstract Task<bool> StartMove(CinemachinePathBase path, CancellationToken cancel);

	public abstract Task StopMove(CancellationToken cancel = default(CancellationToken));

	public static void ConstructSmoothPath(Path path, Vector3 startFacingDir, Vector3 lookAtDir, T0MovePath smoothPath, float tangantStrenth = 0.25f)
	{
		smoothPath.worldSpacePath = true;
		smoothPath.m_Waypoints = path.int3Path.Select((Int3 i3pos) => new CinemachineSmoothPath.Waypoint
		{
			position = (Vector3)i3pos
		}).ToArray();
		smoothPath.controlPointIn = new CinemachineSmoothPath.Waypoint
		{
			position = smoothPath.m_Waypoints[1].position - tangantStrenth * startFacingDir
		};
		CinemachineSmoothPath.Waypoint controlPointOut = default(CinemachineSmoothPath.Waypoint);
		CinemachineSmoothPath.Waypoint[] waypoints = smoothPath.m_Waypoints;
		controlPointOut.position = waypoints[waypoints.Length - 2].position + tangantStrenth * lookAtDir;
		smoothPath.controlPointOut = controlPointOut;
		smoothPath.InvalidateDistanceCache();
	}

	public abstract Task ChangeMovePath(CinemachinePathBase path, bool needRotate, CancellationToken cancel);
}

using UnityEngine;

public class PreFrameRaycast : MonoBehaviour
{
	private RaycastHit hitInfo;

	private Transform tr;

	private void Start()
	{
	}

	private void Awake()
	{
		tr = base.transform;
	}

	private void Update()
	{
		hitInfo = default(RaycastHit);
		Physics.Raycast(tr.position, tr.forward, out hitInfo);
		Debug.DrawRay(tr.position, tr.forward, Color.red);
	}

	public RaycastHit GetHitInfo()
	{
		if (hitInfo.Equals(null))
		{
			Debug.LogWarning("hitInfo is null");
		}
		return hitInfo;
	}
}

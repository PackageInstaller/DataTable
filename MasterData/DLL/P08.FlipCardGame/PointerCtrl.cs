using UnityEngine;

public class PointerCtrl : MonoBehaviour
{
	public float scrollSpeed = 0.5f;

	public float pulseSpeed = 1.5f;

	public float noiseSize = 1f;

	public float maxWidth = 0.5f;

	public float minWidth = 0.5f;

	private float aniTime;

	private float aniDir = 1f;

	private LineRenderer lRenderer;

	public GameObject pointer;

	private PreFrameRaycast raycast;

	private void Start()
	{
		lRenderer = base.gameObject.GetComponent(typeof(LineRenderer)) as LineRenderer;
		raycast = base.gameObject.GetComponent(typeof(PreFrameRaycast)) as PreFrameRaycast;
	}

	private void Update()
	{
		float b = Mathf.PingPong(Time.time * pulseSpeed, 1f);
		b = Mathf.Max(minWidth, b) * maxWidth;
		lRenderer.SetWidth(b, b);
		lRenderer.SetPosition(0, base.gameObject.transform.position);
		if (raycast == null)
		{
			Debug.Log("raycast is null");
			return;
		}
		RaycastHit hitInfo = raycast.GetHitInfo();
		if ((bool)hitInfo.transform)
		{
			lRenderer.SetPosition(1, hitInfo.point);
			GetComponent<Renderer>().material.mainTextureScale = new Vector2(0.1f * hitInfo.distance, GetComponent<Renderer>().material.mainTextureScale.y);
			if ((bool)pointer)
			{
				pointer.GetComponent<Renderer>().enabled = true;
				pointer.transform.position = hitInfo.point;
				pointer.transform.rotation = Quaternion.LookRotation(hitInfo.normal, base.transform.up);
				pointer.transform.eulerAngles = new Vector3(90f, pointer.transform.eulerAngles.y, pointer.transform.eulerAngles.z);
			}
		}
		else
		{
			if ((bool)pointer)
			{
				pointer.GetComponent<Renderer>().enabled = false;
			}
			float num = 200f;
			lRenderer.SetPosition(1, base.transform.forward * num);
			GetComponent<Renderer>().material.mainTextureScale = new Vector2(0.1f * num, GetComponent<Renderer>().material.mainTextureScale.y);
		}
	}
}

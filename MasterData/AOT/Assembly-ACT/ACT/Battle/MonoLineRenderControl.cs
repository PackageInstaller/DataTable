using UnityEngine;

namespace ACT.Battle;

[ExecuteAlways]
public class MonoLineRenderControl : MonoBehaviour
{
	private LineRenderer line;

	public float startWidth;

	public float endWidth;

	private void Awake()
	{
		line = GetComponent<LineRenderer>();
	}

	private void Update()
	{
		if (line != null)
		{
			line.startWidth = startWidth;
			line.endWidth = endWidth;
		}
	}
}

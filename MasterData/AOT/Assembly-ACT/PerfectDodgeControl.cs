using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public class PerfectDodgeControl : MonoBehaviour
{
	private Volume volume;

	[Range(0f, 1f)]
	public float weight;

	private void Awake()
	{
		volume = GetComponent<Volume>();
	}

	private void Update()
	{
		if (volume != null)
		{
			volume.weight = weight;
		}
	}
}

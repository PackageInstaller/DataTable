using UnityEngine;

namespace ACT.VolumeControl;

public class GlobalVolumeControlTest : MonoBehaviour
{
	public bool useControl;

	private float defaultFogStartDistance;

	private float defaultFogEndDistance;

	private float defaultfFogDensity;

	[ColorUsage(true, true)]
	private Color defaultFogColor;

	[ColorUsage(true, true)]
	public Color fogColor;

	public float fogStartDistance;

	public float fogEndDistance;

	public float fogDensity;

	private void Awake()
	{
		defaultFogStartDistance = RenderSettings.fogStartDistance;
		defaultFogEndDistance = RenderSettings.fogEndDistance;
		defaultfFogDensity = RenderSettings.fogDensity;
		defaultFogColor = RenderSettings.fogColor;
	}

	private void Start()
	{
		defaultFogStartDistance = RenderSettings.fogStartDistance;
		defaultFogEndDistance = RenderSettings.fogEndDistance;
		defaultfFogDensity = RenderSettings.fogDensity;
		defaultFogColor = RenderSettings.fogColor;
	}

	private void Update()
	{
		if (useControl)
		{
			RenderSettings.fogStartDistance = fogStartDistance;
			RenderSettings.fogEndDistance = fogEndDistance;
			RenderSettings.fogDensity = fogDensity;
			RenderSettings.fogColor = fogColor;
		}
	}

	private void OnDisable()
	{
		RenderSettings.fogStartDistance = defaultFogStartDistance;
		RenderSettings.fogEndDistance = defaultFogEndDistance;
		RenderSettings.fogDensity = defaultfFogDensity;
		RenderSettings.fogColor = defaultFogColor;
	}
}

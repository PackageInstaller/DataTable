using Cinemachine;
using UnityEngine;
using UnityEngine.Rendering;

namespace Ase;

public class OuterSceneSetting : MonoBehaviour
{
	[ColorUsage(true, true)]
	public Color ambientLight;

	public Material skyBoxMaterial;

	public GameObject directionLight;

	public Cubemap cubeMap;

	public DefaultReflectionMode reflectionMode;

	public GameObject postProcessing;

	public CinemachineVirtualCamera virtualCamera;

	[SerializeField]
	private GameObject _refRoot;

	private void OnEnable()
	{
		if (_refRoot != null)
		{
			_refRoot.SetActive(value: true);
		}
		RenderSettings.ambientLight = ambientLight;
		RenderSettings.skybox = skyBoxMaterial;
		if (directionLight != null)
		{
			directionLight.SetActive(value: true);
		}
		RenderSettings.defaultReflectionMode = reflectionMode;
		RenderSettings.customReflection = ((reflectionMode == DefaultReflectionMode.Custom) ? cubeMap : null);
		if (postProcessing != null)
		{
			postProcessing.SetActive(value: true);
		}
		if (virtualCamera != null)
		{
			virtualCamera.gameObject.SetActive(value: true);
		}
	}

	private void OnDisable()
	{
		if (directionLight != null)
		{
			directionLight.SetActive(value: false);
		}
		if (postProcessing != null)
		{
			postProcessing.SetActive(value: false);
		}
		if (_refRoot != null)
		{
			_refRoot.SetActive(value: false);
		}
		Restore();
	}

	private void Restore()
	{
		RenderSettings.ambientLight = Color.white;
		RenderSettings.skybox = null;
		RenderSettings.defaultReflectionMode = DefaultReflectionMode.Skybox;
		RenderSettings.customReflection = null;
	}
}

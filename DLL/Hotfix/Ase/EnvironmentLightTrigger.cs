using Ase.ECS;
using UnityEngine;

namespace Ase;

public class EnvironmentLightTrigger : MonoBehaviour, IMathTriggerEventHandler
{
	public bool openBlend;

	public EnvironmentData environmentData = new EnvironmentData();

	private bool isApply;

	public EnvironmentLightCtrl environmentLightCtrl;

	private EnvironmentLightCtrl EnvironmentLightCtrl => environmentLightCtrl;

	private void CollectData()
	{
		Light[] array = Object.FindObjectsOfType<Light>();
		Light light = null;
		Light[] array2 = array;
		foreach (Light light2 in array2)
		{
			if (light2.type == LightType.Directional)
			{
				light = light2;
				break;
			}
		}
		environmentData.skyMaterial = RenderSettings.skybox;
		environmentData.ambientMode = RenderSettings.ambientMode;
		environmentData.ambientLight = RenderSettings.ambientSkyColor;
		environmentData.ambientSkyColor = RenderSettings.ambientSkyColor;
		environmentData.ambientEquatorColor = RenderSettings.ambientEquatorColor;
		environmentData.ambientGroundColor = RenderSettings.ambientGroundColor;
		environmentData.ambientIntensity = RenderSettings.ambientIntensity;
		environmentData.rotation = light.transform.rotation.eulerAngles;
		environmentData.cullingMask = light.cullingMask;
		environmentData.emissionColor = light.color;
		environmentData.emissionIntensity = light.intensity;
		environmentData.emissionIndirectMultiplier = light.bounceIntensity;
	}

	public void OnMathTriggerEnter(MathTriggerEventData eventData)
	{
		if (!(EnvironmentLightCtrl == null) && eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity && !isApply)
		{
			EnvironmentLightCtrl.ApplyEnvironmentData(environmentData, openBlend);
			isApply = true;
		}
	}

	public void OnMathTriggerExit(MathTriggerEventData eventData)
	{
		if (!(EnvironmentLightCtrl == null) && eventData.Other.TryGetComponent<EntityView>(out var component) && component.Entity != null && component.Entity.IsActorEntity && isApply)
		{
			EnvironmentLightCtrl.RemoveEnvironmentData(environmentData, openBlend);
			isApply = false;
		}
	}

	public void OnMathTriggerStay(MathTriggerEventData eventData)
	{
	}
}

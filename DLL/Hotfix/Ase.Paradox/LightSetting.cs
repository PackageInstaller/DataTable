using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase.Paradox;

[Name("调整灯光", 0)]
[Category("✫ DragonLost/SceneSetting")]
[Description("调整场景内指定灯光参数")]
public class LightSetting : ActionTaskBase
{
	[Name("是否根据当前实体获取", 0)]
	public bool isGetByEntity;

	[Name("场景名", 0)]
	[ShowIf("isGetByEntity", false)]
	public string sceneName;

	[Name("跟节点名", 0)]
	[ShowIf("isGetByEntity", false)]
	public string rootGameObjectName;

	[Name("子路径", 0)]
	public string childPath;

	[Name("开关", 0)]
	public bool lightEnabled;

	[Name("颜色开关", 0)]
	public bool colorEnabled;

	[Name("颜色", 0)]
	[ShowIf("colorEnabled", true)]
	public Color lightColor = Color.white;

	[Name("是否调整强度", 0)]
	public bool intensityEnabled;

	[Name("是否调整Bounce强度", 0)]
	public bool bounceIntensityEnabled;

	[Name("强度", 0)]
	[ShowIf("intensityEnabled", true)]
	public float lightIntensity;

	[Name("Bounce强度", 0)]
	[ShowIf("bounceIntensityEnabled", true)]
	public float bounceIntensity;

	[Name("是否调整范围", 0)]
	public bool rangeEnabled;

	[Name("范围", 0)]
	[ShowIf("rangeEnabled", true)]
	public float lightRange;

	[Name("时间", 0)]
	public float durationTime;

	[Name("是否随行为树结束而销毁", 0)]
	public bool isFollowDispose;

	private Light lightComponent;

	private bool beforeEnabled;

	private Color beforeColor;

	private float beforeIntensity;

	private float beforeRange;

	private float beforeBounceIntensity;

	private float frame_Intensity;

	private float frame_Range;

	private float frame_r;

	private float frame_g;

	private float frame_b;

	private float frame_a;

	private float frame_BounceIntensity;

	protected override void OnExecute()
	{
		base.OnExecute();
		Transform lightTransform = GetLightTransform();
		if (lightTransform == null)
		{
			OnActionFail("调整灯光节点错误，未找到对应灯光预设.");
			return;
		}
		lightComponent = lightTransform.GetComponent<Light>();
		if (lightComponent == null)
		{
			OnActionFail("调整灯光节点错误，未找到对应灯光组件.");
			return;
		}
		beforeEnabled = lightComponent.gameObject.activeSelf;
		beforeColor = lightComponent.color;
		beforeIntensity = lightComponent.intensity;
		beforeRange = lightComponent.range;
		if (bounceIntensityEnabled)
		{
			beforeBounceIntensity = lightComponent.bounceIntensity;
		}
		lightComponent.gameObject.SetActive(lightEnabled);
		if (durationTime <= 0f)
		{
			if (intensityEnabled)
			{
				lightComponent.intensity = lightIntensity;
			}
			if (rangeEnabled)
			{
				lightComponent.range = lightRange;
			}
			if (colorEnabled)
			{
				lightComponent.color = lightColor;
			}
			if (bounceIntensityEnabled)
			{
				lightComponent.bounceIntensity = bounceIntensity;
			}
			OnActionFinish();
		}
		else
		{
			frame_Intensity = (intensityEnabled ? ((lightIntensity - beforeIntensity) / durationTime * base.ownerSystem.deltaTime) : 0f);
			frame_Range = (rangeEnabled ? ((lightRange - beforeRange) / durationTime * base.ownerSystem.deltaTime) : 0f);
			if (colorEnabled)
			{
				frame_r = (lightColor.r - beforeColor.r) / durationTime * base.ownerSystem.deltaTime;
				frame_g = (lightColor.g - beforeColor.g) / durationTime * base.ownerSystem.deltaTime;
				frame_b = (lightColor.b - beforeColor.b) / durationTime * base.ownerSystem.deltaTime;
				frame_a = (lightColor.a - beforeColor.a) / durationTime * base.ownerSystem.deltaTime;
			}
			else
			{
				frame_r = (frame_g = (frame_b = (frame_a = 0f)));
			}
			if (bounceIntensityEnabled)
			{
				frame_BounceIntensity = (bounceIntensity - beforeBounceIntensity) / durationTime * base.ownerSystem.deltaTime;
			}
		}
	}

	protected override void OnUpdate()
	{
		if (durationTime <= 0f)
		{
			return;
		}
		if (base.elapsedTime > durationTime)
		{
			if (intensityEnabled)
			{
				lightComponent.intensity = lightIntensity;
			}
			if (rangeEnabled)
			{
				lightComponent.range = lightRange;
			}
			if (colorEnabled)
			{
				lightComponent.color = lightColor;
			}
			if (bounceIntensityEnabled)
			{
				lightComponent.bounceIntensity = bounceIntensity;
			}
			OnActionFinish();
			return;
		}
		if (intensityEnabled)
		{
			lightComponent.intensity += frame_Intensity;
		}
		if (rangeEnabled)
		{
			lightComponent.range += frame_Range;
		}
		if (colorEnabled)
		{
			Color color = lightComponent.color;
			color.r += frame_r;
			color.g += frame_g;
			color.b += frame_b;
			color.a += frame_a;
			lightComponent.color = color;
		}
		if (bounceIntensityEnabled)
		{
			lightComponent.bounceIntensity += frame_BounceIntensity;
		}
	}

	protected Transform GetLightTransform()
	{
		if (string.IsNullOrEmpty(childPath))
		{
			return null;
		}
		if (isGetByEntity)
		{
			GameObject entityObject = ownerEntity.GetEntityObject();
			if (entityObject == null)
			{
				return null;
			}
			Transform transform = entityObject.transform.Find(childPath);
			if (transform != null)
			{
				return transform;
			}
		}
		else
		{
			if (string.IsNullOrEmpty(rootGameObjectName))
			{
				return null;
			}
			Scene scene;
			if (!string.IsNullOrEmpty(sceneName))
			{
				scene = SceneManager.GetSceneByName(sceneName);
			}
			else
			{
				GameObject entityObject2 = ownerEntity.GetEntityObject();
				if (entityObject2 == null)
				{
					EndAction();
					return null;
				}
				scene = entityObject2.scene;
			}
			GameObject[] rootGameObjects = scene.GetRootGameObjects();
			if (rootGameObjects.IsNullOrEmpty())
			{
				return null;
			}
			GameObject[] array = rootGameObjects;
			foreach (GameObject gameObject in array)
			{
				if (gameObject.name.Equals(rootGameObjectName))
				{
					Transform transform2 = gameObject.transform.Find(childPath);
					if (transform2 != null)
					{
						return transform2;
					}
				}
			}
		}
		return null;
	}

	protected override void OnGraphStop()
	{
		if (isFollowDispose && !(lightComponent == null))
		{
			lightComponent.gameObject.SetActive(beforeEnabled);
			if (colorEnabled)
			{
				lightComponent.color = beforeColor;
			}
			if (intensityEnabled)
			{
				lightComponent.intensity = beforeIntensity;
			}
			if (rangeEnabled)
			{
				lightComponent.range = beforeRange;
			}
			if (bounceIntensityEnabled)
			{
				lightComponent.bounceIntensity = beforeBounceIntensity;
			}
			lightComponent = null;
		}
	}
}

using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Ase.Paradox;

[Name("调整地板贴图参数", 0)]
[Category("✫ DragonLost/Scene")]
[Description("调整地板贴图参数")]
public class ModifyGroundMaterial : ActionTaskBase
{
	[Name("场景名", 0)]
	public string sceneName;

	[Name("跟节点名", 0)]
	public string rootGameObjectName;

	[Name("子路径", 0)]
	public string childPath;

	[Name("材质名", 0)]
	public string materialName;

	[Name("法线强度", 0)]
	public float normalStrength;

	[Name("地图范围", 0)]
	public float mapRange;

	[Name("帧数", 0)]
	public int changeFrame;

	[Name("是否跟随行为树结束还原", 0)]
	public bool isFollowDispose;

	private Material material;

	private float nsOriginValue;

	private float mrOriginValue;

	private float nsFrameValue;

	private float mrFrameVale;

	private float tempFrame;

	protected override void OnExecute()
	{
		base.OnExecute();
		Transform groundTransform = GetGroundTransform();
		if (groundTransform == null)
		{
			EndAction();
			return;
		}
		Renderer component = groundTransform.GetComponent<Renderer>();
		if (component == null)
		{
			EndAction();
			return;
		}
		List<Material> list = new List<Material>();
		component.GetMaterials(list);
		material = list.Find((Material b) => b.name == materialName);
		if (material == null || !material.shader.name.Equals("KIIF/PBR_MiyaGround"))
		{
			EndAction();
			return;
		}
		nsOriginValue = material.GetFloat("_BumpScale");
		mrOriginValue = material.GetFloat("_MaskArea");
		if (normalStrength == 0f)
		{
			nsFrameValue = 0f;
		}
		else
		{
			nsFrameValue = (normalStrength - nsOriginValue) / (float)changeFrame;
		}
		if (mapRange == 0f)
		{
			mrFrameVale = 0f;
		}
		else
		{
			mrFrameVale = (mapRange - mrOriginValue) / (float)changeFrame;
		}
		tempFrame = 0f;
	}

	protected override void OnUpdate()
	{
		if (tempFrame < (float)changeFrame)
		{
			tempFrame++;
			material.SetFloat("_BumpScale", nsFrameValue + nsFrameValue * tempFrame);
			material.SetFloat("_MaskArea", mrOriginValue + mrFrameVale * tempFrame);
			if (tempFrame >= (float)changeFrame)
			{
				material.SetFloat("_BumpScale", normalStrength);
				material.SetFloat("_MaskArea", mapRange);
				EndAction();
			}
		}
	}

	protected Transform GetGroundTransform()
	{
		if (string.IsNullOrEmpty(rootGameObjectName) || string.IsNullOrEmpty(childPath))
		{
			return null;
		}
		Scene scene;
		if (string.IsNullOrEmpty(sceneName))
		{
			GameObject entityObject = ownerEntity.GetEntityObject();
			if (entityObject == null)
			{
				return null;
			}
			scene = entityObject.scene;
		}
		else
		{
			scene = SceneManager.GetSceneByName(sceneName);
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
				Transform transform = gameObject.transform.Find(childPath);
				if (transform != null)
				{
					return transform;
				}
			}
		}
		return null;
	}

	protected override void OnGraphStop()
	{
		if (isFollowDispose && material != null)
		{
			material.SetFloat("_BumpScale", nsOriginValue);
			material.SetFloat("_MaskArea", mrOriginValue);
		}
	}
}

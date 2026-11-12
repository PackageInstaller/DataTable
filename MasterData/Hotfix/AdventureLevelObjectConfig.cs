using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class AdventureLevelObjectConfig : ScriptableObject
{
	[Serializable]
	public class SceneObjDataConfig
	{
		public string name;

		public string assetPath;

		public Vector3 position;

		public Vector3 eulerAngles;

		public Vector3 scale;

		public bool isInitializing;

		public GameObject gameObject;

		public AdventureLevelObjPoolMgr.PoolObj poolObj;

		public string parent;

		public SceneObjDataConfig[] childs;

		public Vector3[] boundsPoints;

		public Vector3[] runtimePoints;

		public Vector3 boundsPosition;

		public Vector3 boundsRuntimePosition;

		public Vector3 boundsSize;

		public Vector3 boundsRuntimeSize;

		public Vector3 boundsRuntimeMin;

		public Vector3 boundsRuntimeMax;

		public int lightmapIndex = -1;

		public Texture2D savedLightingmap;

		public Vector4 lightmapScaleOffset = Vector4.zero;

		public SceneObjDataConfig(string name)
		{
			this.name = name;
		}

		public void UpdateTransform(Matrix4x4 transMatrix, Vector3 relativeRotation, float dynamicLoad_SceneObjLoadDistance)
		{
			if (childs != null && childs.Length != 0)
			{
				Vector3 vector = Vector3.one * 999999f;
				Vector3 vector2 = -vector;
				for (int i = 0; i < childs.Length; i++)
				{
					SceneObjDataConfig sceneObjDataConfig = childs[i];
					sceneObjDataConfig.UpdateTransform(transMatrix, relativeRotation, dynamicLoad_SceneObjLoadDistance);
					if (sceneObjDataConfig.boundsRuntimeMin.x < vector.x)
					{
						vector.x = sceneObjDataConfig.boundsRuntimeMin.x;
					}
					if (sceneObjDataConfig.boundsRuntimeMin.z < vector.z)
					{
						vector.z = sceneObjDataConfig.boundsRuntimeMin.z;
					}
					if (sceneObjDataConfig.boundsRuntimeMax.x > vector2.x)
					{
						vector2.x = sceneObjDataConfig.boundsRuntimeMax.x;
					}
					if (sceneObjDataConfig.boundsRuntimeMax.z > vector2.z)
					{
						vector2.z = sceneObjDataConfig.boundsRuntimeMax.z;
					}
				}
				boundsRuntimeMax = vector2;
				boundsRuntimeMin = vector;
				boundsRuntimePosition = (boundsRuntimeMin + boundsRuntimeMax) * 0.5f;
			}
			else
			{
				boundsRuntimePosition = transMatrix.MultiplyPoint(boundsPosition);
				float y = relativeRotation.y;
				if (y == 90f || y == 270f)
				{
					boundsRuntimeSize = new Vector3(boundsSize.z, boundsSize.y, boundsSize.x);
				}
				Vector3 vector3 = (boundsRuntimeSize + Vector3.one * dynamicLoad_SceneObjLoadDistance * 2f) * 0.5f;
				boundsRuntimeMin = boundsRuntimePosition - vector3;
				boundsRuntimeMax = boundsRuntimePosition + vector3;
			}
		}

		public void UpdateLightingmaps()
		{
			if (!(null == gameObject))
			{
				MeshRenderer component = gameObject.GetComponent<MeshRenderer>();
				component.lightmapIndex = lightmapIndex;
				component.lightmapScaleOffset = lightmapScaleOffset;
			}
		}

		public void UpdateLightingmaps(Texture2D map, int index)
		{
			if (!(null == gameObject) && !(null == savedLightingmap) && savedLightingmap.Equals(map))
			{
				MeshRenderer component = gameObject.GetComponent<MeshRenderer>();
				component.lightmapIndex = index;
				component.lightmapScaleOffset = lightmapScaleOffset;
				lightmapIndex = index;
			}
		}

		protected void HandleRuntimePoints(Matrix4x4 matrix)
		{
			if (boundsPoints != null)
			{
				runtimePoints = boundsPoints;
				for (int i = 0; i < boundsPoints.Length; i++)
				{
					runtimePoints[i] = matrix.MultiplyPoint(boundsPoints[i]);
				}
			}
		}

		public bool SanCheck(Vector2 entityPosition)
		{
			if (entityPosition.x >= boundsRuntimeMin.x && entityPosition.y >= boundsRuntimeMin.z && entityPosition.x <= boundsRuntimeMax.x)
			{
				return entityPosition.y <= boundsRuntimeMax.z;
			}
			return false;
		}
	}

	[ReadOnly]
	public List<SceneObjDataConfig> configs = new List<SceneObjDataConfig>();

	public int Count => configs.Count;

	public SceneObjDataConfig this[int index] => configs.get_Item(index);

	public void AddConfig(SceneObjDataConfig config)
	{
		configs.Add(config);
	}
}

using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

public class ChangeEntityMaterial : IReference
{
	public Material material;

	public int materialIndex;

	public ChangeEntityMaterialType materialType;

	public int materialRuntimeId;

	public string pointName;

	public List<ShaderPropertyInfo> inheriteParams;

	public bool isMultiplePoint;

	public List<string> pointListName;

	public int ChangeMatUniqueId;

	public void Clear()
	{
		material = null;
		pointName = null;
		materialIndex = 0;
		materialRuntimeId = 0;
		inheriteParams = null;
		materialType = ChangeEntityMaterialType.SET;
		if (pointListName != null)
		{
			pointListName.Clear();
			CollectionPool<List<string>, string>.Release(pointListName);
			pointListName = null;
		}
	}
}

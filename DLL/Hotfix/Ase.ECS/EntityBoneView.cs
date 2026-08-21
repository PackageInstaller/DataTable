using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Ase.ECS;

public class EntityBoneView : SerializedMonoBehaviour
{
	public Dictionary<string, BoneData> boneList = new Dictionary<string, BoneData>();

	public void Init(BaseEntity entity)
	{
		entity?.GetComponent<EntityBoneComponent>()?.RegisterBonePointData(((Component)this).transform, boneList);
	}
}

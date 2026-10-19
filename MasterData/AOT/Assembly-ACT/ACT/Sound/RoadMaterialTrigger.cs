using ACT.Battle;
using Bamboo.ECS;
using EasyCharacterMovement;
using Fundamental;
using UnityEngine;

namespace ACT.Sound;

public class RoadMaterialTrigger : MonoBehaviour
{
	public RoadMaterial roadMaterial;

	private uint _id;

	private void OnTriggerEnter(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsValid && component.entity.IsCharacter())
		{
			_id = Singleton<RoadMaterialManager>.instance.SetGlobalRoadMaterial(roadMaterial, MaterialType.Road);
		}
	}

	private void OnTriggerExit(Collider other)
	{
		MonoEntity component = other.GetComponent<MonoEntity>();
		if (!(component == null) && component.entity.IsValid && component.entity.IsCharacter())
		{
			Singleton<RoadMaterialManager>.instance.RemoveGlobalRoadMaterial(MaterialType.Road, _id);
			_id = 0u;
		}
	}

	private void OnDestroy()
	{
		if (_id != 0)
		{
			Singleton<RoadMaterialManager>.instance.RemoveGlobalRoadMaterial(MaterialType.Road, _id);
		}
	}
}

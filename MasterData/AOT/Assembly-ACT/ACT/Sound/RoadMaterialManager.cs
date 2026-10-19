using System.Collections.Generic;
using ACT.Event;
using Bamboo.ECS;
using EasyCharacterMovement;
using Fundamental;

namespace ACT.Sound;

public class RoadMaterialManager : Singleton<RoadMaterialManager>
{
	private RoadMaterial _defaultRoadMaterial = RoadMaterial.Max;

	private RoadMaterial _roadMaterial = RoadMaterial.Max;

	private uint _nextMaterialId = 1u;

	private Dictionary<MaterialType, List<KeyValuePair<uint, RoadMaterial>>> _materials = new Dictionary<MaterialType, List<KeyValuePair<uint, RoadMaterial>>>();

	public override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Battle_TP, ResetDefaultRoadMaterial);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, ResetDefaultRoadMaterial);
		if (_materials.Count == 0)
		{
			_materials.Add(MaterialType.Default, new List<KeyValuePair<uint, RoadMaterial>>());
			_materials.Add(MaterialType.Road, new List<KeyValuePair<uint, RoadMaterial>>());
			_materials.Add(MaterialType.Skill, new List<KeyValuePair<uint, RoadMaterial>>());
		}
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Battle_TP, ResetDefaultRoadMaterial);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterLeaveWorld, ResetDefaultRoadMaterial);
		_materials.Clear();
		_nextMaterialId = 1u;
	}

	private void ResetDefaultRoadMaterial(BaseEventContent obj)
	{
		_defaultRoadMaterial = RoadMaterial.Max;
		_materials[MaterialType.Road].Clear();
	}

	public RoadMaterial GetRoadMaterial(Entity behaver)
	{
		if (!behaver.IsValid && _roadMaterial != RoadMaterial.Max)
		{
			return _roadMaterial;
		}
		if (_defaultRoadMaterial == RoadMaterial.Max)
		{
			_defaultRoadMaterial = Singleton<GameManager>.instance.worldManager.ActiveWorld.GetRoadMaterialByWorldPos(behaver.GetCompTransform().physicsPosition);
			if (_defaultRoadMaterial == RoadMaterial.Max)
			{
				return RoadMaterial.Normal;
			}
		}
		return _defaultRoadMaterial;
	}

	public uint SetGlobalRoadMaterial(RoadMaterial roadMaterial, MaterialType materialType)
	{
		List<KeyValuePair<uint, RoadMaterial>> list = _materials[materialType];
		uint num = _nextMaterialId++;
		list.Add(new KeyValuePair<uint, RoadMaterial>(num, roadMaterial));
		_roadMaterial = roadMaterial;
		return num;
	}

	public void RemoveGlobalRoadMaterial(MaterialType materialType, uint id)
	{
		List<KeyValuePair<uint, RoadMaterial>> list = _materials[materialType];
		int num = list.FindIndex((KeyValuePair<uint, RoadMaterial> pair) => pair.Key == id);
		if (num >= 0)
		{
			list.RemoveAt(num);
		}
		if (list.Count != 0)
		{
			_roadMaterial = list[list.Count - 1].Value;
		}
		else
		{
			_roadMaterial = RoadMaterial.Max;
		}
	}
}

using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制材质", "Action", new string[] { "control", "mat", "override", "effect", "fx", "particle" })]
public class ActionControlMatOverride : ConfigAction
{
	public enum MatOverrideType
	{
		Add,
		Remove
	}

	public enum MatType
	{
		Custom,
		Preset
	}

	public MatOverrideType matOverrideType;

	public MatType matType;

	public Dictionary<MonsterWeigtType, Material> materialDict;

	public AnimationCurve customCurve;

	public uint uintmaterialPreset;

	public override void Do(ActionMemory memory)
	{
		Material material = null;
		int index = (int)uintmaterialPreset;
		ConfigCharacter config = memory.target.entity.GetConfig();
		switch (matType)
		{
		case MatType.Custom:
			material = materialDict[config.monsterWeigtType];
			_ = customCurve;
			break;
		case MatType.Preset:
			switch (config.monsterWeigtType)
			{
			case MonsterWeigtType.Normal:
				material = GameLoader.meta.curveLibrary.matOverrides[index].material1;
				break;
			case MonsterWeigtType.Big:
				material = GameLoader.meta.curveLibrary.matOverrides[index].material2;
				break;
			case MonsterWeigtType.Giant:
				material = GameLoader.meta.curveLibrary.matOverrides[index].material3;
				break;
			case MonsterWeigtType.Small:
				material = GameLoader.meta.curveLibrary.matOverrides[index].material4;
				break;
			case MonsterWeigtType.Middle:
				material = GameLoader.meta.curveLibrary.matOverrides[index].material5;
				break;
			}
			_ = GameLoader.meta.curveLibrary.matOverrides[index].animationCurve;
			break;
		}
		if (material != null)
		{
			switch (matOverrideType)
			{
			case MatOverrideType.Add:
				memory.target.entity.GetMono().materialOverride._MatList.Add(material);
				break;
			case MatOverrideType.Remove:
				memory.target.entity.GetMono().materialOverride._MatList.Remove(material);
				break;
			}
		}
	}
}

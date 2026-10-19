using System.Collections.Generic;

namespace ACT.UI;

public class CustomUIStandard
{
	private Dictionary<CustomUICompType, CustomUICompStandard> _compStandards;

	public int CustomSchemeMaxNum { get; }

	public float CompDiameterMin { get; }

	public float CompDiameterMax { get; }

	public float EdgeOffsetMin { get; }

	public float EdgeOffsetMax { get; }

	public float PosModifyStep { get; }

	public CustomUIStandard(CustomUIStandardConfig standardConfig)
	{
		_compStandards = new Dictionary<CustomUICompType, CustomUICompStandard>();
		foreach (var (key, config) in standardConfig.compStandard)
		{
			_compStandards.Add(key, new CustomUICompStandard(config));
		}
		CustomSchemeMaxNum = standardConfig.customSchemeMaxNum;
		CompDiameterMin = standardConfig.compDiameterMin;
		CompDiameterMax = standardConfig.compDiameterMax;
		EdgeOffsetMin = standardConfig.edgeOffsetMin;
		EdgeOffsetMax = standardConfig.edgeOffsetMax;
		PosModifyStep = standardConfig.posModifyStep;
	}

	public float GetOriginalSize(CustomUICompType type)
	{
		if (_compStandards.TryGetValue(type, out var value))
		{
			return value.OriginalSize;
		}
		return 0f;
	}

	public bool GetUseDiameter(CustomUICompType type)
	{
		if (_compStandards.TryGetValue(type, out var value))
		{
			return value.UseDiameter;
		}
		return false;
	}

	public CustomUICompShapeType GetShapeType(CustomUICompType type)
	{
		if (_compStandards.TryGetValue(type, out var value))
		{
			return value.ShapeType;
		}
		return CustomUICompShapeType.None;
	}
}

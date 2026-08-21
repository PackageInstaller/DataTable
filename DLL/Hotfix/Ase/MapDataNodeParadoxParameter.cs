using NodeCanvas.Framework;
using UnityEngine;

namespace Ase;

public struct MapDataNodeParadoxParameter
{
	public IMapDataNodeParadoxParameter parameter;

	public static MapDataNodeParadoxParameter CreateIntParameter(int value)
	{
		return new MapDataNodeParadoxParameter
		{
			parameter = new IntParameter
			{
				value = value
			}
		};
	}

	public static MapDataNodeParadoxParameter CreateStringParameter(string value)
	{
		return new MapDataNodeParadoxParameter
		{
			parameter = new StringParameter
			{
				value = value
			}
		};
	}

	public static MapDataNodeParadoxParameter CreateBoolParameter(bool value)
	{
		return new MapDataNodeParadoxParameter
		{
			parameter = new BoolParameter
			{
				value = value
			}
		};
	}

	public static MapDataNodeParadoxParameter CreateFloatParameter(float value)
	{
		return new MapDataNodeParadoxParameter
		{
			parameter = new FloatParameter
			{
				value = value
			}
		};
	}

	public static MapDataNodeParadoxParameter CreateVector3Parameter(Vector3 value)
	{
		return new MapDataNodeParadoxParameter
		{
			parameter = new Vector3Parameter
			{
				value = value
			}
		};
	}

	public static MapDataNodeParadoxParameter CreateParameter(Variable getValue)
	{
		if (getValue.varType == typeof(int))
		{
			return CreateIntParameter(((Variable<int>)getValue).value);
		}
		if (getValue.varType == typeof(bool))
		{
			return CreateBoolParameter(((Variable<bool>)getValue).value);
		}
		if (getValue.varType == typeof(float))
		{
			return CreateFloatParameter(((Variable<float>)getValue).value);
		}
		if (getValue.varType == typeof(Vector3))
		{
			return CreateVector3Parameter(((Variable<Vector3>)getValue).value);
		}
		_ = getValue.varType == typeof(string);
		return CreateStringParameter(((Variable<string>)getValue).value);
	}
}

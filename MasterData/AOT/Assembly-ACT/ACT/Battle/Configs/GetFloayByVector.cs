using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("从向量获取浮点值", "Function", new string[] { "get", "floay", "by", "vector", "position", "rotation", "quaternion" })]
public class GetFloayByVector : ConfigFunction<float>
{
	public enum Vector3Type
	{
		X,
		Y,
		Z
	}

	public ConfigFunction<Vector3> configFunction;

	public Vector3Type vector3Type;

	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		Vector3 vector = configFunction.Return(memory);
		switch (vector3Type)
		{
		case Vector3Type.X:
			result = vector.x;
			break;
		case Vector3Type.Y:
			result = vector.y;
			break;
		case Vector3Type.Z:
			result = vector.z;
			break;
		}
		return result;
	}
}

using UnityEngine;

namespace ACT.Battle.Configs;

public class ConfigRoleCompensationPattern : LuminSerializedScriptableObject
{
	public string comment;

	public string comment1;

	public ConfigFunction<float> expectHeight = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public ConfigFunction<float> expectWidth = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 3f
		}
	};

	public RoleCompensationStartPosType startPosType;

	public ConfigFunction<Vector3> centerFunction = new FunctionOwnerOffesPosition();

	public ConfigFunction<Vector3> endPos = new FunctionEntityPosition
	{
		findTargets = new ConfigFindRangeTargets
		{
			targetBounds = new TargetBounds
			{
				size = new Vector3(0f, 0f, 3f),
				center = new Vector3(0f, 0f, 1.5f)
			}
		},
		predicate = new WhereTargetsPredicate
		{
			whereTargets = new WhereTargets
			{
				alliance = Alliance.Enemy
			}
		}
	};

	public ConfigFunction<Vector3> mirrorEndPos = new FunctionEntityPosition
	{
		findTargets = new ConfigFindRangeTargets
		{
			targetBounds = new TargetBounds
			{
				size = new Vector3(0f, 0f, 3f),
				center = new Vector3(0f, 0f, 1.5f)
			}
		},
		predicate = new WhereTargetsPredicate
		{
			whereTargets = new WhereTargets
			{
				alliance = Alliance.Enemy
			}
		}
	};

	public RoleCompensationInfo roleCompensationInfo = new RoleCompensationInfo();

	public ConfigCompensation roleCompensationParameter = new ConfigCompensation();
}

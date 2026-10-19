using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class RoleCompensationPattern : CompensationPattern
{
	public ConfigRoleCompensationPattern configCompensationPattern;

	public ConfigFunction<float> expectHeight;

	public ConfigFunction<float> expectWidth;

	public RoleCompensationStartPosType startPosType;

	public ConfigFunction<Vector3> centerFunction;

	public ConfigFunction<Vector3> endPos;

	public ConfigFunction<Vector3> mirrorEndPos;

	public RoleCompensationInfo roleCompensationInfo;

	public ConfigCompensation roleCompensationParameter;

	[Space(30f)]
	[HideInInspector]
	public BaseFindTargets advancedCompensationRange;

	[HideInInspector]
	public ConfigFindRangeTargets attackBoxFindTargets;

	[HideInInspector]
	public bool useRoleCompensation = true;

	[HideInInspector]
	public ConfigFindRangeTargets roleCompensationRange;

	[Space(30f)]
	[HideInInspector]
	public bool useEnemyTraction = true;

	[HideInInspector]
	public bool enemyUseHorizontalTraction;

	[HideInInspector]
	public TargetBounds enemyTractionBounds;

	public Vector2 DisCalculate(bool faceLeft, Vector3 startPos, Vector3 endPos, float realExpectHeight, float realExpectWidth)
	{
		Vector2 zero = Vector2.zero;
		float num = startPos.y - realExpectHeight;
		float num2 = startPos.y + realExpectHeight;
		if (endPos.y <= num || endPos.y >= num2)
		{
			if (endPos.y > num2)
			{
				zero.y = endPos.y - num2;
			}
			else if (endPos.y < num)
			{
				zero.y = endPos.y - num;
			}
		}
		float num3 = startPos.x;
		float num4 = startPos.x;
		if (faceLeft)
		{
			num3 -= realExpectWidth;
		}
		else
		{
			num4 += realExpectWidth;
		}
		if (endPos.x <= num3 || endPos.x >= num4)
		{
			if (endPos.x < num3)
			{
				zero.x = endPos.x - num3;
			}
			else if (endPos.x > num4)
			{
				zero.x = endPos.x - num4;
			}
		}
		return zero;
	}

	public Vector2 SetPos(bool faceLeft, Vector3 startPos, Vector3 endPos, float realExpectHeight, float realExpectWidth)
	{
		Vector2 zero = Vector2.zero;
		if (startPos.y - endPos.y != realExpectHeight)
		{
			zero.y = endPos.y + realExpectHeight - startPos.y;
		}
		if (startPos.x - endPos.x != realExpectWidth)
		{
			if (faceLeft)
			{
				zero.x = endPos.x + realExpectWidth - startPos.x;
			}
			else
			{
				zero.x = endPos.x - realExpectWidth - startPos.x;
			}
		}
		return zero;
	}

	public override void CompensationHandle(SystemAbility systemAbility, Entity behave, float duration, FSMRuntimeState rState)
	{
		if (endPos == null)
		{
			return;
		}
		ActionMemory memory = new ActionMemory(behave, behave, behave);
		Vector3 vector = endPos.Return(memory);
		Vector3 vector2 = behave.GetCompTransform().physicsPosition;
		bool flag = Vector3.SqrMagnitude(vector2 - vector) < 1E-12f;
		Vector2 vector3 = Vector2.zero;
		switch (startPosType)
		{
		case RoleCompensationStartPosType.waist:
		{
			behave.GetMono().TryGetAttachPoint("waist", out var attackPoint);
			vector2 = attackPoint.position;
			break;
		}
		case RoleCompensationStartPosType.custom:
			if (centerFunction == null)
			{
				return;
			}
			vector2 = centerFunction.Return(memory);
			break;
		}
		float realExpectHeight = expectHeight.Return(memory);
		float realExpectWidth = expectWidth.Return(memory);
		CompInput? compInput = behave.GetCompInput();
		CompTransform compTransform = behave.GetCompTransform();
		bool flag2 = compTransform.FaceDir == FaceDir.Left;
		bool flag3 = compInput.dirX == EInputDir.Right && compTransform.FaceDir == FaceDir.Right;
		bool flag4 = compInput.dirX == EInputDir.Left && compTransform.FaceDir == FaceDir.Left;
		if (flag)
		{
			if (roleCompensationInfo.needCompensationMirror && (!roleCompensationInfo.inputPriority || !(flag3 | flag4)))
			{
				if (mirrorEndPos == null)
				{
					return;
				}
				vector = mirrorEndPos.Return(memory);
				if (!(Vector3.SqrMagnitude(vector2 - vector) < 1E-12f))
				{
					if (Vector3.SqrMagnitude(compTransform.physicsPosition - vector) < 1E-12f)
					{
						return;
					}
					behave.SetFaceLeft(!flag2);
					behave.GetCompMotion().layer0Peak.startFaceDir = ((compTransform.FaceDir != FaceDir.Left) ? FaceDir.Right : FaceDir.Left);
					behave.GetCompPhysics().SetDirImmediately();
					switch (roleCompensationInfo.roleCompensationType)
					{
					case RoleCompensationType.Compensation:
						vector3 = DisCalculate(compTransform.FaceDir == FaceDir.Left, vector2, vector, realExpectHeight, realExpectWidth);
						break;
					case RoleCompensationType.SetPos:
						vector3 = SetPos(compTransform.FaceDir == FaceDir.Left, vector2, vector, realExpectHeight, realExpectWidth);
						break;
					}
				}
			}
		}
		else
		{
			if (roleCompensationInfo.frontNeedChangeDir && (!roleCompensationInfo.inputPriority || !(flag3 | flag4)) && !BoolUtility.IsInFront(flag2, vector2.x, vector.x))
			{
				behave.SetFaceLeft(!flag2);
				behave.GetCompMotion().layer0Peak.startFaceDir = ((!behave.IsFaceLeft()) ? FaceDir.Right : FaceDir.Left);
				behave.GetCompPhysics().SetDirImmediately();
			}
			switch (roleCompensationInfo.roleCompensationType)
			{
			case RoleCompensationType.Compensation:
				vector3 = DisCalculate(behave.IsFaceLeft(), vector2, vector, realExpectHeight, realExpectWidth);
				break;
			case RoleCompensationType.SetPos:
				vector3 = SetPos(behave.IsFaceLeft(), vector2, vector, realExpectHeight, realExpectWidth);
				break;
			}
		}
		if (Vector2.SqrMagnitude(vector3) > 0f)
		{
			roleCompensationParameter.DoCompensation(vector3, behave, duration);
		}
	}
}

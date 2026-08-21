using System;
using RootMotion.FinalIK;
using Sirenix.OdinInspector;
using UnityEngine;

namespace T0World;

public class T0CharacterIkBehavior : SerializedMonoBehaviour
{
	public BipedIK bipedIk;

	public float ikOpenDis = 3.5f;

	public float ikOpenAngle = 240f;

	private T0CharacterIkControlerStateEnum openIkState = T0CharacterIkControlerStateEnum.open;

	private Transform ikTarget;

	private float lookAtWeight = 1f;

	private float spineWeight = 1f;

	private float aimWeight = 1f;

	private float leftFootWeight;

	private float rightFootWeight;

	private float rightHandWeight;

	private float leftHandWeight;

	private float pelvisWeight;

	private float ikTweenValue;

	private bool isOpen = true;

	private LTDescr ikTween;

	private int ikTweenID;

	public Transform IKFootGoalL;

	public Transform IKFootGoalR;

	public Transform estimateFootStepL;

	public Transform estimateFootStepR;

	[Range(0.1f, 1f)]
	public float footIKWeightFactor = 1f;

	public bool IsCloseState => openIkState == T0CharacterIkControlerStateEnum.close;

	public void SetWeightData(T0InterationSetBipedIK ikData)
	{
		lookAtWeight = ikData.lookAtWeight;
		spineWeight = ikData.spineWeight;
		aimWeight = ikData.aimWeight;
		leftFootWeight = ikData.leftFootWeight;
		rightFootWeight = ikData.rightFootWeight;
		rightHandWeight = ikData.rightHandWeight;
		leftHandWeight = ikData.leftHandWeight;
		pelvisWeight = ikData.pelvisWeight;
		bipedIk.solvers.lookAt.SetLookAtWeight(bipedIk.solvers.lookAt.GetIKPositionWeight(), ikData.lookBodyWeight, ikData.lookHeadWeight, ikData.lookeyesWeight);
	}

	public void RemoveIkTween()
	{
		if (ikTween != null)
		{
			LeanTween.cancel(ikTweenID);
			ikTween = null;
			ikTweenID = -1;
		}
	}

	public void InitCharaterIk(Transform ikTarget)
	{
		SetIkLookTarget(ikTarget);
		lookAtWeight = bipedIk.solvers.lookAt.GetIKPositionWeight();
		spineWeight = bipedIk.solvers.spine.GetIKPositionWeight();
		aimWeight = bipedIk.solvers.aim.GetIKPositionWeight();
		leftFootWeight = bipedIk.solvers.leftFoot.GetIKPositionWeight();
		rightFootWeight = bipedIk.solvers.rightFoot.GetIKPositionWeight();
		rightHandWeight = bipedIk.solvers.rightHand.GetIKPositionWeight();
		leftHandWeight = bipedIk.solvers.leftHand.GetIKPositionWeight();
		pelvisWeight = bipedIk.solvers.pelvis.positionWeight;
		OpenIk(open: false, 0.1f);
	}

	public void SetIkLookTarget(Transform ikTarget)
	{
		if (openIkState != T0CharacterIkControlerStateEnum.specify_open)
		{
			this.ikTarget = ikTarget;
			bipedIk.solvers.lookAt.target = ikTarget;
			bipedIk.solvers.spine.target = ikTarget;
			bipedIk.solvers.aim.transform = ikTarget;
		}
	}

	public void ChangeIkState(T0CharacterIkControlerStateEnum ikState)
	{
		openIkState = ikState;
		switch (ikState)
		{
		case T0CharacterIkControlerStateEnum.open:
		case T0CharacterIkControlerStateEnum.specify_open:
			OpenIk();
			break;
		case T0CharacterIkControlerStateEnum.close:
			OpenIk(open: false);
			break;
		}
	}

	public void OpenIk(bool open = true, float leanTimes = 1.5f)
	{
		if (isOpen != open)
		{
			RemoveIkTween();
			isOpen = open;
			float num = ikTweenValue;
			float endValue = (open ? 1f : 0f);
			ikTween = LeanTween.value(num, endValue, leanTimes).setOnUpdate(delegate(float value)
			{
				ikTweenValue = value;
				bipedIk.solvers.lookAt.SetLookAtWeight(ikTweenValue * lookAtWeight);
				bipedIk.solvers.spine.SetIKPositionWeight(ikTweenValue * spineWeight);
				bipedIk.solvers.aim.SetIKPositionWeight(ikTweenValue * aimWeight);
				bipedIk.solvers.leftFoot.SetIKPositionWeight(ikTweenValue * leftFootWeight);
				bipedIk.solvers.rightFoot.SetIKPositionWeight(ikTweenValue * rightFootWeight);
				bipedIk.solvers.rightHand.SetIKPositionWeight(ikTweenValue * rightHandWeight);
				bipedIk.solvers.leftHand.SetIKPositionWeight(ikTweenValue * leftHandWeight);
				bipedIk.solvers.pelvis.positionWeight = ikTweenValue * pelvisWeight;
			}).setOnComplete((Action)delegate
			{
				ikTweenValue = endValue;
				bipedIk.solvers.lookAt.SetLookAtWeight(endValue * lookAtWeight);
				bipedIk.solvers.spine.SetIKPositionWeight(endValue * spineWeight);
				bipedIk.solvers.aim.SetIKPositionWeight(endValue * aimWeight);
				bipedIk.solvers.leftFoot.SetIKPositionWeight(endValue * leftFootWeight);
				bipedIk.solvers.rightFoot.SetIKPositionWeight(endValue * rightFootWeight);
				bipedIk.solvers.rightHand.SetIKPositionWeight(endValue * rightHandWeight);
				bipedIk.solvers.leftHand.SetIKPositionWeight(endValue * leftHandWeight);
				bipedIk.solvers.pelvis.positionWeight = endValue * pelvisWeight;
			});
			ikTweenID = ikTween.id;
		}
	}

	private void Awake()
	{
		if (!IKFootGoalL)
		{
			GameObject gameObject = new GameObject("FootIK_L");
			IKFootGoalL = gameObject.transform;
			RestoreIKGoal(IKFootGoalL);
			bipedIk.solvers.leftFoot.target = IKFootGoalL;
		}
		if (!IKFootGoalR)
		{
			GameObject gameObject2 = new GameObject("FootIK_R");
			IKFootGoalR = gameObject2.transform;
			RestoreIKGoal(IKFootGoalR);
			bipedIk.solvers.rightFoot.target = IKFootGoalR;
		}
	}

	public void Update()
	{
		CheckIsInBehind();
	}

	public void CheckIsInBehind()
	{
		if (openIkState == T0CharacterIkControlerStateEnum.close)
		{
			return;
		}
		bool flag = true;
		float num = float.PositiveInfinity;
		if ((bool)ikTarget)
		{
			num = Vector3.Distance(base.transform.position, ikTarget.position);
		}
		if (num > ikOpenDis)
		{
			flag = false;
		}
		else
		{
			Vector3 normalized = (ikTarget.position - base.transform.position).normalized;
			if (Vector3.Angle(base.transform.forward, normalized) > ikOpenAngle)
			{
				flag = false;
			}
		}
		if (flag != isOpen)
		{
			OpenIk(flag);
		}
	}

	private static void SetIKGoalPos(Transform goal, Vector3 pos)
	{
		goal.SetParent(null);
		goal.position = pos;
	}

	private void RestoreIKGoal(Transform goal)
	{
		goal.SetParent(base.transform);
	}

	internal void UpdateIKGoalPos(AvatarIKGoal goal)
	{
		switch (goal)
		{
		case AvatarIKGoal.LeftFoot:
		{
			if (Physics.Raycast(new Ray(estimateFootStepL.position + 0.5f * Vector3.up, Vector3.down), out var hitInfo2, 1f, LayerMask.GetMask("ground"), QueryTriggerInteraction.Ignore))
			{
				SetIKGoalPos(IKFootGoalL, hitInfo2.point);
			}
			else
			{
				RestoreIKGoal(IKFootGoalL);
			}
			bipedIk.SetIKPositionWeight(goal, 0f);
			break;
		}
		case AvatarIKGoal.RightFoot:
		{
			if (Physics.Raycast(new Ray(estimateFootStepR.position + 0.5f * Vector3.up, Vector3.down), out var hitInfo, 1f, LayerMask.GetMask("ground"), QueryTriggerInteraction.Ignore))
			{
				SetIKGoalPos(IKFootGoalR, hitInfo.point);
			}
			else
			{
				RestoreIKGoal(IKFootGoalR);
			}
			bipedIk.SetIKPositionWeight(goal, 0f);
			break;
		}
		}
	}

	public void UpdateIKWeight(AvatarIKGoal goal, float weight)
	{
		if (goal == AvatarIKGoal.LeftFoot || goal == AvatarIKGoal.RightFoot)
		{
			bipedIk.SetIKPositionWeight(goal, weight * footIKWeightFactor);
		}
	}
}

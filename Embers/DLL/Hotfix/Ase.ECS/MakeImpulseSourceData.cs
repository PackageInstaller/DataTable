using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class MakeImpulseSourceData : IReference
{
	public float ImpulseInterval;

	public float ImpulseNums;

	public float _impulseForce;

	public AnimationCurve ImpulseForceCurve;

	public Vector3 ImpulseDir;

	public float ImpulseSpeed;

	public float ImpulseDistance;

	public Vector3 ImpulsePosition;

	public int ImpulsePosEntityId;

	public string ImpulsePosPoint;

	public Vector3 ImpulsePositionOffset;

	public float BlendTime;

	public float IntensityInit;

	public AnimationCurve StrengCurve;

	public AnimationCurve DistanceStrengCurve;

	public float frequency = 1f;

	public AnimationCurve FrequencyCurve;

	public float duration = 0.1f;

	public string NoiseName;

	public float ImpulsePriorityInit;

	public AnimationCurve ImpulsePriorityCurve;

	public AnimationCurve ImpulsePriorityDisCurve;

	public float Timer;

	public bool UseRandomNoise;

	public int ImpulseUniqueIndex;

	public float ImpulseForce => _impulseForce * GameSettingExtension.GetFloatRawValue("敌人震屏强度");

	public void Clear()
	{
		ImpulseInterval = 0f;
		ImpulseNums = 0f;
		ImpulseForceCurve = null;
		ImpulsePosition = Vector3.zero;
		ImpulsePosEntityId = 0;
		ImpulsePosPoint = string.Empty;
		BlendTime = 0f;
		StrengCurve = null;
		FrequencyCurve = null;
		NoiseName = string.Empty;
		ImpulsePriorityInit = 0f;
		ImpulsePriorityCurve = null;
		ImpulsePriorityDisCurve = null;
		DistanceStrengCurve = null;
		UseRandomNoise = false;
		ImpulseUniqueIndex = 0;
	}
}

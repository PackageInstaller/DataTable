using System;
using Cinemachine;
using UnityEngine;

namespace Ase;

[Serializable]
public class CameraConfig : ScriptableObject
{
	private const string OriginGroup = "Root";

	public CinemachineBrain.UpdateMethod updateMethod;

	public CinemachineBrain.BrainUpdateMethod brainUpdateMethod;

	public float battleDefaultBlendTime = 1f;

	public CameraBaseData battleCameraBaseData;

	[Header("相机吸附配置")]
	public int transitionTick;

	public AnimationCurve animationCurve;

	public int cameraMinDistance = 40;

	public int cameraMaxDistance = 45;

	[Range(0f, 10f)]
	public float heroGazeScopeX = 1f;

	public float heroRadius = 1f;

	public float monsterRadius = 2f;

	public Vector2 heroBoundOffset;

	public Vector2 monsterBoundOffset;

	public Vector3 centerOffset;

	public float stretchSharpness;

	public float adsorptionSharpness;

	public CameraBaseData ultimateSkillCameraBaseData;

	[Header("修改相机距离配置")]
	public float distanceMin = 30f;

	public float distanceMax = 80f;

	public float cameraDistanceBaseValue;

	[Header("战斗状态")]
	public int levelBattleCameraPriority = 10;

	public float levelDefaultBlendTime = 2f;

	public AnimationCurve customCurveAnimationCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);
}

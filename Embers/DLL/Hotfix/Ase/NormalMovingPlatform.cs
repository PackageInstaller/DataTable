using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class NormalMovingPlatform : MovingPlatform
{
	public List<NormalPlatformControlCollider> ControlCollidersEnable = new List<NormalPlatformControlCollider>();

	[SerializeField]
	private WrapMode wrapMode;

	[SerializeField]
	private float time;

	[SerializeField]
	private AnimationCurve curveX;

	[SerializeField]
	private AnimationCurve curveY;

	[SerializeField]
	private AnimationCurve curveZ;

	[SerializeField]
	private float runningTime;

	[SerializeField]
	private Vector3 runningSpeed;

	[SerializeField]
	private bool isReseve;

	public float YRoatation;

	private float ySpeed;

	private float dis;

	protected override bool IsRunning => runningSpeed.magnitude != 0f;

	protected override void OnInited()
	{
		base.OnInited();
		if (!(Mover != null))
		{
			return;
		}
		int levelId = Mover.GetSystem<SceneSystem>().GetLevelId();
		LevelSaveService.NormalPlatformData normalPlatformData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetNormalPlatformData(levelId, base.ID);
		if (normalPlatformData != null)
		{
			if (wrapMode == WrapMode.Once)
			{
				((Component)(object)this).transform.position = normalPlatformData.Pos;
			}
			((Component)(object)this).transform.localEulerAngles = normalPlatformData.Angle;
			((Component)(object)this).transform.localScale = normalPlatformData.Scale;
			SetPause(normalPlatformData.IsPause);
			wrapMode = (WrapMode)normalPlatformData.WrapMode;
			time = normalPlatformData.ExcuteTime;
			SetCurData(curveX, normalPlatformData.XData);
			SetCurData(curveY, normalPlatformData.YData);
			SetCurData(curveZ, normalPlatformData.ZData);
		}
	}

	protected override void SetVirtualSaveData(GameObject virtualObj)
	{
		int levelId = _sceneSystem.GetLevelId();
		LevelSaveService.NormalPlatformData normalPlatformData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetNormalPlatformData(levelId, base.ID);
		if (virtualObj != null && normalPlatformData != null)
		{
			if (wrapMode == WrapMode.Once)
			{
				virtualObj.transform.position = normalPlatformData.Pos;
			}
			virtualObj.transform.localEulerAngles = normalPlatformData.Angle;
			virtualObj.transform.localScale = normalPlatformData.Scale;
		}
	}

	private void SetCurData(AnimationCurve curve, LevelSaveService.PlatformCurveData platformCurveData)
	{
		if (curve != null && platformCurveData != null)
		{
			curve.postWrapMode = (UnityEngine.WrapMode)platformCurveData.PostWrapMode;
			curve.preWrapMode = (UnityEngine.WrapMode)platformCurveData.PreWrapMode;
			int num = 0;
			if (platformCurveData.AnimationCurveKeyFrames != null)
			{
				num = platformCurveData.AnimationCurveKeyFrames.Count;
			}
			Keyframe[] array = new Keyframe[num];
			for (int i = 0; i < num; i++)
			{
				array[i].time = platformCurveData.AnimationCurveKeyFrames[i].Time;
				array[i].value = platformCurveData.AnimationCurveKeyFrames[i].Value;
				array[i].inTangent = platformCurveData.AnimationCurveKeyFrames[i].InTangent;
				array[i].outTangent = platformCurveData.AnimationCurveKeyFrames[i].OutTangent;
				array[i].tangentMode = platformCurveData.AnimationCurveKeyFrames[i].TangentMode;
				array[i].weightedMode = (WeightedMode)platformCurveData.AnimationCurveKeyFrames[i].WeightedMode;
				array[i].inWeight = platformCurveData.AnimationCurveKeyFrames[i].InWeight;
				array[i].outWeight = platformCurveData.AnimationCurveKeyFrames[i].OutWeight;
			}
			curve.keys = array;
		}
	}

	protected override void OnUpdateMovement(out Vector3 goalPosition, out Quaternion goalRotation, float deltaTime)
	{
		deltaTime = (float)(int)(deltaTime * 100f) * 1f / 100f;
		float num = deltaTime;
		float num2 = 0.01f;
		if (isReseve)
		{
			deltaTime *= -1f;
			num *= -1f;
			num2 *= -1f;
		}
		dis = 0f;
		goalPosition = Mover.TransientPosition;
		while (num != 0f)
		{
			if (Mathf.Abs(num) < Mathf.Abs(num2))
			{
				runningTime += num;
			}
			else
			{
				runningTime += num2;
			}
			runningTime = Mathf.Clamp(runningTime, 0f, time);
			runningSpeed.x = curveX.Evaluate(runningTime);
			runningSpeed.y = curveY.Evaluate(runningTime);
			runningSpeed.z = curveZ.Evaluate(runningTime);
			runningSpeed = Quaternion.Euler(Vector3.up * YRoatation) * runningSpeed;
			if (Mathf.Abs(num) < Mathf.Abs(num2))
			{
				goalPosition += runningSpeed * num;
				num -= num;
				dis += runningSpeed.y * num;
			}
			else
			{
				goalPosition += runningSpeed * num2;
				dis += runningSpeed.y * num2;
				num -= num2;
			}
		}
		goalRotation = Mover.TransientRotation;
		if (wrapMode == WrapMode.Once)
		{
			if (runningTime >= time)
			{
				runningTime = 0f;
				SetPause(paused: true);
				SavePlatformData();
			}
		}
		else if (wrapMode == WrapMode.Loop)
		{
			if (runningTime >= time)
			{
				runningTime = 0f;
			}
		}
		else if (wrapMode == WrapMode.PingPong)
		{
			if (runningTime >= time)
			{
				runningTime = time;
				isReseve = true;
			}
			else if (runningTime <= 0f)
			{
				runningTime = 0f;
				isReseve = false;
			}
		}
		ChangeCollidersEnable();
	}

	protected override void GetMoveSpeedZero()
	{
		if (runningSpeed.sqrMagnitude == 0f && !moveSpeedZero)
		{
			PlatformAnimator.SetBool(animtorParamMoveSpeed, true);
			moveSpeedZero = true;
		}
		else if (runningSpeed.sqrMagnitude != 0f && moveSpeedZero)
		{
			PlatformAnimator.SetBool(animtorParamMoveSpeed, false);
			moveSpeedZero = false;
		}
	}

	public void ChangeCollidersEnable()
	{
		foreach (NormalPlatformControlCollider item in ControlCollidersEnable)
		{
			if (!(runningTime > item.StartTime) || !(runningTime < item.OverTime))
			{
				continue;
			}
			foreach (GameObject activeGameObject in item.ActiveGameObjects)
			{
				if (activeGameObject != null && !activeGameObject.activeSelf)
				{
					activeGameObject.SetActive(value: true);
				}
			}
			foreach (GameObject inActiveGameObject in item.InActiveGameObjects)
			{
				if (inActiveGameObject != null && inActiveGameObject.activeSelf)
				{
					inActiveGameObject.SetActive(value: false);
				}
			}
		}
	}

	protected override void OnResetPlatform()
	{
		base.OnResetPlatform();
		runningTime = 0f;
		runningSpeed = Vector3.zero;
		isReseve = false;
	}

	public void ChangePlatformParams(WrapMode warWrapMode, float time, AnimationCurve curveX, AnimationCurve curveY, AnimationCurve curveZ)
	{
		OnResetPlatform();
		wrapMode = warWrapMode;
		this.curveX = curveX;
		this.curveY = curveY;
		this.curveZ = curveZ;
		this.time = time;
		SavePlatformData();
	}

	public override void SavePlatformData()
	{
		base.SavePlatformData();
		int levelId = Mover.GetSystem<SceneSystem>().GetLevelId();
		Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNormalPlatformData(levelId, base.ID, base.Paused, time, curveX, curveY, curveZ, (int)wrapMode, ((Component)(object)this).transform.position, ((Component)(object)this).transform.localEulerAngles, ((Component)(object)this).transform.localScale);
	}
}

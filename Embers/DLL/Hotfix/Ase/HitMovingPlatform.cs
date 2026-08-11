#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;

namespace Ase;

public class HitMovingPlatform : MovingPlatform
{
	private string hitVolumeAnimtorParam = "CanHit";

	public List<Animator> PhysicsMoverAnimators;

	public List<HitPlatformControlCollider> ControlCollidersEnable;

	[SerializeField]
	private AnimationCurve speedCurve;

	[SerializeField]
	private Vector3 originMoveDirect;

	[SerializeField]
	private float time;

	[SerializeField]
	private float runningTime;

	[SerializeField]
	private float runningSpeed;

	[SerializeField]
	private Vector3 runningMoveDirect;

	[SerializeField]
	private List<HitVolumeParamConfigInfo> hitVolumeParamConfigInfos;

	public bool IsUseLocalMove;

	private AnimationCurve originAniCurve;

	private List<HitVolumeParamConfigInfo> originHitVolumeParamConfigInfos;

	private bool originPause;

	private float originTime;

	protected override bool CanHit => true;

	protected override bool IsRunning => runningSpeed != 0f;

	protected override void OnInited()
	{
		base.OnInited();
		runningTime = 0f;
		runningMoveDirect = originMoveDirect;
		if (Mover != null)
		{
			for (int i = 0; i < hitVolumeParamConfigInfos.Count; i++)
			{
				HitVolumeCanHitChange(i, hitVolumeParamConfigInfos[i].IsCanHit);
			}
		}
		CacheOriginData();
	}

	private void CacheOriginData()
	{
		originAniCurve = new AnimationCurve(speedCurve.keys);
		originHitVolumeParamConfigInfos = new List<HitVolumeParamConfigInfo>(hitVolumeParamConfigInfos.Count);
		for (int i = 0; i < hitVolumeParamConfigInfos.Count; i++)
		{
			originHitVolumeParamConfigInfos.Add(HitVolumeParamConfigInfo.CopyData(hitVolumeParamConfigInfos[i]));
		}
		originPause = base.Paused;
		originTime = time;
	}

	protected override void OnUpdateMovement(out Vector3 goalPosition, out Quaternion goalRotation, float deltaTime)
	{
		runningTime += deltaTime;
		runningTime = Mathf.Clamp(runningTime, 0f, time);
		runningSpeed = speedCurve.Evaluate(runningTime);
		if (IsUseLocalMove)
		{
			goalPosition = Mover.TransientPosition + ((Component)(object)this).transform.rotation * runningMoveDirect * (runningSpeed * deltaTime);
		}
		else
		{
			goalPosition = Mover.TransientPosition + runningMoveDirect * (runningSpeed * deltaTime);
		}
		goalRotation = Mover.TransientRotation;
		if (runningTime >= time)
		{
			runningTime = 0f;
			SetPause(paused: true);
			runningSpeed = 0f;
		}
		ChangeCollidersEnable();
	}

	public void ChangeCollidersEnable()
	{
		foreach (HitPlatformControlCollider item in ControlCollidersEnable)
		{
			if ((item.SpeedOptional != SpeedValueCompare.Greater || !(runningSpeed > item.Speed)) && (item.SpeedOptional != SpeedValueCompare.Equal || runningSpeed != item.Speed) && (item.SpeedOptional != SpeedValueCompare.Less || !(runningSpeed < item.Speed)))
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

	protected override void GetMoveSpeedZero()
	{
		if (runningSpeed == 0f && !moveSpeedZero)
		{
			PlatformAnimator.SetBool(animtorParamMoveSpeed, true);
			moveSpeedZero = true;
		}
		else if (runningSpeed != 0f && moveSpeedZero)
		{
			PlatformAnimator.SetBool(animtorParamMoveSpeed, false);
			moveSpeedZero = false;
		}
	}

	public override void InteractiveFinish(int index)
	{
		base.InteractiveFinish(index);
		if (!base.Paused || index >= hitVolumeParamConfigInfos.Count)
		{
			return;
		}
		HitVolumeParamConfigInfo hitVolumeParamConfigInfo = hitVolumeParamConfigInfos[index];
		if (!hitVolumeParamConfigInfo.IsCanHit)
		{
			SavePlatformData();
			return;
		}
		SetPause(paused: false);
		hitVolumeParamConfigInfo.CanHitCount -= hitVolumeParamConfigInfo.ReduceHitCount;
		hitVolumeParamConfigInfo.CanHitCount = Mathf.Max(hitVolumeParamConfigInfo.CanHitCount, 0);
		hitVolumeParamConfigInfo.IsCanHit = hitVolumeParamConfigInfo.CanHitCount > 0;
		HitVolumeCanHitChange(index, hitVolumeParamConfigInfo.IsCanHit);
		if (hitVolumeParamConfigInfo.HitVolumeHitCountChangeInfo.Count > 0)
		{
			foreach (HitVolumeHitCountChangeInfo item in hitVolumeParamConfigInfo.HitVolumeHitCountChangeInfo)
			{
				if (hitVolumeParamConfigInfos.Count >= item.Id)
				{
					hitVolumeParamConfigInfos[item.Id].CanHitCount -= item.ReduceHitCount;
					hitVolumeParamConfigInfo.CanHitCount = Mathf.Max(hitVolumeParamConfigInfos[item.Id].CanHitCount, 0);
					hitVolumeParamConfigInfos[item.Id].IsCanHit = hitVolumeParamConfigInfos[item.Id].CanHitCount > 0;
					HitVolumeCanHitChange(index, hitVolumeParamConfigInfos[item.Id].IsCanHit);
				}
			}
		}
		SavePlatformData();
		runningMoveDirect = hitVolumeParamConfigInfo.HitMoveDirects;
	}

	public void SetHitVolumeParamCanHit(int index, bool isCanHit)
	{
		if (index < hitVolumeParamConfigInfos.Count)
		{
			hitVolumeParamConfigInfos[index].IsCanHit = isCanHit;
			HitVolumeCanHitChange(index, isCanHit);
		}
	}

	public override void ResetPlatform()
	{
		base.ResetPlatform();
		Mover.SetPositionAndRotation(originPosition, Quaternion.Euler(originEulerAngles));
		runningTime = 0f;
		runningMoveDirect = originMoveDirect;
		speedCurve = new AnimationCurve(originAniCurve.keys);
		for (int i = 0; i < hitVolumeParamConfigInfos.Count; i++)
		{
			HitVolumeParamConfigInfo.ReverData(originHitVolumeParamConfigInfos[i], hitVolumeParamConfigInfos[i]);
		}
		SetPause(originPause);
		if (Mover != null)
		{
			for (int j = 0; j < hitVolumeParamConfigInfos.Count; j++)
			{
				HitVolumeCanHitChange(j, hitVolumeParamConfigInfos[j].IsCanHit);
			}
		}
	}

	protected override void OnResetPlatform()
	{
		base.OnResetPlatform();
		runningTime = 0f;
		runningMoveDirect = originMoveDirect;
	}

	private void HitVolumeCanHitChange(int index, bool canHit)
	{
		if (PhysicsMoverAnimators.Count <= index)
		{
			return;
		}
		Animator val = PhysicsMoverAnimators[index];
		if ((Object)(object)val == null)
		{
			Log.Error("击打平台" + ((Component)(object)this).gameObject.name + "受击盒动画控制器为空");
			return;
		}
		if (canHit)
		{
			((Component)(object)val).gameObject.SetActive(value: true);
			val.SetBool(hitVolumeAnimtorParam, true);
		}
		else
		{
			val.SetBool(hitVolumeAnimtorParam, false);
		}
		if (canHit)
		{
			SetMovingPaltformInteractive(index, active: true);
		}
		else
		{
			SetMovingPaltformInteractive(index, active: false);
		}
	}

	public override void OnPause()
	{
		base.OnPause();
		if (!base.Paused)
		{
			for (int i = 0; i < hitVolumeParamConfigInfos.Count; i++)
			{
				if (hitVolumeParamConfigInfos[i].IsCanHit)
				{
					SetMovingPaltformInteractive(i, active: false);
				}
			}
			return;
		}
		for (int j = 0; j < hitVolumeParamConfigInfos.Count; j++)
		{
			if (hitVolumeParamConfigInfos[j].IsCanHit)
			{
				SetMovingPaltformInteractive(j, active: true);
			}
		}
	}

	private void SetMovingPaltformInteractive(int index, bool active)
	{
		if (movingPaltformInteractiveComs != null && movingPaltformInteractiveComs.Length > index)
		{
			movingPaltformInteractiveComs[index].SetCanInteractive(active && base.Paused);
		}
	}
}

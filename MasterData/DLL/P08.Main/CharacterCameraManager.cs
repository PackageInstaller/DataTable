using System;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using UnityEngine;

public class CharacterCameraManager : MonoBehaviour
{
	public enum Elasticity_Type
	{
		NONE,
		Active,
		Passive_Wait,
		Passive
	}

	public List<CinemachineFreeLook> cinemachineFreeLookList;

	private List<CinemachineComposer> cinemachineComposerList;

	public List<Transform> dummyTrsList;

	private CinemachineFreeLook lastCamera;

	private const int PRIORITY = 1000;

	[SerializeField]
	private float moveSpeedX = 0.05f;

	private float? _curMoveSpeedX;

	[SerializeField]
	private float moveSpeedY = 0.002f;

	private float? _curMoveSpeedY;

	[SerializeField]
	private float maxMoveSpeedX = 20f;

	[SerializeField]
	private float maxMoveSpeedY = 0.05f;

	[SerializeField]
	private float deltaTimeX = 0.1f;

	[SerializeField]
	private float deltaTimeY = 0.1f;

	[SerializeField]
	private float elasticityAreaX = 5f;

	[SerializeField]
	private float elasticityAreaY = 0.1f;

	[SerializeField]
	private float elasticityAreaSpeed = 0.1f;

	[SerializeField]
	private float elasticityAreaSpeedPassive = 0.1f;

	[SerializeField]
	private AnimationCurve aimCurver;

	[SerializeField]
	private float cameraChangeTime = 1f;

	[SerializeField]
	private float tweenToDefaultTime = 0.3f;

	[Range(0.001f, 1f)]
	public float moveSpeedAffectComposerFactor = 1f;

	public int lastCameraIndex = -1;

	[HideInInspector]
	public MutiTouchHelper touchHelper;

	[SerializeField]
	private List<CameraCfgGroup> cameraCfgGroupS;

	private CameraCfgGroup currentCameraGroupCfg;

	private LTDescr tween_freeLook;

	private LTDescr tween_composer;

	private LTDescr tween_move;

	public bool isMove;

	private bool? manuallyRecordIsTweening;

	public CameraInputMode cameara_mode = CameraInputMode.Normal;

	private float lastSpeedX;

	private float lastSpeedY;

	private float lastdeltaSpeed;

	private Transform lookAt;

	private const float DELTA_LIMIT = 0.001f;

	private float delta_timer;

	private Elasticity_Type elasticity_x;

	private Elasticity_Type elasticity_y;

	private float curMoveSpeedX => _curMoveSpeedX ?? moveSpeedX;

	private float curMoveSpeedY => _curMoveSpeedY ?? moveSpeedX;

	public bool IsTweening => manuallyRecordIsTweening ?? LeanTween.isTweening(base.gameObject);

	private static bool GetIsTweening(LTSeq seq)
	{
		if (seq != null)
		{
			return LeanTween.isTweening(seq.id);
		}
		return false;
	}

	private static bool GetIsTweening(LTDescr seq)
	{
		if (seq != null)
		{
			return LeanTween.isTweening(seq.id);
		}
		return false;
	}

	private void Awake()
	{
		if (cinemachineFreeLookList != null)
		{
			cinemachineComposerList = new List<CinemachineComposer>(cinemachineFreeLookList.Count);
			for (int i = 0; i < cinemachineFreeLookList.Count; i++)
			{
				cinemachineComposerList.Add(cinemachineFreeLookList[i].GetRig(1).GetCinemachineComponent<CinemachineComposer>());
			}
		}
	}

	private CameraCfg GetCameraCfg(int index)
	{
		if (index >= currentCameraGroupCfg.cameraCfgS.Count)
		{
			return currentCameraGroupCfg.cameraCfgS[0];
		}
		return currentCameraGroupCfg.cameraCfgS[index];
	}

	private CameraCfg GetCameraCfg(int groupIndex, int index)
	{
		groupIndex = Math.Clamp(groupIndex, 0, cameraCfgGroupS.Count - 1);
		CameraCfgGroup cameraCfgGroup = cameraCfgGroupS[groupIndex];
		index = Math.Clamp(index, 0, cameraCfgGroup.cameraCfgS.Count - 1);
		return cameraCfgGroup.cameraCfgS[index];
	}

	private Transform GetdummyTrs(int index)
	{
		if (index >= dummyTrsList.Count)
		{
			return dummyTrsList[0];
		}
		return dummyTrsList[index];
	}

	public void SetActiveCamera(int index, bool cut = false, bool restore = true)
	{
		if (lastCameraIndex != index && cinemachineFreeLookList != null && cinemachineFreeLookList.Count >= index)
		{
			if (lastCamera != null)
			{
				lastCamera.Priority = 0;
			}
			RemoveTween();
			SetCameraBlend(cut);
			ResetMoveSpeed();
			lastCameraIndex = index;
			if (restore)
			{
				ResetCameraDefaultCfg();
			}
			cinemachineFreeLookList[index].Priority = 1000;
			lastCamera = cinemachineFreeLookList[index];
			lastCamera.UpdateCameraState(Vector3.up, 0f);
		}
	}

	public void RemoveActiveCamera()
	{
		if (!(lastCamera == null))
		{
			SetCameraBlend();
			lastCameraIndex = -1;
			lastCamera.Priority = 0;
			lastCamera = null;
			ResetMoveSpeed();
		}
	}

	public void SwitchCamearInputmode(int mode = 1)
	{
		switch (mode)
		{
		case 1:
			cameara_mode = CameraInputMode.Normal;
			break;
		case 2:
			cameara_mode = CameraInputMode.FixedElevation;
			break;
		case 3:
			cameara_mode = CameraInputMode.Move;
			break;
		default:
			cameara_mode = CameraInputMode.Normal;
			break;
		}
	}

	public void TweenToDefaultCameraPos()
	{
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			ResetMoveSpeed();
			CinemachineFreeLook freeLook = cinemachineFreeLookList[lastCameraIndex];
			CinemachineComposer composer = cinemachineComposerList[lastCameraIndex];
			CameraCfg cameraCfg = GetCameraCfg(lastCameraIndex);
			RemoveTween();
			tween_freeLook = LeanTween.value(base.gameObject, freeLook.m_XAxis.Value, cameraCfg.defaultX, tweenToDefaultTime).setOnUpdate(delegate(float value)
			{
				freeLook.m_XAxis.Value = value;
			});
			tween_composer = LeanTween.value(base.gameObject, composer.m_ScreenY, cameraCfg.defaultY, tweenToDefaultTime).setOnUpdate(delegate(float value)
			{
				composer.m_ScreenY = value;
			});
		}
	}

	public void TweenAllCamToCameraPosByCfgID(int cfgID)
	{
		TweenAllCamToCameraPosByCfgID(cfgID, Enumerable.Range(0, cinemachineFreeLookList.Count - 1));
	}

	public void TweenAllCamToCameraPosByCfgID(int cfgID, params int[] tweenCamIds)
	{
		TweenAllCamToCameraPosByCfgID(cfgID, tweenCamIds.AsEnumerable());
	}

	internal void TweenAllCamToCameraPosByCfgID(int cfgID, IEnumerable<int> tweenCamIds)
	{
		if (cfgID < 0 || cfgID >= cameraCfgGroupS.Count)
		{
			return;
		}
		ResetMoveSpeed();
		RemoveTween();
		UpdateSpeedFactor(cfgID);
		CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[lastCameraIndex];
		CinemachineComposer cinemachineComposer = cinemachineComposerList[lastCameraIndex];
		Vector2 freelookDir = new Vector2(cinemachineFreeLook.m_XAxis.Value, cinemachineFreeLook.m_YAxis.Value);
		Vector2 composerValue = new Vector2(cinemachineComposer.m_ScreenX, cinemachineComposer.m_ScreenY);
		tween_freeLook = LeanTween.value(base.gameObject, 0f, 1f, cameraChangeTime).setEase(aimCurver).setOnUpdate(delegate(float nt)
		{
			foreach (int tweenCamId in tweenCamIds)
			{
				CinemachineFreeLook cinemachineFreeLook2 = cinemachineFreeLookList[tweenCamId];
				CameraCfg cameraCfg = GetCameraCfg(cfgID, tweenCamId);
				float value = Mathf.LerpAngle(freelookDir.x, cameraCfg.defaultX, nt);
				float value2 = Mathf.Lerp(freelookDir.y, cameraCfg.defaultAxisY, nt);
				cinemachineFreeLook2.m_XAxis.Value = value;
				cinemachineFreeLook2.m_YAxis.Value = value2;
			}
		});
		tween_composer = LeanTween.value(base.gameObject, 0f, 1f, cameraChangeTime).setEase(aimCurver).setOnUpdate(delegate(float nt)
		{
			foreach (int tweenCamId2 in tweenCamIds)
			{
				CinemachineComposer cinemachineComposer2 = cinemachineComposerList[tweenCamId2];
				CameraCfg cameraCfg = GetCameraCfg(cfgID, tweenCamId2);
				Vector2 vector = Vector2.Lerp(composerValue, new Vector2(cameraCfg.defaultComposerX, cameraCfg.defaultY), nt);
				cinemachineComposer2.m_ScreenX = vector.x;
				cinemachineComposer2.m_ScreenY = vector.y;
			}
		});
	}

	public void RemoveTween()
	{
		manuallyRecordIsTweening = null;
		LeanTween.cancel(base.gameObject);
	}

	public void SetCameraPosWithMoveX(float moveValue, Action callback, LeanTweenType easeType = LeanTweenType.linear)
	{
		if (lastCameraIndex != -1)
		{
			cinemachineComposerList[lastCameraIndex].m_ScreenX = moveValue + 0.5f;
			TweenCamComposerXToCenter(callback, easeType);
		}
	}

	public void AddCameraPosWithMoveX(float moveValue, Action callback, LeanTweenType easeType = LeanTweenType.linear)
	{
		if (lastCameraIndex != -1)
		{
			CinemachineComposer cinemachineComposer = cinemachineComposerList[lastCameraIndex];
			float xValue = moveValue + cinemachineComposer.m_ScreenX;
			TweenCamComposerX(xValue, callback, easeType);
		}
	}

	public void TweenCamComposerXToCenter(Action callback, LeanTweenType easeType = LeanTweenType.linear)
	{
		TweenCamComposerX(0.5f, callback, easeType);
	}

	public void TweenCamComposerX(float xValue, Action callback, LeanTweenType easeType = LeanTweenType.linear)
	{
		if (lastCameraIndex == -1)
		{
			return;
		}
		RemoveTween();
		CinemachineFreeLook freeLook = cinemachineFreeLookList[lastCameraIndex];
		GetCameraCfg(lastCameraIndex);
		ResetMoveSpeed();
		float screenX = cinemachineComposerList[lastCameraIndex].m_ScreenX;
		manuallyRecordIsTweening = true;
		tween_move = LeanTween.value(base.gameObject, screenX, xValue, tweenToDefaultTime).setEase(easeType).setOnUpdate(delegate(float value)
		{
			for (int i = 0; i <= 2; i++)
			{
				freeLook.GetRig(i).GetCinemachineComponent<CinemachineComposer>().m_ScreenX = value;
			}
		})
			.setOnComplete((Action)delegate
			{
				manuallyRecordIsTweening = false;
				callback?.Invoke();
				manuallyRecordIsTweening = null;
			});
	}

	public void TweenCamComposerToCenter(Action callback)
	{
		if (lastCameraIndex == -1)
		{
			return;
		}
		CinemachineFreeLook freeLook = cinemachineFreeLookList[lastCameraIndex];
		GetCameraCfg(lastCameraIndex);
		CinemachineComposer cinemachineComposer = cinemachineComposerList[lastCameraIndex];
		float screenX = cinemachineComposer.m_ScreenX;
		float screenY = cinemachineComposer.m_ScreenY;
		manuallyRecordIsTweening = true;
		LeanTween.value(base.gameObject, new Vector2(screenX, screenY), new Vector2(0.5f, 0.5f), tweenToDefaultTime).setOnUpdateVector2(delegate(Vector2 value)
		{
			for (int i = 0; i <= 2; i++)
			{
				CinemachineComposer cinemachineComponent = freeLook.GetRig(i).GetCinemachineComponent<CinemachineComposer>();
				cinemachineComponent.m_ScreenX = value.x;
				cinemachineComponent.m_ScreenY = value.y;
			}
		}).setOnComplete((Action)delegate
		{
			manuallyRecordIsTweening = false;
			callback?.Invoke();
			manuallyRecordIsTweening = null;
		});
	}

	private void UpdateSpeedFactor(int groupIdx)
	{
		UpdateSpeedFactor(cameraCfgGroupS[groupIdx]);
	}

	private void UpdateSpeedFactor(CameraCfgGroup group)
	{
		if (group.overrideMoveSpeed)
		{
			_curMoveSpeedX = group.overrideMoveSpeedValue.x;
			_curMoveSpeedY = group.overrideMoveSpeedValue.y;
		}
		else
		{
			_curMoveSpeedX = null;
			_curMoveSpeedY = null;
		}
	}

	public void SetCameraParams(int status)
	{
		if (status >= cameraCfgGroupS.Count)
		{
			return;
		}
		currentCameraGroupCfg = cameraCfgGroupS[status];
		UpdateSpeedFactor(currentCameraGroupCfg);
		for (int i = 0; i < cinemachineFreeLookList.Count; i++)
		{
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[i];
			CameraCfg cameraCfg = GetCameraCfg(i);
			cinemachineFreeLook.m_XAxis.m_Wrap = cameraCfg.warpX;
			cinemachineFreeLook.m_YAxis.m_Wrap = cameraCfg.warpY;
			cinemachineFreeLook.m_Orbits[0].m_Radius = cameraCfg.radius;
			cinemachineFreeLook.m_Orbits[1].m_Radius = cameraCfg.radius;
			cinemachineFreeLook.m_Orbits[2].m_Radius = cameraCfg.radius;
			cinemachineFreeLook.m_Orbits[0].m_Height = cameraCfg.rigHeight[0];
			cinemachineFreeLook.m_Orbits[1].m_Height = cameraCfg.rigHeight[1];
			cinemachineFreeLook.m_Orbits[2].m_Height = cameraCfg.rigHeight[2];
			if (i < currentCameraGroupCfg.cameraCfgS.Count)
			{
				if (cameraCfg.warpX)
				{
					cinemachineFreeLook.m_XAxis.m_MinValue = cameraCfg.minScreenX;
					cinemachineFreeLook.m_XAxis.m_MaxValue = cameraCfg.maxScreenX;
				}
				else
				{
					cinemachineFreeLook.m_XAxis.m_MinValue = cameraCfg.minScreenX - elasticityAreaX;
					cinemachineFreeLook.m_XAxis.m_MaxValue = cameraCfg.maxScreenX + elasticityAreaX;
				}
			}
			GetdummyTrs(i).localPosition = cameraCfg.dummyPosition;
			CinemachineVirtualCamera rig = cinemachineFreeLook.GetRig(1);
			if (cameraCfg.fov > 0f)
			{
				rig.m_Lens.FieldOfView = cameraCfg.fov;
			}
			if (cameraCfg.dutch >= -180f)
			{
				rig.m_Lens.Dutch = cameraCfg.dutch;
			}
		}
	}

	public void ResetCameraDefaultCfg()
	{
		if (!(lastCamera == null) && lastCameraIndex != -1 && lastCameraIndex < currentCameraGroupCfg.cameraCfgS.Count)
		{
			RemoveTween();
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[lastCameraIndex];
			CinemachineComposer cinemachineComposer = cinemachineComposerList[lastCameraIndex];
			CameraCfg cameraCfg = GetCameraCfg(lastCameraIndex);
			cinemachineFreeLook.m_XAxis.Value = cameraCfg.defaultX;
			cinemachineFreeLook.m_YAxis.Value = cameraCfg.defaultAxisY;
			cinemachineComposer.m_ScreenY = cameraCfg.defaultY;
			ResetMoveSpeed();
			cinemachineFreeLook.UpdateCameraState(Vector3.up, 0f);
		}
	}

	protected void SetCameraBlend(bool cut = false)
	{
		CinemachineBrain cinemachineBrain = Camera.main.GetComponent<CinemachineBrain>();
		if (cinemachineBrain == null)
		{
			cinemachineBrain = Camera.main.gameObject.AddComponent<CinemachineBrain>();
		}
		CinemachineBlendDefinition defaultBlend = default(CinemachineBlendDefinition);
		if (cut)
		{
			defaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
		}
		else
		{
			defaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Custom, cameraChangeTime);
			defaultBlend.m_CustomCurve = aimCurver;
		}
		cinemachineBrain.m_DefaultBlend = defaultBlend;
	}

	public void RotateCamera(float speed_x, float speed_y)
	{
		lastSpeedX = speed_x;
		lastSpeedY = speed_y;
		if (cameara_mode == CameraInputMode.Normal)
		{
			ResetFreelookHeight();
			Rotate(speed_x, speed_y);
		}
		else if (cameara_mode == CameraInputMode.FixedElevation)
		{
			RotateCameraElevation(speed_x, speed_y);
		}
		else if (cameara_mode == CameraInputMode.Move)
		{
			MoveCamera(speed_x, speed_y);
		}
	}

	private void RotaCameraWithDelta(float speed_x, float speed_y)
	{
		Rotate(speed_x, speed_y);
	}

	private void RotateCameraElevation(float speed_x, float speed_y)
	{
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			int index = lastCameraIndex;
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[index];
			float num = (0f - speed_y) * moveSpeedAffectComposerFactor * Time.deltaTime * curMoveSpeedY;
			CameraCfg cameraCfg = GetCameraCfg(index);
			float minScreenY = cameraCfg.minScreenY;
			float maxScreenY = cameraCfg.maxScreenY;
			float num2 = speed_x * moveSpeedAffectComposerFactor * Time.deltaTime * curMoveSpeedX;
			float minComposerX = cameraCfg.minComposerX;
			float maxComposerX = cameraCfg.maxComposerX;
			for (int i = 0; i <= 2; i++)
			{
				CinemachineComposer cinemachineComponent = cinemachineFreeLook.GetRig(i).GetCinemachineComponent<CinemachineComposer>();
				float screenY = Mathf.Clamp(cinemachineComponent.m_ScreenY + num, minScreenY, maxScreenY);
				cinemachineComponent.m_ScreenY = screenY;
				float screenX = Mathf.Clamp(cinemachineComponent.m_ScreenX + num2, minComposerX, maxComposerX);
				cinemachineComponent.m_ScreenX = screenX;
			}
		}
	}

	private void RotateCamera(float pitchDelta)
	{
	}

	private void MoveCamera(float speed_x, float speed_y)
	{
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			int index = lastCameraIndex;
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[index];
			_ = cinemachineComposerList[index];
			float num = speed_x * Time.deltaTime * curMoveSpeedX * 180f;
			float num2 = (0f - speed_y) * Time.deltaTime * curMoveSpeedY;
			cinemachineFreeLook.m_XAxis.Value = cinemachineFreeLook.m_XAxis.Value + num;
			CameraCfg cameraCfg = GetCameraCfg(index);
			cinemachineFreeLook.m_Orbits[0].m_Height = cameraCfg.rigHeight[0];
			cinemachineFreeLook.m_Orbits[1].m_Height = cameraCfg.rigHeight[1];
			cinemachineFreeLook.m_Orbits[2].m_Height = cameraCfg.rigHeight[2];
			cinemachineFreeLook.m_YAxis.Value = cinemachineFreeLook.m_YAxis.Value + num2;
		}
	}

	public void SyncFreelookVCamMove(int target, int source)
	{
		if (source >= 0 && source < cinemachineFreeLookList.Count && target >= 0 && target < cinemachineFreeLookList.Count)
		{
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[source];
			CinemachineFreeLook cinemachineFreeLook2 = cinemachineFreeLookList[target];
			cinemachineFreeLook2.m_XAxis.Value = cinemachineFreeLook.m_XAxis.Value;
			cinemachineFreeLook2.m_YAxis.Value = cinemachineFreeLook.m_YAxis.Value;
			CinemachineComposer cinemachineComposer = cinemachineComposerList[source];
			CinemachineComposer cinemachineComposer2 = cinemachineComposerList[target];
			cinemachineComposer2.m_ScreenX = cinemachineComposer.m_ScreenX;
			cinemachineComposer2.m_ScreenY = cinemachineComposer.m_ScreenY;
		}
	}

	internal void Rotate(float speed_x, float speed_y)
	{
		speed_x = Mathf.Clamp(speed_x, 0f - maxMoveSpeedX, maxMoveSpeedX);
		speed_y = Mathf.Clamp(speed_y, 0f - maxMoveSpeedY, maxMoveSpeedY);
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			RemoveTween();
			int index = lastCameraIndex;
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[index];
			CinemachineComposer cinemachineComposer = cinemachineComposerList[index];
			float num = speed_x * Time.deltaTime * curMoveSpeedX * 180f;
			float num2 = speed_y * Time.deltaTime * curMoveSpeedY * moveSpeedAffectComposerFactor;
			cinemachineFreeLook.m_XAxis.Value = cinemachineFreeLook.m_XAxis.Value + num;
			CameraCfg cameraCfg = GetCameraCfg(index);
			float screenY = Mathf.Clamp(cinemachineComposer.m_ScreenY + num2, cameraCfg.minScreenY - elasticityAreaY, cameraCfg.maxScreenY + elasticityAreaY);
			cinemachineComposer.m_ScreenY = screenY;
		}
	}

	public void UpdateElevation(float speed_y)
	{
		speed_y = Mathf.Clamp(speed_y, 0f - maxMoveSpeedY, maxMoveSpeedY);
		lastdeltaSpeed = speed_y;
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			RemoveTween();
			int index = lastCameraIndex;
			_ = cinemachineFreeLookList[index];
			_ = cinemachineComposerList[index];
			_ = Time.deltaTime;
			_ = curMoveSpeedY;
			GetCameraCfg(index);
		}
	}

	private void ResetFreelookHeight()
	{
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			int index = lastCameraIndex;
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[index];
			cinemachineFreeLook.m_Orbits[0].m_Height = 0f;
			cinemachineFreeLook.m_Orbits[1].m_Height = 0f;
			cinemachineFreeLook.m_Orbits[2].m_Height = 0f;
		}
	}

	private void ResetMoveSpeed()
	{
		lastSpeedX = 0f;
		lastSpeedY = 0f;
		elasticity_x = (elasticity_y = Elasticity_Type.NONE);
	}

	public void LateUpdate()
	{
	}

	private void Update()
	{
		if (touchHelper == null)
		{
			return;
		}
		if (!touchHelper.isOnDrag && !IsTweening)
		{
			if (lastCameraIndex == -1)
			{
				return;
			}
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[lastCameraIndex];
			CinemachineComposer cinemachineComposer = cinemachineComposerList[lastCameraIndex];
			if (lastCameraIndex >= currentCameraGroupCfg.cameraCfgS.Count || cameara_mode == CameraInputMode.FixedElevation)
			{
				return;
			}
			CameraCfg cameraCfg = GetCameraCfg(lastCameraIndex);
			delta_timer += Time.deltaTime;
			if (elasticity_x == Elasticity_Type.NONE && !cameraCfg.warpX)
			{
				if (cinemachineFreeLook.m_XAxis.Value < cameraCfg.minScreenX || cinemachineFreeLook.m_XAxis.Value > cameraCfg.maxScreenX)
				{
					elasticity_x = Elasticity_Type.Active;
				}
				else
				{
					elasticity_x = Elasticity_Type.Passive_Wait;
				}
			}
			float num = 0f;
			if (Elasticity_Type.Passive_Wait == elasticity_x && 0f != lastSpeedX)
			{
				float num2 = 0.01f;
				num = Mathf.SmoothStep(lastSpeedX, 0f, Mathf.Min(delta_timer / deltaTimeX, 1f));
				if (cinemachineFreeLook.m_XAxis.Value < cameraCfg.minScreenX)
				{
					if (MathF.Abs(num) < num2)
					{
						elasticity_x = Elasticity_Type.Passive;
					}
					else
					{
						num += num2;
					}
				}
				else if (cinemachineFreeLook.m_XAxis.Value > cameraCfg.maxScreenX)
				{
					if (MathF.Abs(num) < num2)
					{
						elasticity_x = Elasticity_Type.Passive;
					}
					else
					{
						num -= num2;
					}
				}
				if (cinemachineFreeLook.m_XAxis.Value <= cameraCfg.minScreenX - elasticityAreaX || cinemachineFreeLook.m_XAxis.Value >= cameraCfg.maxScreenX + elasticityAreaX)
				{
					elasticity_x = Elasticity_Type.Passive;
				}
			}
			else
			{
				num = 0f;
				lastSpeedX = 0f;
			}
			if (Elasticity_Type.Passive == elasticity_x || Elasticity_Type.Active == elasticity_x)
			{
				float smoothTime = ((Elasticity_Type.Passive == elasticity_x) ? elasticityAreaSpeedPassive : elasticityAreaSpeed);
				if (cinemachineFreeLook.m_XAxis.Value < cameraCfg.minScreenX && cameraCfg.minScreenX - cinemachineFreeLook.m_XAxis.Value > 0.001f)
				{
					float currentVelocity = 0f;
					cinemachineFreeLook.m_XAxis.Value = Mathf.SmoothDamp(cinemachineFreeLook.m_XAxis.Value, cameraCfg.minScreenX, ref currentVelocity, smoothTime);
				}
				else if (cinemachineFreeLook.m_XAxis.Value > cameraCfg.maxScreenX && cinemachineFreeLook.m_XAxis.Value - cameraCfg.maxScreenX > 0.001f)
				{
					float currentVelocity2 = 0f;
					cinemachineFreeLook.m_XAxis.Value = Mathf.SmoothDamp(cinemachineFreeLook.m_XAxis.Value, cameraCfg.maxScreenX, ref currentVelocity2, smoothTime);
				}
			}
			if (elasticity_y == Elasticity_Type.NONE && !cameraCfg.warpY)
			{
				if (cinemachineComposer.m_ScreenY < cameraCfg.minScreenY || cinemachineComposer.m_ScreenY > cameraCfg.maxScreenY)
				{
					elasticity_y = Elasticity_Type.Active;
				}
				else
				{
					elasticity_y = Elasticity_Type.Passive_Wait;
				}
			}
			float num3 = 0f;
			if (Elasticity_Type.Passive_Wait == elasticity_y && 0f != lastSpeedY)
			{
				float num4 = 0.01f;
				num3 = Mathf.SmoothStep(lastSpeedY, 0f, Mathf.Min(delta_timer / deltaTimeY, 1f));
				if (cinemachineComposer.m_ScreenY < cameraCfg.minScreenY)
				{
					if (MathF.Abs(num3) < num4)
					{
						elasticity_y = Elasticity_Type.Passive;
					}
					else
					{
						num3 += num4;
					}
				}
				else if (cinemachineComposer.m_ScreenY > cameraCfg.maxScreenY)
				{
					if (MathF.Abs(num3) < num4)
					{
						elasticity_y = Elasticity_Type.Passive;
					}
					else
					{
						num3 -= num4;
					}
				}
				if (cinemachineComposer.m_ScreenY <= cameraCfg.minScreenY - elasticityAreaY || cinemachineComposer.m_ScreenY >= cameraCfg.maxScreenY + elasticityAreaY)
				{
					elasticity_y = Elasticity_Type.Passive;
				}
			}
			else
			{
				num3 = 0f;
				lastSpeedY = 0f;
			}
			if (Elasticity_Type.Passive == elasticity_y || Elasticity_Type.Active == elasticity_y)
			{
				float smoothTime2 = ((Elasticity_Type.Passive == elasticity_y) ? elasticityAreaSpeedPassive : elasticityAreaSpeed);
				if (cinemachineComposer.m_ScreenY < cameraCfg.minScreenY && cameraCfg.minScreenY - cinemachineComposer.m_ScreenY > 0.001f)
				{
					float currentVelocity3 = 0f;
					cinemachineComposer.m_ScreenY = Mathf.SmoothDamp(cinemachineComposer.m_ScreenY, cameraCfg.minScreenY, ref currentVelocity3, smoothTime2);
				}
				else if (cinemachineComposer.m_ScreenY > cameraCfg.maxScreenY && cinemachineComposer.m_ScreenY - cameraCfg.maxScreenY > 0.001f)
				{
					float currentVelocity4 = 0f;
					cinemachineComposer.m_ScreenY = Mathf.SmoothDamp(cinemachineComposer.m_ScreenY, cameraCfg.maxScreenY, ref currentVelocity4, smoothTime2);
				}
			}
			if ((num != 0f || num3 != 0f) && lastCameraIndex != -1)
			{
				RotaCameraWithDelta(num, num3);
			}
		}
		else
		{
			delta_timer = 0f;
			elasticity_x = Elasticity_Type.NONE;
			elasticity_y = Elasticity_Type.NONE;
		}
	}

	public void IsOpenelevation(bool flag)
	{
		if (!(lastCamera == null) && lastCameraIndex != -1)
		{
			int index = lastCameraIndex;
			CinemachineFreeLook cinemachineFreeLook = cinemachineFreeLookList[index];
			_ = cinemachineComposerList[index];
			if (cinemachineFreeLook.Follow != null)
			{
				lookAt = cinemachineFreeLook.Follow;
			}
			Debug.Log("开启固定视角" + flag + " " + cinemachineFreeLook.Follow);
			cinemachineFreeLook.Follow = (flag ? null : lookAt);
		}
	}

	protected void OnDestroy()
	{
		RemoveTween();
		touchHelper = null;
	}
}

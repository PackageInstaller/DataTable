using System;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class CommonEffectPlayerWithEntityScale
{
	public Transform target;

	private bool _isPause;

	private float _timeScale = 1f;

	private Dictionary<string, EffectController> _effect = new Dictionary<string, EffectController>(64);

	private List<EffectController> _effectController = new List<EffectController>(64);

	private bool _isOut;

	private float _outTimeScale = 1f;

	public EffectController Play(string effectName, string handPointPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isAttach, bool isLoop, bool needManager, float normalize = 0f, float effectKeepTime = 0.5f, bool usePosition = false, Vector3 centerPos = default(Vector3), bool isLockEffectRotation = false, bool isMainPlayeOrBossOrElitel = false, bool isFriend = false, bool isCameraEffect = false, float timeScale = 1f)
	{
		if (needManager && _effect.ContainsKey(effectName))
		{
			return null;
		}
		EffectController effectController = PlayEffect(target, effectName, handPointPath, offset, scale, rotation, forward, isAttach, isLoop, timeScale, normalize, effectKeepTime, usePosition, centerPos, isLockEffectRotation, OnEffectStop, isCameraEffect, isMainPlayeOrBossOrElitel, isFriend);
		if (needManager)
		{
			_effect[effectName] = effectController;
		}
		_effectController.Add(effectController);
		return effectController;
	}

	public void Stop(string effect)
	{
		EffectController value = null;
		if (_effect.TryGetValue(effect, out value))
		{
			value.Clean();
			_effect.Remove(effect);
			_effectController.Remove(value);
			PooledAsset.DestroyOrReturn(value.gameObject);
		}
	}

	public void StopAll()
	{
		foreach (EffectController item in _effectController)
		{
			item.Clean();
			PooledAsset.DestroyOrReturn(item.gameObject);
		}
		_effectController.Clear();
		_effect.Clear();
	}

	public void Pause(bool isPause = true)
	{
		if (_isPause != isPause)
		{
			List<EffectController>.Enumerator enumerator = _effectController.GetEnumerator();
			while (enumerator.MoveNext())
			{
				enumerator.Current.Pause(isPause);
			}
			_isPause = isPause;
		}
	}

	public static EEffectQuality CheckQuality(bool isMainPlayer)
	{
		EEffectQuality result = BattleScene.MainPlayerQuality;
		if (!isMainPlayer)
		{
			result = BattleScene.AIQuality;
		}
		return result;
	}

	public static GameObject SetVirtualCameraEffect(GameObject effectGameObject, GameObject targetVirtualCamera, bool useVirtualCameraFirst)
	{
		if (effectGameObject == null)
		{
			Debug.LogError("特效为空");
			return null;
		}
		Camera main = Camera.main;
		if (main == null)
		{
			Debug.LogError("找不到主相机");
			return effectGameObject;
		}
		effectGameObject.transform.SetParent(main.transform);
		CinemachineVirtualCamera cinemachineVirtualCamera = null;
		if (targetVirtualCamera != null)
		{
			cinemachineVirtualCamera = targetVirtualCamera.GetComponentInChildren<CinemachineVirtualCamera>();
		}
		if ((cinemachineVirtualCamera == null) & useVirtualCameraFirst)
		{
			CinemachineBrain component = main.GetComponent<CinemachineBrain>();
			if (component != null)
			{
				cinemachineVirtualCamera = component.ActiveVirtualCamera as CinemachineVirtualCamera;
			}
		}
		if (cinemachineVirtualCamera != null)
		{
			U3DUtil.Get<CameraEffectController>(effectGameObject).SetCameraEvent(cinemachineVirtualCamera);
		}
		effectGameObject.transform.localPosition = Vector3.zero;
		effectGameObject.transform.localRotation = Quaternion.identity;
		return effectGameObject;
	}

	public static EffectController PlayEffect(Transform target, string effectName, string handPointPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isAttach, bool isLoop, float timeScale = 1f, float normalize = 0f, float effectKeepTime = 0.5f, bool usePosition = false, Vector3 centerPos = default(Vector3), bool isLockEffectRotation = false, Action<EffectController> onStop = null, bool isCameraEffect = false, bool isMainPlayerOrBossOrElitel = false, bool isFriend = false)
	{
		GameObject gameObject = InstantiateEffect(target, effectName, handPointPath, offset, scale, rotation, forward, isAttach, usePosition, centerPos, isLockEffectRotation, isCameraEffect);
		if (gameObject == null)
		{
			return null;
		}
		EffectController effectController = U3DUtil.Get<EffectController>(gameObject);
		effectController.Initialize(isLoop, effectKeepTime, timeScale, CheckQuality(isMainPlayerOrBossOrElitel), onStop, isMainPlayerOrBossOrElitel, isFriend);
		effectController.Simulator(normalize * effectKeepTime, isMainPlayerOrBossOrElitel, isFriend);
		if ((isAttach & isLockEffectRotation) && effectController.mPositionAttachIsNotChild == null)
		{
			effectController.mPositionAttachIsNotChild = gameObject.GetComponent<PositionAttachIsNotChild>();
		}
		return effectController;
	}

	public static GameObject InstantiateEffect(Transform target, string effectName, string handPointPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isAttach, bool usePosition = false, Vector3 centerPos = default(Vector3), bool isLockEffectRotation = false, bool isCameraEffect = false)
	{
		GameObject gameObject;
		if (BattleSceneLoader.HasEnoughMemory())
		{
			gameObject = Asset.Instantiate(effectName);
		}
		else
		{
			string lowVariantEffectName = GetLowVariantEffectName(effectName);
			if (AssetManager.TryGetAssetNameAndBundleName(lowVariantEffectName, out var _, out var _))
			{
				effectName = lowVariantEffectName;
			}
			gameObject = Asset.InstantiateAutoUnloadWhileDestroy(effectName);
		}
		if (null == gameObject)
		{
			Debug.LogError("Can't Find Effect By " + effectName);
			return null;
		}
		if (isCameraEffect)
		{
			gameObject.transform.SetParent(Camera.main.transform);
			gameObject.transform.localScale = scale;
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.identity;
			return gameObject;
		}
		Transform transform = null;
		transform = ((!string.IsNullOrEmpty(handPointPath)) ? target.Find(handPointPath) : target);
		if (null == transform)
		{
			Debug.LogError(target.name + " Can't Find HandPoint By " + handPointPath + " to attach effect " + gameObject.name);
			PooledAsset.DestroyOrReturn(gameObject);
			return null;
		}
		if (usePosition)
		{
			gameObject.transform.position = (Vector3)IntMath.Transform((Int3)offset, (Int3)forward, (Int3)centerPos);
			gameObject.transform.forward = forward;
			gameObject.transform.localScale = scale;
		}
		else if (isAttach)
		{
			if (isLockEffectRotation)
			{
				gameObject.transform.position = transform.position + transform.TransformDirection(offset);
				gameObject.transform.localScale = scale;
				gameObject.transform.rotation = Quaternion.Euler(Quaternion.LookRotation(-forward).eulerAngles + rotation);
				PositionAttachIsNotChild positionAttachIsNotChild = U3DUtil.Get<PositionAttachIsNotChild>(gameObject);
				positionAttachIsNotChild.enabled = true;
				positionAttachIsNotChild.AttachTransform = transform;
				positionAttachIsNotChild.PositionOffset = transform.TransformDirection(offset);
				positionAttachIsNotChild.IsEnable = true;
			}
			else
			{
				gameObject.transform.SetParent(transform);
				gameObject.transform.localPosition = offset;
				gameObject.transform.localScale = scale;
				gameObject.transform.localRotation = Quaternion.Euler(rotation);
			}
		}
		else
		{
			gameObject.transform.position = transform.position + transform.TransformDirection(offset) + new Vector3(0f, 0.011f, 0f);
			gameObject.transform.localScale = scale;
			if (isLockEffectRotation)
			{
				gameObject.transform.rotation = Quaternion.Euler(Quaternion.LookRotation(-forward).eulerAngles + rotation);
			}
			else
			{
				gameObject.transform.rotation = Quaternion.Euler(transform.rotation.eulerAngles + rotation);
			}
		}
		return gameObject;
	}

	private static string GetLowVariantEffectName(string effectName)
	{
		return CullVfxOnlyKeepLowQuality.GetLowQualityVfxName(effectName);
	}

	public static EffectController PlayEffect(string effectName, Vector3 position, Vector3 scale, Vector3 rotation, Vector3 forward, bool isMainPlayerOrBossOrElitel = false, bool isFriend = false, bool isLoop = false, float timeScale = 1f, float normalize = 0f, float effectKeepTime = 0.5f, Action<EffectController> onStop = null)
	{
		GameObject gameObject = Asset.Instantiate(effectName);
		if (null == gameObject)
		{
			Debug.LogError("Can't Find Effect By " + effectName);
			return null;
		}
		gameObject.transform.position = position;
		gameObject.transform.localScale = scale;
		gameObject.transform.forward = ((forward == Vector3.zero) ? Vector3.forward : forward);
		gameObject.transform.Rotate(rotation);
		EffectController effectController = U3DUtil.Get<EffectController>(gameObject);
		effectController.Initialize(isLoop, effectKeepTime, timeScale, CheckQuality(isMainPlayerOrBossOrElitel), onStop, isMainPlayerOrBossOrElitel, isFriend);
		effectController.Simulator(normalize * effectKeepTime, isMainPlayerOrBossOrElitel, isFriend);
		return effectController;
	}

	private void OnEffectStop(EffectController effectController)
	{
		_effectController.Remove(effectController);
	}

	internal void Shutdown()
	{
		_effectController.Clear();
		_effect.Clear();
	}

	public void Update(NAgent agent)
	{
		if (!(agent != null) || !(agent.Blackboard as BBHumanoid != null) || (agent.Blackboard as BBHumanoid).m_NextSimFrameData == null)
		{
			return;
		}
		if ((agent.Blackboard as BBHumanoid).m_NextSimFrameData.mIsHide == E_EntityHideType.Logic)
		{
			if (!_isOut)
			{
				_outTimeScale = _timeScale;
				SetTimeScale(0f);
				_isOut = true;
			}
		}
		else if ((agent.Blackboard as BBHumanoid).m_NextSimFrameData.mIsHide == E_EntityHideType.None && _isOut)
		{
			_isOut = false;
			SetTimeScale(_outTimeScale);
		}
	}

	public void SetTimeScale(float timescale)
	{
		if (_isOut)
		{
			_outTimeScale = timescale;
			return;
		}
		for (int i = 0; i < _effectController.Count; i++)
		{
			_effectController[i].SetTimeScale(timescale);
		}
	}

	internal void DisableRenders()
	{
		if (_effectController == null || _effectController.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _effectController.Count; i++)
		{
			if (_effectController[i] != null)
			{
				_effectController[i].Hide(v: true);
			}
			else
			{
				Debug.LogError("特效中播放存在bug！");
			}
		}
	}

	internal void EnableRenders()
	{
		if (_effectController == null || _effectController.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _effectController.Count; i++)
		{
			if (_effectController[i] != null)
			{
				_effectController[i].Hide(v: false);
			}
			else
			{
				Debug.LogError("特效中播放存在bug！");
			}
		}
	}
}

using System;
using System.Collections.Generic;
using ACT.UI;
using Bamboo.AssetField;
using Cinemachine;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CameraNoiseManager : Singleton<CameraNoiseManager>
{
	private const float RealCameraNoiseForceZoomByUI = 0.1f;

	private CinemachineBrain _cineMachineBrain;

	private Dictionary<string, CinemachineImpulseSource> _Impulses;

	private Dictionary<CameraNoiseType, CinemachineImpulseSource> _activeImpulses;

	private Dictionary<string, AssetLoadHandle> _cameraNoiseHandles;

	private Dictionary<string, int> _autoUnloadVersions;

	public override void Init()
	{
		_Impulses = new Dictionary<string, CinemachineImpulseSource>();
		_activeImpulses = new Dictionary<CameraNoiseType, CinemachineImpulseSource>();
		_cameraNoiseHandles = new Dictionary<string, AssetLoadHandle>();
		_autoUnloadVersions = new Dictionary<string, int>();
	}

	public override void UnInit()
	{
		ResetData();
		base.UnInit();
	}

	private float GetCurrentCameraDistance(Vector3 pos)
	{
		if (_cineMachineBrain == null)
		{
			Camera main = Camera.main;
			if (main != null)
			{
				_cineMachineBrain = main.GetComponent<CinemachineBrain>();
			}
		}
		Vector3 position;
		if (_cineMachineBrain != null && _cineMachineBrain.ActiveVirtualCamera is CinemachineVirtualCamera cinemachineVirtualCamera)
		{
			position = cinemachineVirtualCamera.transform.position;
		}
		else
		{
			if (!(Camera.main != null))
			{
				return 10f;
			}
			position = Camera.main.transform.position;
		}
		return Mathf.Abs(position.z - pos.z);
	}

	private float GetCurrentCameraFOV()
	{
		if (_cineMachineBrain == null)
		{
			Camera main = Camera.main;
			if (main != null)
			{
				_cineMachineBrain = main.GetComponent<CinemachineBrain>();
			}
		}
		if (_cineMachineBrain != null && _cineMachineBrain.ActiveVirtualCamera is CinemachineVirtualCamera cinemachineVirtualCamera)
		{
			return cinemachineVirtualCamera.m_Lens.FieldOfView;
		}
		if (Camera.main != null)
		{
			return Camera.main.fieldOfView;
		}
		return 35f;
	}

	private float GetFOVForceMultiplier(Vector3 pos)
	{
		if (GameLoader.meta.fovControlConfig == null)
		{
			return 1f;
		}
		float currentCameraFOV = GetCurrentCameraFOV();
		float currentCameraDistance = GetCurrentCameraDistance(pos);
		return GameLoader.meta.fovControlConfig.GetForceMultiplierByFOV(currentCameraFOV, currentCameraDistance);
	}

	private void LoadCameraNoise(CameraNoiseType noiseType, Vector3 pos, YooAssetReference noise, float sustainTime, float force, bool changeVelocityXZ, bool unloadAfterPlaying)
	{
		AssetLoadHandle value = AssetStationManager.BattleStation.InstantiateAsync(noise.GUID, (AssetLoadHandle loadHandle) =>
		{
			LoadNoiseFinish(noiseType, noise.GUID, loadHandle, pos, sustainTime, force, changeVelocityXZ, unloadAfterPlaying);
		});
		_cameraNoiseHandles[noise.GUID] = value;
	}

	internal void UnloadCameraNoise(YooAssetReference noise)
	{
		UnloadCameraNoise(noise.GUID);
	}

	private void LoadNoiseFinish(CameraNoiseType noiseType, string name, AssetLoadHandle handle, Vector3 pos, float sustainTime, float force, bool changeVelocityXZ, bool unloadAfterPlaying)
	{
		if (!AssetLoadHandleExtensions.IsValid(handle))
		{
			_cameraNoiseHandles.Remove(name);
			return;
		}
		if (!_cameraNoiseHandles.ContainsKey(name))
		{
			_cameraNoiseHandles[name] = handle;
		}
		GameObject gameObject = handle.As<GameObject>();
		if (gameObject == null)
		{
			_cameraNoiseHandles.Remove(name);
			if (AssetLoadHandleExtensions.IsValid(handle))
			{
				AssetStationManager.BattleStation.ReleaseInstance(handle);
			}
		}
		else
		{
			CinemachineImpulseSource component = gameObject.GetComponent<CinemachineImpulseSource>();
			_Impulses[name] = component;
			PlayCameraNoise(noiseType, name, component, pos, sustainTime, force, changeVelocityXZ, unloadAfterPlaying);
		}
	}

	private void UnloadCameraNoise(string name)
	{
		_autoUnloadVersions.Remove(name);
		if (_Impulses.TryGetValue(name, out var value))
		{
			_Impulses.Remove(name);
			for (CameraNoiseType cameraNoiseType = CameraNoiseType.AttackBoxTrigger; cameraNoiseType <= CameraNoiseType.AttackEnvironmentTrigger; cameraNoiseType++)
			{
				if (_activeImpulses.TryGetValue(cameraNoiseType, out var value2) && value2 == value)
				{
					_activeImpulses.Remove(cameraNoiseType);
				}
			}
		}
		if (_cameraNoiseHandles.TryGetValue(name, out var value3))
		{
			_cameraNoiseHandles.Remove(name);
			if (AssetLoadHandleExtensions.IsValid(value3))
			{
				AssetStationManager.BattleStation.ReleaseInstance(value3);
			}
		}
	}

	internal void TriggerCameraNoise(CameraNoiseType noiseType, Vector3 pos, YooAssetReference noise, Vector3 velocity, float sustainTime = 0f, float force = 0f, bool changeVelocityXZ = false, bool overLay = true, bool unloadAfterPlaying = false)
	{
		force *= GameLoader.meta.MobileCameraNoiseStrength;
		CameraNoiseType cameraNoiseType = noiseType;
		if (((uint)cameraNoiseType <= 2u && LocalQualitySettings.ReadFromLocal().cameraNoise == 0) || (CinemachineImpulseManager.Instance.HasActiveEvents && !overLay && noiseType == CameraNoiseType.AttackBoxTrigger))
		{
			return;
		}
		force *= GetFOVForceMultiplier(pos);
		if (noiseType != CameraNoiseType.PlotTrigger)
		{
			force *= (float)LocalQualitySettings.ReadFromLocal().cameraNoise * 0.1f;
		}
		AssetLoadHandle value2;
		if (_Impulses.TryGetValue(noise.GUID, out var value))
		{
			PlayCameraNoise(noiseType, noise.GUID, value, pos, sustainTime, force, changeVelocityXZ, unloadAfterPlaying);
		}
		else if (_cameraNoiseHandles.TryGetValue(noise.GUID, out value2))
		{
			value2.Completed += (AssetLoadHandle _) =>
			{
				if (_Impulses.TryGetValue(noise.GUID, out var value3))
				{
					PlayCameraNoise(noiseType, noise.GUID, value3, pos, sustainTime, force, changeVelocityXZ, unloadAfterPlaying);
				}
			};
		}
		else
		{
			LoadCameraNoise(noiseType, pos, noise, sustainTime, force, changeVelocityXZ, unloadAfterPlaying);
		}
	}

	private void PlayCameraNoise(CameraNoiseType noiseType, string name, CinemachineImpulseSource impulse, Vector3 pos, float sustainTime, float force, bool changeVelocityXZ, bool unloadAfterPlaying)
	{
		if (noiseType != CameraNoiseType.AnimTrigger && noiseType != CameraNoiseType.LevelTrigger && _activeImpulses.TryGetValue(noiseType, out var _))
		{
			CinemachineImpulseManager.Instance.Clear();
			_activeImpulses.Remove(noiseType);
		}
		if (sustainTime > 0f)
		{
			impulse.m_ImpulseDefinition.m_TimeEnvelope.m_SustainTime = sustainTime;
		}
		impulse.GenerateImpulseWithPositionAndForce(pos, force, changeVelocityXZ);
		_activeImpulses[noiseType] = impulse;
		_autoUnloadVersions.TryGetValue(name, out var value2);
		value2++;
		_autoUnloadVersions[name] = value2;
		if (unloadAfterPlaying)
		{
			float duration = impulse.m_ImpulseDefinition.m_TimeEnvelope.m_AttackTime + impulse.m_ImpulseDefinition.m_TimeEnvelope.m_SustainTime + impulse.m_ImpulseDefinition.m_TimeEnvelope.m_DecayTime;
			UnloadCameraNoiseAfterPlaying(name, value2, duration).Forget();
		}
	}

	private async UniTaskVoid UnloadCameraNoiseAfterPlaying(string name, int autoUnloadVersion, float duration)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(duration));
		if (_autoUnloadVersions.TryGetValue(name, out var value) && value == autoUnloadVersion)
		{
			UnloadCameraNoise(name);
		}
	}

	public void ResetData()
	{
		foreach (AssetLoadHandle value in _cameraNoiseHandles.Values)
		{
			if (AssetLoadHandleExtensions.IsValid(value))
			{
				AssetStationManager.BattleStation.ReleaseInstance(value);
			}
		}
		_activeImpulses.Clear();
		_Impulses.Clear();
		_cameraNoiseHandles.Clear();
		_autoUnloadVersions.Clear();
	}
}

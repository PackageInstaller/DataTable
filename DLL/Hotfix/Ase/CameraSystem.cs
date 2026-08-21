using Ase.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class CameraSystem : BaseSystem
{
	private VirtualCameraSystem _virtualCameraSystem;

	private Camera _battleCamera;

	private Camera _effectCamera;

	protected override bool IsLogicSystem => false;

	public override bool NeedPauseSystem => false;

	public Camera BattleCamera => _battleCamera;

	public Camera EffectCamera => _effectCamera;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		_battleCamera = GameEntry.Camera.MainCamera;
		_effectCamera = GameEntry.Camera.EffectCamera;
		return true;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_virtualCameraSystem = GetSystem<VirtualCameraSystem>();
		_ = _virtualCameraSystem;
	}

	public void BindTargetEntity(BaseEntity baseEntity)
	{
		GetSystem<VirtualCameraSystem>().BindTargetEntity(baseEntity as HeroEntity);
	}

	public void ResetBattleCamera(BaseEntity baseEntity)
	{
		if (baseEntity != null && _virtualCameraSystem != null)
		{
			_virtualCameraSystem.AdjustVirtualCameraPriority(CameraKey.BattleCamera, world.CameraConfig.battleCameraBaseData.battleCameraProperty);
			_virtualCameraSystem.AdjustBattleCameraOffset(CameraKey.BattleCamera, Vector3.zero);
			_virtualCameraSystem.AdjustVirtualCameraFieldOfView(CameraKey.BattleCamera, world.CameraConfig.battleCameraBaseData.cameraFov);
			BindTargetEntity(baseEntity);
		}
	}

	public override void OnPause()
	{
		_virtualCameraSystem?.OnPauseShakeCamera();
	}

	public override void OnResume()
	{
		_virtualCameraSystem?.OnResumeShakeCamera();
	}

	public override void OnDispose()
	{
		_virtualCameraSystem = null;
		base.OnDispose();
	}

	public Vector3 GetCameraDirect()
	{
		if ((bool)_battleCamera)
		{
			return _battleCamera.transform.eulerAngles;
		}
		return Vector3.zero;
	}
}

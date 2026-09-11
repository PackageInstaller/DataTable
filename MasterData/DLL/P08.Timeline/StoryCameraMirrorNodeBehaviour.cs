using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class StoryCameraMirrorNodeBehaviour : PlayableBehaviour
{
	public bool IsMotion;

	public Vector2 MotionCenter = Vector2.one * 0.5f;

	public float MotionRotation;

	private bool orgIsMotion;

	private Vector2 orgMotionCenter = Vector2.one * 0.5f;

	private float orgMotionRotation;

	private CameraExtension _cameraExtension;

	private bool _running;

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		if (_cameraExtension == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				_cameraExtension = battleScene.CameraExtension;
			}
		}
		if (!(_cameraExtension == null) && !_running)
		{
			_running = true;
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (_cameraExtension == null)
		{
			_cameraExtension = Camera.main.GetComponent<CameraExtension>();
		}
		if (!_running && _cameraExtension != null)
		{
			_running = true;
			orgIsMotion = _cameraExtension.isMotion;
			orgMotionCenter = _cameraExtension.motionCentre;
			orgMotionRotation = _cameraExtension.motionRotation;
		}
		if (_running && _cameraExtension != null)
		{
			_cameraExtension.isMotion = IsMotion;
			_cameraExtension.motionCentre = MotionCenter;
			_cameraExtension.motionRotation = MotionRotation;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (_cameraExtension == null)
		{
			_cameraExtension = Camera.main.GetComponent<CameraExtension>();
		}
		if (!_running && _cameraExtension != null)
		{
			_running = true;
			orgIsMotion = _cameraExtension.isMotion;
			orgMotionCenter = _cameraExtension.motionCentre;
			orgMotionRotation = _cameraExtension.motionRotation;
		}
		if (_running && _cameraExtension != null)
		{
			_cameraExtension.isMotion = IsMotion;
			_cameraExtension.motionCentre = MotionCenter;
			_cameraExtension.motionRotation = MotionRotation;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (_cameraExtension == null && Application.isPlaying)
		{
			_cameraExtension = Camera.main.GetComponent<CameraExtension>();
		}
		if (_running && _cameraExtension != null)
		{
			_cameraExtension.isMotion = orgIsMotion;
			_cameraExtension.motionCentre = orgMotionCenter;
			_cameraExtension.motionRotation = orgMotionRotation;
		}
		_running = false;
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		IsMotion = false;
		MotionCenter = Vector2.zero;
		MotionRotation = 0f;
		_cameraExtension = null;
		_running = false;
	}
}

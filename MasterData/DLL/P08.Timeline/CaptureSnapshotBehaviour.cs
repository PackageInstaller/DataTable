using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class CaptureSnapshotBehaviour : PlayableBehaviour
{
	private CameraExtension _cameraEx;

	private bool _isSnapshot;

	public override void OnGraphStart(Playable playable)
	{
		_isSnapshot = false;
	}

	public override void OnGraphStop(Playable playable)
	{
		_isSnapshot = false;
		_cameraEx = null;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (Application.isPlaying)
		{
			if (_cameraEx == null && _cameraEx == null)
			{
				_cameraEx = Camera.main.GetComponent<CameraExtension>();
			}
			if (!(_cameraEx == null) && !_isSnapshot)
			{
				_isSnapshot = true;
				_cameraEx.CaptureSnapshot();
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (_isSnapshot && _cameraEx != null)
		{
			_cameraEx.FreeSnapshot();
			_isSnapshot = false;
		}
	}
}

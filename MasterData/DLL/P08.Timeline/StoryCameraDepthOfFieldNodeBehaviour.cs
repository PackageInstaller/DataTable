using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

public class StoryCameraDepthOfFieldNodeBehaviour : PlayableBehaviour
{
	public DepthOfFieldType mDepthOfFieldType;

	public float mDepthOfFieldNear = 5f;

	public float mDepthOfFieldFar = 10f;

	public AnimationCurve mDepthOfFieldScale = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	private DepthOfFieldType orgDepthOfFieldType;

	private float orgDepthOfFieldNear = 5f;

	private float orgDepthOfFieldFar = 10f;

	private bool running;

	private CameraExtension cameraExtension;

	private void SetRun()
	{
		if (!running && cameraExtension != null)
		{
			running = true;
			orgDepthOfFieldType = cameraExtension.dofType;
			orgDepthOfFieldNear = cameraExtension.dofNear;
			orgDepthOfFieldFar = cameraExtension.dofFar;
		}
	}

	private void SetValue(float timeRate)
	{
		if (running && cameraExtension != null)
		{
			cameraExtension.dofType = mDepthOfFieldType;
			cameraExtension.dofNear = mDepthOfFieldNear;
			cameraExtension.dofFar = mDepthOfFieldFar;
			cameraExtension.dofScale = mDepthOfFieldScale.Evaluate(timeRate);
		}
	}

	private void SetStop()
	{
		if (running && cameraExtension != null)
		{
			running = false;
			cameraExtension.dofType = orgDepthOfFieldType;
			cameraExtension.dofNear = orgDepthOfFieldNear;
			cameraExtension.dofFar = orgDepthOfFieldFar;
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (cameraExtension == null)
		{
			cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		}
		SetRun();
		SetValue(0f);
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (cameraExtension == null)
		{
			cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		}
		double time = playable.GetTime();
		double duration = playable.GetDuration();
		float value = (float)(time / duration);
		SetRun();
		SetValue(value);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (cameraExtension == null && Application.isPlaying)
		{
			cameraExtension = Camera.main.gameObject.GetComponent<CameraExtension>();
		}
		SetStop();
	}
}

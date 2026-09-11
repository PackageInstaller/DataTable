using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineActiveControlNodeBehaviour : PlayableBehaviour
{
	public string path;

	public bool active;

	public bool inverseWhenFinished = true;

	public StoryTimelineActiveControlType ctrlType = StoryTimelineActiveControlType.UI;

	public string sceneName;

	public string uiRootName;

	public string childGoPath;

	public bool moveto;

	public bool startFromTargetPosition;

	public Vector3 startLocalPosition;

	public AnimationCurve moveCurve;

	public Vector3 endLocalPosition;

	public bool rotate;

	public float rotateDegree;

	public AnimationCurve rotateCurve = new AnimationCurve();

	private GameObject targetGameObject;

	private bool finished;

	private bool startMove;

	private Vector3 startPos;

	private bool startRotate;

	private Vector3 startRot;

	private bool isRunning;

	public override void OnGraphStop(Playable playable)
	{
		finished = false;
		startMove = false;
		startRotate = false;
		isRunning = false;
	}

	public void SetWeight(float weight)
	{
		if (isRunning && weight == 0f)
		{
			isRunning = false;
			Exit();
		}
		if (!isRunning && weight == 1f)
		{
			isRunning = true;
			Enter();
		}
	}

	public void Enter()
	{
	}

	public void Exit()
	{
		if (finished && inverseWhenFinished && targetGameObject != null)
		{
			finished = false;
			targetGameObject.SetActive(!active);
		}
		if (moveto && targetGameObject != null)
		{
			targetGameObject.transform.localPosition = endLocalPosition;
			startMove = false;
		}
		if (rotate && targetGameObject != null)
		{
			if (startRotate)
			{
				targetGameObject.transform.localEulerAngles = startRot.AddY(rotateDegree);
			}
			else
			{
				targetGameObject.transform.localEulerAngles.AddY(rotateDegree);
			}
			startRotate = false;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
	}

	public void ProcessMove(Playable playable)
	{
		if (moveto)
		{
			if (!startMove)
			{
				startMove = true;
				startPos = (startFromTargetPosition ? startLocalPosition : targetGameObject.transform.localPosition);
			}
			float num = (float)playable.GetTime();
			float num2 = (float)playable.GetDuration();
			float time = Mathf.Clamp(num / num2, 0f, 1f);
			Vector3 localPosition = Vector3.Lerp(startPos, endLocalPosition, moveCurve.Evaluate(time));
			targetGameObject.transform.localPosition = localPosition;
		}
	}

	public void ProcessActive()
	{
		if (!finished || targetGameObject.activeSelf != active)
		{
			targetGameObject.SetActive(active);
			finished = true;
		}
	}

	public void ProcessRotate(Playable playable)
	{
		if (rotate)
		{
			if (!startRotate)
			{
				startRotate = true;
				startRot = targetGameObject.transform.localEulerAngles;
			}
			float num = (float)playable.GetTime();
			float num2 = (float)playable.GetDuration();
			float time = Mathf.Clamp(num / num2, 0f, 1f);
			float deltaY = Mathf.Lerp(0f, rotateDegree, rotateCurve.Evaluate(time));
			Vector3 vector = startRot;
			targetGameObject.transform.localEulerAngles = vector.AddY(deltaY);
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (targetGameObject == null)
		{
			if (ctrlType == StoryTimelineActiveControlType.UI || ctrlType == StoryTimelineActiveControlType.scene)
			{
				GameObject gameObject = GameObject.Find((ctrlType == StoryTimelineActiveControlType.UI) ? uiRootName : sceneName);
				if (gameObject != null)
				{
					Transform transform = gameObject.transform.Find(path);
					if (transform != null)
					{
						targetGameObject = transform.gameObject;
					}
				}
			}
			else
			{
				if (ctrlType != StoryTimelineActiveControlType.child)
				{
					return;
				}
				PlayableDirector playableDirector = playable.GetGraph().GetResolver() as PlayableDirector;
				if (playableDirector != null)
				{
					Transform transform2 = playableDirector.transform.Find(childGoPath);
					if (transform2 != null)
					{
						targetGameObject = transform2.gameObject;
					}
					else
					{
						targetGameObject = playableDirector.gameObject;
					}
				}
			}
		}
		else
		{
			ProcessActive();
			ProcessMove(playable);
			ProcessRotate(playable);
		}
	}
}

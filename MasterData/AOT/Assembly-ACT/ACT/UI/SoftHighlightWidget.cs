using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SoftHighlightWidget : GuideWidget
{
	[SerializeReference]
	private Image bg;

	[SerializeReference]
	private RectTransform frame;

	[SerializeReference]
	private RectTransform clickArea;

	[SerializeReference]
	private BetterAnimation betterAnimation;

	private float _arrowDistance = 30f;

	private string _actionPath;

	private Transform _target;

	private int DeleteTime;

	private Delayer _DeleteDelayer;

	private Vector3[] frameWorldCorner = new Vector3[4];

	private Vector2 center;

	private float width;

	private float height;

	public override void Init(GuideStepData stepData)
	{
		if (stepData is SoftHighlightStepData softHighlightStepData)
		{
			_stepId = stepData.Id;
			_actionPath = stepData._actionPath;
			DeleteTime = softHighlightStepData.DeleteTime;
			AddListener();
			InitFrame(softHighlightStepData.FindAction);
			InitClickArea();
			betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				betterAnimation.GetSequence("Loop").Play().SetLoops(-1);
			}).Play();
			if (DeleteTime > 0)
			{
				AddDeleteTime();
			}
		}
	}

	public void Init(int Id, int deleteTime, FindHighlightObjAction findAction)
	{
		_stepId = Id;
		DeleteTime = deleteTime;
		AddListener();
		InitFrame(findAction);
		InitClickArea();
		betterAnimation?.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			betterAnimation.GetSequence("Loop").Play().SetLoops(-1);
		}).Play();
		if (DeleteTime > 0)
		{
			AddDeleteTime();
		}
	}

	protected override void OnDisable()
	{
	}

	public override void UnInit()
	{
		RemoveListener();
		if (_DeleteDelayer.IsValid())
		{
			_DeleteDelayer.Cancel();
		}
		base.UnInit();
	}

	private void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Input_FinshCurrentGuideStep, OnStepFinsh);
	}

	private void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Input_FinshCurrentGuideStep, OnStepFinsh);
	}

	private void OnStepFinsh(BaseEventContent obj)
	{
		if (obj is GuideInputFinshStepEvt guideInputFinshStepEvt && guideInputFinshStepEvt.InputActionPath.Equals(_actionPath))
		{
			StepFinish();
		}
	}

	private void AddDeleteTime()
	{
		_DeleteDelayer = UpdateTimer.Default.DelayMs(DeleteTime * 1000, () =>
		{
			SendDeleteTimeFinshGuide();
		});
	}

	private void SendDeleteTimeFinshGuide()
	{
		GuideDeleteTimeFinshEvt evt = Singleton<EventManager>.instance.GetEvt<GuideDeleteTimeFinshEvt>();
		evt.stepId = _stepId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Guide_DeleteTimeFinsh, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void OnClick()
	{
	}

	private void InitFrame(FindHighlightObjAction findAction)
	{
		if (findAction == null)
		{
			_ = LuminApplication.LogEnabled;
			StepFinish();
			return;
		}
		Transform transform = findAction.Find();
		if (transform == null)
		{
			StepFinish();
			_ = LuminApplication.LogEnabled;
			return;
		}
		_target = transform;
		RectTransform rectTransform = transform as RectTransform;
		Vector3 vector = GameUtility.uiCamera.WorldToScreenPoint(UIUtility.GetWorldPosIgnorePivot(rectTransform));
		if (!(vector.x >= 0f) || !(vector.x <= (float)Screen.width) || !(vector.y >= 0f) || !(vector.y <= (float)Screen.height))
		{
			StepFinish();
			_ = LuminApplication.LogEnabled;
			_ = LuminApplication.LogEnabled;
			_ = LuminApplication.LogEnabled;
			return;
		}
		frame.position = UIUtility.GetWorldPosIgnorePivot(rectTransform);
		frame.sizeDelta = new Vector2(rectTransform.rect.width, rectTransform.rect.height);
		Vector3[] worldCorners = UIUtility.GetWorldCorners(rectTransform);
		Vector3[] worldCorners2 = UIUtility.GetWorldCorners(frame);
		float num = worldCorners[2].x - worldCorners[0].x;
		float num2 = worldCorners2[2].x - worldCorners2[0].x;
		frame.sizeDelta *= num / num2;
		InitBgMaterialParam();
	}

	private void InitBgMaterialParam()
	{
		frame.GetWorldCorners(frameWorldCorner);
		for (int i = 0; i < frameWorldCorner.Length; i++)
		{
			frameWorldCorner[i] = WorldToScreenPoint(GameUtility.uiCanvas, frameWorldCorner[i]);
		}
		center.x = frameWorldCorner[0].x + (frameWorldCorner[3].x - frameWorldCorner[0].x) / 2f;
		center.y = frameWorldCorner[0].y + (frameWorldCorner[1].y - frameWorldCorner[0].y) / 2f;
		width = (frameWorldCorner[3].x - frameWorldCorner[0].x) / 2f;
		height = (frameWorldCorner[1].y - frameWorldCorner[0].y) / 2f;
		bg.material.SetVector("_Center", center);
		bg.material.SetFloat("_SliderX", width);
		bg.material.SetFloat("_SliderY", height);
	}

	private void InitClickArea()
	{
		clickArea.pivot = frame.pivot;
		clickArea.position = frame.position;
		clickArea.sizeDelta = frame.sizeDelta;
	}

	private Vector2 WorldToScreenPoint(Canvas canvas, Vector3 world)
	{
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(canvas.worldCamera, world);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(canvas.GetComponent<RectTransform>(), screenPoint, canvas.worldCamera, out var localPoint);
		return localPoint;
	}
}

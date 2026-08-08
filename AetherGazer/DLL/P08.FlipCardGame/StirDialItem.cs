using System;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class StirDialItem : MonoBehaviour
{
	[NonSerialized]
	public StirGameManager gameManager;

	[NonSerialized]
	public StirStep config;

	public RectTransform pivotTransOfDial;

	public RectTransform startPointTransOfDial;

	public RectTransform endPointTransOfDial;

	public RectTransform pointerTrans;

	public ControllerExCollection controllerEx;

	private ControllerEx statusController;

	public RectTransform transOfQteCircle;

	public Image imgOfQteCircle;

	public Animator qteZoneValidAnimator;

	private CookingGameConst.StirDialStatus _status;

	private bool statusDirty;

	private double radiusOfDial;

	private double perimeterOfDial;

	private Vector3 pivotToStartVector;

	private Vector3 pivotToEndVector;

	private float angleOfStartToEndPoint;

	private double arcLengthOfDial;

	private double rad2DegOfDial;

	private float curAccelerate;

	private int lastQteZoneIndex;

	private float lastQteStartVelocity;

	private float lastQteEndVelocity;

	private float lastQteProgressPercent;

	private int nextQteZoneIndex;

	private float nextQteStartVelocity;

	private float nextQteEndVelocity;

	private float nextQteProgressPercent;

	private float diffVelocityOfNext2Cur;

	private double arcLengthOfQte;

	private bool isPlayingQteZoneAnim;

	public CookingGameConst.StirDialStatus status
	{
		get
		{
			return _status;
		}
		private set
		{
			if (_status != value)
			{
				statusDirty = true;
				_status = value;
			}
		}
	}

	public float curVelocity { get; private set; }

	public float curQteStartVelocity { get; private set; }

	public float curQteEndVelocity { get; private set; }

	public void Init(StirGameManager manager, StirStep config)
	{
		gameManager = manager;
		this.config = config;
		Vector3 localPosition = pivotTransOfDial.localPosition;
		pivotToStartVector = startPointTransOfDial.localPosition - localPosition;
		pivotToEndVector = endPointTransOfDial.localPosition - localPosition;
		radiusOfDial = Vector2.Distance(pivotToStartVector, pivotToEndVector);
		perimeterOfDial = 6.2831854820251465 * radiusOfDial;
		angleOfStartToEndPoint = Vector3.Angle(pivotToStartVector, pivotToEndVector);
		arcLengthOfDial = (double)((360f - angleOfStartToEndPoint) * (MathF.PI / 180f)) * radiusOfDial;
		rad2DegOfDial = 57.295780181884766 / radiusOfDial;
		statusController = controllerEx.GetController("status");
	}

	public void InitGame()
	{
		curVelocity = 0f;
		lastQteZoneIndex = 0;
		lastQteStartVelocity = config.normalizeVelocityList[lastQteZoneIndex].startValueOfDial;
		lastQteEndVelocity = lastQteStartVelocity + config.normalizeVelocityDelta;
		lastQteProgressPercent = config.normalizeVelocityList[lastQteZoneIndex].progressPerCent;
		curQteStartVelocity = lastQteStartVelocity;
		curQteEndVelocity = lastQteEndVelocity;
		if (lastQteZoneIndex < config.normalizeVelocityList.Count - 1)
		{
			nextQteZoneIndex = lastQteZoneIndex + 1;
			nextQteStartVelocity = config.normalizeVelocityList[nextQteZoneIndex].startValueOfDial;
			nextQteEndVelocity = nextQteStartVelocity + config.normalizeVelocityDelta;
			nextQteProgressPercent = config.normalizeVelocityList[nextQteZoneIndex].progressPerCent;
		}
		float num = (curQteEndVelocity - curQteStartVelocity) / config.maxVelocityOfDial;
		arcLengthOfQte = (double)num * arcLengthOfDial;
		double num2 = arcLengthOfQte / perimeterOfDial;
		imgOfQteCircle.fillAmount = (float)num2;
		pointerTrans.localRotation = Quaternion.Euler(0f, 0f, 0f);
		qteZoneValidAnimator.enabled = false;
		isPlayingQteZoneAnim = false;
	}

	public void SwitchToSuccessStatus()
	{
		qteZoneValidAnimator.enabled = false;
		isPlayingQteZoneAnim = false;
	}

	public void UpdateLogic()
	{
		UpdateAccelerate();
		UpateVelocity();
		UpdateQteRang();
		UpdateStatus();
	}

	public void UpdateAccelerate()
	{
		if (gameManager.GetCurPotVelocity() >= config.stirVelocityThreshold)
		{
			curAccelerate = config.upAccelerateSpeed;
		}
		else
		{
			curAccelerate = config.downAccelerateSpeed;
		}
	}

	public void UpateVelocity()
	{
		curVelocity += curAccelerate * Time.deltaTime;
		if (curVelocity < 0f)
		{
			curVelocity = 0f;
		}
		else if (curVelocity > config.maxVelocityOfDial)
		{
			curVelocity = config.maxVelocityOfDial;
		}
	}

	public void UpdateQteRang()
	{
		if (lastQteZoneIndex + 1 < config.normalizeVelocityList.Count)
		{
			float curProgress = gameManager.GetCurProgress();
			if (curProgress >= nextQteProgressPercent)
			{
				lastQteZoneIndex = nextQteZoneIndex;
				lastQteStartVelocity = nextQteStartVelocity;
				lastQteEndVelocity = nextQteEndVelocity;
				lastQteProgressPercent = nextQteProgressPercent;
				nextQteZoneIndex = lastQteZoneIndex + 1;
				nextQteStartVelocity = config.normalizeVelocityList[nextQteZoneIndex].startValueOfDial;
				nextQteEndVelocity = nextQteStartVelocity + config.normalizeVelocityDelta;
				nextQteProgressPercent = config.normalizeVelocityList[nextQteZoneIndex].progressPerCent;
			}
			else
			{
				float num = (curProgress - lastQteProgressPercent) / (nextQteProgressPercent - lastQteProgressPercent);
				float num2 = (nextQteStartVelocity - lastQteStartVelocity) * num;
				curQteStartVelocity = lastQteStartVelocity + num2;
				curQteEndVelocity = lastQteEndVelocity + num2;
			}
		}
	}

	public void UpdateStatus()
	{
		if (curVelocity <= 0f)
		{
			status = CookingGameConst.StirDialStatus.ZERO;
		}
		else if (curVelocity > curQteEndVelocity)
		{
			status = CookingGameConst.StirDialStatus.MORE;
		}
		else if (curVelocity >= curQteStartVelocity)
		{
			status = CookingGameConst.StirDialStatus.PERFECT;
		}
		else
		{
			status = CookingGameConst.StirDialStatus.LESS;
		}
	}

	public bool IsPointerInQteZone()
	{
		if (curVelocity >= curQteStartVelocity)
		{
			return curVelocity <= curQteEndVelocity;
		}
		return false;
	}

	public void UpdateRender()
	{
		RenderQteZonePos();
		RenderQteZoneAnim();
		RenderPointer();
		RendererStatus();
		statusDirty = false;
	}

	public void RenderQteZonePos()
	{
		double num = (double)(curQteStartVelocity / config.maxVelocityOfDial) * arcLengthOfDial;
		double num2 = (arcLengthOfDial / 2.0 - num) * rad2DegOfDial;
		transOfQteCircle.localRotation = Quaternion.Euler(0f, 0f, (float)num2);
	}

	public void RenderQteZoneAnim()
	{
		if (curVelocity >= curQteStartVelocity && curVelocity <= curQteEndVelocity)
		{
			PlayQteZoneAnim();
		}
		else
		{
			ResetQteZoneAnim();
		}
	}

	public void PlayQteZoneAnim()
	{
		if (!isPlayingQteZoneAnim)
		{
			isPlayingQteZoneAnim = true;
			qteZoneValidAnimator.enabled = true;
			qteZoneValidAnimator.Play("progressSelect", 0, 0f);
			qteZoneValidAnimator.Update(0f);
		}
	}

	public void ResetQteZoneAnim()
	{
		isPlayingQteZoneAnim = false;
		qteZoneValidAnimator.enabled = false;
		qteZoneValidAnimator.Play("progressSelect", 0, 0f);
		qteZoneValidAnimator.Update(0f);
	}

	public void RenderPointer()
	{
		double num = (double)(curVelocity / config.maxVelocityOfDial) * arcLengthOfDial * rad2DegOfDial;
		pointerTrans.localRotation = Quaternion.Euler(0f, 0f, 0f - (float)num);
	}

	public void RendererStatus()
	{
		if (statusDirty)
		{
			statusController.SetSelectedState((status == CookingGameConst.StirDialStatus.PERFECT) ? "perfect" : "normal");
		}
	}
}

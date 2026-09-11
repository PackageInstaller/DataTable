using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class StirPotItem : MonoBehaviour
{
	[NonSerialized]
	public StirGameManager gameManager;

	[NonSerialized]
	public StirStep config;

	public EventTriggerListener eventTriggerListener;

	public RectTransform spoonTrans;

	public RectTransform stirRangTrans;

	public RectTransform spoonRangeTrans;

	private Camera uiCamera;

	private float pot_oval_full_a;

	private float pot_oval_full_b;

	private float spoon_oval_full_a;

	private float spoon_oval_full_b;

	public Animator potStirAnimator;

	public Animator foodAnimator;

	public GameObject successAnimGo;

	private Vector2 potPivotPos;

	private Vector2 lastMousePos;

	private float pot_oval_a_square_inverse;

	private float pot_oval_b_square_inverse;

	private float spoon_oval_a_square_inverse;

	private float spoon_oval_b_square_inverse;

	private bool startPlayedStirAudio;

	private bool playingStirAudio;

	public float curVelocity { get; private set; }

	private void Start()
	{
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		lastMousePos = Vector2.zero;
		potPivotPos = RectTransformUtility.WorldToScreenPoint(uiCamera, stirRangTrans.position);
	}

	private void OnEnable()
	{
		pot_oval_full_a = stirRangTrans.sizeDelta.x;
		pot_oval_full_b = stirRangTrans.sizeDelta.y;
		float num = pot_oval_full_a / 2f;
		float num2 = pot_oval_full_b / 2f;
		pot_oval_a_square_inverse = 1f / (num * num);
		pot_oval_b_square_inverse = 1f / (num2 * num2);
		spoon_oval_full_a = spoonRangeTrans.sizeDelta.x;
		spoon_oval_full_b = spoonRangeTrans.sizeDelta.y;
		float num3 = spoon_oval_full_a / 2f;
		float num4 = spoon_oval_full_b / 2f;
		spoon_oval_a_square_inverse = 1f / (num3 * num3);
		spoon_oval_b_square_inverse = 1f / (num4 * num4);
	}

	public void Init(StirGameManager manager, StirStep config)
	{
		gameManager = manager;
		this.config = config;
		eventTriggerListener.AddListenerType1(EventTriggerType.BeginDrag, OnBeginDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.Drag, OnDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.EndDrag, OnEndDrag);
	}

	public void InitGame()
	{
		curVelocity = 0f;
		lastMousePos = Vector2.zero;
		successAnimGo.SetActive(value: false);
		potStirAnimator.enabled = true;
		potStirAnimator.speed = 0f;
		foodAnimator.enabled = true;
		foodAnimator.speed = 0f;
	}

	public void SwitchToSuccessStatus()
	{
		potStirAnimator.enabled = false;
		foodAnimator.enabled = false;
	}

	public void UpdateLogic()
	{
	}

	public bool IsOnPotRang(Vector2 screenPos)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(stirRangTrans, screenPos, uiCamera, out var localPoint);
		return isInOval(pot_oval_a_square_inverse, pot_oval_b_square_inverse, localPoint);
	}

	public bool IsStirClockWise(Vector2 curMousePos)
	{
		Vector2 vector = lastMousePos - potPivotPos;
		Vector2 to = curMousePos - potPivotPos;
		return Vector2.SignedAngle(vector, to) < 0f;
	}

	public void UpdateRender()
	{
		RenderPotStirAnim();
		RenderSpoonPos();
	}

	public void RenderSpoonPos()
	{
		if (!lastMousePos.Equals(Vector2.zero))
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(spoonRangeTrans, lastMousePos, uiCamera, out var localPoint);
			if (CalculateIntersectionOfOval(spoon_oval_a_square_inverse, spoon_oval_b_square_inverse, localPoint, out var result))
			{
				spoonTrans.localPosition = result;
			}
		}
	}

	public void RenderPotStirAnim()
	{
		if (gameManager.GetDialStatus() == CookingGameConst.StirDialStatus.ZERO)
		{
			potStirAnimator.speed = 0f;
			foodAnimator.speed = 0f;
		}
		else if (gameManager.GetDialStatus() == CookingGameConst.StirDialStatus.MORE)
		{
			potStirAnimator.speed = config.moreStirAnimSpeedPercent / 100f;
			foodAnimator.speed = 1f;
		}
		else if (gameManager.GetDialStatus() == CookingGameConst.StirDialStatus.PERFECT)
		{
			potStirAnimator.speed = config.perfectStirAnimSpeedPercent / 100f;
			foodAnimator.speed = 1f;
		}
		else
		{
			potStirAnimator.speed = config.lessStirAnimSpeedPercent / 100f;
			foodAnimator.speed = 1f;
		}
		if (curVelocity > 0f && !startPlayedStirAudio)
		{
			startPlayedStirAudio = true;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_mix_loop", useStream: false);
		}
		if (!startPlayedStirAudio)
		{
			return;
		}
		if (curVelocity > 0f)
		{
			if (!playingStirAudio)
			{
				playingStirAudio = true;
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_mix_loop_action_resume", useStream: false);
			}
		}
		else if (playingStirAudio)
		{
			playingStirAudio = false;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_mix_loop_action_pause", useStream: false);
		}
	}

	public void PlaySuccessAnim()
	{
		successAnimGo.SetActive(value: true);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold03", useStream: false);
	}

	public bool isInOval(float oval_a_square_inverse, float oval_b_square_inverse, Vector2 point)
	{
		return point.x * point.x * oval_a_square_inverse + point.y * point.y * oval_b_square_inverse <= 1f;
	}

	public bool CalculateIntersectionOfOval(float oval_a_square_inverse, float oval_b_square_inverse, Vector2 direction, out Vector2 result)
	{
		result = Vector2.zero;
		if (direction == Vector2.zero)
		{
			return false;
		}
		float x = direction.x;
		float y = direction.y;
		float num = x * x * oval_a_square_inverse + y * y * oval_b_square_inverse;
		if (num <= Mathf.Epsilon)
		{
			return false;
		}
		float num2 = 1f / Mathf.Sqrt(num);
		result = new Vector2(x * num2, y * num2);
		return true;
	}

	private void OnBeginDrag(GameObject go, PointerEventData e)
	{
		if (gameManager.gameStatus == CookingGameConst.StirGameStatus.PLAYING)
		{
			lastMousePos = e.position;
		}
	}

	private void OnDrag(GameObject go, PointerEventData e)
	{
		if (gameManager.gameStatus != CookingGameConst.StirGameStatus.PLAYING)
		{
			return;
		}
		if (IsOnPotRang(e.position))
		{
			float num = Vector2.Distance(lastMousePos, e.position);
			if (num < config.stirMoveDistanceThreshold)
			{
				curVelocity = 0f;
			}
			else if (IsStirClockWise(e.position))
			{
				curVelocity = num / Time.deltaTime;
			}
			else
			{
				curVelocity = 0f;
			}
		}
		lastMousePos = e.position;
	}

	private void OnEndDrag(GameObject go, PointerEventData e)
	{
		if (gameManager.gameStatus == CookingGameConst.StirGameStatus.PLAYING)
		{
			lastMousePos = Vector2.zero;
			curVelocity = 0f;
		}
	}

	public void StopLoopAudio()
	{
		if (playingStirAudio)
		{
			playingStirAudio = false;
			startPlayedStirAudio = false;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_mix_loop_action_stop", useStream: false);
		}
	}
}

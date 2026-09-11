using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class AssemblyStep : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IDragHandler, IPointerUpHandler
{
	private int progress = 1;

	private float threshold = 0.9f;

	public RectTransform rectTranform1;

	public RectTransform rectTranform2;

	public RectTransform rectTranform3;

	public RectTransform rectTranform4;

	public GameObject image1;

	public GameObject image2;

	public GameObject image3;

	public GameObject image4;

	public GameObject image5;

	public GameObject image6;

	private CanvasScaler canvasScaler;

	private Camera uiCamera;

	private Vector2 initrect;

	private Vector2 initrect2;

	private Vector2 initrect3;

	private float operateTimer;

	private bool isGuide;

	private bool isover;

	private bool isfinish;

	private bool isdrep = true;

	private bool next;

	public string guideKey = "";

	private string guideString;

	public int guideTime;

	[SerializeField]
	public Animator animator;

	[SerializeField]
	public int maxProgress;

	private void Start()
	{
		rectTranform1 = GetComponent<RectTransform>();
		initrect = rectTranform1.anchoredPosition;
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		canvasScaler = gameObject.GetComponentInParent<CanvasScaler>();
		GameGuide(flag: true);
	}

	private void Update()
	{
		if (!isfinish)
		{
			operateTimer += Time.deltaTime;
			if (operateTimer >= (float)guideTime)
			{
				GameGuide(flag: true);
				operateTimer = 0f;
			}
		}
	}

	public void init()
	{
		isdrep = true;
		image1.SetActive(value: false);
		isover = false;
		image3.SetActive(value: true);
		next = true;
	}

	public void finish()
	{
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (isdrep && eventData.pointerCurrentRaycast.gameObject == image5.gameObject)
		{
			operateTimer = 0f;
			AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_pick", useStream: false);
			GameGuide(flag: false);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTranform4, eventData.position, eventData.pressEventCamera, out var localPoint))
			{
				rectTranform3.anchoredPosition = localPoint;
			}
			image2.SetActive(value: true);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (isdrep)
		{
			operateTimer = 0f;
			image2.SetActive(value: true);
			Vector2 referenceResolution = canvasScaler.referenceResolution;
			Vector2 vector = new Vector2(Screen.width, Screen.height);
			float a = vector.x / referenceResolution.x;
			float b = vector.y / referenceResolution.y;
			float num = Mathf.Min(a, b);
			Vector2 vector2 = eventData.delta / num;
			rectTranform3.anchoredPosition += vector2;
			if (IsMostlyInside(rectTranform3, rectTranform2))
			{
				image4.SetActive(value: true);
			}
			else
			{
				image4.SetActive(value: false);
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_down", useStream: false);
		if (IsMostlyInside(rectTranform3, rectTranform2))
		{
			isdrep = false;
			image4.SetActive(value: false);
			if (progress < maxProgress)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_move02", useStream: false);
			}
			if (progress == maxProgress)
			{
				isfinish = true;
			}
			CookingGameManager.Instance.AddStepSuccess(CookingGameManager.Instance.currentStep.config.stepID);
			animator.Play("sushi", 0, 0f);
		}
		image2.SetActive(value: false);
		rectTranform3.anchoredPosition = initrect;
	}

	private void GameGuide(bool flag)
	{
		isGuide = flag;
		image6.SetActive(flag);
		CookingGameManager.Instance.ShowGuideText(flag, guideKey);
	}

	private bool IsMostlyInside(RectTransform rect1, RectTransform rect2)
	{
		Rect worldRect = GetWorldRect(rect1);
		Rect worldRect2 = GetWorldRect(rect2);
		Rect rect3 = Rect.MinMaxRect(Mathf.Max(worldRect.xMin, worldRect2.xMin), Mathf.Max(worldRect.yMin, worldRect2.yMin), Mathf.Min(worldRect.xMax, worldRect2.xMax), Mathf.Min(worldRect.yMax, worldRect2.yMax));
		if (rect3.width > 0f && rect3.height > 0f)
		{
			float num = rect3.width * rect3.height;
			float num2 = worldRect.width * worldRect.height;
			return num / num2 > threshold;
		}
		return false;
	}

	private Rect GetWorldRect(RectTransform rectTransform)
	{
		Vector3[] array = new Vector3[4];
		rectTransform.GetWorldCorners(array);
		float num = float.MaxValue;
		float num2 = float.MaxValue;
		float num3 = float.MinValue;
		float num4 = float.MinValue;
		Vector3[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			Vector3 vector = array2[i];
			num = Mathf.Min(num, vector.x);
			num2 = Mathf.Min(num2, vector.y);
			num3 = Mathf.Max(num3, vector.x);
			num4 = Mathf.Max(num4, vector.y);
		}
		return Rect.MinMaxRect(num, num2, num3, num4);
	}

	public bool getState()
	{
		return isover;
	}

	public void setState(bool newisover)
	{
		isover = newisover;
	}

	public int getMaxProgress()
	{
		return maxProgress;
	}

	public int getProgress()
	{
		return progress;
	}

	public void setProgress(int newprogress)
	{
		progress = newprogress;
	}
}

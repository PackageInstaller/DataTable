using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DragStep : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IDragHandler, IPointerUpHandler
{
	private float threshold = 0.9f;

	public RectTransform rectTranform1;

	public RectTransform rectTranform2;

	public RectTransform rectTranform3;

	public RectTransform rectTranform4;

	public GameObject image1;

	public GameObject image2;

	public GameObject image3;

	public GameObject image4;

	private CanvasScaler canvasScaler;

	private Vector2 initrect;

	private bool isover;

	private bool isdrep = true;

	private float operateTimer;

	private bool isGuide;

	public string guideKey = "";

	public int guideTime;

	[SerializeField]
	private int maxProgress;

	[SerializeField]
	public Animator animator;

	private int Progress;

	private void Start()
	{
		rectTranform4 = GetComponent<RectTransform>();
		initrect = rectTranform4.anchoredPosition;
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		canvasScaler = gameObject.GetComponentInParent<CanvasScaler>();
		GameGuide(flag: true);
	}

	private void Update()
	{
		if (!isover)
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
		isover = false;
		Progress = 0;
		image3.SetActive(value: true);
	}

	public void finish()
	{
		image3.SetActive(value: true);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		image4.SetActive(value: false);
		if (eventData.pointerCurrentRaycast.gameObject == image3.gameObject && isdrep)
		{
			operateTimer = 0f;
			GameGuide(flag: false);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTranform3, eventData.position, eventData.pressEventCamera, out var localPoint))
			{
				rectTranform1.anchoredPosition = rectTranform3.anchoredPosition + localPoint;
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
			rectTranform1.anchoredPosition += vector2;
		}
	}

	private void GameGuide(bool flag)
	{
		isGuide = flag;
		image4.SetActive(flag);
		CookingGameManager.Instance.ShowGuideText(flag, guideKey);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (IsMostlyInside(rectTranform1, rectTranform2))
		{
			isdrep = false;
			Progress++;
			animator.SetActive(bActive: true);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_transition01", useStream: false);
			CookingGameManager.Instance.AddStepSuccess(CookingGameManager.Instance.currentStep.config.stepID);
			animator.Play("CuttingSmoke", 0, 0f);
			image1.SetActive(value: true);
			image3.SetActive(value: false);
			if (Progress == maxProgress)
			{
				isover = true;
			}
		}
		image2.SetActive(value: false);
		rectTranform1.anchoredPosition = initrect;
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
}

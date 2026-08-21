using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class UIScreenTap : MonoBehaviour
{
	public RectTransform effectContainer;

	private GameObject effectObj;

	public float effectLifeTime = 1f;

	public Vector2 refResolution = new Vector2(2560f, 1440f);

	public CanvasScaler.ScreenMatchMode screenMatchMode = CanvasScaler.ScreenMatchMode.Shrink;

	public Vector2 pcEffectSize = new Vector2(72f, 72f);

	private Queue<GameObject> pool = new Queue<GameObject>();

	private List<GameObject> activatedList = new List<GameObject>();

	private bool _isPc;

	private const string clickPath = "Widget/System/UIScreenTap/ScreenTapEffect";

	private void Start()
	{
		effectObj = Asset.Load<GameObject>("Widget/System/UIScreenTap/ScreenTapEffect");
		_isPc = true;
	}

	private void Update()
	{
		for (int num = activatedList.Count - 1; num >= 0; num--)
		{
			GameObject gameObject = activatedList[num];
			float num2 = float.Parse(gameObject.name);
			if (Time.time - num2 > effectLifeTime)
			{
				Recycle(gameObject);
				activatedList.RemoveAt(num);
			}
		}
		if (Input.touchCount > 0)
		{
			for (int i = 0; i < Input.touchCount; i++)
			{
				Touch touch = Input.GetTouch(i);
				if (touch.phase == TouchPhase.Began)
				{
					Play(touch.position);
				}
			}
		}
		else if (Input.GetMouseButtonDown(0))
		{
			Play(Input.mousePosition);
		}
	}

	private void Play(Vector2 tapPos)
	{
		GameObject gameObject = Create();
		activatedList.Add(gameObject);
		gameObject.SetActive(value: true);
		gameObject.name = Time.time.ToString();
		gameObject.transform.SetAsLastSibling();
		RectTransformUtility.ScreenPointToLocalPointInRectangle(effectContainer, tapPos, CanvasManager.Instance.uiCamera, out var localPoint);
		gameObject.transform.localPosition = localPoint;
		if (_isPc)
		{
			RefResolutionScaleCalculator refResolutionScaleCalculator = default(RefResolutionScaleCalculator);
			refResolutionScaleCalculator.refResolution = refResolution;
			refResolutionScaleCalculator.screenMatchMode = screenMatchMode;
			refResolutionScaleCalculator.logBase = 2f;
			refResolutionScaleCalculator.matchWidthOrHeight = 0.5f;
			float scaleFactor = refResolutionScaleCalculator.GetScaleFactor(new Vector2(Screen.width, Screen.height));
			Vector3 vector = new Vector3(scaleFactor, scaleFactor, 1f);
			if (gameObject.transform is RectTransform rectTransform)
			{
				vector *= pcEffectSize / rectTransform.sizeDelta;
			}
			gameObject.transform.localScale = vector;
		}
	}

	private GameObject Create()
	{
		GameObject gameObject = null;
		if (pool.Count > 0)
		{
			gameObject = pool.Dequeue();
		}
		else
		{
			gameObject = ((!effectObj) ? new GameObject() : Object.Instantiate(effectObj));
			gameObject.transform.SetParent(effectContainer, worldPositionStays: false);
		}
		return gameObject;
	}

	private void Recycle(GameObject go)
	{
		go.SetActive(value: false);
		pool.Enqueue(go);
	}
}

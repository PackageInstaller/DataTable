using ControllerExSpace;
using UnityEngine;
using UnityEngine.UI;

public class NayFacePopStep : PopStepBase
{
	[Header("配置项")]
	public int requiredClicks = 10;

	public float doubleClickTime = 0.5f;

	public float clickCD = 0.5f;

	public float guideTime = 8f;

	public float hitStateDuration = 0.3f;

	public Vector2 enterPosition;

	public Vector2 exitPosition;

	public Vector2 faceSize = new Vector2(300f, 300f);

	[Header("状态图片")]
	public Sprite normalStateSprite;

	public Sprite hitStateSprite;

	public Sprite exitStateSprite;

	public Image faceImage;

	public Button button;

	[Header("引导元素")]
	public GameObject guideHand;

	public string guideText;

	public GameObject clickEffect;

	public Animator ani;

	public LeanTweenType aniType;

	public ControllerExCollection controller;

	public float hitAniduration = 0.4f;

	public float endScale = 1.2f;

	private NayFacePopGameManager manager;

	public RectTransform faceRect { get; private set; }

	public override void Start()
	{
		base.Start();
		InitializeFace();
		manager = new NayFacePopGameManager(this);
		EnterScene();
	}

	private void InitializeFace()
	{
		faceImage.sprite = normalStateSprite;
		faceRect = faceImage.transform.GetComponent<RectTransform>();
		faceRect.anchoredPosition = enterPosition;
		button.onClick.AddListener(delegate
		{
			manager.OnFaceClick();
		});
	}

	private void EnterScene()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_trick", useStream: true);
		controller.GetController("isCry").SetSelectedState("false");
		LeanTween.move(faceRect, Vector2.zero, 0.5f).setEase(LeanTweenType.easeInCubic);
	}

	private void Update()
	{
		manager.Update();
	}

	public override bool IsStepCompleted()
	{
		return manager.IsCompleted();
	}

	public override float GetProgress()
	{
		return manager.GetCurrentProgress() / requiredClicks;
	}
}

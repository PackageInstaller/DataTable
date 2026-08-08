using System;
using System.Collections;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class FoodCutLine : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler, IPointerDownHandler, IPointerUpHandler
{
	public int index;

	[SerializeField]
	private Image AreaImage;

	[SerializeField]
	private GameObject effectGO;

	[SerializeField]
	private GameObject KuangGO;

	[SerializeField]
	private Image LineGO;

	public GameObject cutlineOG;

	public GameObject foodPicOG;

	[SerializeField]
	private ControllerExCollection ctl;

	[SerializeField]
	private Animator CutAnimator;

	public GameObject GuideGO;

	[SerializeField]
	private Animator GuideAnimator;

	[SerializeField]
	private string guideKey = "";

	private string guideString;

	[SerializeField]
	private float guideSec = 8f;

	private bool row;

	private float mix;

	private float max;

	private Vector2 Point;

	private bool isCover;

	private bool isInner;

	private ControllerEx statueController;

	private RectTransform imgRect;

	private Camera uiCamera;

	private bool checkInit = true;

	private float percent = 0.8f;

	private IEnumerator animCoroutine;

	private bool isBlocking;

	private float noCutTimer;

	private bool playGuide;

	private void Update()
	{
		if (!playGuide && !isCover)
		{
			noCutTimer += Time.deltaTime;
			if (noCutTimer >= guideSec)
			{
				PlayGuideAnim();
				noCutTimer = 0f;
			}
		}
	}

	public void Start()
	{
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		this.SetActive(bActive: true);
		cutlineOG.SetActive(value: false);
		statueController = ctl.GetController("status");
		isInner = true;
		CutAnimator.enabled = false;
		effectGO.SetActive(value: false);
		statueController.SetSelectedIndex(0);
		imgRect = AreaImage.GetComponent<RectTransform>();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (isCover || !checkInit || CookingGameManager.Instance.isPlayingPopStep)
		{
			return;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform.GetComponent<RectTransform>(), eventData.position, eventData.pressEventCamera, out Point);
		if (row)
		{
			mix = imgRect.rect.xMax;
			max = imgRect.rect.xMax;
			if (imgRect.rect.xMax > Point.x + imgRect.rect.width * (1f - percent))
			{
				statueController.SetSelectedIndex(1);
				isInner = false;
			}
			else
			{
				isInner = true;
			}
		}
		else
		{
			mix = imgRect.rect.yMax;
			max = imgRect.rect.yMax;
			if (imgRect.rect.yMax > Point.y + imgRect.rect.height * (1f - percent))
			{
				statueController.SetSelectedIndex(1);
				isInner = false;
			}
			else
			{
				isInner = true;
			}
		}
		checkInit = false;
		GuideAnimator.SetActive(bActive: false);
		hideGuideText();
		playGuide = false;
		isBlocking = false;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (!isCover)
		{
			checkInit = true;
			if (!isInner)
			{
				statueController.SetSelectedIndex(0);
			}
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!isCover)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform.GetComponent<RectTransform>(), eventData.position, uiCamera, out Point);
			updateMaxAndMix();
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!isCover && isInner)
		{
			RectTransformUtility.ScreenPointToLocalPointInRectangle(base.transform.GetComponent<RectTransform>(), eventData.position, eventData.pressEventCamera, out Point);
			updateMaxAndMix();
			updateLineLen();
			updateImgColor();
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		LineGO.fillAmount = 0f;
		if (isInner && !isCover && Mathf.Abs(max - mix) >= GetCutLine())
		{
			KuangGO.SetActive(value: false);
			AreaImage.SetActive(bActive: false);
			GuideGO.SetActive(value: false);
			CutAnimator.enabled = true;
			CookingGameManager.Instance.AddStepSuccess(CookingGameManager.Instance.currentStep.config.stepID);
			CutAnimator.Play("SimpleCutting", 0, 0f);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_cut01", useStream: false);
			isCover = true;
		}
		if (!isInner)
		{
			isInner = true;
			statueController.SetSelectedIndex(0);
		}
		checkInit = true;
		if (!isCover)
		{
			CookingGameManager.Instance.AddStepFailure(CookingGameManager.Instance.currentStep.config.stepID);
		}
	}

	public bool GetCutOver()
	{
		return isCover;
	}

	public void CloseImg()
	{
		this.SetActive(bActive: false);
		effectGO.SetActive(value: false);
		AreaImage.SetActive(bActive: false);
		GuideGO.SetActive(value: false);
	}

	public void OpenImg()
	{
		this.SetActive(bActive: true);
		AreaImage.SetActive(bActive: true);
		effectGO.SetActive(value: true);
		if (index == 1)
		{
			PlayGuideAnim();
		}
		noCutTimer = 0f;
	}

	public bool getFinishAnimator()
	{
		return CutAnimator.GetCurrentAnimatorStateInfo(0).normalizedTime > 0f;
	}

	private float GetCutLine()
	{
		if (row)
		{
			return imgRect.rect.width * percent;
		}
		return imgRect.rect.height * percent;
	}

	private void updateMaxAndMix()
	{
		if (imgRect.rect.Contains(Point) && !checkInit)
		{
			if (row)
			{
				mix = Mathf.Max(Mathf.Min(Point.x, mix), imgRect.rect.xMin);
				max = Mathf.Min(Mathf.Max(Point.x, max), imgRect.rect.xMax);
			}
			else
			{
				mix = Mathf.Max(Mathf.Min(Point.y, mix), imgRect.rect.yMin);
				max = Mathf.Min(Mathf.Max(Point.y, max), imgRect.rect.yMax);
			}
		}
	}

	private void updateImgColor()
	{
		if (checkInit || imgRect.rect.Contains(Point))
		{
			return;
		}
		if (row)
		{
			if (imgRect.rect.xMax >= Point.x && imgRect.rect.xMin <= Point.x && Mathf.Abs(max - mix) < GetCutLine())
			{
				isInner = false;
				statueController.SetSelectedIndex(1);
			}
		}
		else if (imgRect.rect.yMax >= Point.y && imgRect.rect.yMin <= Point.y && Mathf.Abs(max - mix) < GetCutLine())
		{
			isInner = false;
			statueController.SetSelectedIndex(1);
		}
	}

	private void updateLineLen()
	{
		float num = Mathf.Abs(max - mix);
		float cutLine = GetCutLine();
		if (num >= cutLine)
		{
			LineGO.fillAmount = 1f;
		}
		else
		{
			LineGO.fillAmount = num / cutLine;
		}
	}

	private void PlayGuideAnim()
	{
		if (!isBlocking && !CookingGameManager.Instance.isPlayingPopStep)
		{
			playGuide = true;
			isBlocking = true;
			GuideGO.SetActive(value: true);
			showGuideText();
			PlayAnimWithCallback(GuideAnimator, "GuideUI", SuccessAnimEnd);
		}
	}

	private void PlayAnimWithCallback(Animator animator, string animName, Action callback = null)
	{
		animator.enabled = true;
		animator.Play(animName, 0, 0f);
		animator.Update(0f);
		StopAnimCoroutine();
		animCoroutine = CheckAnimEnd(animator, animName, callback);
		StartCoroutine(animCoroutine);
	}

	private IEnumerator CheckAnimEnd(Animator animator, string animName, Action callback)
	{
		yield return null;
		bool invokedMidCallback = false;
		while (true)
		{
			if ((double)animator.GetCurrentAnimatorStateInfo(0).normalizedTime >= 0.5 && !invokedMidCallback)
			{
				invokedMidCallback = true;
				yield return null;
				continue;
			}
			if (!playGuide)
			{
				break;
			}
			yield return null;
		}
		animator.enabled = false;
		callback();
	}

	private void StopAnimCoroutine()
	{
		if (animCoroutine != null)
		{
			StopCoroutine(animCoroutine);
		}
	}

	private void SuccessAnimEnd()
	{
		playGuide = false;
		GuideAnimator.SetActive(bActive: false);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.ShowGuideText(flag: false, "");
		}
		isBlocking = false;
	}

	private void hideGuideText()
	{
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.ShowGuideText(flag: false, "");
		}
	}

	private void showGuideText()
	{
		if ((bool)CookingGameManager.Instance)
		{
			string text = ((LuaHelper.CallFunction("GetTips", guideKey) != null) ? (LuaHelper.CallFunction("GetTips", guideKey)[0] as string) : null);
			guideString = ((text == null || text == "") ? "未正确配置tip" : text);
			CookingGameManager.Instance.ShowGuideText(flag: true, guideString);
		}
	}
}

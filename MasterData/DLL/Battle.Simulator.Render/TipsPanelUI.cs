using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TipsPanelUI : MonoBehaviour
{
	public GameObject textTmp;

	private List<ScrollText> texts = new List<ScrollText>();

	private bool hasShow;

	public float showTime;

	private float time;

	public Text title;

	public Button listButton;

	public RectTransform bg;

	public GameObject titlePanel;

	public GameObject tipsPanel;

	public GameObject buttonIcon;

	private bool hasSubTips;

	private Stack<ScrollText> pools = new Stack<ScrollText>();

	private Stack<ScrollText> running = new Stack<ScrollText>();

	private float targetY;

	private float originY;

	private Vector2 originBgVector = Vector2.zero;

	private Vector2 targetBgVector = Vector2.zero;

	private bool isShowing;

	public float moveTime = 0.3f;

	public ScrollText Get()
	{
		if (pools.Count > 0)
		{
			return pools.Pop();
		}
		return U3DUtil.Get<ScrollText>(Object.Instantiate(textTmp, textTmp.transform.parent));
	}

	public void Init(string titleStr, List<string> text)
	{
		while (running.Count > 0)
		{
			ScrollText scrollText = running.Pop();
			scrollText.gameObject.SetActive(value: false);
			pools.Push(scrollText);
		}
		texts.Clear();
		title.text = titleStr;
		Rect rect = (textTmp.transform as RectTransform).rect;
		hasSubTips = text.Count > 0;
		for (int i = 0; i < text.Count; i++)
		{
			ScrollText scrollText2 = Get();
			scrollText2.gameObject.SetActive(value: true);
			scrollText2.Init(text[i]);
			texts.Add(scrollText2);
		}
		if (hasSubTips)
		{
			tipsPanel.SetActive(value: true);
			listButton.gameObject.SetActive(value: true);
			isShowing = false;
			targetY = originY - rect.height * (float)text.Count;
			targetBgVector = originBgVector + new Vector2(0f, rect.height * (float)text.Count);
			ShowOrHide();
			hasShow = false;
		}
		else
		{
			tipsPanel.SetActive(value: false);
			listButton.gameObject.SetActive(value: false);
			hasShow = true;
		}
	}

	private void ShowEffect(bool isShow)
	{
		if (!isShow)
		{
			LeanTween.scaleY(tipsPanel, 0f, moveTime);
			LeanTween.size(bg, originBgVector, moveTime);
		}
		else
		{
			LeanTween.scaleY(tipsPanel, 1f, moveTime);
			LeanTween.size(bg, targetBgVector, moveTime);
		}
		StartCoroutine(RorateButton(moveTime, isShow));
	}

	private IEnumerator RorateButton(float time, bool isShow)
	{
		yield return new WaitForSeconds(time);
		if (buttonIcon != null)
		{
			buttonIcon.transform.rotation = Quaternion.Euler(0f, 0f, (!isShow) ? 180 : 0);
		}
	}

	public void ShowOrHide()
	{
		if (isShowing)
		{
			isShowing = false;
		}
		else
		{
			isShowing = true;
		}
		hasShow = true;
		ShowEffect(isShowing);
	}

	private void OnEnable()
	{
		if (titlePanel != null)
		{
			originBgVector = (titlePanel.transform as RectTransform).rect.size;
		}
		if (listButton != null)
		{
			listButton.onClick.AddListener(ShowOrHide);
		}
	}

	private void Update()
	{
		if (!hasShow)
		{
			time += Time.deltaTime;
			if (time >= showTime)
			{
				hasShow = true;
				ShowOrHide();
			}
		}
	}
}

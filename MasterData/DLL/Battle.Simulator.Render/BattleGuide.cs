using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BattleGuide : MonoBehaviour
{
	public string title = "";

	public List<string> titles = new List<string>();

	public List<string> contents = new List<string>();

	public Text titleComponent;

	public Text contentComponent;

	public Image[] imagesTabs;

	public Image[] imagesTabsBg;

	public Button buttonNext;

	public Button buttonLast;

	public Button buttonHide;

	public Image buttonHideImage;

	public Sprite ImageHide;

	public Sprite ImageShow;

	public int width = 622;

	private int currentIndex;

	private int maxIndex = 1;

	private bool isHide;

	private float localPositionX;

	public void SetContent(List<string> contentList, string title, List<string> titlesParam)
	{
		this.title = title;
		titles = titlesParam;
		contents = contentList;
		currentIndex = 0;
		maxIndex = ((contentList.Count <= 0) ? 1 : contentList.Count);
		for (int i = 0; i < maxIndex; i++)
		{
			imagesTabsBg[i].gameObject.SetActive(value: true);
			contents[i] = contentList[i];
		}
		contentComponent.text = contents[currentIndex].Replace("\\n", "\n");
		if (titles != null && titles.Count > currentIndex)
		{
			title = titles[currentIndex];
		}
		titleComponent.text = title;
		for (int j = maxIndex; j < imagesTabsBg.Length; j++)
		{
			imagesTabsBg[j].gameObject.SetActive(value: false);
		}
		for (int k = 0; k < imagesTabsBg.Length; k++)
		{
			imagesTabs[k].gameObject.SetActive(value: false);
		}
		imagesTabs[currentIndex].gameObject.SetActive(value: true);
		if (maxIndex < 2)
		{
			buttonNext.gameObject.SetActive(value: false);
			buttonLast.gameObject.SetActive(value: false);
		}
		else
		{
			buttonNext.gameObject.SetActive(value: true);
			buttonLast.gameObject.SetActive(value: true);
		}
		if (isHide)
		{
			ChangeHideState();
		}
	}

	private void Awake()
	{
		if (titleComponent == null)
		{
			titleComponent = base.transform.Find("title/text").GetComponent<Text>();
		}
		if (imagesTabs == null)
		{
			imagesTabs = new Image[5];
			for (int i = 0; i < imagesTabs.Length; i++)
			{
				imagesTabs[i] = base.transform.Find("tabs/tab" + (i + 1) + "/image").GetComponent<Image>();
				imagesTabsBg[i] = base.transform.Find("tabs/tab" + (i + 1)).GetComponent<Image>();
			}
		}
		if (contentComponent == null)
		{
			contentComponent = base.transform.Find("text").GetComponent<Text>();
		}
		if (buttonNext == null)
		{
			buttonNext = base.transform.Find("btn_next").GetComponent<Button>();
		}
		buttonNext.onClick.AddListener(delegate
		{
			imagesTabs[currentIndex].gameObject.SetActive(value: false);
			currentIndex++;
			currentIndex %= maxIndex;
			imagesTabs[currentIndex].gameObject.SetActive(value: true);
			contentComponent.text = contents[currentIndex].Replace("\\n", "\n");
			if (titles != null && titles.Count > currentIndex)
			{
				title = titles[currentIndex];
			}
			titleComponent.text = title;
		});
		if (buttonLast == null)
		{
			buttonLast = base.transform.Find("btn_upper").GetComponent<Button>();
		}
		buttonLast.onClick.AddListener(delegate
		{
			imagesTabs[currentIndex].gameObject.SetActive(value: false);
			currentIndex += maxIndex - 1;
			currentIndex %= maxIndex;
			imagesTabs[currentIndex].gameObject.SetActive(value: true);
			contentComponent.text = contents[currentIndex].Replace("\\n", "\n");
			if (titles != null && titles.Count > currentIndex)
			{
				title = titles[currentIndex];
			}
			titleComponent.text = title;
		});
		SetContent(contents, title, titles);
		if (buttonHide == null)
		{
			buttonHide = base.transform.parent.Find("ButtonHide").GetComponent<Button>();
		}
		buttonHide.onClick.AddListener(delegate
		{
			ChangeHideState();
		});
		if (buttonHideImage == null)
		{
			buttonHideImage = buttonHide.gameObject.GetComponent<Image>();
			buttonHideImage.sprite = ImageHide;
		}
		localPositionX = base.transform.localPosition.x;
	}

	public void ChangeHideState()
	{
		isHide = !isHide;
		LeanTween.moveLocalX(to: (!isHide) ? localPositionX : (localPositionX - (float)width), gameObject: base.gameObject, time: 0.1f);
		if (!(buttonHideImage == null))
		{
			if (isHide)
			{
				buttonHideImage.sprite = ImageShow;
			}
			else
			{
				buttonHideImage.sprite = ImageHide;
			}
		}
	}
}

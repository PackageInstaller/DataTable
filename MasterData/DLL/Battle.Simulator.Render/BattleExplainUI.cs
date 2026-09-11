using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BattleExplainUI : MonoBehaviour
{
	public string title = "";

	public List<string> titles = new List<string>();

	public List<string> contents = new List<string>();

	public List<string> pictureList = new List<string>();

	public Text titleComponent;

	public Text contentComponent;

	public Image[] imagesTabs;

	public Image[] imagesTabsBg;

	public GameObject[] pictureItems;

	public Image[] pictures;

	public Button buttonNext;

	public Button buttonLast;

	public Button buttonClose;

	public Button buttonShow;

	public Color titleColor = Color.white;

	public Color contentColor = Color.white;

	private const int width = 844;

	private int currentIndex;

	private int maxIndex = 1;

	private int simTimeScale;

	public void SetContent(List<string> contentList, string title, List<string> titlesParam, List<string> imageList, Color titleColor, Color contentColor)
	{
		this.title = title;
		this.titleColor = titleColor;
		this.contentColor = contentColor;
		titles = titlesParam;
		contents.Clear();
		pictureList.Clear();
		currentIndex = 0;
		maxIndex = ((contentList.Count <= 0) ? 1 : contentList.Count);
		for (int i = 0; i < maxIndex; i++)
		{
			imagesTabsBg[i].gameObject.SetActive(value: true);
			pictureItems[i].SetActive(value: true);
			contents.Add(contentList[i]);
			pictureList.Add(imageList[i]);
			pictures[maxIndex - 1 - i].sprite = Asset.Load<Sprite>(imageList[i]);
		}
		contentComponent.text = contents[currentIndex].Replace("\\n", "\n");
		contentComponent.color = this.contentColor;
		if (titles != null && titles.Count > currentIndex)
		{
			title = titles[currentIndex];
		}
		titleComponent.text = title;
		titleComponent.color = this.titleColor;
		for (int j = maxIndex; j < imagesTabsBg.Length; j++)
		{
			imagesTabsBg[j].gameObject.SetActive(value: false);
			pictureItems[j].SetActive(value: false);
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
			buttonClose.gameObject.SetActive(value: true);
		}
		else
		{
			buttonClose.gameObject.SetActive(value: false);
			buttonNext.gameObject.SetActive(value: true);
		}
		buttonShow.gameObject.SetActive(value: false);
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
			ChangeNextOrUpper(isLeft: true, pictureItems[maxIndex - 1 - currentIndex]);
			currentIndex++;
			currentIndex %= maxIndex;
			imagesTabs[currentIndex].gameObject.SetActive(value: true);
			contentComponent.text = contents[currentIndex].Replace("\\n", "\n");
			contentComponent.color = contentColor;
			if (titles != null && titles.Count > currentIndex)
			{
				title = titles[currentIndex];
			}
			titleComponent.text = title;
			titleComponent.color = titleColor;
			if (currentIndex == maxIndex - 1)
			{
				buttonNext.gameObject.SetActive(value: false);
				buttonClose.gameObject.SetActive(value: true);
			}
			if (!buttonLast.gameObject.activeSelf)
			{
				buttonLast.gameObject.SetActive(value: true);
			}
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
			contentComponent.color = contentColor;
			if (titles != null && titles.Count > currentIndex)
			{
				title = titles[currentIndex];
			}
			titleComponent.text = title;
			titleComponent.color = titleColor;
			ChangeNextOrUpper(isLeft: false, pictureItems[maxIndex - 1 - currentIndex]);
			if (currentIndex < maxIndex - 1)
			{
				if (buttonClose.gameObject.activeSelf)
				{
					buttonClose.gameObject.SetActive(value: false);
				}
				if (!buttonNext.gameObject.activeSelf)
				{
					buttonNext.gameObject.SetActive(value: true);
				}
			}
			if (currentIndex == 0 && buttonLast.gameObject.activeSelf)
			{
				buttonLast.gameObject.SetActive(value: false);
			}
		});
		if (buttonClose == null)
		{
			buttonClose = base.transform.Find("btn_close").GetComponent<Button>();
		}
		buttonClose.onClick.AddListener(delegate
		{
			buttonLast.gameObject.SetActive(value: false);
			buttonClose.gameObject.SetActive(value: false);
			buttonNext.gameObject.SetActive(value: true);
			if (titles != null && titles.Count > 0)
			{
				titleComponent.text = titles[0];
			}
			else
			{
				titleComponent.text = title;
			}
			contentComponent.text = contents[0].Replace("\\n", "\n");
			for (int j = 0; j < maxIndex; j++)
			{
				if (pictureItems[j].GetComponent<RectTransform>().position.x != 0f)
				{
					Vector3 position = pictureItems[j].GetComponent<RectTransform>().position;
					position.x = 0f;
					pictureItems[j].GetComponent<RectTransform>().localPosition = position;
				}
				imagesTabs[j].gameObject.SetActive(value: false);
			}
			imagesTabs[0].gameObject.SetActive(value: true);
			currentIndex = 0;
			base.gameObject.SetActive(value: false);
			buttonShow.gameObject.SetActive(value: true);
			if (ClientSimulator.Instance.SimTimeScale == 0)
			{
				ClientSimulator.Instance.SimTimeScale = simTimeScale;
			}
		});
		if (buttonShow == null)
		{
			buttonShow = base.transform.parent.Find("ButtonShow").GetComponent<Button>();
		}
		buttonShow.onClick.AddListener(delegate
		{
			buttonShow.gameObject.SetActive(value: false);
			if (ClientSimulator.Instance.SimTimeScale != 0)
			{
				simTimeScale = ClientSimulator.Instance.SimTimeScale;
				ClientSimulator.Instance.SimTimeScale = 0;
			}
			base.gameObject.SetActive(value: true);
		});
		if (ClientSimulator.Instance.SimTimeScale != 0)
		{
			simTimeScale = ClientSimulator.Instance.SimTimeScale;
			ClientSimulator.Instance.SimTimeScale = 0;
		}
	}

	private void ChangeNextOrUpper(bool isLeft, GameObject pictureItem)
	{
		float to = ((!isLeft) ? 0f : (-844f));
		LeanTween.moveLocalX(pictureItem, to, 0.5f);
	}
}

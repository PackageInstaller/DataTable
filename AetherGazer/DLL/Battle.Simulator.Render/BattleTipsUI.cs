using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class BattleTipsUI : MonoBehaviour
{
	public string title = "";

	public List<string> contents = new List<string>();

	public Text titleComponent;

	public Text contentComponent;

	public Button buttonHide;

	public Button buttonNext;

	public Button buttonLast;

	public Image page;

	private int currentIndex;

	public void SetContent(List<string> contentList, string title)
	{
		this.title = title;
		contents = contentList;
		currentIndex = 0;
		if (titleComponent != null)
		{
			titleComponent.text = title;
		}
		ShowPage();
	}

	private void ChangePage(int delta)
	{
		if (contents != null && contents.Count != 0)
		{
			currentIndex += delta + contents.Count;
			currentIndex %= contents.Count;
		}
	}

	private void ShowPage()
	{
		if (!(page == null) && contents != null && contents.Count != 0 && !(contentComponent == null))
		{
			page.fillAmount = ((float)currentIndex + 1f) / (float)contents.Count;
			contentComponent.text = contents[currentIndex];
		}
	}

	private void Awake()
	{
		SetContent(contents, title);
		buttonNext.onClick.AddListener(delegate
		{
			ChangePage(1);
			ShowPage();
		});
		buttonLast.onClick.AddListener(delegate
		{
			ChangePage(-1);
			ShowPage();
		});
	}
}

using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT;

public class TestView : MonoBehaviour
{
	[Serializable]
	public class TabInfo
	{
		public Toggle tog;

		public GameObject tab;

		public int cam;

		public Material bg;

		public List<GameObject> bindGameObjects = new List<GameObject>();

		public List<string> animations = new List<string>();
	}

	public string changeToView;

	public TestView_Scene viewScene;

	public Button btnChangeView;

	public string entryAnim;

	public List<TabInfo> tabs = new List<TabInfo>();

	private bool playEntryAnim;

	private int currentTab = -1;

	private Coroutine updateAnimCoroutine;

	private void Awake()
	{
		for (int i = 0; i < tabs.Count; i++)
		{
			TabInfo tabInfo = tabs[i];
			int index = i;
			tabInfo.tog.transform.Find("Label").GetComponent<TMP_Text>().text = $"Tab {i}";
			tabInfo.tog.onValueChanged.AddListener((bool v) =>
			{
				if (v)
				{
					ChangeToTab(index);
				}
			});
			tabInfo.tab.gameObject.SetActive(value: false);
		}
		tabs[0].tog.SetIsOnWithoutNotify(value: true);
		btnChangeView.onClick.AddListener(OnBtnChangeViewClicked);
	}

	private void OnEnable()
	{
		if (currentTab < 0)
		{
			ChangeToTab(0);
		}
		playEntryAnim = true;
	}

	private void OnDisable()
	{
		try
		{
			ChangeToTab(-1);
		}
		catch (Exception)
		{
		}
	}

	private void OnBtnChangeViewClicked()
	{
		TestViewManager.Instance.ChangeView(changeToView);
	}

	private void ChangeToTab(int index)
	{
		if (index != currentTab)
		{
			if (updateAnimCoroutine != null)
			{
				StopCoroutine(updateAnimCoroutine);
				updateAnimCoroutine = null;
			}
			if (currentTab >= 0)
			{
				OnTabHide(currentTab);
			}
			currentTab = index;
			if (currentTab >= 0)
			{
				OnTabShow(currentTab);
			}
		}
	}

	private void OnTabShow(int index)
	{
		TabInfo tabInfo = tabs[index];
		tabInfo.tab.SetActive(value: true);
		foreach (GameObject bindGameObject in tabInfo.bindGameObjects)
		{
			bindGameObject.gameObject.SetActive(value: true);
		}
		StartCoroutine(UpdateAnim(index));
		viewScene.bindingAnimator.SetBool("Show", value: true);
		viewScene.SetCamera(tabInfo.cam);
		viewScene.bg.material = tabInfo.bg;
	}

	private void OnTabHide(int index)
	{
		TabInfo tabInfo = tabs[index];
		tabInfo.tab.SetActive(value: false);
		foreach (GameObject bindGameObject in tabInfo.bindGameObjects)
		{
			bindGameObject.gameObject.SetActive(value: false);
		}
	}

	private IEnumerator UpdateAnim(int tabIndex)
	{
		if (!string.IsNullOrEmpty(entryAnim) && !playEntryAnim)
		{
			viewScene.bindingAnimator.SetTrigger(entryAnim);
			yield break;
		}
		TabInfo tabInfo = tabs[tabIndex];
		if (tabInfo.animations.Count > 1)
		{
			float nextTime = Time.time;
			while (true)
			{
				if (Time.time >= nextTime)
				{
					nextTime = Time.time + UnityEngine.Random.Range(3f, 5f);
					_ = tabInfo.animations[UnityEngine.Random.Range(0, tabInfo.animations.Count)];
					foreach (string animation in tabInfo.animations)
					{
						viewScene.bindingAnimator.SetTrigger(animation);
					}
				}
				yield return 0;
			}
		}
		viewScene.bindingAnimator.SetTrigger(tabInfo.animations[0]);
	}
}

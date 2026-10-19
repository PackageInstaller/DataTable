using System.Collections.Generic;
using UnityEngine;

namespace ACT;

public class TestViewManager : MonoBehaviour
{
	public List<TestView> views = new List<TestView>();

	public static TestViewManager Instance { get; private set; }

	private void Awake()
	{
		Instance = this;
	}

	private void OnEnable()
	{
		Instance.ChangeView(views[0].name);
	}

	public async void ChangeView(string viewName)
	{
		foreach (TestView view in views)
		{
			if (view.name != viewName)
			{
				view.gameObject.SetActive(value: false);
			}
		}
		foreach (TestView view2 in views)
		{
			if (view2.name == viewName)
			{
				view2.gameObject.SetActive(value: true);
			}
		}
	}
}

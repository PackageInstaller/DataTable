using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace P08.Gamepad;

public class InputActionSystem
{
	internal class TransientData
	{
		public Dictionary<string, InputBinding> consumed = new Dictionary<string, InputBinding>();

		public List<PageInputActionMap> pageReverseList = new List<PageInputActionMap>();

		public PageInputActionMap topPage;

		public void Reset()
		{
			consumed.Clear();
			pageReverseList.Clear();
		}
	}

	private InputSettings _settings;

	private InputActionProcessor _processor;

	private Dictionary<string, PageInputActionMap> _pages;

	private List<PageInputActionMap> _pageEnableList;

	private int _pagesVersion;

	internal TransientData _transient = new TransientData();

	private static int uniqueCounter;

	public PageInputActionMap topPage => _transient.topPage;

	public List<PageInputActionMap> pageEnableList => _pageEnableList;

	public int pagesVersion => _pagesVersion;

	internal InputActionSystem()
	{
		_processor = new InputActionProcessor(this);
		_pages = new Dictionary<string, PageInputActionMap>();
		_pageEnableList = new List<PageInputActionMap>();
	}

	public void Tick()
	{
		_transient.Reset();
		_transient.pageReverseList.Clear();
		for (int num = _pageEnableList.Count - 1; num >= 0; num--)
		{
			_transient.pageReverseList.Add(_pageEnableList[num]);
		}
		PageInputActionMap pageInputActionMap = _transient.pageReverseList.FirstOrDefault((PageInputActionMap page) => page.canBeTop && page.enabled);
		if (pageInputActionMap != _transient.topPage)
		{
			_transient.topPage = pageInputActionMap;
			IncPagesVersion();
		}
		_processor.ClearKeyNameList();
		foreach (PageInputActionMap pageReverse in _transient.pageReverseList)
		{
			_processor.ProcessPage(pageReverse);
		}
		_processor.ProcessInputEvents();
	}

	public bool TryGetPageInputActionMap(string pageName, out PageInputActionMap map)
	{
		return _pages.TryGetValue(pageName, out map);
	}

	public PageInputActionMap GetPageInputActionMap(string pageName)
	{
		if (!TryGetPageInputActionMap(pageName, out var map))
		{
			Debug.LogError("PageInputActionMap not fonud: " + pageName);
			return null;
		}
		return map;
	}

	internal InputBinding GetPageInputBinding_(string pageName, InputAction action)
	{
		return GetPageInputActionMap(pageName)?.GetInputBinding_(action);
	}

	internal InputBinding GetPageInputBinding_(string pageName, En_ButtonType buttonType)
	{
		return GetPageInputActionMap(pageName)?.GetBindingButtonType(buttonType);
	}

	public InputAction GetInputAction(string pageName, string actionName)
	{
		return GetPageInputActionMap(pageName)?.GetInputAction(actionName);
	}

	public InputAction GetInputAction(string pageName, En_ButtonType buttonType)
	{
		return GetPageInputActionMap(pageName)?.GetInputAction(buttonType);
	}

	public void EnablePage(PageInputActionMap page)
	{
		if (!page.enabled)
		{
			IncPagesVersion();
			page.Enable();
			_pageEnableList.Add(page);
		}
	}

	public void DisablePage(PageInputActionMap page)
	{
		if (page.enabled)
		{
			IncPagesVersion();
			page.Disable();
			_pageEnableList.Remove(page);
			_processor.ClearKeyNameList();
			_processor.ProcessPage(page);
		}
	}

	public void IncPagesVersion()
	{
		_pagesVersion++;
	}

	internal PageInputActionMap CreateDummyPageMap(string dummyPageName, EInputActiveType activeType = EInputActiveType.TopPage, bool canBeTop = true)
	{
		PageInputActionMap pageInputActionMap = new PageInputActionMap(GetUniquePageName(dummyPageName), activeType, canBeTop);
		_pages.Add(pageInputActionMap.pageName, pageInputActionMap);
		return pageInputActionMap;
	}

	internal PageInputActionMap CreatePageInputActionMap(PageInputActionRes res)
	{
		string uniquePageName = GetUniquePageName(res.pageName);
		PageInputActionMap pageInputActionMap = new PageInputActionMap(res, uniquePageName);
		foreach (InputActionRes inputAction in res.inputActions)
		{
			if (inputAction == null)
			{
				Debug.LogError("InputActionSystem::" + pageInputActionMap.pageName + " has empty action");
			}
			else
			{
				CreateInputAction(pageInputActionMap, inputAction);
			}
		}
		_pages.Add(pageInputActionMap.pageName, pageInputActionMap);
		return pageInputActionMap;
	}

	internal void DestroyPageInputActoinMap(PageInputActionMap actionMap)
	{
		_pages.Remove(actionMap.pageName);
	}

	internal InputAction CreateInputAction(PageInputActionMap map, InputActionRes res)
	{
		InputAction inputAction = new InputAction(res);
		map.AddInputAction(inputAction);
		foreach (InputBindingRes binding2 in res.bindings)
		{
			InputBinding binding = CreateInputBinding(inputAction, binding2);
			map.AddInputBinding(binding);
		}
		return inputAction;
	}

	internal InputBinding CreateInputBinding(InputAction action, InputBindingRes res)
	{
		List<IInputActionTrigger> list = new List<IInputActionTrigger>();
		list.Add(new PressTrigger());
		return new InputBinding(action, res, list);
	}

	private string GetUniquePageName(string pageName)
	{
		if (!_pages.ContainsKey(pageName))
		{
			return pageName;
		}
		int num = 0;
		string text;
		do
		{
			if (++num > 100)
			{
				Debug.LogError($"InputActionSystem: try {num - 1} but could not find unique name for page {pageName}");
				return pageName;
			}
			text = $"{pageName}_{++uniqueCounter}";
		}
		while (_pages.ContainsKey(text));
		return text;
	}
}

using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.Linq;
using ACT.UI.Interface;
using UnityEngine;

namespace ACT.UI;

[RequireComponent(typeof(ActToggleGroup))]
public class CommonTabListComponent : SubUIView<CommonTabListInputController>
{
	public OperateBtnPrompt leftBtnPrompt;

	public OperateBtnPrompt rightBtnPrompt;

	public SwitchPageInputType switchPageInputType;

	[NonSerialized]
	public readonly ObservableCollection<ITabItem> TabItems = new ObservableCollection<ITabItem>();

	[SerializeField]
	private RectTransform _tabRoot;

	[SerializeField]
	private RectTransform _contentRoot;

	[SerializeField]
	private ActToggleGroup _group;

	[SerializeField]
	private bool _hideInactiveTabOnAdd = true;

	private bool _inited;

	private readonly HashSet<BaseTabToggle> _registeredTabs = new HashSet<BaseTabToggle>();

	public ITabItem ActiveTab
	{
		get
		{
			if ((bool)_group)
			{
				return _group.GetFirstActiveToggle() as ITabItem;
			}
			return null;
		}
		set
		{
			if (value == null)
			{
				CloseAllTabs();
			}
			else
			{
				if (!_group || !(value is ActToggle actToggle))
				{
					return;
				}
				Func<bool> canActive = value.CanActive;
				if (canActive != null && !canActive())
				{
					return;
				}
				if (!_inited)
				{
					int registeredToggleIndex = GetRegisteredToggleIndex(actToggle);
					_group.Init(registeredToggleIndex);
					_inited = true;
					return;
				}
				if (actToggle.IsOn)
				{
					actToggle.SetIsOnWithoutNotify(val: false);
				}
				_group.SetToggleOn(actToggle);
			}
		}
	}

	public RectTransform ContentRoot => _contentRoot;

	public RectTransform TabRoot => _tabRoot;

	public ActToggleGroup Group => _group;

	public bool HideInactiveTabOnAdd
	{
		get
		{
			return _hideInactiveTabOnAdd;
		}
		set
		{
			_hideInactiveTabOnAdd = value;
		}
	}

	public Action<ITabItem> OnTabActive { get; set; }

	public Action<ITabItem> OnTabDeActive { get; set; }

	private void CloseAllTabs()
	{
		if ((bool)_group)
		{
			_group.SetAllToggleOff(ignoreClickInterval: true);
		}
		foreach (ITabItem tabItem in TabItems)
		{
			if (tabItem is ActToggle { IsOn: not false } actToggle)
			{
				actToggle.SetIsOn(val: false);
			}
		}
	}

	public void Initialize(RectTransform tabRoot, RectTransform contentRoot, ActToggleGroup group, bool hideInactiveTabOnAdd = true)
	{
		_tabRoot = tabRoot;
		_contentRoot = contentRoot;
		_group = group;
		_hideInactiveTabOnAdd = hideInactiveTabOnAdd;
	}

	private void OnValidate()
	{
		if (_group == null)
		{
			_group = GetComponent<ActToggleGroup>();
		}
	}

	private void Awake()
	{
		TabItems.CollectionChanged += OnTabItemsChanged;
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		_inited = false;
	}

	protected override void OnUnityDestroy()
	{
		TabItems.CollectionChanged -= OnTabItemsChanged;
		UnRegisterAllTabs();
		_inited = false;
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		leftBtnPrompt?.SetVisible(vis: true);
		rightBtnPrompt?.SetVisible(vis: true);
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		leftBtnPrompt?.SetVisible(vis: false);
		rightBtnPrompt?.SetVisible(vis: false);
	}

	private void OnTabItemsChanged(object sender, NotifyCollectionChangedEventArgs notifyCollectionChangedEventArgs)
	{
		if (notifyCollectionChangedEventArgs.Action == NotifyCollectionChangedAction.Add)
		{
			foreach (object newItem in notifyCollectionChangedEventArgs.NewItems)
			{
				if (newItem is BaseTabToggle baseTabToggle)
				{
					baseTabToggle.transform.SetParent(_tabRoot, worldPositionStays: false);
					if (baseTabToggle.Content is BaseTabContent baseTabContent)
					{
						baseTabContent.transform.SetParent(_contentRoot, worldPositionStays: false);
					}
					baseTabToggle.Group = _group;
					RegisterTab(baseTabToggle);
					if (_hideInactiveTabOnAdd)
					{
						baseTabToggle.gameObject.SetActive(baseTabToggle.CanActive?.Invoke() ?? true);
					}
				}
			}
			RefreshTabItemsOrder();
		}
		if (notifyCollectionChangedEventArgs.Action == NotifyCollectionChangedAction.Remove)
		{
			foreach (object oldItem in notifyCollectionChangedEventArgs.OldItems)
			{
				if (oldItem is BaseTabToggle baseTabToggle2)
				{
					baseTabToggle2.transform.SetParent(_tabRoot.parent);
					UnRegisterTab(baseTabToggle2);
					baseTabToggle2.gameObject.SetActive(value: false);
				}
			}
		}
		if (notifyCollectionChangedEventArgs.Action == NotifyCollectionChangedAction.Reset)
		{
			UnRegisterAllTabs();
		}
	}

	private void RefreshTabItemsOrder()
	{
		BaseTabToggle[] array = (from tab in TabItems.OfType<BaseTabToggle>()
			orderby tab.SortOrder
			select tab).ToArray();
		TabItems.CollectionChanged -= OnTabItemsChanged;
		try
		{
			for (int num = 0; num < array.Length; num++)
			{
				BaseTabToggle baseTabToggle = array[num];
				int num2 = TabItems.IndexOf(baseTabToggle);
				if (num2 >= 0 && num2 != num)
				{
					TabItems.Move(num2, num);
				}
				baseTabToggle.transform.SetSiblingIndex(num);
				if (baseTabToggle.Content is BaseTabContent baseTabContent)
				{
					baseTabContent.transform.SetSiblingIndex(num);
				}
			}
		}
		finally
		{
			TabItems.CollectionChanged += OnTabItemsChanged;
		}
	}

	private void RegisterTab(BaseTabToggle tabToggle)
	{
		if (_registeredTabs.Add(tabToggle))
		{
			tabToggle.OnTabActiveCallback = (Action<BaseTabToggle>)Delegate.Combine(tabToggle.OnTabActiveCallback, new Action<BaseTabToggle>(OnSingleTabActive));
			tabToggle.OnTabDeActiveCallback = (Action<BaseTabToggle>)Delegate.Combine(tabToggle.OnTabDeActiveCallback, new Action<BaseTabToggle>(OnSingleTabDeActive));
		}
	}

	private void UnRegisterTab(BaseTabToggle tabToggle)
	{
		if (_registeredTabs.Remove(tabToggle))
		{
			tabToggle.OnTabActiveCallback = (Action<BaseTabToggle>)Delegate.Remove(tabToggle.OnTabActiveCallback, new Action<BaseTabToggle>(OnSingleTabActive));
			tabToggle.OnTabDeActiveCallback = (Action<BaseTabToggle>)Delegate.Remove(tabToggle.OnTabDeActiveCallback, new Action<BaseTabToggle>(OnSingleTabDeActive));
		}
	}

	private void UnRegisterAllTabs()
	{
		foreach (BaseTabToggle registeredTab in _registeredTabs)
		{
			registeredTab.OnTabActiveCallback = (Action<BaseTabToggle>)Delegate.Remove(registeredTab.OnTabActiveCallback, new Action<BaseTabToggle>(OnSingleTabActive));
			registeredTab.OnTabDeActiveCallback = (Action<BaseTabToggle>)Delegate.Remove(registeredTab.OnTabDeActiveCallback, new Action<BaseTabToggle>(OnSingleTabDeActive));
		}
		_registeredTabs.Clear();
	}

	private void OnSingleTabActive(BaseTabToggle tabToggle)
	{
		try
		{
			OnTabActive?.Invoke(tabToggle);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private void OnSingleTabDeActive(BaseTabToggle tabToggle)
	{
		try
		{
			OnTabDeActive?.Invoke(tabToggle);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private int GetRegisteredToggleIndex(ActToggle toggle)
	{
		int toggleCount = _group.ToggleCount;
		for (int i = 0; i < toggleCount; i++)
		{
			if (_group.GetToggleByIndex(i) == toggle)
			{
				return i;
			}
		}
		return -1;
	}
}

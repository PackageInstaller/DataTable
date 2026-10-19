using System;
using ACT.Model;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class InventoryFilterCell : ActToggle, ILoopScrollDataSource
{
	[SerializeField]
	private LocalizeStringEvent _name;

	[SerializeField]
	private LocalizeStringEvent _disableName;

	public FilterType FilterType;

	public int Value;

	private int m_LoopIndex;

	public Action<int> OnToggleOn;

	public Action<int> OnToggleOff;

	private CanvasGroup _canvasGroup;

	private LayoutElement _layoutElement;

	public void UpdateName(string table, int id)
	{
		_name.SetTable(table);
		_name.StringReference.TableEntryReference = id;
		_disableName.SetTable(table);
		_disableName.StringReference.TableEntryReference = id;
	}

	protected override void Awake()
	{
		base.Awake();
		AddListener();
		_canvasGroup = GetComponent<CanvasGroup>();
		_layoutElement = GetComponent<LayoutElement>();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		RemoveListener();
	}

	private void AddListener()
	{
		onToggleClick.AddListener(OnClick);
		onToggleOn.AddListener(OnToggleOnInternal);
		onToggleOff.AddListener(OnToggleOffInternal);
	}

	private void RemoveListener()
	{
		onToggleClick.RemoveListener(OnClick);
		onToggleOn.RemoveListener(OnToggleOnInternal);
		onToggleOff.RemoveListener(OnToggleOffInternal);
	}

	private void OnClick()
	{
		SetIsOn(!IsOn);
	}

	private void OnToggleOnInternal()
	{
		OnToggleOn?.Invoke(m_LoopIndex);
	}

	private void OnToggleOffInternal()
	{
		OnToggleOff?.Invoke(m_LoopIndex);
	}

	public void ScrollCellIndex(int idx)
	{
		m_LoopIndex = idx;
	}

	public void OnLoad(int idx)
	{
		m_LoopIndex = idx;
	}

	public void OnShow()
	{
		gameObject.SetActive(value: true);
		if ((bool)_canvasGroup)
		{
			_canvasGroup.alpha = 1f;
			_canvasGroup.interactable = true;
			_canvasGroup.blocksRaycasts = true;
			_layoutElement.ignoreLayout = false;
		}
	}

	public void OnHide()
	{
		if ((bool)_canvasGroup)
		{
			_canvasGroup.alpha = 0f;
			_canvasGroup.interactable = false;
			_canvasGroup.blocksRaycasts = false;
			_layoutElement.ignoreLayout = true;
		}
		else
		{
			gameObject.SetActive(value: false);
		}
	}

	public void OnUnLoad()
	{
	}

	public void PlayCustomAnimation(float delaySecond = 0f)
	{
		BetterAnimation component = GetComponent<BetterAnimation>();
		if (!(component == null))
		{
			component.GetSequence("Show")?.Goto(0f).SetDelay(delaySecond).Play();
		}
	}

	public int GetIndex()
	{
		return m_LoopIndex;
	}
}

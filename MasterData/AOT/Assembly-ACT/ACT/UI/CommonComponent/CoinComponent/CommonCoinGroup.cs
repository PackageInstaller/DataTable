using System;
using System.Collections.Generic;
using ACT.UI.InputController.CoinComponentInputController;
using ACT.ViewControl;
using Fundamental;
using Runtime.UI.CommonComponent;
using UnityEngine;

namespace ACT.UI.CommonComponent.CoinComponent;

[RequireComponent(typeof(ViewControlLayer))]
public class CommonCoinGroup : SubUIView<CoinComponentInputController>, IUIFrameElement
{
	private static readonly ObjectPool<Stack<CommonCoinComponent>> s_CoinComponentPool = new ObjectPool<Stack<CommonCoinComponent>>(null, (Stack<CommonCoinComponent> x) =>
	{
		x.Clear();
	});

	public CommonCoinComponent template;

	public List<CoinComponentConfig> configs;

	public OperateBtnPrompt prompt;

	[NonSerialized]
	public List<CommonCoinComponent> CoinComponents = new List<CommonCoinComponent>();

	private Stack<CommonCoinComponent> m_CoinComponentPool;

	private readonly List<CommonCoinComponent> m_DefaultCoinComponents = new List<CommonCoinComponent>();

	private readonly List<CommonCoinComponent> m_RuntimeCoinComponents = new List<CommonCoinComponent>();

	public bool IsOperating { get; set; }

	public void Initialize()
	{
		CollectDefaultCoinComponents();
		List<CoinComponentConfig> list = configs;
		if (list != null && list.Count > 0)
		{
			RefreshCoinComponents();
		}
		else
		{
			ShowDefaultCoinComponents();
		}
		FocusIn();
		IsOperating = false;
	}

	public void UnInitialize()
	{
		ReturnRuntimeCoinComponents();
		if (m_CoinComponentPool != null)
		{
			s_CoinComponentPool.Release(m_CoinComponentPool);
			m_CoinComponentPool = null;
		}
		IsOperating = false;
	}

	public void RefreshCoinComponents(params CoinComponentConfig[] coinConfigs)
	{
		RefreshCoinComponents((IEnumerable<CoinComponentConfig>)coinConfigs);
	}

	public void RefreshCoinComponents(IEnumerable<CoinComponentConfig> coinConfigs)
	{
		if (configs == null)
		{
			configs = new List<CoinComponentConfig>();
		}
		configs.Clear();
		if (coinConfigs != null)
		{
			configs.AddRange(coinConfigs);
		}
		RefreshCoinComponents();
	}

	private void CollectDefaultCoinComponents()
	{
		m_DefaultCoinComponents.Clear();
		GetComponentsInChildren(includeInactive: true, m_DefaultCoinComponents);
		m_DefaultCoinComponents.Remove(template);
	}

	private void ShowDefaultCoinComponents()
	{
		ReturnRuntimeCoinComponents();
		CoinComponents.Clear();
		if ((bool)template && template.transform.IsChildOf(transform))
		{
			template.gameObject.SetActive(value: false);
		}
		for (int i = 0; i < m_DefaultCoinComponents.Count; i++)
		{
			CommonCoinComponent commonCoinComponent = m_DefaultCoinComponents[i];
			if ((bool)commonCoinComponent)
			{
				commonCoinComponent.gameObject.SetActive(value: true);
				CoinComponents.Add(commonCoinComponent);
			}
		}
	}

	private void HideDefaultCoinComponents()
	{
		for (int i = 0; i < m_DefaultCoinComponents.Count; i++)
		{
			CommonCoinComponent commonCoinComponent = m_DefaultCoinComponents[i];
			if ((bool)commonCoinComponent)
			{
				commonCoinComponent.gameObject.SetActive(value: false);
			}
		}
	}

	private void RefreshCoinComponents()
	{
		ReturnRuntimeCoinComponents();
		if (configs == null)
		{
			ShowDefaultCoinComponents();
			return;
		}
		if (configs.Count == 0)
		{
			ShowDefaultCoinComponents();
			return;
		}
		if (template == null)
		{
			Debug.LogError("CoinComponent template is null, cannot refresh coin components");
			ShowDefaultCoinComponents();
			return;
		}
		HideDefaultCoinComponents();
		CoinComponents.Clear();
		foreach (CoinComponentConfig config in configs)
		{
			if ((bool)template)
			{
				if (template.transform.IsChildOf(transform))
				{
					template.gameObject.SetActive(value: false);
				}
				CommonCoinComponent coinComponent = GetCoinComponent();
				coinComponent.transform.SetParent(transform, worldPositionStays: false);
				coinComponent.transform.SetAsLastSibling();
				coinComponent.gameObject.SetActive(value: true);
				coinComponent.InitData(config.itemId, isBagItem: true);
				coinComponent.Initialize();
				coinComponent.supplementBtn?.gameObject.SetActive(config.hasPlusButton);
				CoinComponents.Add(coinComponent);
				m_RuntimeCoinComponents.Add(coinComponent);
			}
		}
	}

	private CommonCoinComponent GetCoinComponent()
	{
		EnsureCoinComponentPool();
		if (m_CoinComponentPool.Count <= 0)
		{
			return UnityEngine.Object.Instantiate(template, transform);
		}
		return m_CoinComponentPool.Pop();
	}

	private void EnsureCoinComponentPool()
	{
		if (m_CoinComponentPool == null)
		{
			m_CoinComponentPool = s_CoinComponentPool.Get();
		}
	}

	private void ReturnRuntimeCoinComponents()
	{
		EnsureCoinComponentPool();
		for (int i = 0; i < m_RuntimeCoinComponents.Count; i++)
		{
			CommonCoinComponent commonCoinComponent = m_RuntimeCoinComponents[i];
			if ((bool)commonCoinComponent)
			{
				commonCoinComponent.gameObject.SetActive(value: false);
				commonCoinComponent.transform.SetParent(transform, worldPositionStays: false);
				m_CoinComponentPool.Push(commonCoinComponent);
			}
		}
		m_RuntimeCoinComponents.Clear();
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		prompt?.SetVisible(vis: true);
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		prompt?.SetVisible(vis: false);
	}
}

using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.UI.InputController;
using ACT.ViewControl;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipBuffView : BaseUIView<EquipBuffViewInputController>
{
	private EquipBuffViewData m_data;

	[Header("左侧")]
	[SerializeField]
	private Transform m_TabContentRoot;

	[SerializeField]
	private GameObject m_TabTemplate;

	[Header("右侧")]
	[Header("右上侧")]
	[SerializeField]
	private BImage m_BuffIcon;

	[SerializeField]
	private LocalizeStringEvent m_BuffName;

	[Header("右下侧")]
	[SerializeField]
	private Transform m_LevelContentRoot;

	[SerializeField]
	private GameObject m_levelDescriptionTemplate;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	[SerializeField]
	private ViewControlRoot m_ViewControlRoot;

	[SerializeField]
	private ViewControlLayer m_ViewControlLayer;

	public ScrollRect ActiveDescScrollRect;

	public RightStickScrollSupport RightStickScrollSupport;

	private int m_CurrBuffIndex;

	private static ObjectPool<Stack<GameObject>> m_TabPool = new ObjectPool<Stack<GameObject>>((Stack<GameObject> x) =>
	{
		x.Clear();
	}, null);

	private static ObjectPool<Stack<GameObject>> m_LevelPool = new ObjectPool<Stack<GameObject>>((Stack<GameObject> x) =>
	{
		x.Clear();
	}, null);

	private Stack<GameObject> m_TabObjectPool;

	private Stack<GameObject> m_LevelObjectPool;

	private ContinuousNavigateData m_NavigateData;

	private bool m_canRightStickScroll = true;

	public List<EquipBuffItemData> buffInfos => m_data.buffInfos;

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		if (m_ViewControlRoot != null && !m_ViewControlRoot.ReFocus())
		{
			m_ViewControlLayer?.Focus();
		}
	}

	private void Awake()
	{
		m_TabObjectPool = m_TabPool.Get();
		m_LevelObjectPool = m_LevelPool.Get();
	}

	private void OnDestroy()
	{
		m_TabPool.Release(m_TabObjectPool);
		m_TabObjectPool = null;
		m_LevelPool.Release(m_LevelObjectPool);
		m_LevelObjectPool = null;
	}

	private void UpdateRightPart()
	{
		EquipBuffItemData equipBuffItemData = buffInfos[m_CurrBuffIndex];
		EquipFeatureData data = CoreUtils.GetData(equipBuffItemData.id, RuntimeConfigs.data.equipFeatureDatas);
		Station.LoadImage(130, data.icon, m_BuffIcon);
		m_BuffName.StringReference.TableEntryReference = CoreUtils.GetEquipFeatureNameLocalId(data);
		ReturnLevelObjects();
		int maxLv = data.maxLv;
		for (int i = 1; i <= maxLv; i++)
		{
			GameObject gameObject = ((m_LevelObjectPool.Count > 0) ? m_LevelObjectPool.Pop() : UnityEngine.Object.Instantiate(m_levelDescriptionTemplate, m_LevelContentRoot));
			gameObject.transform.SetParent(m_LevelContentRoot, worldPositionStays: false);
			EquipFeatureLevelInfo component = gameObject.GetComponent<EquipFeatureLevelInfo>();
			int skillGroupLevelId = TableRule.GetSkillGroupLevelId(data.skillGroupData, i);
			component.Init(skillGroupLevelId, i, !m_data.hideCurrentLevel && Mathf.Min(equipBuffItemData.Num, maxLv) == i);
			gameObject.SetActive(value: true);
		}
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	private void UpdateLeftPart()
	{
		for (int i = 0; i < buffInfos.Count; i++)
		{
			GameObject gameObject = ((m_TabObjectPool.Count > 0) ? m_TabObjectPool.Pop() : UnityEngine.Object.Instantiate(m_TabTemplate, m_TabContentRoot));
			gameObject.transform.SetParent(m_TabContentRoot, worldPositionStays: false);
			EquipFeatureTab component = gameObject.GetComponent<EquipFeatureTab>();
			component.Station = Station;
			component.Init(buffInfos[i].id, buffInfos[i].Num, i == 0, m_data.hideCurrentLevel);
			int i2 = i;
			component.OnSelect = null;
			component.OnSelect = (Action)Delegate.Combine(component.OnSelect, (Action)(() =>
			{
				m_CurrBuffIndex = i2;
				UpdateRightPart();
			}));
			gameObject.SetActive(transform);
		}
	}

	private void PlayTabsAnimation()
	{
		int childCount = m_TabContentRoot.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = m_TabContentRoot.GetChild(i);
			if (child.gameObject.activeInHierarchy)
			{
				EquipFeatureTab component = child.GetComponent<EquipFeatureTab>();
				if ((bool)component)
				{
					component.GetComponent<BetterAnimation>().GetSequence(component.m_ToggleComp.IsOn ? "EnterShow" : "NormalShow").SetDelay(0.03f * (float)i)
						.Play();
				}
			}
		}
	}

	private void ReturnLevelObjects()
	{
		for (int num = m_LevelContentRoot.childCount - 1; num >= 0; num--)
		{
			Transform child = m_LevelContentRoot.GetChild(num);
			m_LevelObjectPool.Push(child.gameObject);
			child.SetParent(m_LevelContentRoot.parent);
			child.GetComponent<EquipFeatureLevelInfo>().UnInit();
		}
	}

	private void ReturnTabObjects()
	{
		for (int num = m_TabContentRoot.childCount - 1; num >= 0; num--)
		{
			Transform child = m_TabContentRoot.GetChild(num);
			m_TabObjectPool.Push(child.gameObject);
			child.SetParent(m_TabContentRoot.parent);
			child.gameObject.SetActive(value: false);
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		OnGamePadInit();
		m_data = uiViewData as EquipBuffViewData;
		if (m_data == null)
		{
			return;
		}
		m_CurrBuffIndex = 0;
		if (!m_data.hideCurrentLevel)
		{
			m_data.buffInfos = m_data.buffInfos.Where((EquipBuffItemData x) => x.Num > 0).ToList();
		}
		UpdateLeftPart();
		UpdateRightPart();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		m_ViewControlLayer.Focus();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play();
		PlayTabsAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		m_data?.closeAction?.Invoke();
		ReturnTabObjects();
		ReturnLevelObjects();
		m_NavigateData?.Reset();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Popup_Close");
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect activeDescScrollRect = ActiveDescScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (rightStickScrollSupport == null || activeDescScrollRect == null)
		{
			m_canRightStickScroll = activeDescScrollRect != null && activeDescScrollRect.content != null && activeDescScrollRect.viewport != null && activeDescScrollRect.content.rect.height > activeDescScrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (activeDescScrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(activeDescScrollRect.content);
		}
		bool flag = activeDescScrollRect.content != null && activeDescScrollRect.viewport != null && activeDescScrollRect.content.rect.height > activeDescScrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void OnNavigate(Vector2 value)
	{
		if (EventSystemHelper.CurrentSelected != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref m_NavigateData, ExecuteNavigate);
		}
		else if (!m_ViewControlRoot.ReFocus())
		{
			m_ViewControlLayer.Focus();
		}
	}

	public void ExecuteNavigate(MoveDirection dir)
	{
		if (m_ViewControlRoot == null)
		{
			return;
		}
		switch (dir)
		{
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/RSUpDownSelect"] = new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadGroup == null) && _allInputPrompt != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			if (m_canRightStickScroll)
			{
				_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
			}
			gamePadGroup.RegisterInputActions(_tipsActions);
		}
	}

	public void OnScrollbarNavigate(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect activeDescScrollRect = ActiveDescScrollRect;
			if (!(activeDescScrollRect == null))
			{
				activeDescScrollRect.velocity = new Vector2(0f, value.y * ActiveDescScrollRect.scrollSensitivity);
			}
		}
	}
}

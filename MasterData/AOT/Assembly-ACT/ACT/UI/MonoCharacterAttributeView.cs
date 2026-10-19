using System;
using System.Collections.Generic;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoCharacterAttributeView : BaseUIView<MonoCharacterAttributeViewInputController>
{
	[Flags]
	public enum AttributeType
	{
		All = 7,
		Character = 1,
		Equip = 2,
		Elite = 4
	}

	public class AttributeData : UIViewData
	{
		public Character character;

		public AttributeType displayType = AttributeType.All;
	}

	public AttributeData attributeData;

	public GameObject prefab;

	public ActButton BtnClose;

	public Transform BaseRoot;

	public Transform AdvanceRoot;

	public Transform ElementRoot;

	[SerializeField]
	public ScrollRect ActiveDescScrollRect;

	[SerializeField]
	public RightStickScrollSupport RightStickScrollSupport;

	public GamePadTipsComp gamePadGroup;

	private List<GameObject> m_ObjList = new List<GameObject>();

	private Character m_Character;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private bool m_canRightStickScroll = true;

	protected override async void PlayOpenAnimation()
	{
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override async void PlayCloseAnimation()
	{
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void Init()
	{
		base.Init();
		OnGamePadInit();
		BtnClose.SetBtnClick(Close, "event:/UI/Common/List_Close");
		attributeData = (AttributeData)uiViewData;
		m_Character = attributeData.character;
		SetAttribute();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	private void SetAttribute()
	{
		Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
		Dictionary<int, float> properties2 = DictionaryPool<int, float>.Get();
		if (m_Character == null)
		{
			DictionaryPool<int, float>.Release(properties);
			DictionaryPool<int, float>.Release(properties2);
			return;
		}
		m_Character.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.Equip, ref properties);
		m_Character.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.LevelUp, ref properties2);
		int num = 0;
		foreach (PropertyData value3 in RuntimeConfigs.data.propertyDatas.Values)
		{
			PropertyTypeData data = CoreUtils.GetData(value3.propertyId, RuntimeConfigs.data.propertyTypeDatas);
			if (data != null && data.uiShow != 0)
			{
				num++;
				GameObject gameObject = null;
				Transform parent = null;
				switch (data.type)
				{
				case 1:
					parent = BaseRoot;
					break;
				case 2:
					parent = AdvanceRoot;
					break;
				case 3:
					parent = ElementRoot;
					break;
				}
				if (m_ObjList.Count < num)
				{
					gameObject = UnityEngine.Object.Instantiate(prefab, parent);
					gameObject.SetActive(value: true);
					m_ObjList.Add(gameObject);
				}
				else
				{
					gameObject = m_ObjList[num - 1];
					gameObject.transform.parent = parent;
				}
				CharacterAttributePropertyCell component = gameObject.GetComponent<CharacterAttributePropertyCell>();
				component.Station = Station;
				properties.TryGetValue(value3.id, out var value);
				properties2.TryGetValue(value3.id, out var value2);
				if (attributeData.displayType == AttributeType.All)
				{
					component.Init(value3.id, value2, value);
				}
				else
				{
					component.Init(value3.id, value);
				}
			}
		}
		DictionaryPool<int, float>.Release(properties);
		DictionaryPool<int, float>.Release(properties2);
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>();
		_allInputPrompt["UI/Back"] = new GamePadTipsAction
		{
			inputAction = "UI/Back",
			localizeKey = 606,
			localizeTable = "Common"
		};
		_allInputPrompt["UI/RSUpDownSelect"] = new GamePadTipsAction
		{
			inputAction = "UI/RSUpDownSelect",
			localizeKey = 2165,
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

	public void OnGamePadClose()
	{
		Close();
	}

	public void OnScrollbarNavigate(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect activeDescScrollRect = ActiveDescScrollRect;
			if (!(activeDescScrollRect == null))
			{
				activeDescScrollRect.velocity = new Vector2(0f, value.y * activeDescScrollRect.scrollSensitivity);
			}
		}
	}
}

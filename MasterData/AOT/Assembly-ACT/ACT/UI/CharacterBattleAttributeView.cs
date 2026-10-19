using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI.InputController.CharacterBattleAttributeView;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.ECS;
using Fundamental;
using Runtime.Utility;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class CharacterBattleAttributeView : BaseUIView<CharacterBattleAttributeViewInputController>
{
	[NonSerialized]
	public AttributeData attributeData;

	public GameObject prefab;

	public ActButton BtnClose;

	public Transform BaseRoot;

	public Transform AdvanceRoot;

	public Transform ElementRoot;

	public ScrollRect ScrollRect;

	public GamePadTipsComp gamePadGroup;

	public ViewControlLayer viewControlLayer;

	public RightStickScrollSupport RightStickScrollSupport;

	private List<GameObject> m_ObjList = new List<GameObject>();

	private Character m_Character;

	private int baseIndex = 1;

	private int advanceIndex = 2;

	private int elementIndex = 3;

	private bool m_canRightStickScroll = true;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

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
		BtnClose.SetBtnClick(Close, "event:/UI/Common/List_Close");
		attributeData = (AttributeData)uiViewData;
		m_Character = attributeData.character;
		SetAttribute();
		OnGamePadInit();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
		viewControlLayer.Focus();
	}

	protected override void UnInit()
	{
		base.UnInit();
		viewControlLayer.UnFocus();
	}

	private void SetAttribute()
	{
		bool isTrailCharacter = m_Character.IsTrailCharacter;
		CompAbility compAbility = (EntityHelper.TryGetBattleEntityByCharacter(m_Character, out var entity) ? entity.GetCompAbility() : null);
		bool flag = entity.IsLogicAvailable();
		Dictionary<int, float> getProperty = m_Character.GetProperty;
		Dictionary<int, int> dictionary = DictionaryPool<int, int>.Get();
		foreach (PropertyData value in RuntimeConfigs.data.propertyDatas.Values)
		{
			if (!dictionary.ContainsKey(value.propertyId))
			{
				dictionary.Add(value.propertyId, 1);
			}
			else
			{
				dictionary[value.propertyId]++;
			}
		}
		List<KeyValuePair<int, float>> list = ListPool<KeyValuePair<int, float>>.Get();
		foreach (KeyValuePair<int, float> item in getProperty)
		{
			list.Add(item);
		}
		list.Sort(CompareCharacterPropertyBySort);
		List<int> list2 = ListPool<int>.Get();
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		foreach (KeyValuePair<int, float> item2 in list)
		{
			PropertyData data = CoreUtils.GetData(item2.Key, RuntimeConfigs.data.propertyDatas);
			if (data == null)
			{
				continue;
			}
			int propertyId = data.propertyId;
			if (list2.Contains(propertyId))
			{
				continue;
			}
			list2.Add(propertyId);
			PropertyTypeData data2 = CoreUtils.GetData(propertyId, RuntimeConfigs.data.propertyTypeDatas);
			if (data2 == null || data2.uiShow == 0)
			{
				continue;
			}
			num++;
			GameObject gameObject = null;
			Transform parent = null;
			switch (data2.type)
			{
			case 1:
				parent = BaseRoot;
				num2++;
				break;
			case 2:
				parent = AdvanceRoot;
				num3++;
				break;
			case 3:
				parent = ElementRoot;
				num4++;
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
				gameObject.transform.SetParent(parent, worldPositionStays: false);
			}
			gameObject.transform.SetAsLastSibling();
			float num5 = (flag ? compAbility.GetProperty((uint)propertyId).PracticalValue : m_Character.systemProperty.GetResultPropertyValue(propertyId));
			float baseResultPropertyValue = m_Character.systemProperty.GetBaseResultPropertyValue(propertyId);
			PropertyCell component = gameObject.GetComponent<PropertyCell>();
			if (isTrailCharacter)
			{
				float num6 = num5;
				string num7 = (data.judge ? GameUtility.TopercentageMathfFloor(num6, 1) : Mathf.FloorToInt(num6).ToString());
				component.InitInNumNeedIcon(data, data2.propertyDescId, Station, num7);
				if (data2.type == baseIndex)
				{
					component.InitBoard(num2 % 2 == 1);
				}
				else if (data2.type == advanceIndex)
				{
					component.InitBoard(num3 % 2 == 1);
				}
				else if (data2.type == elementIndex)
				{
					component.InitBoard(num4 % 2 == 1);
				}
				continue;
			}
			float num8 = num5 - baseResultPropertyValue;
			string text = baseResultPropertyValue.ToString();
			string text2 = num8.ToString();
			if (num8 == 0f || dictionary[propertyId] == 1)
			{
				text = (data.judge ? GameUtility.TopercentageMathfFloor(num5, 1) : Mathf.FloorToInt(num5).ToString());
				component.InitInNumNeedIcon(data, data2.propertyDescId, Station, text);
			}
			else
			{
				float num9 = baseResultPropertyValue;
				num8 = num5 - num9;
				if (data.judge)
				{
					text = GameUtility.TopercentageMathfFloor(num9, 1);
					text2 = GameUtility.TopercentageMathfFloor(num8, 1);
				}
				else
				{
					int num10 = Mathf.FloorToInt(num9);
					int num11 = Mathf.FloorToInt(num5 - (float)num10);
					text = num10.ToString();
					text2 = num11.ToString();
				}
				if (text2 != "0")
				{
					component.InitInNumNeedIcon(data, data2.propertyDescId, Station, text, text2, isAdd: true);
				}
				else
				{
					component.InitInNumNeedIcon(data, data2.propertyDescId, Station, text);
				}
			}
			if (data2.type == baseIndex)
			{
				component.InitBoard(num2 % 2 == 1);
			}
			else if (data2.type == advanceIndex)
			{
				component.InitBoard(num3 % 2 == 1);
			}
			else if (data2.type == elementIndex)
			{
				component.InitBoard(num4 % 2 == 1);
			}
		}
		ListPool<int>.Release(list2);
		DictionaryPool<int, int>.Release(dictionary);
		ListPool<KeyValuePair<int, float>>.Release(list);
	}

	private static int CompareCharacterPropertyBySort(KeyValuePair<int, float> left, KeyValuePair<int, float> right)
	{
		int num = GetPropertyDataSort(left.Key).CompareTo(GetPropertyDataSort(right.Key));
		if (num == 0)
		{
			return left.Key.CompareTo(right.Key);
		}
		return num;
	}

	private static int GetPropertyDataSort(int propertyDataId)
	{
		Dictionary<int, PropertyData> propertyDatas = RuntimeConfigs.data.propertyDatas;
		if (propertyDatas != null && propertyDatas.TryGetValue(propertyDataId, out var value) && value != null)
		{
			return value.sort;
		}
		return int.MaxValue;
	}

	private void RefreshRightStickScrollForbid()
	{
		ScrollRect scrollRect = ScrollRect;
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		if (rightStickScrollSupport == null || scrollRect == null)
		{
			m_canRightStickScroll = scrollRect != null && scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (scrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(scrollRect.content);
		}
		bool flag = scrollRect.content != null && scrollRect.viewport != null && scrollRect.content.rect.height > scrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect scrollRect = ScrollRect;
			if (!(scrollRect == null))
			{
				scrollRect.velocity = new Vector2(0f, value.y * scrollRect.scrollSensitivity);
			}
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
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

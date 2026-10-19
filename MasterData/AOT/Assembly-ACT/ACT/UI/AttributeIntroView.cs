using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AttributeIntroView : BaseUIView<AttributeIntroViewInputController>
{
	[SerializeField]
	private AttributeIntroCell m_AttributeTemplate;

	[SerializeField]
	private GridLayoutGroup m_GridLayoutRoot;

	[SerializeField]
	private ScrollRect ActiveDescScrollRect;

	[SerializeField]
	private RightStickScrollSupport RightStickScrollSupport;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private bool m_canRightStickScroll = true;

	private List<AttributeIntroCell> m_children;

	private AttributeIntroViewData m_data => uiViewData as AttributeIntroViewData;

	private void Awake()
	{
		m_children = ListPool<AttributeIntroCell>.Get();
	}

	protected override void OnUnityDestroy()
	{
		foreach (AttributeIntroCell child in m_children)
		{
			Object.Destroy(child.gameObject);
		}
		m_children.Clear();
		ListPool<AttributeIntroCell>.Release(m_children);
		m_children = null;
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
		int index = 0;
		HashSet<int> hashSet = HashSetPool<int>.Get();
		try
		{
			AttributeIntroViewData data = m_data;
			if (data != null && data.EquipId != 0)
			{
				EquipData data2 = CoreUtils.GetData(data.EquipId, RuntimeConfigs.data.equipDatas);
				if (data2 != null && data2.fixEquipAttrId != 0)
				{
					EquipAttrData data3 = CoreUtils.GetData(data2.fixEquipAttrId, RuntimeConfigs.data.equipAttrDatas);
					if (data3 != null)
					{
						int attrGroup = data3.attrGroup;
						AddEquipAttrGroup(data2.ranEquipAttrGroupAId, attrGroup, hashSet, ref index);
						AddEquipAttrGroup(data2.ranEquipAttrGroupBId, attrGroup, hashSet, ref index);
					}
				}
			}
		}
		finally
		{
			HashSetPool<int>.Release(hashSet);
		}
		for (int i = index; i < m_children.Count; i++)
		{
			m_children[i].gameObject.SetActive(value: false);
		}
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
	}

	private void AddEquipAttrGroup(int groupId, int mainAttrGroup, HashSet<int> handledAttrIds, ref int index)
	{
		if (groupId == 0)
		{
			return;
		}
		EquipAttrGroupData data = CoreUtils.GetData(groupId, RuntimeConfigs.data.equipAttrGroupDatas);
		if (data?.equipAttrList == null)
		{
			return;
		}
		foreach (ItemKv equipAttr in data.equipAttrList)
		{
			if (equipAttr.id != 0)
			{
				EquipAttrData data2 = CoreUtils.GetData(equipAttr.id, RuntimeConfigs.data.equipAttrDatas);
				if (data2 != null && (mainAttrGroup == 0 || data2.attrGroup == mainAttrGroup || data2.attrGroup == 0))
				{
					AddAttributeCell(data2.attrId, handledAttrIds, ref index);
				}
			}
		}
	}

	private void AddAttributeCell(int attrId, HashSet<int> handledAttrIds, ref int index)
	{
		if (handledAttrIds.Add(attrId))
		{
			AttributeIntroCell attributeIntroCell = null;
			if (index < m_children.Count)
			{
				attributeIntroCell = m_children[index];
			}
			else
			{
				attributeIntroCell = Object.Instantiate(m_AttributeTemplate, m_GridLayoutRoot.transform);
				m_children.Add(attributeIntroCell);
			}
			attributeIntroCell.gameObject.SetActive(value: true);
			attributeIntroCell.Init(attrId, Station);
			index++;
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
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
				activeDescScrollRect.velocity = new Vector2(0f, value.y * ActiveDescScrollRect.scrollSensitivity);
			}
		}
	}
}

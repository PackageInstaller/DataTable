using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class GemItemDetail : BaseUIComponent
{
	[Serializable]
	private struct Style
	{
		public GameObject styleRoot;
	}

	[Header("样式")]
	[SerializeField]
	private Style[] m_Styles;

	[Header("锁组件")]
	[SerializeField]
	private EquipGemIsLockBtn m_LockComp;

	[Header("角色已装备头像")]
	[SerializeField]
	private CommonCharacterEquipComponent m_CommonCharacterEquipComponent;

	[Header("文本")]
	[SerializeField]
	private LocalizeStringEvent m_MainTitle;

	[SerializeField]
	private GameObject m_BuffLevelTemplate;

	[SerializeField]
	private Transform m_BuffLevelRoot;

	[Header("BuffItem")]
	[SerializeField]
	private EquipBuffItem m_EquipBuffItem;

	private ImageAssetStation m_Station;

	private Gem m_Context;

	private EquipGemData m_GemData;

	private ItemData m_ItemData;

	private static ObjectPool<Stack<GameObject>> m_LevelPool = new ObjectPool<Stack<GameObject>>((Stack<GameObject> x) =>
	{
		x.Clear();
	}, null);

	private Stack<GameObject> m_LevelObjectPool;

	private readonly List<EquipBuffItem> m_BuffItems = new List<EquipBuffItem>();

	private const string GemDescriptionNodeName = "gemDesc";

	public override ImageAssetStation Station
	{
		get
		{
			return m_Station;
		}
		set
		{
			m_Station = value;
			if ((bool)m_CommonCharacterEquipComponent)
			{
				m_CommonCharacterEquipComponent.Station = value;
			}
		}
	}

	public new Gem Context
	{
		get
		{
			return m_Context;
		}
		set
		{
			m_Context = value;
			UpdateData();
			UpdateStyle();
			UpdateText();
			UpdateBuffItem();
			UpdateBuffLevel();
		}
	}

	private void Awake()
	{
		m_LevelObjectPool = m_LevelPool.Get();
	}

	protected override void OnUnityDestroy()
	{
		m_LevelPool.Release(m_LevelObjectPool);
		m_LevelObjectPool = null;
	}

	private void UpdateData()
	{
		if (Context == null)
		{
			m_GemData = null;
			m_ItemData = null;
		}
		else
		{
			m_GemData = CoreUtils.GetData(Context.Id, RuntimeConfigs.data.equipGemDatas);
			m_ItemData = CoreUtils.GetData(Context.Id, RuntimeConfigs.data.itemDatas);
		}
	}

	private void UpdateStyle()
	{
		if (Context == null)
		{
			for (int i = 0; i < m_Styles.Length; i++)
			{
				m_Styles[i].styleRoot.SetActive(value: false);
			}
			m_LockComp?.gameObject.SetActive(value: false);
			if ((bool)m_CommonCharacterEquipComponent)
			{
				m_CommonCharacterEquipComponent.Character = null;
			}
			return;
		}
		for (int j = 0; j < m_Styles.Length; j++)
		{
			m_Styles[j].styleRoot.SetActive(j == Context.GetQuality() - 3);
		}
		m_LockComp?.gameObject.SetActive(value: false);
		Character character = GameUtility.FindEquipEquipCharacter(Context.InlayEquip);
		if ((bool)m_CommonCharacterEquipComponent)
		{
			m_CommonCharacterEquipComponent.Character = character;
		}
	}

	private void UpdateText()
	{
		m_MainTitle.StringReference.TableEntryReference = m_ItemData?.nameLocal ?? 0;
	}

	private void UpdateBuffItem()
	{
		EquipGemData gemData = m_GemData;
		HideExtraBuffItems();
		if (Context == null || gemData == null || gemData.equipFeature == null || gemData.equipFeature.Count == 0)
		{
			m_EquipBuffItem.gameObject.SetActive(value: false);
			return;
		}
		m_EquipBuffItem.gameObject.SetActive(value: true);
		Context.Refresh();
		List<int> list = ListPool<int>.Get();
		Context.GetAllFeatureIDs(list);
		for (int i = 0; i < gemData.equipFeature.Count; i++)
		{
			int id = gemData.equipFeature[i].id;
			if (!list.Contains(id))
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("试图计算一个不存在的特性？");
				}
				continue;
			}
			EquipBuffItem buffItem = GetBuffItem(i);
			if (!(buffItem == null))
			{
				buffItem.gameObject.SetActive(value: true);
				buffItem.Init(new EquipBuffItemData
				{
					id = id,
					baseNum = 0,
					ownGemChange = Context.GetFeatureData(id)
				}, EquipBuffItem.LevelSpaceItemShowMode.HaveSelect);
			}
		}
		ListPool<int>.Release(list);
	}

	private void UpdateBuffLevel()
	{
		if (m_BuffLevelRoot == null || m_BuffLevelTemplate == null)
		{
			return;
		}
		ReturnLevelObjects();
		if (Context == null || m_GemData == null || m_GemData.equipFeature == null || m_GemData.equipFeature.Count == 0)
		{
			return;
		}
		for (int i = 0; i < m_GemData.equipFeature.Count; i++)
		{
			EquipFeatureData data = CoreUtils.GetData(m_GemData.equipFeature[i].id, RuntimeConfigs.data.equipFeatureDatas);
			if (data != null)
			{
				int maxLv = data.maxLv;
				for (int j = 1; j <= maxLv; j++)
				{
					GameObject gameObject = ((m_LevelObjectPool.Count > 0) ? m_LevelObjectPool.Pop() : UnityEngine.Object.Instantiate(m_BuffLevelTemplate, m_BuffLevelRoot));
					gameObject.transform.SetParent(m_BuffLevelRoot, worldPositionStays: false);
					gameObject.GetComponent<BuffLevelInfo>().Init(j, data);
					gameObject.SetActive(value: true);
				}
			}
		}
	}

	private EquipBuffItem GetBuffItem(int index)
	{
		if (m_EquipBuffItem == null)
		{
			return null;
		}
		if (index == 0)
		{
			return m_EquipBuffItem;
		}
		while (m_BuffItems.Count < index)
		{
			EquipBuffItem equipBuffItem = UnityEngine.Object.Instantiate(m_EquipBuffItem, m_EquipBuffItem.transform.parent, worldPositionStays: false);
			HideGemDescriptionNode(equipBuffItem.transform);
			equipBuffItem.gameObject.SetActive(value: false);
			m_BuffItems.Add(equipBuffItem);
		}
		EquipBuffItem equipBuffItem2 = m_BuffItems[index - 1];
		equipBuffItem2.transform.SetSiblingIndex(m_EquipBuffItem.transform.GetSiblingIndex() + index);
		return equipBuffItem2;
	}

	private static void HideGemDescriptionNode(Transform buffItemRoot)
	{
		Transform[] componentsInChildren = buffItemRoot.GetComponentsInChildren<Transform>(includeInactive: true);
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i].name == "gemDesc")
			{
				componentsInChildren[i].gameObject.SetActive(value: false);
			}
		}
	}

	private void HideExtraBuffItems()
	{
		for (int i = 0; i < m_BuffItems.Count; i++)
		{
			m_BuffItems[i].gameObject.SetActive(value: false);
		}
	}

	private void ReturnLevelObjects()
	{
		if (!(m_BuffLevelRoot == null) && m_LevelObjectPool != null)
		{
			for (int num = m_BuffLevelRoot.childCount - 1; num >= 0; num--)
			{
				Transform child = m_BuffLevelRoot.GetChild(num);
				m_LevelObjectPool.Push(child.gameObject);
				child.SetParent(m_BuffLevelRoot.parent);
				child.gameObject.SetActive(value: false);
			}
		}
	}
}

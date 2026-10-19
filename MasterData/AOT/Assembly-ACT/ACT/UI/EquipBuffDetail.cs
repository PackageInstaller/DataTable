using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Game.Data;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace ACT.UI;

public class EquipBuffDetail : MonoBehaviour
{
	public List<EquipBuffItem> equipBuffItems;

	public GameObject buffDetailRoot;

	[FormerlySerializedAs("m_EmptyRoot")]
	[SerializeField]
	public GameObject emptyRoot;

	public LocalizeStringEvent emptyText;

	public ActButton detailBtn;

	public OperateBtnPrompt operateBtnPrompt;

	private List<EquipBuffItemData> m_BuffItemData = new List<EquipBuffItemData>();

	private void Awake()
	{
		MonoECS.instance.onInputModeChange.AddListener(SwitchInputModel);
		if ((bool)detailBtn)
		{
			detailBtn.SetBtnClick(OpenBuffDetail);
		}
	}

	private void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(SwitchInputModel);
	}

	public void Init(IFeature baseFeatures, IFeature newFeatures, Func<int, bool> shouldShow = null, bool detailRoot = true)
	{
		if (object.Equals(baseFeatures, newFeatures))
		{
			Init(baseFeatures);
			return;
		}
		m_BuffItemData.Clear();
		List<int> list = ListPool<int>.Get();
		baseFeatures.GetAllFeatureIDs(list);
		newFeatures.GetAllFeatureIDs(list);
		if (list != null && list.Count > 0)
		{
			foreach (int item2 in list)
			{
				if (shouldShow == null || shouldShow(item2))
				{
					EquipBuffItemData item = new EquipBuffItemData
					{
						id = item2,
						baseNum = baseFeatures.GetFeatureData(item2, clamp: false),
						ownEquipChange = newFeatures.GetFeatureData(item2, FeatureData.FeatureSourceType.Equip, clamp: false) - baseFeatures.GetFeatureData(item2, FeatureData.FeatureSourceType.Equip, clamp: false),
						ownGemChange = newFeatures.GetFeatureData(item2, FeatureData.FeatureSourceType.Gem, clamp: false) - baseFeatures.GetFeatureData(item2, FeatureData.FeatureSourceType.Gem, clamp: false)
					};
					m_BuffItemData.Add(item);
				}
			}
			ListPool<int>.Release(list);
		}
		m_BuffItemData.Sort((EquipBuffItemData a, EquipBuffItemData b) => b.changeNum.CompareTo(a.changeNum));
		SetBuffItem(EquipBuffItem.LevelSpaceItemShowMode.HaveSelect, detailRoot);
		if ((bool)buffDetailRoot)
		{
			GameObject gameObject = buffDetailRoot;
			List<EquipBuffItemData> buffItemData = m_BuffItemData;
			gameObject.SetActive(buffItemData != null && buffItemData.Count > 0);
		}
		if ((bool)emptyRoot)
		{
			GameObject gameObject2 = emptyRoot;
			List<EquipBuffItemData> buffItemData = m_BuffItemData;
			gameObject2.SetActive(buffItemData != null && buffItemData.Count <= 0);
		}
	}

	public void Init(params IFeature[] features)
	{
		m_BuffItemData.Clear();
		if (features != null)
		{
			foreach (IFeature feature in features)
			{
				if (feature == null)
				{
					continue;
				}
				List<int> list = ListPool<int>.Get();
				feature.GetAllFeatureIDs(list);
				if (list != null && list.Count > 0)
				{
					foreach (int featureID in list)
					{
						int num = m_BuffItemData.FindIndex((EquipBuffItemData x) => x.id == featureID);
						if (num == -1)
						{
							EquipBuffItemData item = new EquipBuffItemData
							{
								id = featureID,
								baseNum = feature.GetFeatureData(featureID, clamp: false),
								ownEquipChange = 0,
								ownGemChange = 0
							};
							m_BuffItemData.Add(item);
						}
						else
						{
							EquipBuffItemData value = m_BuffItemData[num];
							value.baseNum += feature.GetFeatureData(featureID, clamp: false);
							m_BuffItemData[num] = value;
						}
					}
				}
				ListPool<int>.Release(list);
			}
			m_BuffItemData.Sort(SortByChangeNum);
			SetBuffItem(EquipBuffItem.LevelSpaceItemShowMode.HaveSelect);
		}
		if ((bool)buffDetailRoot)
		{
			GameObject gameObject = buffDetailRoot;
			List<EquipBuffItemData> buffItemData = m_BuffItemData;
			gameObject.SetActive(buffItemData != null && buffItemData.Count > 0);
		}
		if ((bool)emptyRoot)
		{
			GameObject gameObject2 = emptyRoot;
			List<EquipBuffItemData> buffItemData = m_BuffItemData;
			gameObject2.SetActive(buffItemData != null && buffItemData.Count <= 0);
		}
	}

	public void AddLockStyle(int featureId, string lockReason)
	{
		EquipBuffItemData item = new EquipBuffItemData
		{
			id = featureId,
			lockReason = lockReason,
			baseNum = 1
		};
		m_BuffItemData.Add(item);
		int num = m_BuffItemData.Count - equipBuffItems.Count;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				EquipBuffItem item2 = UnityEngine.Object.Instantiate(equipBuffItems[0], equipBuffItems[0].transform.parent, worldPositionStays: false);
				equipBuffItems.Add(item2);
			}
		}
		for (int j = 0; j < m_BuffItemData.Count; j++)
		{
			if (m_BuffItemData[j].isLock)
			{
				equipBuffItems[j].Init(m_BuffItemData[j], EquipBuffItem.LevelSpaceItemShowMode.Lock);
				BindBuffItemClick(equipBuffItems[j]);
			}
		}
	}

	private int SortByChangeNum(EquipBuffItemData a, EquipBuffItemData b)
	{
		int num = b.changeNum.CompareTo(a.changeNum);
		if (num == 0)
		{
			num = b.baseNum.CompareTo(a.baseNum);
		}
		return num;
	}

	private void SetBuffItem(EquipBuffItem.LevelSpaceItemShowMode mode = EquipBuffItem.LevelSpaceItemShowMode.Normal, bool detailRoot = true)
	{
		if ((bool)buffDetailRoot)
		{
			buffDetailRoot.SetActive(m_BuffItemData.Count != 0);
		}
		int num = m_BuffItemData.Count - equipBuffItems.Count;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				EquipBuffItem item = UnityEngine.Object.Instantiate(equipBuffItems[0], equipBuffItems[0].transform.parent, worldPositionStays: false);
				equipBuffItems.Add(item);
			}
		}
		int j;
		for (j = 0; j < m_BuffItemData.Count; j++)
		{
			EquipBuffItemData equipBuffItemData = m_BuffItemData[j];
			if (equipBuffItemData.Num == 0 && equipBuffItemData.changeNum == 0 && equipBuffItemData.baseNum == 0)
			{
				equipBuffItems[j].gameObject.SetActive(value: false);
				continue;
			}
			equipBuffItems[j].Init(m_BuffItemData[j], mode, detailRoot);
			BindBuffItemClick(equipBuffItems[j]);
		}
		for (; j < equipBuffItems.Count; j++)
		{
			equipBuffItems[j].gameObject.SetActive(value: false);
		}
	}

	private void BindBuffItemClick(EquipBuffItem item)
	{
		if (item == null)
		{
			return;
		}
		ActButton actButton = item.GetComponent<ActButton>();
		if (actButton == null)
		{
			if (item.GetComponent<Graphic>() == null)
			{
				Image image = item.gameObject.AddComponent<Image>();
				image.color = Color.clear;
				image.raycastTarget = true;
			}
			actButton = item.gameObject.AddComponent<ActButton>();
			actButton.transition = Selectable.Transition.None;
			actButton.navigation = new Navigation
			{
				mode = Navigation.Mode.None
			};
		}
		actButton.SetBtnClick(OnBuffItemClicked, "event:/UI/Interface/Bag/Click");
	}

	private void OnBuffItemClicked()
	{
		OpenBuffDetail(playClickSound: false);
	}

	public void OpenBuffDetail()
	{
		OpenBuffDetail(playClickSound: true);
	}

	public void OpenBuffDetail(bool playClickSound)
	{
		if (playClickSound)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Bag/Click");
		}
		GameUtility.OpenBuffDetail(new EquipBuffViewData
		{
			buffInfos = m_BuffItemData
		});
	}

	public void SetColor(int count, Color color)
	{
		for (int i = 0; i < equipBuffItems.Count; i++)
		{
			if (i < count)
			{
				equipBuffItems[i].SetColor(color);
			}
		}
	}

	public void SwitchInputModel(DeviceInputMode inputMode)
	{
		switch (inputMode)
		{
		case DeviceInputMode.Gamepad:
			if ((bool)detailBtn)
			{
				detailBtn.gameObject.SetActive(value: false);
			}
			if ((bool)operateBtnPrompt)
			{
				operateBtnPrompt.gameObject.SetActive(value: true);
			}
			break;
		case DeviceInputMode.KeyboardAndMouse:
			if ((bool)detailBtn)
			{
				detailBtn.gameObject.SetActive(value: true);
			}
			if ((bool)operateBtnPrompt)
			{
				operateBtnPrompt.gameObject.SetActive(value: false);
			}
			break;
		}
	}
}

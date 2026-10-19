using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT;

public class TreasureCharacterPropertyCell : LoopScrollBaseItem, ISubmitHandler, IEventSystemHandler
{
	[SerializeField]
	private BImage _characterImage;

	[SerializeField]
	private TextMeshProUGUI _charactereName;

	[SerializeField]
	private RectTransform _arrow;

	[SerializeField]
	private GameObject _propertyRoot;

	[SerializeField]
	private ActButton _btnArea;

	[SerializeField]
	private Transform parent;

	[SerializeField]
	private GameObject prefab;

	[SerializeField]
	private GameObject select;

	private bool isExpand;

	private int _characterId;

	private ImageAssetStation station;

	private List<GameObject> m_ObjList = new List<GameObject>();

	public bool IsExpand => isExpand;

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		index = idx;
		_arrow.localScale = new Vector3(1f, 1f, 1f);
		isExpand = false;
		_propertyRoot.SetActive(isExpand);
		_characterId = Model<TreasureModel>.Interface._treasureCharacterList[index];
		if (RuntimeConfigs.data.entityDatas.TryGetValue(_characterId, out var value))
		{
			_charactereName.SetText(LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, value.nameLocal));
		}
		if (station == null)
		{
			station = GetComponentInParent<IBaseUIView>().Station;
		}
		station.LoadImage(126, _characterId, _characterImage);
		_btnArea.SetBtnClick(ExpandPropertyCell);
	}

	private void ExpandPropertyCell()
	{
		isExpand = !isExpand;
		_arrow.localScale = (isExpand ? new Vector3(1f, -1f, 1f) : new Vector3(1f, 1f, 1f));
		_propertyRoot.SetActive(isExpand);
		if (isExpand)
		{
			RefreshPropertyCell();
		}
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TreasureCharacterPropertyRefresh, null);
	}

	public void RefreshPropertyCell()
	{
		int num = 0;
		if (Model<TreasureModel>.Interface.TryGetTreasureCharacterProperty(_characterId, out var properties))
		{
			foreach (KeyValuePair<int, float> item in properties)
			{
				int key = item.Key;
				float value = item.Value;
				PropertyData data = CoreUtils.GetData(key, RuntimeConfigs.data.propertyDatas);
				if (data != null)
				{
					num++;
					GameObject gameObject = null;
					if (m_ObjList.Count < num)
					{
						gameObject = UnityEngine.Object.Instantiate(prefab, parent);
						gameObject.SetActive(value: true);
						m_ObjList.Add(gameObject);
					}
					else
					{
						gameObject = m_ObjList[num - 1];
						gameObject.SetActive(value: true);
					}
					PropertyCell component = gameObject.GetComponent<PropertyCell>();
					bool flag = value == 0f;
					string arg = (data.judge ? GameUtility.Topercentage((float)(Math.Ceiling(value * 10000f) / 10000.0), 1) : Math.Ceiling(value).ToString());
					component.InitInNumNeedIcon(data, data.descLocal, station, flag ? $"<color=#FFFFFF>+{arg}</color>" : $"+{arg}");
				}
			}
		}
		for (int i = num; i < m_ObjList.Count; i++)
		{
			m_ObjList[i]?.SetActive(value: false);
		}
	}

	public void OnSubmit(BaseEventData eventData)
	{
		if (_btnArea.gameObject.activeSelf && _btnArea.IsInteractable())
		{
			_btnArea.OnSubmit(eventData);
		}
	}
}

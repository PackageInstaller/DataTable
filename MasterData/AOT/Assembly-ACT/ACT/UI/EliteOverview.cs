using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class EliteOverview : MonoBehaviour
{
	[SerializeField]
	private EliteSkillOverviewComp[] eliteSkillOverviewComps;

	[SerializeField]
	private List<PropertyCell> propertyCells;

	[SerializeField]
	private Transform nodeGridTrans;

	public GameObject prefab;

	public Transform BaseRoot;

	public Transform AdvanceRoot;

	public Transform ElementRoot;

	public TextMeshProUGUI levelText;

	private List<GameObject> m_ObjList = new List<GameObject>();

	private Character m_Character;

	private int baseIndex = 1;

	private int advanceIndex = 2;

	private int elementIndex = 3;

	public void Init(Character character, ImageAssetStation imageAssetStation)
	{
		gameObject.SetActive(value: true);
		m_Character = character;
		int eliteActiveLevel = character.GetEliteActiveLevel();
		levelText.text = eliteActiveLevel.ToString();
		int[] pointList = CoreUtils.GetData(m_Character.Id, RuntimeConfigs.data.eliteTrainingMaps).pointList;
		SetAttribute(pointList, imageAssetStation);
		int[] characterSkill = CoreUtils.GetData(character.Id, RuntimeConfigs.data.eliteTrainingMaps).characterSkill;
		int eliteActiveLevel2 = character.GetEliteActiveLevel();
		for (int i = 0; i < 3; i++)
		{
			bool active = Model<EliteModel>.Interface.IsTalentActive(i + 1, eliteActiveLevel2, character.IsTrailCharacter);
			int activeLevel = i switch
			{
				0 => RuntimeConfigs.data.game.eliteSkill1Num, 
				1 => RuntimeConfigs.data.game.eliteSkill2Num, 
				2 => RuntimeConfigs.data.game.eliteSkill3Num, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			eliteSkillOverviewComps[i].Init(i, characterSkill[i], active, imageAssetStation, activeLevel);
		}
	}

	private void SetAttribute(int[] allPointIds, ImageAssetStation imageAssetStation)
	{
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
		List<int> list = ListPool<int>.Get();
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		foreach (int num5 in allPointIds)
		{
			EliteTrainingPoint data = CoreUtils.GetData(num5, RuntimeConfigs.data.eliteTrainingPoints);
			int[] attrId = data.attrId;
			for (int j = 0; j < attrId.Length; j++)
			{
				float num6 = (float)m_Character.GetElitePointLevel(num5) * data.attrIncreaseNum[j];
				PropertyData data2 = CoreUtils.GetData(attrId[j], RuntimeConfigs.data.propertyDatas);
				if (data2 != null)
				{
					int propertyId = data2.propertyId;
					list.Add(propertyId);
					PropertyTypeData data3 = CoreUtils.GetData(propertyId, RuntimeConfigs.data.propertyTypeDatas);
					num++;
					GameObject gameObject = null;
					Transform parent = null;
					switch (data3.type)
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
						gameObject.transform.parent = parent;
					}
					PropertyCell component = gameObject.GetComponent<PropertyCell>();
					bool flag = num6 == 0f;
					string arg = (data2.judge ? GameUtility.TopercentageMathfFloor(num6, 1) : Mathf.FloorToInt(num6).ToString());
					component.InitInNumNeedIcon(data2, data2.descLocal, imageAssetStation, flag ? $"<color=#FFFFFF>+{arg}</color>" : $"+{arg}");
					if (data3.type == baseIndex)
					{
						component.InitBoard(num2 % 2 == 1);
					}
					else if (data3.type == advanceIndex)
					{
						component.InitBoard(num3 % 2 == 1);
					}
					else if (data3.type == elementIndex)
					{
						component.InitBoard(num4 % 2 == 1);
					}
				}
			}
		}
		ListPool<int>.Release(list);
		DictionaryPool<int, int>.Release(dictionary);
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}
}

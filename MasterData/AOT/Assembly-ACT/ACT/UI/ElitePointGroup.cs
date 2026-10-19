using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class ElitePointGroup : MonoBehaviour
{
	public class ElitePointGroupData
	{
		public Character character;

		public int PointNum;

		public int MaxLevel;

		public int[] ElitePointIds;

		public Action<int> OnSelectPoint;

		public int curStage;

		public ImageAssetStation m_ImageAssetStation;

		public ElitePointGroupData(Character curCharacter, int[] elitePointIds, int stage, ImageAssetStation station, Action<int> onSelectPoint)
		{
			character = curCharacter;
			ElitePointIds = elitePointIds;
			PointNum = ElitePointIds.Length;
			m_ImageAssetStation = station;
			MaxLevel = GetElitePointMaxLevel(stage);
			curStage = stage;
			OnSelectPoint = onSelectPoint;
		}
	}

	[SerializeField]
	private Transform elitePointRoot;

	private List<ElitePointComp> _elitePoints;

	public void Init(ElitePointGroupData data)
	{
		InitPrefabList(data);
		_elitePoints = new List<ElitePointComp>(data.PointNum);
		InitPointList(data);
	}

	public void UnInit()
	{
		if (_elitePoints != null)
		{
			_elitePoints = null;
		}
	}

	public void OnSelectCharacter(ElitePointGroupData data)
	{
		InitPrefabList(data);
		_elitePoints.Clear();
		InitPointList(data);
	}

	private void InitPointList(ElitePointGroupData data)
	{
		int element = RuntimeConfigs.data.entityDatas[data.character.Id].element;
		for (int i = 0; i < data.PointNum; i++)
		{
			if (elitePointRoot.GetChild(i) != null)
			{
				ElitePointComp component = elitePointRoot.GetChild(i).GetComponent<ElitePointComp>();
				int elitePointId = data.ElitePointIds[i];
				int elitePointLevel = data.character.GetElitePointLevel(elitePointId);
				component.SetData(elitePointId, elitePointLevel, data, element, data.OnSelectPoint);
				_elitePoints.Add(component);
			}
		}
	}

	public void InitPrefabList(ElitePointGroupData data)
	{
		if (elitePointRoot != null)
		{
			ElitePointComp[] componentsInChildren = elitePointRoot.GetComponentsInChildren<ElitePointComp>();
			int[] pointList = CoreUtils.GetData(data.character.Id, RuntimeConfigs.data.eliteTrainingMaps).pointList;
			int num = 0;
			ElitePointComp[] array = componentsInChildren;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].Init(pointList[num], data, num);
				num++;
			}
		}
	}

	public void RefreshSelectedPoint(int pointId)
	{
		if (_elitePoints == null)
		{
			return;
		}
		foreach (ElitePointComp elitePoint in _elitePoints)
		{
			elitePoint.RefreshSelect(pointId);
		}
	}

	public static int GetElitePointNum(int stage)
	{
		return stage switch
		{
			1 => RuntimeConfigs.data.game.eliteStage1AttrNum, 
			2 => RuntimeConfigs.data.game.eliteStage2AttrNum, 
			3 => RuntimeConfigs.data.game.eliteStage3AttrNum, 
			_ => 0, 
		};
	}

	public static int GetElitePointMaxLevel(int stage)
	{
		return stage switch
		{
			1 => RuntimeConfigs.data.game.eliteStage1AttrLevel, 
			2 => RuntimeConfigs.data.game.eliteStage2AttrLevel, 
			3 => RuntimeConfigs.data.game.eliteStage3AttrLevel, 
			_ => 0, 
		};
	}

	public static int GetEliteTalentStageLevel(int stage)
	{
		return stage switch
		{
			1 => RuntimeConfigs.data.game.eliteSkill1Num, 
			2 => RuntimeConfigs.data.game.eliteSkill2Num, 
			3 => RuntimeConfigs.data.game.eliteSkill3Num, 
			_ => 0, 
		};
	}

	public static int GetEliteTalentActiveLevel(int stage)
	{
		return stage switch
		{
			1 => RuntimeConfigs.data.game.eliteStage2EliteLevel, 
			2 => RuntimeConfigs.data.game.eliteStage3EliteLevel, 
			_ => 0, 
		};
	}

	public static int GetEliteTalentActiveLevelByMaxLevel(int curMaxLevel)
	{
		if (curMaxLevel == RuntimeConfigs.data.game.eliteStage1AttrLevel)
		{
			return RuntimeConfigs.data.game.eliteStage2EliteLevel;
		}
		if (curMaxLevel == RuntimeConfigs.data.game.eliteStage2AttrLevel)
		{
			return RuntimeConfigs.data.game.eliteStage3EliteLevel;
		}
		return 0;
	}
}

using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class ElitePointGroupV2 : MonoBehaviour
{
	public class ElitePointGroupDataV2
	{
		public Character character;

		public int[] ElitePointIds;

		public int PointNum;

		public int maxLevel;

		public int curStage;

		public Action<int, int> OnSelectPoint;

		public ImageAssetStation m_ImageAssetStation;

		public ElitePointGroupDataV2(Character curCharacter, int[] elitePointIds, int stage, ImageAssetStation station, Action<int, int> onSelectPoint)
		{
			character = curCharacter;
			ElitePointIds = elitePointIds;
			PointNum = ElitePointIds.Length;
			maxLevel = Model<EliteModel>.Interface.GetElitePointMaxLevel(stage);
			curStage = stage;
			OnSelectPoint = onSelectPoint;
			m_ImageAssetStation = station;
		}
	}

	public List<ElitePointComponent> pointsList = new List<ElitePointComponent>();

	private ElitePointGroupDataV2 _currentData;

	private EliteElementEffectPool _elementEffectPool;

	public void Init(ElitePointGroupDataV2 data, bool isLevelUp)
	{
		_currentData = data;
		InitPointList(data, isLevelUp);
	}

	public void UnInit()
	{
	}

	public void OnSelectCharacter(ElitePointGroupDataV2 data)
	{
		_currentData = data;
		InitPointList(data, isLevelUp: false);
	}

	private void InitPointList(ElitePointGroupDataV2 data, bool isLevelUp)
	{
		int element = RuntimeConfigs.data.entityDatas[data.character.Id].element;
		Model<EliteModel>.Interface.pointsDic.TryGetValue(data.character.Id, out var value);
		bool hasEnoughUpgradeMaterials = HasEnoughUpgradeMaterials(data.character);
		EnsureElementEffectPool();
		for (int i = 0; i < pointsList.Count; i++)
		{
			ElitePointComponent elitePointComponent = pointsList[i];
			elitePointComponent.SetElementEffectPool(_elementEffectPool);
			int pointStageIndex = 0;
			int num = 0;
			int num2 = 0;
			if (value != null)
			{
				pointStageIndex = value[i].stageId;
				num = value[i].indexOfThreeProgress;
				num2 = value[i].pointId;
			}
			int elitePointLevel = data.character.GetElitePointLevel(num2);
			int pointIndexOfList = Model<EliteModel>.Interface.GetPointIndexOfList(data.character.Id, num2);
			elitePointComponent.SetData(displayLevel: Model<EliteModel>.Interface.GetDisPlayLevel(elitePointLevel, num + 1, data.curStage, pointIndexOfList), displayMaxLevel: Model<EliteModel>.Interface.GetEachStageMaxLevel(num + 1, pointIndexOfList), pointStateEnum: Model<EliteModel>.Interface.GetPointState(elitePointLevel, pointStageIndex, data.curStage, num, pointIndexOfList), elitePointId: num2, curLevel: elitePointLevel, pointStageIndex: pointStageIndex, data: data, colorIndex: element, onSelectPoint: data.OnSelectPoint, indexOfThreeProgress: num, hasEnoughUpgradeMaterials: hasEnoughUpgradeMaterials, isLevelUp: isLevelUp);
		}
	}

	private void EnsureElementEffectPool()
	{
		if (_elementEffectPool == null && pointsList != null && pointsList.Count != 0)
		{
			int count = pointsList.Count;
			_elementEffectPool = new EliteElementEffectPool(transform, count, count * 2);
		}
	}

	public void RefreshSelectedPoint(int pointId, int indexOfThreeProgress, bool gamePadShowPreviousTrail = false, bool prevWasTalent = false, int prevPointId = -1, int prevIndexOfThreeProgress = -1)
	{
		if (pointsList == null)
		{
			return;
		}
		foreach (ElitePointComponent points in pointsList)
		{
			points.RefreshSelect(pointId, indexOfThreeProgress, gamePadShowPreviousTrail, prevWasTalent, prevPointId, prevIndexOfThreeProgress);
		}
	}

	public void RefreshPoint(int pointId, int indexOfThreeProgress, bool isLevelUp)
	{
		if (_currentData == null || _currentData.character == null || !Model<EliteModel>.Interface.pointsDic.TryGetValue(_currentData.character.Id, out var value) || value == null)
		{
			return;
		}
		for (int i = 0; i < value.Count && i < pointsList.Count; i++)
		{
			PointData pointData = value[i];
			if (pointData.pointId == pointId && pointData.indexOfThreeProgress == indexOfThreeProgress)
			{
				RefreshPointByIndex(i, pointData, isLevelUp);
				break;
			}
		}
	}

	public void RefreshConsumeEnoughEffects()
	{
		if (_currentData?.character != null)
		{
			bool hasEnoughUpgradeMaterials = HasEnoughUpgradeMaterials(_currentData.character);
			for (int i = 0; i < pointsList.Count; i++)
			{
				pointsList[i].RefreshConsumeEnoughEffect(hasEnoughUpgradeMaterials);
			}
		}
	}

	private void RefreshPointByIndex(int pointListIndex, PointData pointData, bool isLevelUp)
	{
		ElitePointComponent elitePointComponent = pointsList[pointListIndex];
		int eliteStage = Model<EliteModel>.Interface.GetEliteStage(_currentData.character);
		_currentData.curStage = eliteStage;
		int elitePointLevel = _currentData.character.GetElitePointLevel(pointData.pointId);
		int pointIndexOfList = Model<EliteModel>.Interface.GetPointIndexOfList(_currentData.character.Id, pointData.pointId);
		elitePointComponent.SetData(displayLevel: Model<EliteModel>.Interface.GetDisPlayLevel(elitePointLevel, pointData.indexOfThreeProgress + 1, eliteStage, pointIndexOfList), displayMaxLevel: Model<EliteModel>.Interface.GetEachStageMaxLevel(pointData.indexOfThreeProgress + 1, pointIndexOfList), pointStateEnum: Model<EliteModel>.Interface.GetPointState(elitePointLevel, pointData.stageId, eliteStage, pointData.indexOfThreeProgress, pointIndexOfList), colorIndex: RuntimeConfigs.data.entityDatas[_currentData.character.Id].element, hasEnoughUpgradeMaterials: HasEnoughUpgradeMaterials(_currentData.character), elitePointId: pointData.pointId, curLevel: elitePointLevel, pointStageIndex: pointData.stageId, data: _currentData, onSelectPoint: _currentData.OnSelectPoint, indexOfThreeProgress: pointData.indexOfThreeProgress, isLevelUp: isLevelUp);
	}

	private static bool HasEnoughUpgradeMaterials(Character character)
	{
		(int, int, int) tokenData = Model<EliteModel>.Interface.GetTokenData(character);
		return tokenData.Item1 + tokenData.Item2 >= tokenData.Item3;
	}
}

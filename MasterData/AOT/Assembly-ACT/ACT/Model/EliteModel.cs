using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class EliteModel : Model<EliteModel>
{
	private const int ELITE_POINT_NODE_COUNT = 18;

	private const int ELITE_TALENT_NODE_COUNT = 3;

	private Dictionary<int, LevelRestrictions> levelRestrictionsDic = new Dictionary<int, LevelRestrictions>();

	public Dictionary<int, List<PointData>> pointsDic = new Dictionary<int, List<PointData>>();

	public Dictionary<int, bool> eliteTalentRedDotDic = new Dictionary<int, bool>();

	private readonly Dictionary<EliteNodeId, EliteNodeMoveTargets> _eliteNodeMoveMap = new Dictionary<EliteNodeId, EliteNodeMoveTargets>();

	public EliteTrainingMap _cachedEliteTrainingMap;

	private readonly Dictionary<int, EliteTrainingMap> _eliteTrainingMapCache = new Dictionary<int, EliteTrainingMap>();

	private int[] _cachedLevelThresholds;

	private const int ELITE_STAGE_THRESHOLD_COUNT = 3;

	private const int POINTSTAGE = 3;

	private const int POINTLISTLENGTH = 9;

	private const int STAGE1 = 1;

	private const int STAGE2 = 2;

	private const int STAGE3 = 3;

	private int firstStageMaxLevel;

	private int secondStageMaxLevel;

	private int thirdStageMaxLevel;

	private bool isTrialCharacter;

	private bool isTalentPoint;

	public IReadOnlyDictionary<EliteNodeId, EliteNodeMoveTargets> EliteNodeMoveMap => _eliteNodeMoveMap;

	public bool IsTrialCharacter
	{
		get
		{
			return isTrialCharacter;
		}
		set
		{
			isTrialCharacter = value;
		}
	}

	public bool IsTalentPoint
	{
		get
		{
			return isTalentPoint;
		}
		set
		{
			isTalentPoint = value;
		}
	}

	protected override void Init()
	{
		InitializeCachedData();
		InitializePointsDic();
		InitializeEliteNodeMoveMap();
		InitLevelRestrictions();
		InitThreeStageMaxLevel();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_EliteLevelChange, OnCharacterEliteLevelChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayerLevelUpChange, OnPlayerLevelUpChange);
	}

	private void InitThreeStageMaxLevel()
	{
		firstStageMaxLevel = RuntimeConfigs.data.game.eliteStage1AttrNum * RuntimeConfigs.data.game.eliteStage1AttrLevel;
		secondStageMaxLevel = RuntimeConfigs.data.game.eliteStage2AttrNum * RuntimeConfigs.data.game.eliteStage2AttrLevel;
		thirdStageMaxLevel = RuntimeConfigs.data.game.eliteStage3AttrNum * RuntimeConfigs.data.game.eliteStage3AttrLevel;
	}

	protected override void UnInit()
	{
		pointsDic.Clear();
		levelRestrictionsDic.Clear();
		eliteTalentRedDotDic.Clear();
		_eliteNodeMoveMap.Clear();
		_eliteTrainingMapCache.Clear();
		_cachedEliteTrainingMap = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_EliteLevelChange, OnCharacterEliteLevelChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayerLevelUpChange, OnPlayerLevelUpChange);
	}

	private void InitLevelRestrictions()
	{
		levelRestrictionsDic.Add(1, new LevelRestrictions
		{
			playerLevel = RuntimeConfigs.data.game.eliteStage2PlayerLevel,
			eliteLevel = RuntimeConfigs.data.game.eliteSkill1Num
		});
		levelRestrictionsDic.Add(2, new LevelRestrictions
		{
			playerLevel = RuntimeConfigs.data.game.eliteStage3PlayerLevel,
			eliteLevel = RuntimeConfigs.data.game.eliteSkill2Num
		});
		levelRestrictionsDic.Add(3, new LevelRestrictions
		{
			playerLevel = RuntimeConfigs.data.game.eliteStage3PlayerLevel,
			eliteLevel = RuntimeConfigs.data.game.eliteSkill3Num
		});
	}

	private void InitializeEliteNodeMoveMap()
	{
		_eliteNodeMoveMap.Clear();
		for (int i = 0; i < 18; i++)
		{
			EliteNodeId key = CreatePointNode(i);
			_eliteNodeMoveMap[key] = new EliteNodeMoveTargets(EliteNodeId.Invalid, EliteNodeId.Invalid, EliteNodeId.Invalid, EliteNodeId.Invalid);
		}
		for (int j = 0; j < 3; j++)
		{
			EliteNodeId key2 = CreateTalentNode(j);
			_eliteNodeMoveMap[key2] = new EliteNodeMoveTargets(EliteNodeId.Invalid, EliteNodeId.Invalid, EliteNodeId.Invalid, EliteNodeId.Invalid);
		}
		EliteNodeId source = CreatePointNode(0);
		EliteNodeId? up = CreateTalentNode(0);
		EliteNodeId? down = CreatePointNode(1);
		EliteNodeId? right = CreatePointNode(3);
		SetNodeMoveTargets(source, up, down, null, right);
		EliteNodeId source2 = CreatePointNode(1);
		EliteNodeId? up2 = CreatePointNode(0);
		EliteNodeId? down2 = CreatePointNode(2);
		right = CreatePointNode(4);
		SetNodeMoveTargets(source2, up2, down2, null, right);
		EliteNodeId source3 = CreatePointNode(2);
		EliteNodeId? up3 = CreatePointNode(1);
		right = CreatePointNode(5);
		SetNodeMoveTargets(source3, up3, null, null, right);
		SetNodeMoveTargets(CreatePointNode(3), CreateTalentNode(1), CreatePointNode(4), CreatePointNode(0), CreatePointNode(6));
		SetNodeMoveTargets(CreatePointNode(4), CreatePointNode(3), CreatePointNode(5), CreatePointNode(1), CreatePointNode(7));
		EliteNodeId source4 = CreatePointNode(5);
		EliteNodeId? up4 = CreatePointNode(4);
		right = CreatePointNode(2);
		EliteNodeId? right2 = CreatePointNode(8);
		SetNodeMoveTargets(source4, up4, null, right, right2);
		EliteNodeId source5 = CreatePointNode(6);
		right2 = CreatePointNode(7);
		right = CreatePointNode(3);
		EliteNodeId? right3 = CreatePointNode(12);
		SetNodeMoveTargets(source5, null, right2, right, right3);
		SetNodeMoveTargets(CreatePointNode(7), CreatePointNode(6), CreatePointNode(8), CreatePointNode(4), CreatePointNode(13));
		EliteNodeId source6 = CreatePointNode(8);
		EliteNodeId? up5 = CreatePointNode(7);
		right3 = CreatePointNode(5);
		right = CreatePointNode(14);
		SetNodeMoveTargets(source6, up5, null, right3, right);
		SetNodeMoveTargets(CreatePointNode(9), CreateTalentNode(2), CreatePointNode(10), CreatePointNode(12), CreatePointNode(15));
		SetNodeMoveTargets(CreatePointNode(10), CreatePointNode(9), CreatePointNode(11), CreatePointNode(13), CreatePointNode(16));
		EliteNodeId source7 = CreatePointNode(11);
		EliteNodeId? up6 = CreatePointNode(10);
		right = CreatePointNode(14);
		right3 = CreatePointNode(17);
		SetNodeMoveTargets(source7, up6, null, right, right3);
		EliteNodeId source8 = CreatePointNode(12);
		right3 = CreatePointNode(13);
		right = CreatePointNode(6);
		right2 = CreatePointNode(9);
		SetNodeMoveTargets(source8, null, right3, right, right2);
		SetNodeMoveTargets(CreatePointNode(13), CreatePointNode(12), CreatePointNode(14), CreatePointNode(7), CreatePointNode(10));
		EliteNodeId source9 = CreatePointNode(14);
		EliteNodeId? up7 = CreatePointNode(13);
		right2 = CreatePointNode(8);
		right = CreatePointNode(11);
		SetNodeMoveTargets(source9, up7, null, right2, right);
		EliteNodeId source10 = CreatePointNode(15);
		right = CreatePointNode(16);
		right2 = CreatePointNode(9);
		SetNodeMoveTargets(source10, null, right, right2);
		SetNodeMoveTargets(CreatePointNode(16), CreatePointNode(15), CreatePointNode(17), CreatePointNode(10));
		EliteNodeId source11 = CreatePointNode(17);
		EliteNodeId? up8 = CreatePointNode(16);
		right2 = CreatePointNode(11);
		SetNodeMoveTargets(source11, up8, null, right2);
		EliteNodeId source12 = CreateTalentNode(0);
		right2 = CreatePointNode(0);
		right = CreateTalentNode(1);
		SetNodeMoveTargets(source12, null, right2, null, right);
		EliteNodeId source13 = CreateTalentNode(1);
		right = CreatePointNode(3);
		right2 = CreateTalentNode(0);
		right3 = CreateTalentNode(2);
		SetNodeMoveTargets(source13, null, right, right2, right3);
		EliteNodeId source14 = CreateTalentNode(2);
		right3 = CreatePointNode(9);
		right2 = CreateTalentNode(1);
		SetNodeMoveTargets(source14, null, right3, right2);
	}

	private void SetNodeMoveTargets(EliteNodeId source, EliteNodeId? up = null, EliteNodeId? down = null, EliteNodeId? left = null, EliteNodeId? right = null)
	{
		if (_eliteNodeMoveMap.TryGetValue(source, out var value))
		{
			_eliteNodeMoveMap[source] = new EliteNodeMoveTargets(up ?? value.Up, down ?? value.Down, left ?? value.Left, right ?? value.Right);
		}
	}

	public static EliteNodeId CreatePointNode(int pointListIndex)
	{
		return new EliteNodeId(EliteNodeType.Point, pointListIndex);
	}

	public static EliteNodeId CreateTalentNode(int talentIndex)
	{
		return new EliteNodeId(EliteNodeType.Talent, talentIndex);
	}

	public bool TryGetMoveTarget(EliteNodeId currentNode, EliteNodeMoveDirection direction, out EliteNodeId targetNode)
	{
		targetNode = EliteNodeId.Invalid;
		if (!_eliteNodeMoveMap.TryGetValue(currentNode, out var value))
		{
			return false;
		}
		return value.TryGetTarget(direction, out targetNode);
	}

	private void InitializePointsDic()
	{
		foreach (KeyValuePair<int, EliteTrainingMap> eliteTrainingMap in RuntimeConfigs.data.eliteTrainingMaps)
		{
			EliteTrainingMap value = eliteTrainingMap.Value;
			_eliteTrainingMapCache[value.characterId] = value;
			pointsDic.Add(value.characterId, GetPointData(value.characterId));
		}
	}

	public List<PointData> GetPointData(int characterId)
	{
		int[] pointList = GetEliteTrainingMap(characterId).pointList;
		List<PointData> list = new List<PointData>();
		int num = Math.Min(RuntimeConfigs.data.game.eliteStage1AttrNum, pointList.Length);
		int num2 = Math.Min(RuntimeConfigs.data.game.eliteStage2AttrNum, pointList.Length);
		int num3 = Math.Min(RuntimeConfigs.data.game.eliteStage3AttrNum, pointList.Length);
		for (int i = 0; i < num; i++)
		{
			int pointId = pointList[i];
			list.Add(new PointData
			{
				stageId = 1,
				indexOfThreeProgress = 0,
				pointListIndex = i,
				pointId = pointId,
				maxLevel = RuntimeConfigs.data.game.eliteStage1AttrLevel
			});
		}
		for (int j = 0; j < num2; j++)
		{
			int pointId2 = pointList[j];
			list.Add(new PointData
			{
				stageId = 2,
				indexOfThreeProgress = 1,
				pointListIndex = num + j,
				pointId = pointId2,
				maxLevel = RuntimeConfigs.data.game.eliteStage2AttrLevel
			});
		}
		for (int k = 0; k < num3; k++)
		{
			int pointId3 = pointList[k];
			list.Add(new PointData
			{
				stageId = 3,
				indexOfThreeProgress = 2,
				pointListIndex = num + num2 + k,
				pointId = pointId3,
				maxLevel = RuntimeConfigs.data.game.eliteStage3AttrLevel
			});
		}
		return list;
	}

	public int GetPointListIndex(int characterId, int pointId, int indexOfThreeProgress)
	{
		if (pointsDic.TryGetValue(characterId, out var value))
		{
			foreach (PointData item in value)
			{
				if (item.pointId == pointId && item.indexOfThreeProgress == indexOfThreeProgress)
				{
					return item.pointListIndex;
				}
			}
		}
		return -1;
	}

	private void InitializeCachedData()
	{
		_cachedLevelThresholds = new int[3];
		_cachedLevelThresholds[0] = RuntimeConfigs.data.game.eliteStage1CharacterLevel;
		_cachedLevelThresholds[1] = RuntimeConfigs.data.game.eliteStage2EliteLevel;
		_cachedLevelThresholds[2] = RuntimeConfigs.data.game.eliteStage3EliteLevel;
	}

	public int GetLevelThresholds(int stageId)
	{
		if (stageId <= 0 || stageId > _cachedLevelThresholds.Length)
		{
			return 0;
		}
		return _cachedLevelThresholds[stageId - 1];
	}

	public int GetPointIndexOfList(int characterId, int pointId)
	{
		return GetEliteTrainingMap(characterId).pointList.IndexOf(pointId);
	}

	public int GetEachStageMaxLevel(int stageId, int pointIndexOfList)
	{
		int result = 0;
		switch (stageId)
		{
		case 1:
			result = RuntimeConfigs.data.game.eliteStage1AttrLevel;
			break;
		case 2:
			result = ((pointIndexOfList > 2) ? RuntimeConfigs.data.game.eliteStage2AttrLevel : (RuntimeConfigs.data.game.eliteStage2AttrLevel - RuntimeConfigs.data.game.eliteStage1AttrLevel));
			break;
		case 3:
			result = ((pointIndexOfList <= 5) ? (RuntimeConfigs.data.game.eliteStage3AttrLevel - RuntimeConfigs.data.game.eliteStage2AttrLevel) : RuntimeConfigs.data.game.eliteStage3AttrLevel);
			break;
		}
		return result;
	}

	public int GetElitePointStageId(int characterId, int pointId)
	{
		int num = GetEliteTrainingMap(characterId).pointList.IndexOf(pointId);
		if (num >= 0 && num <= 2)
		{
			return 1;
		}
		if (num >= 3 && num <= 5)
		{
			return 2;
		}
		if (num >= 6 && num <= 8)
		{
			return 3;
		}
		return 1;
	}

	public int GetEliteStage(Character character)
	{
		if (character == null)
		{
			return 0;
		}
		int level = character.Level;
		int[] pointList = GetEliteTrainingMap(character.Id).pointList;
		int pointAllLevel = CalculateTotalPointLevel(character, pointList);
		return CalculateStage(level, pointAllLevel, character.IsTrailCharacter);
	}

	public EliteTrainingMap GetEliteTrainingMap(int characterId)
	{
		if (!_eliteTrainingMapCache.TryGetValue(characterId, out var value))
		{
			value = CoreUtils.GetData(characterId, RuntimeConfigs.data.eliteTrainingMaps);
			_eliteTrainingMapCache[characterId] = value;
		}
		_cachedEliteTrainingMap = value;
		return _cachedEliteTrainingMap;
	}

	public int CalculateTotalPointLevel(Character character, int[] allPoints)
	{
		int num = 0;
		foreach (int elitePointId in allPoints)
		{
			num += character.GetElitePointLevel(elitePointId);
		}
		return num;
	}

	public int GetElitePointIndex(Character character, int pointId)
	{
		int[] pointList = GetEliteTrainingMap(character.Id).pointList;
		for (int i = 0; i < pointList.Length; i++)
		{
			if (pointList[i] == pointId)
			{
				return i + 1;
			}
		}
		return 0;
	}

	public int CalculateStage(int characterLevel, int pointAllLevel, bool isTrialCharacter = false)
	{
		if (characterLevel < _cachedLevelThresholds[0])
		{
			return 0;
		}
		int num = 1;
		for (int i = 1; i < _cachedLevelThresholds.Length; i++)
		{
			if (pointAllLevel >= _cachedLevelThresholds[i] && levelRestrictionsDic.TryGetValue(i, out var value) && (isTrialCharacter || SystemUnlockManager.playerLevel >= value.playerLevel))
			{
				num++;
			}
		}
		return num;
	}

	public int GetNotMaxLevelPointWithMinId(Character character, int stage)
	{
		if (character == null)
		{
			return 0;
		}
		int elitePointNum = ElitePointGroup.GetElitePointNum(stage);
		int[] pointList = GetEliteTrainingMap(character.Id).pointList;
		int num = pointList[0];
		int num2 = pointList[0];
		for (int i = 0; i < elitePointNum; i++)
		{
			if (num >= pointList[i])
			{
				num = pointList[i];
			}
			int num3 = pointList[i];
			int elitePointLevel = character.GetElitePointLevel(num3);
			if (elitePointLevel < 1)
			{
				return pointList[i];
			}
			if (elitePointLevel < ElitePointGroup.GetElitePointMaxLevel(stage))
			{
				num2 = num3;
			}
		}
		if (character.GetElitePointLevel(num) < ElitePointGroup.GetElitePointMaxLevel(stage))
		{
			return num;
		}
		if (character.GetElitePointLevel(num) == character.GetElitePointLevel(num2))
		{
			return num;
		}
		return num2;
	}

	public List<Properties> CreatePropertiesList(int attrId)
	{
		return new List<Properties>(1)
		{
			new Properties(attrId, 0f)
		};
	}

	public (int remainTokenNum, int availableTokenNum, int costTokenNumPerLevel) GetTokenData(Character _selectCharacter)
	{
		int itemCount = G.localPlayer.Inventory.GetItemCount(_selectCharacter.GetGenericCharacterEliteItem());
		int characterEliteItem = _selectCharacter.GetCharacterEliteItem();
		int itemCount2 = G.localPlayer.Inventory.GetItemCount(characterEliteItem);
		int costTokenNumPerLevelByStage = GetCostTokenNumPerLevelByStage(_selectCharacter);
		return (remainTokenNum: itemCount, availableTokenNum: itemCount2, costTokenNumPerLevel: costTokenNumPerLevelByStage);
	}

	public int GetCostTokenNumPerLevelByStage(Character character)
	{
		int eliteActiveLevel = character.GetEliteActiveLevel();
		int[] array = null;
		int num = 0;
		switch (character.GetQuality())
		{
		case 4:
			array = RuntimeConfigs.data.game.elite4StarStageTokenNum;
			break;
		case 5:
			array = RuntimeConfigs.data.game.elite5StarStageTokenNum;
			break;
		}
		if (eliteActiveLevel < RuntimeConfigs.data.game.eliteSkill1Num)
		{
			return array[0];
		}
		if (eliteActiveLevel < RuntimeConfigs.data.game.eliteSkill2Num)
		{
			return array[1];
		}
		return array[2];
	}

	public int CalculateItemEnoughLevel(int remainTokenNum, int availableTokenNum, int costTokenNumPerLevel, int curPointLevel)
	{
		int eliteStage3AttrLevel = RuntimeConfigs.data.game.eliteStage3AttrLevel;
		if (curPointLevel >= eliteStage3AttrLevel || costTokenNumPerLevel <= 0)
		{
			return eliteStage3AttrLevel;
		}
		long num = (long)remainTokenNum + (long)availableTokenNum;
		long num2 = Math.Max(0L, num / costTokenNumPerLevel);
		return (int)Math.Min(eliteStage3AttrLevel, curPointLevel + num2);
	}

	public (int, int, int) GetSelectPointStageId(int characterId, int elitePointId)
	{
		int[] characterSkill = GetEliteTrainingMap(characterId).characterSkill;
		int num = characterSkill.IndexOf(elitePointId);
		int num2 = 0;
		return new ValueTuple<int, int, int>(item3: num switch
		{
			0 => RuntimeConfigs.data.game.eliteSkill1Num, 
			1 => RuntimeConfigs.data.game.eliteSkill2Num, 
			_ => RuntimeConfigs.data.game.eliteSkill3Num, 
		}, item1: num + 1, item2: characterSkill[num]);
	}

	public (bool, int) IsTriggerStageDown(int level, int activeLevel)
	{
		int num = 0;
		int num2 = GetEliteIconByActiveLevel(activeLevel) - 1;
		if (level < RuntimeConfigs.data.game.eliteSkill1Num)
		{
			num = 0;
		}
		else if (level < RuntimeConfigs.data.game.eliteSkill2Num)
		{
			num = 1;
		}
		else if (level < RuntimeConfigs.data.game.eliteSkill3Num)
		{
			num = 2;
		}
		else if (level >= RuntimeConfigs.data.game.eliteSkill3Num)
		{
			num = 3;
		}
		return (num < num2, num);
	}

	public (int, int) GetBackLevel(Character character, int activeLevel, int pointCurLevel, int indexOfThreeProgress, int elitePointId)
	{
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		switch (indexOfThreeProgress)
		{
		case 0:
			if (pointCurLevel >= RuntimeConfigs.data.game.eliteStage1AttrLevel)
			{
				num = ((pointCurLevel <= RuntimeConfigs.data.game.eliteStage1AttrLevel || pointCurLevel > RuntimeConfigs.data.game.eliteStage2AttrLevel) ? (activeLevel - (pointCurLevel - RuntimeConfigs.data.game.eliteStage2AttrLevel + (RuntimeConfigs.data.game.eliteStage2AttrLevel - RuntimeConfigs.data.game.eliteStage1AttrLevel) + 1)) : (activeLevel - (pointCurLevel - RuntimeConfigs.data.game.eliteStage1AttrLevel + 1)));
			}
			else
			{
				num = activeLevel - 1;
			}
			break;
		case 1:
			num = ((pointCurLevel <= RuntimeConfigs.data.game.eliteStage2AttrLevel) ? (activeLevel - 1) : (activeLevel - (pointCurLevel - RuntimeConfigs.data.game.eliteStage2AttrLevel) - 1));
			break;
		case 2:
			num = activeLevel - 1;
			break;
		}
		num3 = GetOtherElitePointBackLevelAndConsumeCount(elitePointId, num, activeLevel, character);
		Debug.Log("自己节点回退等级" + num);
		num2 = GetBackConsumeCount(activeLevel, num - num3, character);
		Debug.Log("其他节点回退等级" + num);
		Debug.Log("其他节点回退资源" + num2);
		return (num - num3, num2);
	}

	public int GetBackConsumeCount(int activeLevel, int backLevel, Character character)
	{
		int quality = character.GetQuality();
		int[] array = quality switch
		{
			4 => RuntimeConfigs.data.game.elite4StarStageTokenNum, 
			5 => RuntimeConfigs.data.game.elite5StarStageTokenNum, 
			6 => RuntimeConfigs.data.game.elite5StarStageTokenNum, 
		};
		if (activeLevel <= backLevel)
		{
			return 0;
		}
		if (activeLevel < 1 || backLevel < 1)
		{
			return array[0];
		}
		return CalculateTotalCostToLevel(activeLevel, array) - CalculateTotalCostToLevel(backLevel, array);
	}

	private int CalculateTotalCostToLevel(int targetLevelMinusOne, int[] tokenList)
	{
		if (targetLevelMinusOne < 0)
		{
			return 0;
		}
		int num = tokenList[0];
		int num2 = tokenList[1];
		int num3 = tokenList[2];
		if (targetLevelMinusOne <= RuntimeConfigs.data.game.eliteSkill1Num)
		{
			return targetLevelMinusOne * num;
		}
		if (targetLevelMinusOne <= RuntimeConfigs.data.game.eliteSkill2Num)
		{
			return RuntimeConfigs.data.game.eliteSkill1Num * num + (targetLevelMinusOne - RuntimeConfigs.data.game.eliteSkill1Num) * num2;
		}
		return RuntimeConfigs.data.game.eliteSkill1Num * num + (RuntimeConfigs.data.game.eliteSkill2Num - RuntimeConfigs.data.game.eliteSkill1Num) * num2 + (targetLevelMinusOne - RuntimeConfigs.data.game.eliteSkill2Num) * num3;
	}

	public int GetOtherElitePointBackLevelAndConsumeCount(int elitePointId, int backLevel, int activeLevel, Character character)
	{
		if (!IsTriggerStageDown(backLevel, activeLevel).Item1 || !pointsDic.TryGetValue(character.Id, out var value))
		{
			return 0;
		}
		int num;
		if (backLevel < RuntimeConfigs.data.game.eliteStage2EliteLevel)
		{
			num = 2;
		}
		else
		{
			if (backLevel >= RuntimeConfigs.data.game.eliteStage3EliteLevel)
			{
				return 0;
			}
			num = 3;
		}
		int num2 = 0;
		foreach (PointData item in value)
		{
			int pointId = item.pointId;
			if (pointId == elitePointId || item.stageId != num)
			{
				continue;
			}
			int indexOfThreeProgress = item.indexOfThreeProgress;
			int pointListIndex = item.pointListIndex;
			int elitePointLevel = character.GetElitePointLevel(pointId);
			if (pointListIndex > 5 && pointListIndex <= 8)
			{
				if (elitePointLevel > 0)
				{
					num2 += elitePointLevel;
				}
			}
			else if (indexOfThreeProgress == 0 && elitePointLevel <= RuntimeConfigs.data.game.eliteStage1AttrLevel)
			{
				num2 += elitePointLevel;
			}
			else if (indexOfThreeProgress == 1 && elitePointLevel > RuntimeConfigs.data.game.eliteStage1AttrLevel && elitePointLevel <= RuntimeConfigs.data.game.eliteStage2AttrLevel)
			{
				num2 += elitePointLevel;
			}
			else if (indexOfThreeProgress == 2 && elitePointLevel > RuntimeConfigs.data.game.eliteStage2AttrLevel)
			{
				num2 += elitePointLevel - RuntimeConfigs.data.game.eliteStage2AttrLevel;
			}
		}
		return num2;
	}

	public int GetEliteIconByActiveLevel(int activeLevel)
	{
		int num = 1;
		int playerLevel = SystemUnlockManager.playerLevel;
		if (activeLevel >= RuntimeConfigs.data.game.eliteSkill3Num && playerLevel >= RuntimeConfigs.data.game.eliteStage3PlayerLevel)
		{
			return 4;
		}
		if (activeLevel >= RuntimeConfigs.data.game.eliteSkill2Num && playerLevel >= RuntimeConfigs.data.game.eliteStage3PlayerLevel)
		{
			return 3;
		}
		if (activeLevel >= RuntimeConfigs.data.game.eliteSkill1Num && playerLevel >= RuntimeConfigs.data.game.eliteStage2PlayerLevel)
		{
			return 2;
		}
		return 1;
	}

	public int GetElitePointMaxLevel(int stage)
	{
		return stage switch
		{
			1 => RuntimeConfigs.data.game.eliteStage1AttrLevel, 
			2 => RuntimeConfigs.data.game.eliteStage2AttrLevel, 
			3 => RuntimeConfigs.data.game.eliteStage3AttrLevel, 
			_ => 0, 
		};
	}

	public int GetDisPlayLevel(int currentLevel, int pointStageIndex, int selectCharacterId, int elitePointId, Character character)
	{
		return GetDisPlayLevel(currentLevel, pointStageIndex, GetEliteStage(character), GetPointIndexOfList(selectCharacterId, elitePointId));
	}

	public int GetDisPlayLevel(int currentLevel, int pointStageIndex, int stageId, int pointIndexOfList)
	{
		int num = 0;
		if (currentLevel <= RuntimeConfigs.data.game.eliteStage1AttrLevel)
		{
			switch (pointStageIndex)
			{
			case 1:
				num = currentLevel;
				break;
			case 2:
				if (stageId >= 2)
				{
					if (pointIndexOfList > 2)
					{
						num = currentLevel;
					}
				}
				else
				{
					num = 0;
				}
				break;
			case 3:
				if (stageId >= 3)
				{
					if (pointIndexOfList > 5)
					{
						num = currentLevel;
					}
				}
				else
				{
					num = 0;
				}
				break;
			}
		}
		else if (currentLevel > RuntimeConfigs.data.game.eliteStage1AttrLevel && currentLevel <= RuntimeConfigs.data.game.eliteStage2AttrLevel)
		{
			switch (pointStageIndex)
			{
			case 1:
				num = RuntimeConfigs.data.game.eliteStage1AttrLevel;
				break;
			case 2:
				num = ((pointIndexOfList > 2) ? currentLevel : (currentLevel - RuntimeConfigs.data.game.eliteStage1AttrLevel));
				break;
			case 3:
				num = ((stageId >= 3) ? ((pointIndexOfList > 5) ? currentLevel : 0) : 0);
				break;
			}
		}
		else if (currentLevel <= RuntimeConfigs.data.game.eliteStage3AttrLevel)
		{
			switch (pointStageIndex)
			{
			case 1:
				num = RuntimeConfigs.data.game.eliteStage1AttrLevel;
				break;
			case 2:
				num = GetEachStageMaxLevel(pointStageIndex, pointIndexOfList);
				break;
			case 3:
				num = ((pointIndexOfList > 5) ? currentLevel : (currentLevel - RuntimeConfigs.data.game.eliteStage2AttrLevel));
				break;
			}
		}
		if (num < 0)
		{
			num = 0;
		}
		return num;
	}

	public PointStateEnum GetPointState(int currentLevel, int pointStageIndex, int curStageId, int indexOfThreeProgress, int pointIndexOfList)
	{
		PointStateEnum result = PointStateEnum.Lock;
		int eliteStage1AttrLevel = RuntimeConfigs.data.game.eliteStage1AttrLevel;
		int eliteStage2AttrLevel = RuntimeConfigs.data.game.eliteStage2AttrLevel;
		int eliteStage3AttrLevel = RuntimeConfigs.data.game.eliteStage3AttrLevel;
		if (pointStageIndex > curStageId && curStageId != 0)
		{
			result = PointStateEnum.Lock;
		}
		else if (curStageId == 0)
		{
			switch (pointStageIndex)
			{
			case 1:
				result = ((currentLevel < eliteStage1AttrLevel) ? PointStateEnum.CanUpgrade : PointStateEnum.IsMax);
				break;
			case 2:
				result = PointStateEnum.Lock;
				break;
			case 3:
				result = PointStateEnum.Lock;
				break;
			}
		}
		else if (pointStageIndex == curStageId)
		{
			switch (indexOfThreeProgress)
			{
			case 0:
				result = ((currentLevel < eliteStage1AttrLevel) ? PointStateEnum.CanUpgrade : PointStateEnum.IsMax);
				break;
			case 1:
				if (pointIndexOfList <= 2)
				{
					if (currentLevel >= eliteStage1AttrLevel)
					{
						result = ((currentLevel >= eliteStage2AttrLevel || currentLevel < eliteStage1AttrLevel) ? PointStateEnum.IsMax : PointStateEnum.CanUpgrade);
					}
					else
					{
						result = PointStateEnum.UnlockedPrerequisites;
					}
				}
				else if (pointIndexOfList <= 5)
				{
					result = ((currentLevel >= eliteStage2AttrLevel) ? PointStateEnum.IsMax : PointStateEnum.CanUpgrade);
				}
				break;
			case 2:
				result = ((currentLevel < eliteStage3AttrLevel) ? PointStateEnum.CanUpgrade : PointStateEnum.IsMax);
				break;
			}
		}
		else if (pointStageIndex < curStageId)
		{
			switch (indexOfThreeProgress)
			{
			case 0:
				if (pointIndexOfList > 2)
				{
					if (pointIndexOfList <= 2 || pointIndexOfList > 5)
					{
						result = ((currentLevel < eliteStage3AttrLevel) ? PointStateEnum.CanUpgrade : PointStateEnum.IsMax);
					}
					else
					{
						result = ((currentLevel < eliteStage2AttrLevel) ? PointStateEnum.CanUpgrade : PointStateEnum.IsMax);
					}
				}
				else
				{
					result = ((currentLevel < eliteStage1AttrLevel) ? PointStateEnum.CanUpgrade : PointStateEnum.IsMax);
				}
				break;
			case 1:
				if (currentLevel >= eliteStage1AttrLevel)
				{
					result = ((currentLevel >= eliteStage2AttrLevel || currentLevel < eliteStage1AttrLevel) ? PointStateEnum.IsMax : PointStateEnum.CanUpgrade);
				}
				else
				{
					result = PointStateEnum.UnlockedPrerequisites;
				}
				break;
			}
		}
		return result;
	}

	public Color GetBoardColorByCharacterId(int characterId)
	{
		int element = RuntimeConfigs.data.entityDatas[characterId].element;
		return ColorParseUtility.HexToColor(RuntimeConfigs.data.elementConfigs[element].elementColour);
	}

	public int GetCharacterSkillId(int characterId, int stageId)
	{
		return GetEliteTrainingMap(characterId).characterSkill[stageId - 1];
	}

	public bool IsNewTalentActive(int beforeUpgradeLevel, int newActiveLevel)
	{
		if (beforeUpgradeLevel < newActiveLevel)
		{
			if (newActiveLevel == RuntimeConfigs.data.game.eliteSkill1Num && SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.eliteStage2PlayerLevel)
			{
				return true;
			}
			if (newActiveLevel == RuntimeConfigs.data.game.eliteSkill2Num && SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.eliteStage3PlayerLevel)
			{
				return true;
			}
			if (newActiveLevel == RuntimeConfigs.data.game.eliteSkill3Num && SystemUnlockManager.playerLevel >= RuntimeConfigs.data.game.eliteStage3PlayerLevel)
			{
				return true;
			}
		}
		return false;
	}

	private void OnCharacterEliteLevelChange(BaseEventContent content)
	{
		CharacterEliteLevelChange characterEliteLevelChange = content as CharacterEliteLevelChange;
		if ((characterEliteLevelChange == null || !characterEliteLevelChange.character.IsSubWorld) && characterEliteLevelChange != null && IsNewTalentActive(characterEliteLevelChange.beforeLevel, characterEliteLevelChange.afterLevel))
		{
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPELITEBREAK, new PopupEliteBreakViewData
			{
				stageId = GetEliteStage(characterEliteLevelChange.character) + 1,
				character = characterEliteLevelChange.character
			});
		}
	}

	public bool IsTalentActive(int talentIndex, int eliteLevel, bool isTrialCharacter = false)
	{
		int num = (isTrialCharacter ? int.MaxValue : SystemUnlockManager.playerLevel);
		bool result = false;
		switch (talentIndex)
		{
		case 1:
			result = num >= RuntimeConfigs.data.game.eliteStage2PlayerLevel && eliteLevel >= RuntimeConfigs.data.game.eliteSkill1Num;
			break;
		case 2:
			result = num >= RuntimeConfigs.data.game.eliteStage3PlayerLevel && eliteLevel >= RuntimeConfigs.data.game.eliteSkill2Num;
			break;
		case 3:
			result = num >= RuntimeConfigs.data.game.eliteStage3PlayerLevel && eliteLevel >= RuntimeConfigs.data.game.eliteSkill3Num;
			break;
		}
		return result;
	}

	private void OnPlayerLevelUpChange(BaseEventContent obj)
	{
		PlayerLevelChangeEvt obj2 = obj as PlayerLevelChangeEvt;
		int beforeLevel = obj2.beforeLevel;
		int curretLevel = obj2.curretLevel;
		if (curretLevel < RuntimeConfigs.data.game.eliteStage2PlayerLevel)
		{
			return;
		}
		List<Character> bagCharacters = CharacterDataHelper.GetBagCharacters();
		if (beforeLevel < RuntimeConfigs.data.game.eliteStage2PlayerLevel && curretLevel >= RuntimeConfigs.data.game.eliteStage2PlayerLevel)
		{
			foreach (Character item in bagCharacters)
			{
				int id = item.Id;
				if (item.EliteInfo.Levels.Count != 0)
				{
					int num = 0;
					foreach (KeyValuePair<int, int> level in item.EliteInfo.Levels)
					{
						num += level.Value;
					}
					if (num >= RuntimeConfigs.data.game.eliteSkill1Num)
					{
						string path = string.Format(RedDotPathDefine.Character + "|{0}|EliteEntrance", id);
						SetCharacterEliteRedDot(path, isShow: true);
						if (eliteTalentRedDotDic.TryGetValue(id, out var _))
						{
							eliteTalentRedDotDic[id] = true;
						}
						else
						{
							eliteTalentRedDotDic.Add(id, value: true);
						}
					}
				}
			}
			return;
		}
		if (beforeLevel >= RuntimeConfigs.data.game.eliteStage3PlayerLevel || curretLevel < RuntimeConfigs.data.game.eliteStage3PlayerLevel)
		{
			return;
		}
		foreach (Character item2 in bagCharacters)
		{
			int id2 = item2.Id;
			if (item2.EliteInfo.Levels.Count == 0)
			{
				continue;
			}
			int num2 = 0;
			foreach (KeyValuePair<int, int> level2 in item2.EliteInfo.Levels)
			{
				num2 += level2.Value;
			}
			if (num2 >= RuntimeConfigs.data.game.eliteSkill2Num)
			{
				string path2 = string.Format(RedDotPathDefine.Character + "|{0}|EliteEntrance", id2);
				SetCharacterEliteRedDot(path2, isShow: true);
				if (eliteTalentRedDotDic.TryGetValue(id2, out var _))
				{
					eliteTalentRedDotDic[id2] = true;
				}
				else
				{
					eliteTalentRedDotDic.Add(id2, value: true);
				}
			}
		}
	}

	public void SetCharacterEliteRedDot(string path, bool isShow)
	{
		Singleton<RedDotManager>.instance.SetLeafNodeActive(path, isShow);
	}
}

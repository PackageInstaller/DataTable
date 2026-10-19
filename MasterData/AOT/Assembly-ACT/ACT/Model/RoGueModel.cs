using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using Bamboo.ImageCenter;
using Fundamental;
using Pb;

namespace ACT.Model;

public class RoGueModel : Model<RoGueModel>
{
	public Dictionary<int, RogueCard> _RogueCards = new Dictionary<int, RogueCard>();

	public Dictionary<int, RogueArtifactCard> _RogueArtifacts = new Dictionary<int, RogueArtifactCard>();

	public List<RogueCard> _RogueCardList = new List<RogueCard>();

	public List<RogueArtifactCard> _RogueArtifactsList = new List<RogueArtifactCard>();

	public Dictionary<int, List<RogueSuit>> _RogueSuitData = new Dictionary<int, List<RogueSuit>>();

	public int CurrentStepId;

	public RogueStage CurrentRogueStage;

	public List<int> _RogueTableArtifacts = new List<int>();

	public int _RogueTableStageEffectId;

	public List<int> _RogueTableBuff = new List<int>();

	public int _RogueTableAllCost;

	public RogueInfoNtf info;

	public ImageAssetStation rogueStation;

	protected override void Init()
	{
		rogueStation = ImageManager.instance.GetAssetStation();
		InitRogueSuitData();
		CurrentStepId = 1;
	}

	protected override void UnInit()
	{
		RogueExit evt = Singleton<EventManager>.instance.GetEvt<RogueExit>();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_Exit, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		ImageManager.instance.UnloadAssetStation(rogueStation);
	}

	public void ReSet()
	{
		InitRogueSuitData();
		CurrentStepId = 1;
	}

	public void RogueInfo(RogueInfoNtf rogueInfoNtf)
	{
		info = rogueInfoNtf;
	}

	public void InitRogueTable(int raid)
	{
		CurrentRogueStage = CoreUtils.GetData(raid, RuntimeConfigs.data.rogueStages);
		if (_RogueTableStageEffectId == 0)
		{
			_RogueTableStageEffectId = CurrentRogueStage.tableStageEffect;
		}
	}

	public void ClearRogueTableData()
	{
		_RogueTableAllCost = 0;
		_RogueTableArtifacts.Clear();
		_RogueTableBuff.Clear();
		_RogueTableStageEffectId = 0;
	}

	public RogueCard GetRogueCardById(int id)
	{
		if (_RogueCards.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public RogueCard GetRogueCardData(int index)
	{
		return _RogueCardList[index];
	}

	public void RefreshCardList()
	{
		_RogueCardList = _RogueCards.Values.ToList();
	}

	public RogueArtifactCard GetRogueArtifactsData(int index)
	{
		return _RogueArtifactsList[index];
	}

	public void RefreshArtifactsList()
	{
		_RogueArtifactsList = _RogueArtifacts.Values.ToList();
	}

	public void AddRogueCards(RogueCard _rogueCard)
	{
		if (!_RogueCards.ContainsKey(_rogueCard.id))
		{
			_RogueCards.Add(_rogueCard.id, _rogueCard);
			AddCardEvent(_rogueCard);
		}
	}

	public void AddRogueArtifacts(RogueArtifactCard _rogueArtifact)
	{
		_RogueArtifacts.Add(_rogueArtifact.id, _rogueArtifact);
		RogueAddArtifactEvent evt = Singleton<EventManager>.instance.GetEvt<RogueAddArtifactEvent>();
		evt.artifact = _rogueArtifact;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_AddArtifact, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void RemoveRogueCards(RogueCard _rogueCard)
	{
		_RogueCards.Remove(_rogueCard.id);
	}

	public RogueCard CompositeRogueCard(RogueCard _MainCard, RogueCard _VicerogueCard)
	{
		if (_RogueCards.ContainsKey(_MainCard.id) && _RogueCards.ContainsKey(_VicerogueCard.id))
		{
			RogueComposeCardEvent rogueComposeCardEvent = new RogueComposeCardEvent();
			List<int> list = new List<int>();
			list.AddRange(_MainCard.effects);
			rogueComposeCardEvent.baseCard1 = new RogueCard(_MainCard.id, _MainCard.triggerId, list, _MainCard.level, _MainCard.suitid);
			rogueComposeCardEvent.baseCard2 = _VicerogueCard;
			for (int i = 0; i < _VicerogueCard.effects.Count; i++)
			{
				_RogueCards[_MainCard.id].effects.Add(_VicerogueCard.effects[i]);
			}
			RemoveRogueCards(_VicerogueCard);
			_RogueCards[_MainCard.id].level++;
			rogueComposeCardEvent.composeCard = _RogueCards[_MainCard.id];
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_ComposeCard, rogueComposeCardEvent);
			Singleton<EventManager>.instance.ReleaseEvt(rogueComposeCardEvent);
		}
		return _RogueCards[_MainCard.id];
	}

	private void AddCardEvent(RogueCard rogueCard)
	{
		RogueAddCardEvent evt = Singleton<EventManager>.instance.GetEvt<RogueAddCardEvent>();
		evt.rogueCard = rogueCard;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_AddCard, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public List<T> GetRandomElements<T>(IEnumerable<T> list, int elementsCount)
	{
		return list.OrderBy((T arg) => Guid.NewGuid()).Take(elementsCount).ToList();
	}

	public void RemoveCardEvent(RogueCard rogueCard)
	{
		RogueRemoveCardEvent evt = Singleton<EventManager>.instance.GetEvt<RogueRemoveCardEvent>();
		evt.rogueCard = rogueCard;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_RemoveCard, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public int GetHaveCardNumBySuit(int suit)
	{
		int num = 0;
		foreach (KeyValuePair<int, RogueCard> rogueCard in _RogueCards)
		{
			for (int i = 0; i < rogueCard.Value.effects.Count; i++)
			{
				if (CoreUtils.GetData(rogueCard.Value.effects[i], RuntimeConfigs.data.rogueEffectCards).suit == suit)
				{
					num++;
				}
			}
		}
		return num;
	}

	public void InitRogueSuitData()
	{
		if (_RogueSuitData.Count > 0)
		{
			_RogueSuitData.Clear();
		}
		Dictionary<int, RogueSuit> dictionary = new Dictionary<int, RogueSuit>(RuntimeConfigs.data.rogueSuits);
		if (dictionary == null)
		{
			return;
		}
		foreach (KeyValuePair<int, RogueSuit> item in dictionary)
		{
			if (_RogueSuitData.TryGetValue(item.Value.suitID, out var value))
			{
				value.Add(item.Value);
				continue;
			}
			_RogueSuitData.Add(item.Value.suitID, new List<RogueSuit> { item.Value });
		}
	}

	public List<RogueSuit> GetRogueSuitsBySuitsID(int suitsid)
	{
		if (_RogueSuitData.TryGetValue(suitsid, out var value))
		{
			return value;
		}
		return null;
	}

	public RogueSuit GetRogueSuitByIdandCount(int suitsid, int count)
	{
		List<RogueSuit> rogueSuitsBySuitsID = GetRogueSuitsBySuitsID(suitsid);
		if (rogueSuitsBySuitsID != null)
		{
			for (int i = 0; i < rogueSuitsBySuitsID.Count; i++)
			{
				if (count >= rogueSuitsBySuitsID.Count)
				{
					return rogueSuitsBySuitsID[rogueSuitsBySuitsID.Count];
				}
				if (count == rogueSuitsBySuitsID[i].num)
				{
					return rogueSuitsBySuitsID[i];
				}
			}
		}
		return null;
	}

	public int GetSuitWeightById(int suitsid)
	{
		int haveCardNumBySuit = GetHaveCardNumBySuit(suitsid);
		RogueSuit rogueSuitByIdandCount = GetRogueSuitByIdandCount(suitsid, haveCardNumBySuit);
		if (rogueSuitByIdandCount == null)
		{
			return 100;
		}
		return (int)(rogueSuitByIdandCount.weight * 100f);
	}

	public int GetCardWeightById(int rogueEffectCards)
	{
		RogueEffectCard data = CoreUtils.GetData(rogueEffectCards, RuntimeConfigs.data.rogueEffectCards);
		return data.weight * GetSuitWeightById(data.suit);
	}

	public Dictionary<int, RogueEffectCard> GetRogueEffectCardsByCurrentSpetId()
	{
		Dictionary<int, RogueEffectCard> dictionary = new Dictionary<int, RogueEffectCard>();
		RogueStep data = CoreUtils.GetData(Model<RoGueModel>.Interface.CurrentStepId, RuntimeConfigs.data.rogueSteps);
		if (data != null)
		{
			for (int i = 0; i < data.effectList.Length; i++)
			{
				RogueEffectCard data2 = CoreUtils.GetData(data.effectList[i], RuntimeConfigs.data.rogueEffectCards);
				if (data2 != null)
				{
					dictionary.Add(data2.id, data2);
				}
			}
		}
		return dictionary;
	}

	public Dictionary<int, RogueTriggerCard> GetRogueTriggerCardsByCurrentSpetId()
	{
		Dictionary<int, RogueTriggerCard> dictionary = new Dictionary<int, RogueTriggerCard>();
		RogueStep data = CoreUtils.GetData(Model<RoGueModel>.Interface.CurrentStepId, RuntimeConfigs.data.rogueSteps);
		if (data != null)
		{
			for (int i = 0; i < data.triggerList.Length; i++)
			{
				RogueTriggerCard data2 = CoreUtils.GetData(data.triggerList[i], RuntimeConfigs.data.rogueTriggerCards);
				if (data2 != null)
				{
					dictionary.Add(data2.id, data2);
				}
			}
		}
		return dictionary;
	}

	public void AddTableArtfact(int id)
	{
		if (!_RogueTableArtifacts.Contains(id))
		{
			_RogueTableArtifacts.Add(id);
		}
	}

	public void RemoveTableArtfact(int id)
	{
		if (_RogueTableArtifacts.Contains(id))
		{
			_RogueTableArtifacts.Remove(id);
		}
	}

	public void ChangeTableGlobalEffect(int id)
	{
		_RogueTableStageEffectId = id;
	}

	public void AddTableOptionalCard(int id)
	{
		if (!_RogueTableBuff.Contains(id))
		{
			_RogueTableBuff.Add(id);
		}
	}

	public void RemoveTableOptionalCard(int id)
	{
		if (_RogueTableBuff.Contains(id))
		{
			_RogueTableBuff.Remove(id);
		}
	}

	public void SendRogueChallenge(int level, int[] teamcharacterIds)
	{
	}
}

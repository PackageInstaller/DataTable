using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

namespace RogueCard;

public class RogueCardGuideSystem
{
	public bool isLock;

	public bool IsDragLocked;

	public List<int> lockIndex = new List<int>();

	public LockItemType lockType;

	public bool IsGuiding { get; private set; }

	public void Init()
	{
	}

	public void OnDispose()
	{
		SetGuiding(isGuiding: false);
		UnlockCard();
	}

	public void SetGuiding(bool isGuiding)
	{
		IsGuiding = isGuiding;
	}

	public bool CheckScorePause(int stepID)
	{
		return (bool)LuaHelper.CallFunction("RogueCardGameBridge.CheckScorePause", stepID)[0];
	}

	public bool CheckGuide(RogueCardGuideMoment moment, bool ignoreGuideState = false)
	{
		if (moment != RogueCardGuideMoment.beginning && !IsGuiding && !ignoreGuideState)
		{
			return false;
		}
		string text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_{RogueCardGameMain.GameContext.curRound}_{(int)RogueCardGameMain.GameContext.curStageState}_{moment}";
		if (moment == RogueCardGuideMoment.beginning)
		{
			text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_1_1_{moment}";
		}
		bool num = (bool)LuaHelper.CallFunction("RogueCardGameBridge.CheckGuideData", text)[0];
		if (num)
		{
			Debug.Log("Guide Success");
		}
		return num;
	}

	public List<RogueCardGuideCard> GetGuideRogueCards(RogueCardGuideMoment moment)
	{
		_ = RogueCardGameMain.GameContext.stageID;
		string text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_{RogueCardGameMain.GameContext.curRound}_{(int)RogueCardGameMain.GameContext.curStageState}_{moment}";
		object[] array = LuaHelper.CallFunction("RogueCardGameBridge.GetGuideData", text);
		List<RogueCardGuideCard> list = new List<RogueCardGuideCard>();
		object[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			for (int j = 1; j <= luaTable.Length; j++)
			{
				LuaTable obj = luaTable[j] as LuaTable;
				int suit = (int)(double)obj[1];
				int rank = (int)(double)obj[2];
				list.Add(new RogueCardGuideCard
				{
					suit = suit,
					rank = rank
				});
			}
		}
		return list;
	}

	public List<RogueCardGuideItem> GetGuideItems(RogueCardGuideMoment moment)
	{
		_ = RogueCardGameMain.GameContext.stageID;
		string text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_{RogueCardGameMain.GameContext.curRound}_{(int)RogueCardGameMain.GameContext.curStageState}_{moment}";
		if (moment == RogueCardGuideMoment.beginning)
		{
			text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_1_1_{moment}";
		}
		object[] array = LuaHelper.CallFunction("RogueCardGameBridge.GetGuideData", text);
		List<RogueCardGuideItem> list = new List<RogueCardGuideItem>();
		object[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			for (int j = 1; j <= luaTable.Length; j++)
			{
				LuaTable luaTable2 = luaTable[j] as LuaTable;
				int id = (int)(double)luaTable2[1];
				int versionID = 0;
				if (luaTable2.Length > 1)
				{
					versionID = (int)(double)luaTable2[2];
				}
				list.Add(new RogueCardGuideItem
				{
					id = id,
					versionID = versionID
				});
			}
		}
		return list;
	}

	public List<int> GetGuideID(RogueCardGuideMoment moment)
	{
		_ = RogueCardGameMain.GameContext.stageID;
		string text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_{RogueCardGameMain.GameContext.curRound}_{(int)RogueCardGameMain.GameContext.curStageState}_{moment}";
		if (moment == RogueCardGuideMoment.beginning)
		{
			text = $"rogue_card_{RogueCardGameMain.GameContext.stageID}_teach_1_1_{moment}";
		}
		object[] array = LuaHelper.CallFunction("RogueCardGameBridge.GetGuideData", text);
		List<int> list = new List<int>();
		object[] array2 = array;
		for (int i = 0; i < array2.Length; i++)
		{
			LuaTable luaTable = array2[i] as LuaTable;
			for (int j = 1; j <= luaTable.Length; j++)
			{
				int item = (int)(double)luaTable[j];
				list.Add(item);
			}
		}
		return list;
	}

	public void LockCard(int type, int[] lockIndex)
	{
		lockType = (LockItemType)type;
		this.lockIndex.Clear();
		this.lockIndex.AddRange(lockIndex);
		isLock = true;
		if (type == 1)
		{
			IsDragLocked = true;
		}
	}

	public void UnlockCard()
	{
		lockType = LockItemType.None;
		lockIndex.Clear();
		isLock = false;
		IsDragLocked = false;
	}

	public bool CheckInput(LockItemType type, int index)
	{
		if (type == lockType && lockIndex.Contains(index))
		{
			return false;
		}
		return true;
	}
}

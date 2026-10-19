using System;
using System.Collections.Generic;
using ACT.Core;
using ACT.Game;
using ACT.Model;

namespace ACT.DialogueSystem;

public class LuminDialogueFlowProcessor : DialogueFlowProcessor
{
	public static string[] BodyStateNames = new string[30]
	{
		"diantou01", "yaotou01", "yaotou02", "yaotou03", "baoxiong01", "baoxiong02", "chayao01", "chayao02", "sikao01", "fuxiong01",
		"fuxiong02", "jingya01", "jingya02", "tanshou01", "motou01", "talk01", "talk02", "talk03", "talk04", "talk05",
		"diantou", "yaotou", "woquan", "baoxiong", "chayao", "sikao", "jingya", "xiaoji", "dichu", "shoushang"
	};

	public static string[] FaceStateNames = new string[9] { "weixiao", "daxiao", "yansu", "bukuai", "shengqi", "weiqu", "beishang", "jingya", "haixiu" };

	public LuminDialogueFlow TData => Data as LuminDialogueFlow;

	public LuminDialogueRootProcessor TRoot => Root as LuminDialogueRootProcessor;

	public LuminDialogueFlowProcessor(LuminDialogueFlow data)
		: base(data)
	{
	}

	public List<int> GetKeyWords(long avgId)
	{
		List<int> list = new List<int>();
		switch (TData.dialogueType)
		{
		case LuminDialogueFlowType.AVG:
		{
			if (!RuntimeConfigs.data.dialogueAVGDatas.TryGetValue(avgId, out var value3))
			{
				break;
			}
			int[] keyWords = value3.keyWords;
			foreach (int num3 in keyWords)
			{
				if (!Model<TextLibraryModel>.Interface.TextLibraryIsUnLock(num3))
				{
					list.Add(num3);
				}
			}
			break;
		}
		case LuminDialogueFlowType.AVG_Mission:
		{
			if (!RuntimeConfigs.data.dialogueMissionAVGDatas.TryGetValue(avgId, out var value2))
			{
				break;
			}
			int[] keyWords = value2.keyWords;
			foreach (int num2 in keyWords)
			{
				if (!Model<TextLibraryModel>.Interface.TextLibraryIsUnLock(num2))
				{
					list.Add(num2);
				}
			}
			break;
		}
		case LuminDialogueFlowType.AVG_NPC:
		{
			if (!RuntimeConfigs.data.dialogueNPCAVGDatas.TryGetValue(avgId, out var value))
			{
				break;
			}
			int[] keyWords = value.keyWords;
			foreach (int num in keyWords)
			{
				if (!Model<TextLibraryModel>.Interface.TextLibraryIsUnLock(num))
				{
					list.Add(num);
				}
			}
			break;
		}
		}
		return list;
	}

	public int GetGenderContentId(long avgId)
	{
		switch (TData.dialogueType)
		{
		case LuminDialogueFlowType.AVG:
		{
			if (RuntimeConfigs.data.dialogueAVGDatas.TryGetValue(avgId, out var value2))
			{
				if (G.detailUserInfo.Brief.Gender != 1)
				{
					return value2.content;
				}
				if (value2.maleContent != 0)
				{
					return value2.maleContent;
				}
				return value2.content;
			}
			break;
		}
		case LuminDialogueFlowType.AVG_Mission:
		{
			if (RuntimeConfigs.data.dialogueMissionAVGDatas.TryGetValue(avgId, out var value3))
			{
				if (G.detailUserInfo.Brief.Gender != 1)
				{
					return value3.content;
				}
				if (value3.maleContent != 0)
				{
					return value3.maleContent;
				}
				return value3.content;
			}
			break;
		}
		case LuminDialogueFlowType.AVG_NPC:
		{
			if (RuntimeConfigs.data.dialogueNPCAVGDatas.TryGetValue(avgId, out var value))
			{
				if (G.detailUserInfo.Brief.Gender != 1)
				{
					return value.content;
				}
				if (value.maleContent != 0)
				{
					return value.maleContent;
				}
				return value.content;
			}
			break;
		}
		}
		return 0;
	}

	public int GetContentId(long avgId)
	{
		switch (TData.dialogueType)
		{
		case LuminDialogueFlowType.AVG:
		{
			if (RuntimeConfigs.data.dialogueAVGDatas.TryGetValue(avgId, out var value2))
			{
				return value2.content;
			}
			break;
		}
		case LuminDialogueFlowType.AVG_Mission:
		{
			if (RuntimeConfigs.data.dialogueMissionAVGDatas.TryGetValue(avgId, out var value3))
			{
				return value3.content;
			}
			break;
		}
		case LuminDialogueFlowType.AVG_NPC:
		{
			if (RuntimeConfigs.data.dialogueNPCAVGDatas.TryGetValue(avgId, out var value))
			{
				return value.content;
			}
			break;
		}
		}
		return 0;
	}

	public static string GetBodyStateName(int bodyAnimId)
	{
		if (bodyAnimId > 0 && bodyAnimId <= BodyStateNames.Length)
		{
			return BodyStateNames[bodyAnimId - 1];
		}
		if (bodyAnimId > 100)
		{
			return "special" + (bodyAnimId - 100).ToString("00");
		}
		return string.Empty;
	}

	public static string GetFaceStateName(int faceAnimId)
	{
		if (faceAnimId > 0 && faceAnimId <= FaceStateNames.Length)
		{
			return FaceStateNames[faceAnimId - 1];
		}
		return string.Empty;
	}

	public static string GetFaceSpecialStateName(int actorId, string bodyAnimName)
	{
		if (actorId > 100 && !string.IsNullOrEmpty(bodyAnimName) && bodyAnimName.StartsWith("special", StringComparison.Ordinal))
		{
			if (!RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(actorId, out var value))
			{
				return string.Empty;
			}
			if (!int.TryParse(bodyAnimName.Substring("special".Length), out var result))
			{
				return string.Empty;
			}
			switch (result)
			{
			case 1:
				return value.faceSpecial01;
			case 2:
				return value.faceSpecial02;
			case 3:
				return value.faceSpecial03;
			case 4:
				return value.faceSpecial04;
			case 5:
				return value.faceSpecial05;
			case 6:
				return value.faceSpecial06;
			case 7:
				return value.faceSpecial07;
			}
		}
		return string.Empty;
	}
}

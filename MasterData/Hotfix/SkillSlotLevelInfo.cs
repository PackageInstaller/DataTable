using System.Collections.Generic;

public class SkillSlotLevelInfo
{
	private readonly Dictionary<ActionKey, int> _skillSlotBaseLvBindDict = new Dictionary<ActionKey, int>();

	private readonly Dictionary<ActionKey, int> _skillSlotAmendLvBindDict = new Dictionary<ActionKey, int>();

	public void CopyValueFrom(PlayerSkillCd from)
	{
		if (from == null)
		{
			return;
		}
		foreach (KeyValuePair<ActionKey, int> item in from.SkillSlotBaseLvBindDict)
		{
			_skillSlotBaseLvBindDict.Add(item.Key, item.Value);
		}
		foreach (KeyValuePair<ActionKey, int> item2 in from.SkillSlotAmendLvBindDict)
		{
			_skillSlotAmendLvBindDict.Add(item2.Key, item2.Value);
		}
	}

	public int GetSkillLevel(ActionKey actionKey)
	{
		_skillSlotBaseLvBindDict.TryGetValue(actionKey, out var value);
		_skillSlotAmendLvBindDict.TryGetValue(actionKey, out var value2);
		return value + value2;
	}

	public void Clear()
	{
		_skillSlotBaseLvBindDict.Clear();
		_skillSlotAmendLvBindDict.Clear();
	}
}

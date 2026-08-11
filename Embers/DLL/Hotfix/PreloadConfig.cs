using System;
using System.Collections.Generic;

[Serializable]
public class PreloadConfig
{
	public Dictionary<int, List<int>> collectEffectIdDic;

	public Dictionary<int, List<int>> collectBehaviourTreeIdDic;

	public Dictionary<int, List<string>> collectBattleEntityDic;

	public Dictionary<int, List<string>> collectSummonedEntityDic;

	public Dictionary<int, List<string>> collectTimelineDic;

	public Dictionary<int, List<int>> collectCopyTreeDic;

	public Dictionary<int, List<int>> collectCopyEffectDic;

	public Dictionary<int, Dictionary<int, List<int>>> collectCopyMapItemDic;

	public Dictionary<int, List<int>> collectCopyMonsterDic;

	public PreloadConfig()
	{
		collectEffectIdDic = new Dictionary<int, List<int>>();
		collectBehaviourTreeIdDic = new Dictionary<int, List<int>>();
		collectBattleEntityDic = new Dictionary<int, List<string>>();
		collectTimelineDic = new Dictionary<int, List<string>>();
		collectCopyMapItemDic = new Dictionary<int, Dictionary<int, List<int>>>();
		collectCopyMonsterDic = new Dictionary<int, List<int>>();
		collectSummonedEntityDic = new Dictionary<int, List<string>>();
		collectCopyTreeDic = new Dictionary<int, List<int>>();
		collectCopyEffectDic = new Dictionary<int, List<int>>();
	}
}

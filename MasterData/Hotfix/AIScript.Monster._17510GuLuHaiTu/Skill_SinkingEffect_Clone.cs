#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_SinkingEffect_Clone : SkillScript_Base
{
	private CoroutineNode updateSinkingEffectCor;

	private CoroutineNode updateSafeFloorCor;

	private LogicEntity master;

	private readonly string effectDicTagName = "TagDicSinkingEffet";

	private Dictionary<TSVector2, long> tagDicSinkingEffet = new Dictionary<TSVector2, long>();

	private Dictionary<int, TSVector2> localDicSafePos = new Dictionary<int, TSVector2>();

	private Dictionary<TSVector2, string> breakTriggerlD = new Dictionary<TSVector2, string>
	{
		{
			new TSVector2(-8, 8),
			"Coast_Main_7_1_Floor01g"
		},
		{
			new TSVector2(0, 8),
			"Coast_Main_7_1_Floor01h"
		},
		{
			new TSVector2(8, 8),
			"Coast_Main_7_1_Floor01i"
		},
		{
			new TSVector2(-8, 0),
			"Coast_Main_7_1_Floor01d"
		},
		{
			new TSVector2(0, 0),
			"Coast_Main_7_1_Floor01e"
		},
		{
			new TSVector2(8, 0),
			"Coast_Main_7_1_Floor01f"
		},
		{
			new TSVector2(-8, -8),
			"Coast_Main_7_1_Floor01a"
		},
		{
			new TSVector2(0, -8),
			"Coast_Main_7_1_Floor01b"
		},
		{
			new TSVector2(8, -8),
			"Coast_Main_7_1_Floor01c"
		}
	};

	private Dictionary<TSVector2, string> repaireTriggerlD = new Dictionary<TSVector2, string>
	{
		{
			new TSVector2(-8, 8),
			"Coast_Main_7_1_Floor01g_Repair"
		},
		{
			new TSVector2(0, 8),
			"Coast_Main_7_1_Floor01h_Repair"
		},
		{
			new TSVector2(8, 8),
			"Coast_Main_7_1_Floor01i_Repair"
		},
		{
			new TSVector2(-8, 0),
			"Coast_Main_7_1_Floor01d_Repair"
		},
		{
			new TSVector2(0, 0),
			"Coast_Main_7_1_Floor01e_Repair"
		},
		{
			new TSVector2(8, 0),
			"Coast_Main_7_1_Floor01f_Repair"
		},
		{
			new TSVector2(-8, -8),
			"Coast_Main_7_1_Floor01a_Repair"
		},
		{
			new TSVector2(0, -8),
			"Coast_Main_7_1_Floor01b_Repair"
		},
		{
			new TSVector2(8, -8),
			"Coast_Main_7_1_Floor01c_Repair"
		}
	};

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔分身.开始");
		master = GetMonsterCloner();
		localDicSafePos = GetSafePosFromTag();
		SetLogicTagDicTSVector2LongValue(master, effectDicTagName, tagDicSinkingEffet);
		SetLogicTagToggleValue(master, "IsCloneUpdatePos", value: false);
	}

	protected override void OnSkillDisable()
	{
		StopCor(updateSinkingEffectCor);
		StopCor(updateSafeFloorCor);
		NovaLogger.Debug("咕噜海兔分身.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		updateSafeFloorCor = StartCor(UpdateFloorAndAreaEffect());
		yield return StartCor(EndCondition());
	}

	private IEnumerator EndCondition()
	{
		while (!master.IsDead())
		{
			yield return WaitTime(0.2);
		}
		NovaLogger.Debug("咕噜海兔分身.下沉效果.主人死亡结束");
	}

	private IEnumerator UpdateFloorAndAreaEffect()
	{
		while (true)
		{
			if (GetLogicTagToggleValue(master, "IsCloneUpdatePos"))
			{
				Dictionary<int, TSVector2> tagDicSafePos = GetSafePosFromTag();
				if (tagDicSafePos.Count != localDicSafePos.Count)
				{
					List<TSVector2> differencePOS = new List<TSVector2>();
					if (tagDicSafePos.Count > localDicSafePos.Count)
					{
						NovaLogger.Debug("咕噜海兔分身.移除区域效果");
						SetLogicTagToggleValue(_actor, SkillScript_Base.sinkStateTag, value: false);
						List<LogicEntity> targetEntity = new List<LogicEntity> { GetCurrentPlayer() };
						List<LogicEntity> buffLogicEntity = new List<LogicEntity>();
						buffLogicEntity.AddRange(GetTargetByBuffID(175100030, targetEntity));
						while (buffLogicEntity != null && buffLogicEntity.Count > 0)
						{
							NovaLogger.Debug("咕噜海兔分身.玩家处于下沉中,延迟关闭区域效果");
							yield return WaitTime(0.1);
							buffLogicEntity.Clear();
							buffLogicEntity.AddRange(GetTargetByBuffID(175100030, targetEntity));
						}
						foreach (KeyValuePair<int, TSVector2> item in tagDicSafePos)
						{
							if (!localDicSafePos.ContainsValue(item.Value))
							{
								differencePOS.Add(new TSVector2(item.Value.x, item.Value.y));
							}
						}
						foreach (TSVector2 item2 in differencePOS)
						{
							if (tagDicSinkingEffet.TryGetValue(item2, out var value))
							{
								NovaLogger.Debug("咕噜海兔分身.开始关闭区域效果");
								StopAreaEffect(value);
								NovaLogger.Debug("咕噜海兔分身.结束关闭区域效果");
								tagDicSinkingEffet.Remove(item2);
								if (repaireTriggerlD.TryGetValue(item2, out var value2))
								{
									TriggerOpLisener(value2);
								}
								else
								{
									NovaLogger.Debug("咕噜海兔分身.修复地板TL自定义事件异常");
								}
							}
						}
						SetLogicTagToggleValue(_actor, SkillScript_Base.sinkStateTag, value: true);
					}
					else
					{
						NovaLogger.Debug("咕噜海兔分身.增加区域效果");
						foreach (KeyValuePair<int, TSVector2> localDicSafePo in localDicSafePos)
						{
							if (!tagDicSafePos.ContainsValue(localDicSafePo.Value))
							{
								differencePOS.Add(new TSVector2(localDicSafePo.Value.x, localDicSafePo.Value.y));
							}
						}
						foreach (TSVector2 item3 in differencePOS)
						{
							if (!tagDicSinkingEffet.ContainsKey(item3))
							{
								NovaLogger.Debug("咕噜海兔分身.开始释放区域效果");
								long value3 = PlayAreaEffect("Sink", item3, 0);
								NovaLogger.Debug("咕噜海兔分身.结束释放区域效果");
								tagDicSinkingEffet.Add(new TSVector2(item3.x, item3.y), value3);
								if (breakTriggerlD.TryGetValue(item3, out var value4))
								{
									TriggerOpLisener(value4);
								}
								else
								{
									NovaLogger.Debug("咕噜海兔分身.破坏地板TL自定义事件异常");
								}
							}
						}
					}
					localDicSafePos = GetSafePosFromTag();
				}
				SetLogicTagToggleValue(master, "IsCloneUpdatePos", value: false);
			}
			yield return null;
		}
	}

	private Dictionary<int, TSVector2> GetSafePosFromTag()
	{
		Dictionary<int, TSVector2> logicTagDicIntTSVector2Value = GetLogicTagDicIntTSVector2Value(master, "safeFloor");
		Dictionary<int, TSVector2> dictionary = new Dictionary<int, TSVector2>();
		if (logicTagDicIntTSVector2Value != null && logicTagDicIntTSVector2Value.Count > 0)
		{
			foreach (KeyValuePair<int, TSVector2> item in logicTagDicIntTSVector2Value)
			{
				dictionary.Add(item.Key, new TSVector2(item.Value.x, item.Value.y));
			}
		}
		return dictionary;
	}
}

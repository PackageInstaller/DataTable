using System.Collections.Generic;
using Ase;

public class AchievementConditionAnnotation
{
	public static Dictionary<int, string> ConditionAnnotationDic = new Dictionary<int, string>
	{
		{ 6001, "事件执行者ConfigID" },
		{ 6002, "技能ID" },
		{ 6003, "事件接受者ConfigID" },
		{ 6004, "指令ID" },
		{ 6005, "状态ID（State表）" },
		{ 6006, "弱点等级（Weakness表）" },
		{ 6007, "BuffID" },
		{ 6008, "受击盒等级(HitBox表)" },
		{ 6009, "是否暴击 " },
		{ 6010, "执行者是否为自己 " },
		{ 6011, "接受者是否为自己 " },
		{ 6012, "是否通关 " },
		{ 6013, "怪物种类 " },
		{ 6014, "怪物ID " },
		{ 60041, "技能执行状态=> 对应的枚举 SkillExecuteState" },
		{ 8001, "执行次数" },
		{ 8002, "伤害(计算过防御后的伤害)" },
		{ 8003, "恢复血量" },
		{ 8004, "恢复耐力" },
		{ 8005, "击杀次数" },
		{ 8006, "暴击次数" }
	};

	public static List<int> AnyConditionList = new List<int> { 6010, 6012, 6013, 6014 };

	public static Dictionary<BattleObserverEventEnum, List<int>> BattleObserverEventConditionDic = new Dictionary<BattleObserverEventEnum, List<int>>
	{
		{
			BattleObserverEventEnum.ReleaseSkill,
			new List<int> { 6001, 6002, 6004, 6012, 8001 }
		},
		{
			BattleObserverEventEnum.ChangeState,
			new List<int> { 6001, 6005, 8001 }
		},
		{
			BattleObserverEventEnum.InteractiveSuccess,
			new List<int> { 6001, 8001 }
		},
		{
			BattleObserverEventEnum.ExcuteBuff,
			new List<int> { 6001, 6003, 6007, 8001 }
		},
		{
			BattleObserverEventEnum.Hit,
			new List<int> { 6001, 6002, 6003, 6005, 6006, 6008, 6009, 8002, 8005 }
		},
		{
			BattleObserverEventEnum.RescueSuccess,
			new List<int> { 6001, 6003, 8001 }
		},
		{
			BattleObserverEventEnum.Recover,
			new List<int> { 6001, 6002, 6003, 8003 }
		}
	};
}

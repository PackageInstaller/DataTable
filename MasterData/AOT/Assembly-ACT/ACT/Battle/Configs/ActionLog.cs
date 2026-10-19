using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行日志", "Action", new string[] { "log" })]
public class ActionLog : ConfigAction
{
	public string log;

	public AbilityLogEnum logEnum;

	protected override AbilityAuth defaultAuth => AbilityAuth.Both;

	public override void Do(ActionMemory memory)
	{
		string text = "";
		foreach (AbilityLogEnum value in Enum.GetValues(typeof(AbilityLogEnum)))
		{
			if ((logEnum & value) > AbilityLogEnum.none)
			{
				switch (value)
				{
				case AbilityLogEnum.abilityCurStack:
					text = text + "当前层数" + memory.ability.stack;
					break;
				case AbilityLogEnum.abilityCurDuration:
					text = ((memory.ability == null || memory.ability.config == null) ? (text + "当前持续时间未知") : (text + "当前持续时间" + (memory.ability.config.fDuration.GetFloat(memory.ability) - memory.ability.time)));
					break;
				case AbilityLogEnum.curTIme:
					text = text + "当前时间" + Time.time;
					break;
				}
			}
		}
		text += log;
		_ = LuminApplication.LogEnabled;
	}
}

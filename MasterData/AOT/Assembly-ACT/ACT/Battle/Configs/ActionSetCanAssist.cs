using System;
using System.Linq;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置援护", "Action", new string[] { "set", "can", "assist" })]
public class ActionSetCanAssist : ConfigAction
{
	private enum Mode
	{
		Before,
		After
	}

	private Mode mode;

	public ConfigPredicate[] beforePredicates;

	public ConfigPredicate[] afterPredicates;

	public override void Do(ActionMemory memory)
	{
		BaseEvt evt = memory.evt;
		EvtTryAssist evtTryAssist = evt as EvtTryAssist;
		if (evtTryAssist == null)
		{
			return;
		}
		switch (mode)
		{
		case Mode.Before:
			if (!evtTryAssist.before.Equals(memory.owner))
			{
				return;
			}
			break;
		case Mode.After:
			if (!evtTryAssist.after.Equals(memory.owner))
			{
				return;
			}
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		bool flag = true;
		flag &= beforePredicates.Aggregate(seed: true, (bool current, ConfigPredicate predicate) => current & predicate.Check(new ActionMemory(memory.caster, memory.owner, evtTryAssist.before, memory.evt, memory.ability)));
		flag &= afterPredicates.Aggregate(flag, (bool current, ConfigPredicate predicate) => current & predicate.Check(new ActionMemory(memory.caster, memory.owner, evtTryAssist.after, memory.evt, memory.ability)));
		evtTryAssist.canAssist = flag;
	}
}

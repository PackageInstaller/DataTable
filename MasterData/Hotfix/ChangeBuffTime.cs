[AdventureEffect(HotfixEnum.effectType.CHANGE_BUFF_TIME)]
public class ChangeBuffTime : AdventureEffectBase
{
	private int buffId;

	private int buffGroupId;

	private int buffTag;

	private int changeTimeAbs;

	private int changeTimePercent;

	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue) && TryParseStringParamToInt(effectValueConfig.EffectTypeParam3, out var intValue2))
		{
			switch (intValue)
			{
			case 1:
				TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out buffId);
				break;
			case 2:
				TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out buffGroupId);
				break;
			case 3:
				buffTag = CommonHelper.StringToHash(effectValueConfig.EffectTypeParam2);
				break;
			}
			switch (intValue2)
			{
			case 1:
				TryParseStringParamToInt(effectValueConfig.EffectTypeParam4, out changeTimeAbs);
				break;
			case 2:
				TryParseStringParamToInt(effectValueConfig.EffectTypeParam4, out changeTimePercent);
				break;
			}
			for (int i = 0; i < _targets.Count; i++)
			{
				AdventureActorChangeBuffTimeEffectExecute adventureActorChangeBuffTimeEffectExecute = AdventureActorChangeBuffTimeEffectExecute.Generate();
				adventureActorChangeBuffTimeEffectExecute.sender = _targets.get_Item(i);
				adventureActorChangeBuffTimeEffectExecute.buffId = buffId;
				adventureActorChangeBuffTimeEffectExecute.buffGroupId = buffGroupId;
				adventureActorChangeBuffTimeEffectExecute.buffTag = buffTag;
				adventureActorChangeBuffTimeEffectExecute.changeTimeAbs = changeTimeAbs;
				adventureActorChangeBuffTimeEffectExecute.changeTimePercent = changeTimePercent;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorChangeBuffTimeEffectExecute);
				_targets.get_Item(i).buffComponent?.SetBuffTime(changeTimeAbs, changeTimePercent, buffId, buffGroupId, buffTag);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			AdventureActorChangeBuffTimeEffectPostExecute adventureActorChangeBuffTimeEffectPostExecute = AdventureActorChangeBuffTimeEffectPostExecute.Generate();
			adventureActorChangeBuffTimeEffectPostExecute.sender = _targets.get_Item(i);
			adventureActorChangeBuffTimeEffectPostExecute.buffId = buffId;
			adventureActorChangeBuffTimeEffectPostExecute.buffGroupId = buffGroupId;
			adventureActorChangeBuffTimeEffectPostExecute.buffTag = buffTag;
			adventureActorChangeBuffTimeEffectPostExecute.changeTimeAbs = changeTimeAbs;
			adventureActorChangeBuffTimeEffectPostExecute.changeTimePercent = changeTimePercent;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorChangeBuffTimeEffectPostExecute);
		}
	}
}

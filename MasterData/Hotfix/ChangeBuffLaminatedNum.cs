[AdventureEffect(HotfixEnum.effectType.CHANGE_BUFF_LAMINATEDNUM)]
public class ChangeBuffLaminatedNum : AdventureEffectBase
{
	private int buffId;

	private int buffGroupId;

	private int buffTag;

	private int changeNum;

	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue) && TryParseStringParamToInt(effectValueConfig.EffectTypeParam3, out changeNum))
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
			for (int i = 0; i < _targets.Count; i++)
			{
				AdventureActorChangeBuffLaminatedNumEffectExecute adventureActorChangeBuffLaminatedNumEffectExecute = AdventureActorChangeBuffLaminatedNumEffectExecute.Generate();
				adventureActorChangeBuffLaminatedNumEffectExecute.sender = _targets.get_Item(i);
				adventureActorChangeBuffLaminatedNumEffectExecute.buffId = buffId;
				adventureActorChangeBuffLaminatedNumEffectExecute.buffGroupId = buffGroupId;
				adventureActorChangeBuffLaminatedNumEffectExecute.buffTag = buffTag;
				adventureActorChangeBuffLaminatedNumEffectExecute.changeNum = changeNum;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorChangeBuffLaminatedNumEffectExecute);
				_targets.get_Item(i).buffComponent?.AdjustBuffNum(changeNum, buffId, buffGroupId, buffTag);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			AdventureActorChangeBuffLaminatedNumEffectPostExecute adventureActorChangeBuffLaminatedNumEffectPostExecute = AdventureActorChangeBuffLaminatedNumEffectPostExecute.Generate();
			adventureActorChangeBuffLaminatedNumEffectPostExecute.sender = _targets.get_Item(i);
			adventureActorChangeBuffLaminatedNumEffectPostExecute.buffId = buffId;
			adventureActorChangeBuffLaminatedNumEffectPostExecute.buffGroupId = buffGroupId;
			adventureActorChangeBuffLaminatedNumEffectPostExecute.buffTag = buffTag;
			adventureActorChangeBuffLaminatedNumEffectPostExecute.changeNum = changeNum;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorChangeBuffLaminatedNumEffectPostExecute);
		}
	}
}

using System.Collections;
using TrueSync;

[AdventureEffect(HotfixEnum.effectType.ADD_TAG)]
public class AddTag : AdventureEffectBase
{
	private int _tagHashCode;

	private FP _delayTime;

	private bool _addSuccess;

	private CoroutineNode _delayAddCor;

	public override void Execute()
	{
		base.Execute();
		string effectTypeParam = effectValueConfig.EffectTypeParam1;
		if (string.IsNullOrEmpty(effectTypeParam))
		{
			return;
		}
		_tagHashCode = CommonHelper.StringToHash(effectTypeParam);
		string effectTypeParam2 = effectValueConfig.EffectTypeParam2;
		TryParseStringParamToFP(effectTypeParam2, out _delayTime, allowEmpty: true);
		_addSuccess = false;
		if (_delayTime > 0)
		{
			_delayAddCor = _owner.StartLogicCoroutine(DelayAddTag());
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).AddTag(_tagHashCode);
		}
		_addSuccess = true;
	}

	private IEnumerator DelayAddTag()
	{
		while (_delayTime > 0)
		{
			_delayTime -= _owner.LogicDeltaTime;
			yield return null;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).AddTag(_tagHashCode);
		}
		_addSuccess = true;
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (_addSuccess)
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).RemoveTag(_tagHashCode);
			}
		}
		if (_delayAddCor != null)
		{
			_owner.StopLogicCoroutine(_delayAddCor);
		}
		_delayAddCor = null;
		_tagHashCode = 0;
		_delayTime = 0;
		_addSuccess = false;
	}
}

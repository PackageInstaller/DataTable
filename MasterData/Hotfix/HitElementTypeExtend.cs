using System.Collections.Generic;

[AdventureEffect(HotfixEnum.effectType.HIT_ELEMENT_TYPE_EXTEND)]
public class HitElementTypeExtend : AdventureEffectBase
{
	private readonly List<int> _elementTypes = new List<int>();

	public override void Execute()
	{
		base.Execute();
		string[] array = effectValueConfig.EffectTypeParam1.Split(',');
		for (int i = 0; i < array.Length; i++)
		{
			if (!TryParseStringParamToInt(array[i], out var intValue))
			{
				return;
			}
			_elementTypes.Add(intValue);
		}
		for (int j = 0; j < _targets.Count; j++)
		{
			if (_targets.get_Item(j).actorElementInfo != null)
			{
				_targets.get_Item(j).actorElementInfo.hitElementTypeExtension.AddRange(_elementTypes);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (_elementTypes.Count == 0)
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).actorElementInfo != null)
			{
				for (int j = 0; j < _elementTypes.Count; j++)
				{
					_targets.get_Item(i).actorElementInfo.hitElementTypeExtension.Remove(_elementTypes.get_Item(j));
				}
			}
		}
		_elementTypes.Clear();
	}
}

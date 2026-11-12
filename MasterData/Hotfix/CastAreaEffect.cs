using System.Collections.Generic;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.CAST_AREAEFFECT)]
public class CastAreaEffect : AdventureEffectBase
{
	private List<long> areaEffects = new List<long>();

	public override void Execute()
	{
		base.Execute();
		string effectTypeParam = effectValueConfig.EffectTypeParam1;
		if (string.IsNullOrEmpty(effectTypeParam))
		{
			return;
		}
		areaEffects.Clear();
		for (int i = 0; i < _targets.Count; i++)
		{
			GameObject areaEffectByAlias = ModuleController<AdventureModuleController>.Instance.GetAreaEffectByAlias(_targets.get_Item(i), effectTypeParam, forceUseCommonConfig: true);
			if (areaEffectByAlias == null)
			{
				Debug.LogError($"通过效果释放的区域效果资源不存在，资源别名:{effectTypeParam}，效果id:{effectValueConfig.Id},应该配置在通用资源配置(CommonRelatedResource)中");
				continue;
			}
			long num = SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(_targets.get_Item(i), areaEffectByAlias, new Vector3((float)_targets.get_Item(i).tsTransform.Position.x, (float)_targets.get_Item(i).tsTransform.PositionY, (float)_targets.get_Item(i).tsTransform.Position.y), _targets.get_Item(i).transform.rotation);
			if (num != 0L)
			{
				areaEffects.Add(num);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (areaEffects.Count != 0)
		{
			for (int i = 0; i < areaEffects.Count; i++)
			{
				SceneSingleton<AreaEffectManager>.Instance.StopAreaEffect(areaEffects.get_Item(i));
			}
		}
	}
}

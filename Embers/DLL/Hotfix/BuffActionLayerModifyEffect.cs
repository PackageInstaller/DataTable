using System.Collections.Generic;
using Ase;
using Ase.ECS;

public class BuffActionLayerModifyEffect : BuffActionBase
{
	private int minLayer;

	private int maxLayer;

	private float minValue;

	private float maxValue;

	public override void OnInit(Buff buff, List<float> actionParams)
	{
		actionType = BuffActionTypeEnum.LayerModifyEffect;
		if (actionParams != null && actionParams.Count == 4)
		{
			minLayer = (int)actionParams[0];
			maxLayer = (int)actionParams[1];
			minValue = actionParams[2];
			maxValue = actionParams[3];
		}
	}

	public override void OnReset(Buff buff)
	{
		OnUpdateEffect(buff.BuffEffect, minValue);
	}

	public override void OnExcute(Buff buff)
	{
		int layer = buff.GetLayer();
		if (layer >= minLayer && layer <= maxLayer && minLayer != maxLayer)
		{
			float num = (float)(layer - minLayer) / (float)(maxLayer - minLayer);
			float value = minValue + num * (maxValue - minValue);
			OnUpdateEffect(buff.BuffEffect, value);
		}
	}

	private void OnUpdateEffect(BuffEffectEntity buffEffect, float value)
	{
		if (buffEffect != null)
		{
			EffectView effectView = buffEffect.GetComponent<EntityViewComponent>()?.EntityView as EffectView;
			if (effectView != null)
			{
				effectView.OnModifyMaterialParams(value);
			}
		}
	}
}

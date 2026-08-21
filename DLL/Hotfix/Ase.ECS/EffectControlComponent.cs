using System.Collections.Generic;

namespace Ase.ECS;

public class EffectControlComponent : BaseComponent
{
	private List<EffectEntity> controlEffects;

	public override void OnInit(object data)
	{
		base.OnInit(data);
		controlEffects = new List<EffectEntity>(10);
	}

	public void AddEffect(EffectEntity effect)
	{
		if (controlEffects != null && !controlEffects.Contains(effect))
		{
			controlEffects.Add(effect);
		}
	}

	public void RemoveEffect(EffectEntity effect)
	{
		if (controlEffects != null && controlEffects.Contains(effect))
		{
			controlEffects.Remove(effect);
		}
	}

	public void ShowAllEffect()
	{
		if (controlEffects == null)
		{
			return;
		}
		foreach (EffectEntity controlEffect in controlEffects)
		{
			controlEffect?.GetComponent<EntityViewComponent>()?.ShowEntityView();
		}
	}

	public void HideAllEffect()
	{
		if (controlEffects == null)
		{
			return;
		}
		foreach (EffectEntity controlEffect in controlEffects)
		{
			controlEffect?.GetComponent<EntityViewComponent>()?.HideEntityView();
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		if (controlEffects == null)
		{
			return;
		}
		for (int i = 0; i < controlEffects.Count; i++)
		{
			if (controlEffects[i] != null && controlEffects[i].IsSurvival)
			{
				controlEffects[i].DoEntityRelease();
			}
		}
		controlEffects.Clear();
	}
}

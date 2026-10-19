using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMaterial : VisualEntryBase
{
	private Material _overrideMaterial;

	private Entity _owner;

	public void Init(Entity owner, int priority, Material overrideMaterial)
	{
		_owner = owner;
		_priority = priority;
		_overrideMaterial = overrideMaterial;
	}

	public void Reset()
	{
		_owner = default;
		_priority = -1;
		_overrideMaterial = null;
	}

	public override void Show()
	{
		MonoEntity mono = _owner.GetMono();
		if (!(mono.materialOverride == null))
		{
			MaterialOverride materialOverride = mono.materialOverride;
			List<Material> list = materialOverride._MatList ?? (materialOverride._MatList = new List<Material>());
			if (!list.Contains(_overrideMaterial))
			{
				list.Add(_overrideMaterial);
			}
		}
	}

	public override void Hide()
	{
		MonoEntity mono = _owner.GetMono();
		if (mono.materialOverride != null && mono.materialOverride._MatList.Contains(_overrideMaterial))
		{
			mono.materialOverride._MatList.Remove(_overrideMaterial);
		}
	}
}

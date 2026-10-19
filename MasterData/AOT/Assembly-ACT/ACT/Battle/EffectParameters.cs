using UnityEngine;

namespace ACT.Battle;

internal abstract class EffectParameters
{
	public bool IsUsing { get; set; }

	public GameObject Obj { get; set; }

	public abstract void Init();

	public abstract void UnInit();
}

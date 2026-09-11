using UnityEngine;

namespace T0World;

public class T0CharacterBehavior : T0WorldBehavior
{
	[HideInInspector]
	public new T0CharacterAgent mAgent;

	public override void Initialize()
	{
		base.Initialize();
	}

	public override void FixedUpdateBehavior()
	{
		base.FixedUpdateBehavior();
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
	}

	public override void LateUpdateBehavior()
	{
		base.LateUpdateBehavior();
	}

	public override void DestroyBehavior()
	{
		base.DestroyBehavior();
	}
}

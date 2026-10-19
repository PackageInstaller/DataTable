using System;
using ACT.Battle;
using ACT.World.StateObject;

namespace ACT.World.Asset;

public class DamageableAsset : StateWorldAsset
{
	private InteractDamageable interactDamageable;

	[Obsolete]
	protected override void OnSpawn(StateObjectBase interactObjectBase)
	{
		DamageableData damageableData = data as DamageableData;
		interactDamageable = interactObjectBase as InteractDamageable;
		interactDamageable.address = damageableData.damageableAddress;
		interactDamageable.attacksList = damageableData.attacksList;
		interactDamageable.lastKeep = damageableData.lastKeep;
	}

	[Obsolete]
	public override void Release(MonoECS m_ECS)
	{
		ReleaseAsset<DamageableAsset>(m_ECS);
	}
}

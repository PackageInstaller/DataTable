using System;
using ACT.Battle;

namespace ACT.World.Asset;

public class CollectionPointAsset : StateWorldAsset
{
	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
	}

	[Obsolete]
	public override void Release(MonoECS m_ECS)
	{
		ReleaseAsset<CollectionPointAsset>(m_ECS);
	}
}

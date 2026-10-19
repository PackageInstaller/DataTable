using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

[Obsolete]
public class ShowBoxTimeLine : InteractAction
{
	public float waitTime;

	public string[] abilities;

	public List<YooAssetReference> timelineAssestAssetID = new List<YooAssetReference>();

	private AssetLoadHandle m_Handle;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
	}
}

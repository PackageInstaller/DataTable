using System;
using BehaviorDesigner.Runtime;

namespace ACT.Battle;

[Serializable]
public class ConfigGroupAI
{
	public int id;

	public YooAssetReference<ExternalBehaviorTree> behaviorTreeAssetID;
}

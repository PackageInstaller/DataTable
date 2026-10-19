using UnityEngine;

namespace ACT.World.Asset;

public class FollowBehaveConfig : BehaveConfig
{
	public StateWorldUid tarSwid = int.MinValue;

	public float tpDistance = 5f;

	[SerializeReference]
	public EventActionBase monsterEnterOrCharacterExit;

	[SerializeReference]
	public EventActionBase monsterExitAndCharacterEnter;
}

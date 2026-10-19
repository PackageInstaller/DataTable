using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("播放Connect特效", "Action", new string[] { "fire", "connect", "effect", "fx", "particle" })]
public class ActionFireConnectEffect : ConfigAction
{
	public YooAssetReference effectReferenceAssetID;

	public ConfigFunction<Transform> startPos;

	public ConfigFunction<Transform> endPos;

	public ConfigFunction<Quaternion> rotation;

	public ConfigFunction<Vector3> effectPos;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
		YooAssetReference pattern = effectReferenceAssetID;
		Transform transform = startPos.Return(memory);
		Transform transform2 = endPos.Return(memory);
		if (transform == null || transform2 == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		Quaternion rotate = rotation?.Return(memory) ?? Quaternion.identity;
		Vector3 vector = effectPos?.Return(memory) ?? ((transform.position + transform2.position) / 2f);
		GameManager.effectSystem.FireConnectEffect(pattern, vector, rotate, transform2, transform);
	}
}

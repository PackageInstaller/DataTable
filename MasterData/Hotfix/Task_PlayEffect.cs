using TrueSync;
using UnityEngine;

[AddComponentMenu("触发器结果/表现事件/播放特效", 3)]
public class Task_PlayEffect : TaskCellBase
{
	public enum opEffectType
	{
		[InspectorName("播放特效")]
		play,
		[InspectorName("关闭特效")]
		close
	}

	public enum opOwnerType
	{
		[InspectorName("无")]
		none,
		[InspectorName("玩家")]
		palyer
	}

	public enum effectPosType
	{
		[InspectorName("手填位置")]
		fixPos,
		[InspectorName("玩家位置")]
		playerPos
	}

	public enum effectRotateType
	{
		[InspectorName("手填方向")]
		fixR,
		[InspectorName("玩家方向")]
		playerR
	}

	public opEffectType _opType;

	public opOwnerType _opOwnerType;

	public GameObject effectPrefab;

	public bool _useActorSizeScale;

	public float effectScale = 1f;

	public effectPosType _posType;

	public Vector2 effectPos;

	public float fxPositionY;

	public effectRotateType _rotType;

	public TSVector2 direction;

	public string effectTag;

	protected override void OnExecute()
	{
		if (_opType == opEffectType.play)
		{
			if (effectPrefab == null)
			{
				EndAction(success: false);
				return;
			}
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			float num = fxPositionY + (float)activedPlayerActor.tsTransform.PositionY;
			Vector3 spawnPosition = activedPlayerActor.transform.position;
			Quaternion spawnRotation = Quaternion.Euler(0f, 0f - (float)activedPlayerActor.tsTransform.Rotation360, 0f);
			if (_posType == effectPosType.fixPos)
			{
				spawnPosition = new Vector3(effectPos.x, num, effectPos.y);
			}
			if (_rotType == effectRotateType.fixR)
			{
				spawnRotation = Quaternion.LookRotation(new Vector3((float)direction.x, 0f, (float)direction.y), Vector3.up);
			}
			if (_opOwnerType == opOwnerType.none)
			{
				AdventureFXPlayer fx = AdventureFXPlayer.PlayFX(effectPrefab, 1f, spawnPosition, spawnRotation, effectScale);
				Singleton<TriggerManager>.Instance?.AddTriggerFx(effectTag, fx);
			}
			else if (_opOwnerType == opOwnerType.palyer)
			{
				AdventureFXPlayer fx2 = AdventureFXPlayer.PlayFX(activedPlayerActor.gameObject, _useActorSizeScale, useTransformSync: true, effectPrefab, 1f, spawnPosition, spawnRotation, effectScale);
				Singleton<TriggerManager>.Instance?.AddTriggerFx(effectTag, fx2);
			}
		}
		else if (_opType == opEffectType.close)
		{
			if (string.IsNullOrEmpty(effectTag))
			{
				EndAction(success: false);
				return;
			}
			Singleton<TriggerManager>.Instance?.DeletTriggerFx(effectTag);
		}
		EndAction();
	}
}

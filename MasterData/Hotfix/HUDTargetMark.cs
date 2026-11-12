using TrueSync;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class HUDTargetMark : MonoBehaviour
{
	public Animator ani;

	public float blobOffset = 0.05f;

	private AdventureActor _targetBefore;

	private RectTransform parentRt;

	private RectTransform rt;

	private void OnEnable()
	{
	}

	public void HUDUpdate(float dt)
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor == null)
		{
			transform.localScale = Vector3.zero;
			return;
		}
		LogicEntity logicEntity = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor?.attackTarget;
		if (logicEntity == null)
		{
			_targetBefore = null;
			transform.localScale = Vector3.zero;
			return;
		}
		AdventureActor component = logicEntity.GetComponent<AdventureActor>();
		ActorHealthInfo actorHealthInfo = ((component == null) ? null : component.actorHealthInfo);
		if (component != null && actorHealthInfo != null && actorHealthInfo.isAlive)
		{
			if (component != _targetBefore)
			{
				if (ani != null)
				{
					ani.Play("BattleTarget_in");
				}
				_targetBefore = component;
				FP value = component.dtCollider.Radius;
				if (component.actorScaleInfo != null)
				{
					value = component.actorScaleInfo.modelScale * component.dtCollider.Radius;
				}
				value = TSMath.Clamp(value, 0.65, 1);
				transform.localScale = Vector3.one * (float)value;
			}
			Vector3 targetPos = GetTargetPos(component);
			Vector3 position = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(targetPos);
			transform.position = SceneSingleton<AdventurePlayerController>.Instance.hudCamera.ScreenToWorldPointAsHFOV(position);
		}
		else
		{
			_targetBefore = null;
			transform.localScale = Vector3.zero;
		}
	}

	private Vector3 GetTargetPos(AdventureActor target)
	{
		Transform transform = target.transform;
		Vector3 result = new Vector3(transform.position.x, transform.position.y + blobOffset, transform.position.z);
		if (target.slotConfig != null)
		{
			Transform slotNode = target.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.TargetFlag);
			if (slotNode == null)
			{
				slotNode = target.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Body);
			}
			return slotNode.position;
		}
		return result;
	}
}

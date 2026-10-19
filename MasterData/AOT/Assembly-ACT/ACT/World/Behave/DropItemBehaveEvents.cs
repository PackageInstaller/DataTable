using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Game;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using EasyCharacterMovement;
using Fundamental;
using UnityEngine;

namespace ACT.World.Behave;

[AddComponentMenu("ACT/StateObjectBehave/DropItemBehaveEvents")]
public class DropItemBehaveEvents : MonoBehaviour
{
	public enum DropItemState
	{
		Falling,
		OnGround,
		Collecting
	}

	public static float[] LastCollectTimes = new float[5]
	{
		float.MinValue,
		float.MinValue,
		float.MinValue,
		float.MinValue,
		float.MinValue
	};

	[NonSerialized]
	[HideInInspector]
	public InteractDropItem interactDropItem;

	public Animator animator;

	public bool robotNotPick;

	[Tooltip("交互方式")]
	public InteractType interactType;

	private CancellationTokenSource _tokenSource = new CancellationTokenSource();

	[NonSerialized]
	public DropItemState state;

	[NonSerialized]
	private Transform m_Target;

	private Route route;

	public void Drop()
	{
		animator.SetInteger("state", 0);
	}

	public void OnGround()
	{
		animator.SetInteger("state", 1);
		if (state != DropItemState.Collecting)
		{
			state = DropItemState.OnGround;
		}
		interactDropItem.rig.drag = 5f;
		interactDropItem.rig.angularDrag = 5f;
	}

	public void Pick()
	{
		animator.SetInteger("state", 2);
		interactDropItem.rig.isKinematic = true;
	}

	public void CollectImmediately()
	{
		interactDropItem.EnterState(2);
		OnCollected();
	}

	public void Collect(Transform target)
	{
		m_Target = target;
		route.startPos = transform.position;
		Collecting(_tokenSource.Token).Forget();
	}

	private async UniTaskVoid Collecting(CancellationToken token)
	{
		await UniTask.WaitUntil(() => interactDropItem.currentStateId == 1, PlayerLoopTiming.FixedUpdate, token);
		float duration = UnityEngine.Random.Range(GameLoader.meta.collectDuration.x, GameLoader.meta.collectDuration.y);
		state = DropItemState.Collecting;
		interactDropItem.EnterState(2);
		Vector3 vector = m_Target.position;
		if (!robotNotPick)
		{
			CharacterMovement characterMovement = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().characterMovement;
			vector = m_Target.position + characterMovement.height / 2f * Vector3.up;
		}
		Vector3 position = transform.position;
		float hOffset = GameLoader.meta.pickControlCurveX.Evaluate(vector.x - position.x);
		float vOffset = GameLoader.meta.pickControlCurveY.Evaluate(vector.y - position.y);
		SystemTime timeSys = GameManager.timeSystem;
		while (!token.IsCancellationRequested)
		{
			float num = timeSys.globalSpeed * Time.deltaTime;
			route.endPos = m_Target.position;
			route.controlPos = (route.startPos + route.endPos) / 2f + new Vector3(hOffset, vOffset, 0f);
			route.precent = InterpolationUtility.FixedLerp(route.precent, 1f, num / duration);
			transform.position = route.Evaluate(route.precent);
			if (Mathf.Approximately(route.precent, 1f))
			{
				OnCollected();
				break;
			}
			await UniTask.Yield();
		}
	}

	private void OnDrawGizmos()
	{
		if (interactDropItem.currentStateId == 2)
		{
			float num = 0.02f;
			for (float num2 = 0f; num2 <= 1f; num2 += num)
			{
				Gizmos.color = Color.green;
				Gizmos.DrawSphere(route.startPos, 0.1f);
				Gizmos.DrawSphere(route.endPos, 0.1f);
				Gizmos.DrawSphere(route.controlPos, 0.1f);
				Gizmos.color = Color.red;
				Gizmos.DrawLine(route.Evaluate(num2), route.Evaluate(Mathf.Min(1f, num2 + num)));
			}
		}
	}

	public virtual void OnCollected(Entity eb = default(Entity))
	{
		List<int> list = ListPool<int>.Get();
		list.Add(interactDropItem.dropItemData.Uid);
		G.service.GetDropItem(list, Singleton<DropItemManager>.instance.RemoveDropItems);
		PlayEffect();
		ListPool<int>.Release(list);
	}

	private void PlayEffect()
	{
		float collectedEffectCd = GameLoader.meta.collectedEffectCd;
		if (Time.time - LastCollectTimes[interactDropItem.quality - 1] > collectedEffectCd)
		{
			GameManager.effectSystem.FireEffect(GameLoader.meta.collectedEffectAssetID[interactDropItem.quality - 1], route.endPos, Quaternion.identity);
			LastCollectTimes[interactDropItem.quality - 1] = Time.time;
		}
	}

	private void OnDestroy()
	{
		_tokenSource.Cancel();
		_tokenSource.Dispose();
	}
}

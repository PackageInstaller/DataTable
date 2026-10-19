using System;
using System.Threading;
using ACT.Config;
using ACT.Core;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World.Behave;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using EasyCharacterMovement;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class DropEffect : MonoBehaviour
{
	private AssetLoadHandle m_Handle;

	private int quality;

	[NonSerialized]
	private Transform m_Target;

	private Route m_Route;

	private uint m_PackageId;

	private Rigidbody m_Rig;

	private Action onCollect;

	private CancellationTokenSource m_TokenSource = new CancellationTokenSource();

	public async void Init(int itemId, uint packageId, uint playerId, Action onCollect = null, string addressPath = "")
	{
		m_PackageId = packageId;
		this.onCollect = onCollect;
		ItemData itemData = RuntimeConfigs.data.itemDatas[itemId];
		quality = itemData.quality;
		m_Rig = GetComponent<Rigidbody>();
		m_Rig.velocity = Singleton<DropItemManager>.instance.DropDir();
		if (!string.IsNullOrEmpty(addressPath))
		{
			m_Handle = AssetStationManager.BattleStation.InstantiateAsync("StateObjectBehave/" + addressPath, transform);
			await m_Handle;
		}
		else if (string.IsNullOrEmpty(itemData.address))
		{
			m_Handle = AssetStationManager.BattleStation.InstantiateAsync(GameLoader.meta.defaultItemBhaveAssetID[itemData.quality - 1], transform);
			await m_Handle;
		}
		else
		{
			m_Handle = AssetStationManager.BattleStation.InstantiateAsync("StateObjectBehave/" + itemData.address, transform);
			await m_Handle;
		}
		await UniTask.Delay(TimeSpan.FromSeconds(UnityEngine.Random.Range(GameLoader.meta.collectCD.x, GameLoader.meta.collectCD.y)));
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		if (localPlayer.battleEntity.IsValid)
		{
			Collect(localPlayer.battleEntity.GetRootTransform());
		}
	}

	public void Collect(Transform target)
	{
		m_Target = target;
		m_Route.startPos = transform.position;
		Collecting(m_TokenSource.Token).Forget();
	}

	private async UniTaskVoid Collecting(CancellationToken token)
	{
		try
		{
			gameObject.GetComponent<Rigidbody>().isKinematic = true;
			float duration = UnityEngine.Random.Range(GameLoader.meta.collectDuration.x, GameLoader.meta.collectDuration.y);
			SystemTime systemTime = GameManager.timeSystem;
			while (!token.IsCancellationRequested)
			{
				if (this == null || m_Target == null || transform == null)
				{
					onCollect?.Invoke();
					break;
				}
				CharacterMovement characterMovement = MonoECS.instance.localPlayer.battleEntity.GetCompPhysics().characterMovement;
				Vector3 vector = m_Target.position + characterMovement.height / 2f * Vector3.up;
				Vector3 position = transform.position;
				float num = systemTime.globalSpeed * Time.deltaTime;
				m_Route.endPos = m_Target.position + characterMovement.height / 2f * Vector3.up;
				float x = GameLoader.meta.pickControlCurveX.Evaluate(vector.x - position.x);
				float y = GameLoader.meta.pickControlCurveY.Evaluate(vector.y - position.y);
				m_Route.controlPos = (m_Route.startPos + m_Route.endPos) / 2f + new Vector3(x, y, 0f);
				m_Route.precent = InterpolationUtility.FixedLerp(m_Route.precent, 1f, num / duration);
				transform.position = m_Route.Evaluate(m_Route.precent);
				if (m_Route.precent == 1f)
				{
					OnCollected();
					break;
				}
				await UniTask.Yield();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			onCollect?.Invoke();
		}
	}

	private void OnDrawGizmos()
	{
		float num = 0.02f;
		for (float num2 = 0f; num2 <= 1f; num2 += num)
		{
			Gizmos.color = Color.green;
			Gizmos.DrawSphere(m_Route.startPos, 0.1f);
			Gizmos.DrawSphere(m_Route.endPos, 0.1f);
			Gizmos.DrawSphere(m_Route.controlPos, 0.1f);
			Gizmos.color = Color.red;
			Gizmos.DrawLine(m_Route.Evaluate(num2), m_Route.Evaluate(Mathf.Min(1f, num2 + num)));
		}
	}

	public virtual void OnCollected(Entity eb = default(Entity))
	{
		PlayEffect();
		onCollect?.Invoke();
	}

	private void PlayEffect()
	{
		float collectedEffectCd = GameLoader.meta.collectedEffectCd;
		if (Time.time - DropItemBehaveEvents.LastCollectTimes[quality - 1] > collectedEffectCd)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Smash");
			GameManager.effectSystem.FireEffect(GameLoader.meta.collectedEffectAssetID[quality - 1], m_Route.endPos, Quaternion.identity);
			DropItemBehaveEvents.LastCollectTimes[quality - 1] = Time.time;
		}
	}

	private void OnDestroy()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
	}
}

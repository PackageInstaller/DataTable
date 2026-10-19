using System;
using System.Threading;
using ACT.Battle;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.Collections;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractLaserWeb : InteractObject
{
	public string[] abilities;

	private bool created;

	private BList<AssetLoadHandle> bolts;

	private BList<Entity> traps;

	private BList<IDisposable> m_Disposables;

	private CancellationTokenSource m_TokenSource;

	public override void InitStateObject(int stateId)
	{
		bolts = BListPool<AssetLoadHandle>.Default.Get(8);
		traps = BListPool<Entity>.Default.Get(8);
		m_Disposables = BListPool<IDisposable>.Default.Get(8);
		m_TokenSource = new CancellationTokenSource();
		if (entity.GetCompStateObject()?.StateWorldAssetData is LaserWebData { transforms: var transforms } laserWebData)
		{
			foreach (Pos pos in transforms)
			{
				AssetLoadHandle item = AssetStationManager.BattleStation.InstantiateAsync(laserWebData.boltAssetID, pos.value, pos.rotate, transform, (AssetLoadHandle handle) =>
				{
				});
				bolts.Add(item);
			}
			PosConnect[] connects = laserWebData.connects;
			foreach (PosConnect posConnect in connects)
			{
				CoSpawnTrap(laserWebData.laserAssetID, laserWebData.entityNeutralId, laserWebData.trapType, laserWebData.defenceTowerType, laserWebData.alliance, posConnect.position, posConnect.rotation, new Vector3(posConnect.scale, 1f, 1f), null, abilities, m_TokenSource.Token).Forget();
			}
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		foreach (AssetLoadHandle bolt in bolts)
		{
			AssetStationManager.BattleStation.ReleaseInstance(bolt);
		}
		foreach (Entity trap in traps)
		{
			ReleaseTrap(trap).Forget();
		}
		foreach (IDisposable disposable in m_Disposables)
		{
			disposable?.Dispose();
		}
		BListPool<AssetLoadHandle>.Default.Recycle(bolts);
		BListPool<Entity>.Default.Recycle(traps);
		BListPool<IDisposable>.Default.Recycle(m_Disposables);
		bolts = null;
		traps = null;
		m_Disposables = null;
		base.ReleaseStateObject();
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		if (stateId != 0 && stateId != -1)
		{
			return;
		}
		bool flag = stateId != -1;
		foreach (Entity trap in traps)
		{
			trap.SetActive(flag);
			if (trap.IsLogicAvailable())
			{
				trap.GetRoot().SetActive(flag);
			}
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	private async UniTask CoSpawnTrap(YooAssetReference assetReference, int neutralId, int trapType, int defenceTowerType, Alliance alliance, Vector3 pos, Quaternion rotation, Vector3 scale, Transform parent, string[] ab, CancellationToken token)
	{
		Entity eb = GameManager.entities.factory.CreateMechanismTrapEntity();
		traps.Add(eb);
		eb.GetCompStateObject().StateWorldAssetData = entity.GetCompStateObject().StateWorldAssetData;
		await MonoECS.instance.CoServerSpawnTrapAttack(eb, neutralId, trapType, defenceTowerType, alliance, pos, rotation, scale, assetReference, parent);
		if (!token.IsCancellationRequested)
		{
			eb.GetCompAbility().AddAbilities(ab, AbilitySource.Ability);
			InitState(eb);
			Vector3 localPos = pos - transform.position;
			Quaternion localRotation = Quaternion.Inverse(transform.rotation) * rotation;
			m_Disposables.Add(UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.LastUpdate).Subscribe((AsyncUnit _) =>
			{
				eb.GetRootTransform().SetPositionAndRotation(transform.position + localPos, transform.rotation * localRotation);
			}));
		}
	}

	private void InitState(Entity er)
	{
		bool flag = currentStateId != -1;
		er.SetActive(flag);
		er.GetRoot().SetActive(flag);
	}

	private async UniTaskVoid ReleaseTrap(Entity eb)
	{
		if (!eb.IsValid)
		{
			return;
		}
		if (eb.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(eb);
			return;
		}
		await UniTask.WaitUntil(() => eb.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(eb);
	}

	private void OnDestroy()
	{
		if (m_Disposables == null)
		{
			return;
		}
		foreach (IDisposable disposable in m_Disposables)
		{
			disposable?.Dispose();
		}
		m_Disposables = null;
	}
}

#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class WeaknessBarSystem : BaseSystem, IObserverHandler
{
	private CanvasComponent.CanvasGroup canvasGroup;

	private Camera barCamera;

	private IObjectPool<GameObject> _squarePool;

	private IObjectPool<GameObject> _hitLinePool;

	private IObjectPool<GameObject> _bossBarPool;

	private IObjectPool<GameObject> _monsterBarPool;

	private IObjectPool<GameObject> _effectPool;

	private List<WeaknessBarItem> _barItems = new List<WeaknessBarItem>();

	protected override bool IsLogicSystem => false;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		canvasGroup = GameEntry.Canvas.GetCanvasGroup("WeaknessBar");
	}

	public override void OnAwake(object data = null)
	{
		barCamera = GetSystem<CameraSystem>().BattleCamera;
		GetSystem<BattleObserverSystem>()?.Attach(BattleObserverEventEnum.ChangeRoom, this);
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (canvasGroup == null)
		{
			Log.Error("HealthBar Group is not found.");
			return false;
		}
		string weaknessSquarePath = AssetUtility.GetUIItemAsset("Battle/Weakness/WeaknessSquare");
		GameObject gameObject = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(weaknessSquarePath);
		if (gameObject == null)
		{
			Log.Error("弱点系统初始化失败：square为空!");
			return false;
		}
		_squarePool = new ObjectPool<GameObject>(new EntityInfoItemViewFactory(weaknessSquarePath, gameObject, canvasGroup.Root), 5, 20);
		string hitLinePath = AssetUtility.GetUIItemAsset("Battle/Weakness/WeaknessLine");
		GameObject gameObject2 = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(hitLinePath);
		if (gameObject2 == null)
		{
			Log.Error("弱点系统初始化失败：hitLine为空!");
			return false;
		}
		_hitLinePool = new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hitLinePath, gameObject2, canvasGroup.Root), 5, 20);
		string bossBarPath = AssetUtility.GetUIItemAsset("Battle/Weakness/WeaknessBossSlider");
		GameObject gameObject3 = await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(bossBarPath);
		if (gameObject3 == null)
		{
			Log.Error("弱点系统初始化失败：hitLine为空!");
			return false;
		}
		_bossBarPool = new ObjectPool<GameObject>(new EntityInfoItemViewFactory(bossBarPath, gameObject3, canvasGroup.Root), 1, 2);
		string effectsWeaknessBarFlashPath = AssetUtility.GetUIEffectAsset("Weakness/Effects_WeaknessBarFlash");
		_effectPool = new ObjectPool<GameObject>(new EntityInfoItemViewFactory(effectsWeaknessBarFlashPath, await GetSystem<GameResourceSystem>().LoadAssetAsync<GameObject>(effectsWeaknessBarFlashPath), canvasGroup.Root), 1, 12);
		return true;
	}

	public WeaknessBarItem ShowWeaknessBar(BaseWeaknessData data, bool isBoss, DRWeaknessUIData uiData)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		WeaknessBarItem weaknessBarItem = CreateWeaknessBarItem(isBoss);
		if (weaknessBarItem == null)
		{
			return null;
		}
		weaknessBarItem.AddPool(_squarePool, _hitLinePool, _effectPool);
		weaknessBarItem.Init(barCamera, canvasGroup.Canvas);
		weaknessBarItem.UpdateData(data, isBoss, uiData);
		IEntityRoom monsterEntity = weaknessBarItem.Data.monsterEntity;
		if (monsterEntity != null)
		{
			weaknessBarItem.SetShowEnable(monsterEntity.InLocalActorRoom());
		}
		return weaknessBarItem;
	}

	public void UpdateWeaknessBar(WeaknessBarItem weaknessBarItem, float deltaTime)
	{
		if (weaknessBarItem != null)
		{
			weaknessBarItem.OnFixedUpdate(deltaTime);
		}
	}

	private WeaknessBarItem CreateWeaknessBarItem(bool isBoss)
	{
		if (!SystemIsNeedExecute)
		{
			return null;
		}
		GameObject gameObject = _bossBarPool.Allocate();
		if (gameObject == null)
		{
			return null;
		}
		WeaknessBarItem component = gameObject.GetComponent<WeaknessBarItem>();
		_barItems.Add(component);
		return component;
	}

	public void HideWeaknessBar(bool isBoss, WeaknessBarItem weaknessBarItem)
	{
		if (isBoss)
		{
			weaknessBarItem.ReleaseAllWeaknessEffect();
		}
		if (_barItems == null)
		{
			return;
		}
		for (int i = 0; i < _barItems.Count; i++)
		{
			if (_barItems[i] == weaknessBarItem)
			{
				_barItems.RemoveAt(i);
				break;
			}
		}
	}

	public void OnNotify(IObserverParams param)
	{
		if (!(param is ObserverChangeRoomParams observerChangeRoomParams))
		{
			return;
		}
		_ = observerChangeRoomParams.RoomID;
		for (int i = 0; i < _barItems.Count; i++)
		{
			IEntityRoom monsterEntity = _barItems[i].Data.monsterEntity;
			if (monsterEntity != null)
			{
				_barItems[i].SetShowEnable(monsterEntity.InLocalActorRoom());
			}
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ShutdownWeaknessBar();
	}

	private void ShutdownWeaknessBar()
	{
		if (_squarePool != null)
		{
			_squarePool.Dispose();
			_squarePool = null;
		}
		if (_hitLinePool != null)
		{
			_hitLinePool.Dispose();
			_hitLinePool = null;
		}
		if (_bossBarPool != null)
		{
			_bossBarPool.Dispose();
			_bossBarPool = null;
		}
		if (_monsterBarPool != null)
		{
			_monsterBarPool.Dispose();
			_monsterBarPool = null;
		}
		if (_effectPool != null)
		{
			_effectPool.Dispose();
			_effectPool = null;
		}
		if (_barItems != null)
		{
			_barItems.Clear();
			_barItems = null;
		}
	}
}

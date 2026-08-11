using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase.ECS;

public class HealthBarsSystem : BaseSystem
{
	private CanvasComponent.CanvasGroup canvasGroup;

	private Camera barCamera;

	private Dictionary<int, IObjectPool<GameObject>> hpBarPools = new Dictionary<int, IObjectPool<GameObject>>();

	protected override bool IsLogicSystem => false;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		canvasGroup = GameEntry.Canvas.GetCanvasGroup("HealthBar");
	}

	public override void OnAwake(object data = null)
	{
		barCamera = GetSystem<CameraSystem>().BattleCamera;
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		GameResourceSystem resourceSystem = GetSystem<GameResourceSystem>();
		if (resourceSystem == null)
		{
			return false;
		}
		if (canvasGroup == null)
		{
			return false;
		}
		string hpBarPath = AssetUtility.GetUIItemAsset("Battle/HP/HPBarItem");
		string hpBarBloodPath = AssetUtility.GetUIItemAsset("Battle/HP/HPBarItemBlood");
		string hpBarTenacityPath = AssetUtility.GetUIItemAsset("Battle/HP/HPBarItemTenacity");
		GameObject hpBarItem = await resourceSystem.LoadAssetAsync<GameObject>(hpBarPath);
		GameObject hpBarBloodItem = await resourceSystem.LoadAssetAsync<GameObject>(hpBarBloodPath);
		GameObject hpBarTenacityItem = await resourceSystem.LoadAssetAsync<GameObject>(hpBarTenacityPath);
		if (hpBarItem == null)
		{
			return false;
		}
		if (hpBarBloodItem == null)
		{
			return false;
		}
		if (hpBarTenacityItem == null)
		{
			return false;
		}
		string hPBarSmallPath = AssetUtility.GetUIItemAsset("Battle/HP/HPBarSmallItem");
		string hPBarSmallBloodPath = AssetUtility.GetUIItemAsset("Battle/HP/HPBarSmallItemBlood");
		string hPBarSmallTenacityPath = AssetUtility.GetUIItemAsset("Battle/HP/HPBarSmallItemTenacity");
		GameObject hPBarSmallItem = await resourceSystem.LoadAssetAsync<GameObject>(hPBarSmallPath);
		GameObject hPBarSmallBloodItem = await resourceSystem.LoadAssetAsync<GameObject>(hPBarSmallBloodPath);
		GameObject gameObject = await resourceSystem.LoadAssetAsync<GameObject>(hPBarSmallTenacityPath);
		if (hPBarSmallItem == null)
		{
			return false;
		}
		if (hPBarSmallBloodItem == null)
		{
			return false;
		}
		if (gameObject == null)
		{
			return false;
		}
		int num;
		int num2;
		int num3;
		int num4;
		int num5;
		int num6;
		int num7;
		if (world.IsStoryWorld || world.IsGuideWorld)
		{
			num = 2;
			num2 = 2;
			num3 = 1;
			num4 = 1;
			num5 = 3;
			num6 = 1;
			num7 = 1;
		}
		else
		{
			num = 1;
			num2 = 0;
			num3 = 0;
			num4 = 0;
			num5 = 0;
			num6 = 0;
			num7 = 0;
		}
		hpBarPools.Add(2, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hpBarPath, hpBarItem, canvasGroup.Root), num2, Mathf.Max(1, num2 * num)));
		hpBarPools.Add(21, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hpBarBloodPath, hpBarBloodItem, canvasGroup.Root), num3, Mathf.Max(1, num3 * num)));
		hpBarPools.Add(22, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hpBarTenacityPath, hpBarTenacityItem, canvasGroup.Root), num4, Mathf.Max(1, num4 * num)));
		hpBarPools.Add(1, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hPBarSmallPath, hPBarSmallItem, canvasGroup.Root), num5, Mathf.Max(1, num5 * num)));
		hpBarPools.Add(11, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hPBarSmallBloodPath, hPBarSmallBloodItem, canvasGroup.Root), num6, Mathf.Max(1, num6 * num)));
		hpBarPools.Add(12, new ObjectPool<GameObject>(new EntityInfoItemViewFactory(hPBarSmallTenacityPath, gameObject, canvasGroup.Root), num7, Mathf.Max(1, num7 * num)));
		return true;
	}

	public HPBarItem AllocateHpBar(int hpBarType, Transform followRoot)
	{
		if (barCamera == null || followRoot == null || canvasGroup == null)
		{
			return null;
		}
		HPBarItem hPBarItem = CreateHpBarItem(hpBarType);
		if (hPBarItem == null)
		{
			return null;
		}
		hPBarItem.BindFollowRoot(followRoot);
		hPBarItem.ExternalCallRefreshPosition();
		return hPBarItem;
	}

	private HPBarItem CreateHpBarItem(int hpBarType)
	{
		hpBarPools.TryGetValue(hpBarType, out var value);
		if (value == null)
		{
			return null;
		}
		HPBarItem component = value.Allocate().GetComponent<HPBarItem>();
		if (!component.IsInitHandlerCalled)
		{
			component.Init(barCamera, canvasGroup.Canvas);
		}
		return component;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		foreach (KeyValuePair<int, IObjectPool<GameObject>> hpBarPool in hpBarPools)
		{
			hpBarPool.Value.Dispose();
		}
		hpBarPools.Clear();
		canvasGroup = null;
	}
}

using Cysharp.Threading.Tasks;
using UnityEngine;

namespace Ase.ECS;

public class PostProcessEffectSystem : BaseSystem
{
	private const string MonochromeFlashAssetPath = "Assets/Art/Entities/Heroes/HeroesCommon/PostProcess/PostProcess_MonochromeFlash.prefab";

	private const string BaseColorProperty = "_BaseColor";

	private const string ScreenEffectPostProcessLayer = "ScreenEffectPostProcess";

	private GameObject monochromeFlashInstance;

	private bool monochromeFlashAssetLoaded;

	protected override bool IsLogicSystem => false;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (!SystemIsNeedExecute)
		{
			return true;
		}
		GameResourceSystem system = GetSystem<GameResourceSystem>();
		if (system == null)
		{
			return true;
		}
		GameObject gameObject = await system.LoadAssetAsync<GameObject>("Assets/Art/Entities/Heroes/HeroesCommon/PostProcess/PostProcess_MonochromeFlash.prefab");
		if (gameObject == null || world == null)
		{
			return true;
		}
		monochromeFlashAssetLoaded = true;
		monochromeFlashInstance = Object.Instantiate(gameObject, world.WorldRoot);
		monochromeFlashInstance.SetLayerRecursively(LayerMask.NameToLayer("ScreenEffectPostProcess"));
		monochromeFlashInstance.SetActive(value: false);
		monochromeFlashInstance.transform.SetParent(world.EntityRoot);
		return true;
	}

	public bool PlayMonochromeFlash(MonochromeFlashPostProcessData data)
	{
		if (!SystemIsNeedExecute || monochromeFlashInstance == null)
		{
			return false;
		}
		StopMonochromeFlash();
		monochromeFlashInstance.SetActive(value: true);
		return true;
	}

	public override void OnDispose()
	{
		StopMonochromeFlash();
		if (monochromeFlashInstance != null)
		{
			Object.Destroy(monochromeFlashInstance);
		}
		if (monochromeFlashAssetLoaded)
		{
			GetSystem<GameResourceSystem>()?.UnloadAsset("Assets/Art/Entities/Heroes/HeroesCommon/PostProcess/PostProcess_MonochromeFlash.prefab");
		}
		monochromeFlashInstance = null;
		monochromeFlashAssetLoaded = false;
		base.OnDispose();
	}

	private void StopMonochromeFlash()
	{
		if (monochromeFlashInstance != null)
		{
			monochromeFlashInstance.SetActive(value: false);
		}
	}
}

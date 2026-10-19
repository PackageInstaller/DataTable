using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class UISceneManager : Singleton<UISceneManager>
{
	private static Vector3 UISCENE_POSITION = new Vector3(0f, 0f, -100f);

	private CancellationTokenSource _cts;

	private Dictionary<Type, AssetLoadHandle> _sceneAssets = new Dictionary<Type, AssetLoadHandle>();

	private Dictionary<Type, bool> _sceneOpenState = new Dictionary<Type, bool>();

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		base.Init();
		_cts = new CancellationTokenSource();
	}

	public override void UnInit()
	{
		base.UnInit();
		Type[] array = _sceneAssets.Keys.ToArray();
		foreach (Type sceneType in array)
		{
			ReleaseScene(sceneType);
		}
	}

	public async UniTask LoadScene<T>(string asset) where T : BaseUIScene
	{
		Stopwatch loadSceneStopwatch = Stopwatch.StartNew();
		if (!_sceneAssets.TryGetValue(typeof(T), out var _))
		{
			Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.High;
			_sceneAssets[typeof(T)] = AssetStationManager.BattleStation.InstantiateAsync(asset);
			AssetLoadHandle assetLoadHandle = _sceneAssets[typeof(T)];
			assetLoadHandle.Completed += (AssetLoadHandle assetLoadHandle2) =>
			{
				T component = assetLoadHandle2.AsGameObject().GetComponent<T>();
				component.transform.position = UISCENE_POSITION;
				component.OnLoadComplete();
				if (_sceneOpenState.TryGetValue(typeof(T), out var value2) & value2)
				{
					component.Open();
				}
				Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.Normal;
			};
		}
		await _sceneAssets[typeof(T)];
		loadSceneStopwatch.Stop();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[UISceneManager] LoadScene<{typeof(T).Name}> 耗时 {loadSceneStopwatch.ElapsedMilliseconds} 毫秒");
		}
	}

	public void OpenScene<T>() where T : BaseUIScene
	{
		if (_sceneAssets.ContainsKey(typeof(T)) && !(_sceneOpenState.TryGetValue(typeof(T), out var value) & value))
		{
			_sceneOpenState[typeof(T)] = true;
			if (_sceneAssets.TryGetValue(typeof(T), out var value2) && value2.IsDone)
			{
				value2.AsGameObject().GetComponent<T>().Open();
			}
		}
	}

	public void CloseScene<T>() where T : BaseUIScene
	{
		if (_sceneAssets.ContainsKey(typeof(T)) && (!_sceneOpenState.TryGetValue(typeof(T), out var value) || value))
		{
			_sceneOpenState[typeof(T)] = false;
			if (_sceneAssets.TryGetValue(typeof(T), out var value2) && value2.IsDone)
			{
				value2.AsGameObject().GetComponent<T>().Close();
			}
		}
	}

	public void ReleaseScene<T>() where T : BaseUIScene
	{
		ReleaseScene(typeof(T));
	}

	private void ReleaseScene(Type sceneType)
	{
		if (!_sceneAssets.TryGetValue(sceneType, out var value))
		{
			return;
		}
		if (value.IsDone)
		{
			BaseUIScene baseUIScene = value.AsGameObject().GetComponent(sceneType) as BaseUIScene;
			if ((_sceneOpenState.TryGetValue(sceneType, out var value2) & value2) && (bool)baseUIScene)
			{
				baseUIScene.Close();
			}
			if ((bool)baseUIScene)
			{
				baseUIScene.OnRelease();
			}
		}
		AssetStationManager.BattleStation.ReleaseInstance(value);
		_sceneAssets.Remove(sceneType);
		_sceneOpenState.Remove(sceneType);
	}

	public T GetScene<T>() where T : BaseUIScene
	{
		if (_sceneAssets.TryGetValue(typeof(T), out var value) && value.IsDone)
		{
			return value.AsGameObject().GetComponent<T>();
		}
		return null;
	}
}

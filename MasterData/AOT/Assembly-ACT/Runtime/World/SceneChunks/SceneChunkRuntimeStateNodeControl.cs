using System.Threading;
using ACT;
using ACT.World.SceneChunks;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Runtime.Manager.SubManagers.WorldManager.Modules.ChunkModule;
using UnityEngine;

namespace Runtime.World.SceneChunks;

public class SceneChunkRuntimeStateNodeControl
{
	private AssetLoadHandle _foregroundScenePrefabHandle;

	private AssetLoadHandle _backgroundScenePrefabHandle;

	private AssetLoadHandle _blueprintHandle;

	private AssetLoadHandle _levelDesignHandle;

	private bool _nodeBelongStateAssetsLoaded;

	private bool _editorLoaded;

	private const string Load_State_Asset = "LoadStateAssets";

	private const string Load_Level_Design = "LoadLevelDesign";

	private const string Load_Scene_Asset = "LoadSceneAsset";

	private const string Load_Blueprint_Asset = "LoadStateBlueprint";

	private SceneChunkRuntimeControlBase _parentChunkControl;

	public SceneBlock ActiveBlock { get; private set; }

	public bool IsLoaded => AllNodePartsLoad();

	private bool AllNodePartsLoad()
	{
		int num;
		AssetLoadHandle foregroundScenePrefabHandle;
		if (!_editorLoaded)
		{
			foregroundScenePrefabHandle = _foregroundScenePrefabHandle;
			num = ((foregroundScenePrefabHandle.IsValid && foregroundScenePrefabHandle.IsDone) ? 1 : 0);
		}
		else
		{
			num = 1;
		}
		foregroundScenePrefabHandle = _backgroundScenePrefabHandle;
		bool flag = !foregroundScenePrefabHandle.IsValid || _backgroundScenePrefabHandle.IsDone;
		bool flag2 = !_levelDesignHandle.IsValid || _levelDesignHandle.IsDone;
		bool flag3 = !_blueprintHandle.IsValid || _blueprintHandle.IsDone;
		return (((uint)num & (flag ? 1u : 0u) & (flag2 ? 1u : 0u)) != 0 && _nodeBelongStateAssetsLoaded) & flag3;
	}

	internal async UniTask Load(SceneBlock block, CancellationToken cancelToken, CancellationToken syncToken, float progressFrom = 0f, float progressTo = 1f)
	{
		if (ActiveBlock != block)
		{
			UniTask unloadTask = Unload();
			ActiveBlock = block;
			UniTask loadTask = Load(cancelToken, syncToken, progressFrom, progressTo);
			while (unloadTask.Status == UniTaskStatus.Pending || loadTask.Status == UniTaskStatus.Pending)
			{
				await UniTask.NextFrame();
			}
		}
	}

	private async UniTask Load(CancellationToken cancelToken, CancellationToken syncToken, float progressFrom, float progressTo)
	{
		LuminApplication.APM.AnalyserPushSample("LoadSceneAsset");
		await LoadSceneAsset();
		LuminApplication.APM.AnalyserPopSample("LoadSceneAsset");
		ReportStageProgress(progressFrom, progressTo, 0.35f);
		LuminApplication.APM.AnalyserPushSample("LoadLevelDesign");
		await LoadLevelDesign();
		LuminApplication.APM.AnalyserPopSample("LoadLevelDesign");
		ReportStageProgress(progressFrom, progressTo, 0.45f);
		LuminApplication.APM.AnalyserPushSample("LoadStateAssets");
		await LoadStateAssets(cancelToken, syncToken, Mathf.Lerp(progressFrom, progressTo, 0.45f), Mathf.Lerp(progressFrom, progressTo, 0.9f));
		LuminApplication.APM.AnalyserPopSample("LoadStateAssets");
		LuminApplication.APM.AnalyserPushSample("LoadStateBlueprint");
		await LoadStateBlueprint();
		LuminApplication.APM.AnalyserPopSample("LoadStateBlueprint");
		ReportStageProgress(progressFrom, progressTo, 1f);
	}

	private static void ReportStageProgress(float progressFrom, float progressTo, float ratio)
	{
		SceneChunkLoadUnloadUtils.ReportRange(progressFrom, progressTo, ratio);
	}

	internal async UniTask Unload()
	{
		UnloadStateBlueprint();
		UnloadLevelDesign();
		UnloadStateAssets();
		UniTask uniTask = UnloadSceneAsset();
		ActiveBlock = null;
		await uniTask;
	}

	public SceneChunkRuntimeStateNodeControl(SceneChunkRuntimeControlBase parentChunkControl)
	{
		_parentChunkControl = parentChunkControl;
	}

	private async UniTask LoadSceneAsset()
	{
		int loadCnt = 0;
		string debugName = ActiveBlock.DebugSceneName;
		if (!_foregroundScenePrefabHandle.IsValid)
		{
			(AssetLoadHandle?, bool, int) tuple = await SceneChunkLoadUnloadUtils.LoadSceneAsset(_parentChunkControl.ChunkId, debugName, ActiveBlock.SceneAssetRef, SceneChunkLoadUnloadUtils.SceneType.Foreground);
			AssetLoadHandle? item = tuple.Item1;
			bool item2 = tuple.Item2;
			int item3 = tuple.Item3;
			_foregroundScenePrefabHandle = item.GetValueOrDefault();
			loadCnt += item3;
			if (item2)
			{
				_editorLoaded = true;
			}
		}
		if (!_backgroundScenePrefabHandle.IsValid)
		{
			(AssetLoadHandle?, bool, int) tuple2 = await SceneChunkLoadUnloadUtils.LoadSceneAsset(_parentChunkControl.ChunkId, debugName, ActiveBlock.BackgroundSceneAssetRef, SceneChunkLoadUnloadUtils.SceneType.Background);
			AssetLoadHandle? item4 = tuple2.Item1;
			int item5 = tuple2.Item3;
			_backgroundScenePrefabHandle = item4.GetValueOrDefault();
			loadCnt += item5;
		}
		if (loadCnt == 0)
		{
			_editorLoaded = true;
			await UniTask.CompletedTask;
		}
	}

	private async UniTask UnloadSceneAsset()
	{
		_editorLoaded = false;
		SceneChunkLoadUnloadUtils.UnloadSceneAsset(_foregroundScenePrefabHandle);
		SceneChunkLoadUnloadUtils.UnloadSceneAsset(_backgroundScenePrefabHandle);
		await UniTask.CompletedTask;
	}

	private async UniTask LoadLevelDesign()
	{
		if (ActiveBlock != null)
		{
			Transform parent = _foregroundScenePrefabHandle.AsGameObject()?.transform;
			_levelDesignHandle = await SceneChunkLoadUnloadUtils.LoadLevelDesign(ActiveBlock.LevelDesignAssetRef, parent);
		}
	}

	private void UnloadLevelDesign()
	{
		SceneChunkLoadUnloadUtils.UnloadLevelDesign(_levelDesignHandle);
	}

	private async UniTask LoadStateAssets(CancellationToken cancelToken, CancellationToken syncToken, float progressFrom = 0f, float progressTo = 0f)
	{
		if (ActiveBlock != null)
		{
			_nodeBelongStateAssetsLoaded = false;
			await SceneChunkLoadUnloadUtils.LoadStateAssets(ActiveBlock.StateWorldAssetDatas, cancelToken, syncToken, progressFrom, progressTo);
			_nodeBelongStateAssetsLoaded = true;
		}
	}

	private void UnloadStateAssets()
	{
		if (ActiveBlock != null)
		{
			_nodeBelongStateAssetsLoaded = false;
			SceneChunkLoadUnloadUtils.UnloadStateAssets(ActiveBlock.StateWorldAssetDatas);
		}
	}

	private async UniTask LoadStateBlueprint()
	{
		Transform container = _foregroundScenePrefabHandle.AsGameObject()?.transform;
		_blueprintHandle = await SceneChunkLoadUnloadUtils.LoadStateBlueprint(ActiveBlock.LevelBlueprintAssetRef, container);
	}

	private void UnloadStateBlueprint()
	{
		SceneChunkLoadUnloadUtils.UnloadStateBlueprint(_blueprintHandle);
	}
}

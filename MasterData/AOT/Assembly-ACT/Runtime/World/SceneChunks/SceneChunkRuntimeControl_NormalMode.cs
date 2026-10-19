using System.Threading;
using ACT;
using ACT.World.SceneChunks;
using Cysharp.Threading.Tasks;
using Runtime.Manager.SubManagers.WorldManager.Modules.ChunkModule;
using UnityEngine;
using YooAsset;

namespace Runtime.World.SceneChunks;

public class SceneChunkRuntimeControl_NormalMode : SceneChunkRuntimeControlBase
{
	private bool _isLoaded;

	private SceneHandle _runtimeLoadHandle;

	private SceneChunkRuntimeStateNodeControl _stateNodeControl;

	public override bool StateIsChanged => GetAvailableSceneBlock(Data) != _stateNodeControl?.ActiveBlock;

	internal override SceneBlock ActiveStateData => _stateNodeControl?.ActiveBlock;

	public bool HasActiveBlock => _stateNodeControl?.ActiveBlock != null;

	public SceneBlock ActiveBlock => _stateNodeControl?.ActiveBlock;

	public override SceneBlock GetConditionAvailableBlock()
	{
		return GetAvailableSceneBlock(Data);
	}

	public SceneChunkRuntimeControl_NormalMode(SceneChunk chunk)
		: base(chunk)
	{
	}

	internal static SceneBlock GetAvailableSceneBlock(SceneChunk chunk)
	{
		SceneBlock[] subScenes = chunk.SubScenes;
		int num = subScenes.Length;
		if (num == 0)
		{
			return null;
		}
		if (num <= 1)
		{
			return subScenes[0];
		}
		return GetConditionPassedBlock(chunk);
	}

	private static SceneBlock GetConditionPassedBlock(SceneChunk chunk)
	{
		SceneBlock[] subScenes = chunk.SubScenes;
		for (int num = subScenes.Length - 1; num >= 0; num--)
		{
			SceneBlock sceneBlock = subScenes[num];
			if (sceneBlock.ConditionPassed())
			{
				return sceneBlock;
			}
		}
		Debug.LogError($"[查找当前可用场景块 (WorldId:{chunk.WorldConfigId}, Map:{chunk.MapId}, Area:{chunk.AreaId})] 无法找到满足条件的场景块，默认返回第一个场景块");
		return subScenes[0];
	}

	internal override async UniTask ExecuteLoad(CancellationToken cancelLoadToken, CancellationToken syncInitToken, LoadInstruction instruction = null)
	{
		await LoadSceneBlock(cancelLoadToken, syncInitToken, instruction);
		await LoadChunkParts(cancelLoadToken, syncInitToken, instruction);
		SceneChunkLoadUnloadUtils.ReportSubProgress(1f);
	}

	internal override async UniTask ExecuteUnload()
	{
		UnLoadChunkParts();
		await UnloadSceneBlock();
	}

	private async UniTask LoadSceneBlock(CancellationToken cancelLoadToken, CancellationToken syncInitToken, LoadInstruction instruction = null)
	{
		if (_stateNodeControl == null)
		{
			_stateNodeControl = new SceneChunkRuntimeStateNodeControl(this);
		}
		_stateNodeControl.Load(GetAvailableSceneBlock(Data), cancelLoadToken, syncInitToken, 0.05f, 0.65f).Forget();
		await UniTask.WaitUntil(() => cancelLoadToken.IsCancellationRequested || _stateNodeControl.IsLoaded, PlayerLoopTiming.Update, cancelLoadToken);
		if (cancelLoadToken.IsCancellationRequested)
		{
			UnloadSceneBlock().Forget();
		}
	}

	private async UniTask UnloadSceneBlock()
	{
		await _stateNodeControl.Unload();
	}

	private async UniTask LoadChunkParts(CancellationToken cancelToken, CancellationToken syncInitToken, LoadInstruction instruction = null)
	{
		instruction?.WaitOne();
		await LoadStateAssets(cancelToken, syncInitToken);
		_isLoaded = true;
		instruction?.CompleteOne();
	}

	private void UnLoadChunkParts()
	{
		_isLoaded = false;
		UnloadStateAssets();
	}

	private async UniTask LoadStateAssets(CancellationToken cancelToken, CancellationToken syncInitToken)
	{
		if (Data.StateWorldAssetDatas != null)
		{
			await SceneChunkLoadUnloadUtils.LoadStateAssets(Data.StateWorldAssetDatas, cancelToken, syncInitToken, 0.65f, 1f);
		}
	}

	private void UnloadStateAssets()
	{
		SceneChunkLoadUnloadUtils.UnloadStateAssets(Data.StateWorldAssetDatas);
	}
}

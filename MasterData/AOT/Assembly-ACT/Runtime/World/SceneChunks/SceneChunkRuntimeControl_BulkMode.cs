using System.Threading;
using ACT;
using ACT.World.SceneChunks;
using Cysharp.Threading.Tasks;
using Runtime.Manager.SubManagers.WorldManager.Modules.ChunkModule;

namespace Runtime.World.SceneChunks;

public class SceneChunkRuntimeControl_BulkMode : SceneChunkRuntimeControlBase
{
	private SceneChunkRuntimeStateNodeControl[] _blockControls;

	public override bool StateIsChanged => false;

	internal override SceneBlock ActiveStateData => null;

	public override SceneBlock GetConditionAvailableBlock()
	{
		return null;
	}

	public SceneChunkRuntimeControl_BulkMode(SceneChunk chunk)
		: base(chunk)
	{
	}

	internal override async UniTask ExecuteUnload()
	{
		if (_blockControls == null || _blockControls.Length == 0)
		{
			return;
		}
		UniTask[] unloadTasks = new UniTask[_blockControls.Length];
		for (int i = 0; i < _blockControls.Length; i++)
		{
			SceneChunkRuntimeStateNodeControl sceneChunkRuntimeStateNodeControl = _blockControls[i];
			unloadTasks[i] = sceneChunkRuntimeStateNodeControl.Unload();
		}
		_blockControls = null;
		await UniTask.WaitUntil(() =>
		{
			UniTask[] array = unloadTasks;
			foreach (UniTask uniTask in array)
			{
				if (uniTask.Status == UniTaskStatus.Pending)
				{
					return false;
				}
			}
			return true;
		});
		await UniTask.NextFrame();
	}

	internal override async UniTask ExecuteLoad(CancellationToken cancelLoadToken, CancellationToken syncInitToken, LoadInstruction instruction = null)
	{
		SceneBlock[] subScenes = Data.SubScenes;
		int num = subScenes.Length;
		_blockControls = new SceneChunkRuntimeStateNodeControl[num];
		float num2 = ((num > 0) ? (0.59999996f / (float)num) : 0f);
		for (int i = 0; i < num; i++)
		{
			SceneChunkRuntimeStateNodeControl sceneChunkRuntimeStateNodeControl = new SceneChunkRuntimeStateNodeControl(this);
			_blockControls[i] = sceneChunkRuntimeStateNodeControl;
			sceneChunkRuntimeStateNodeControl.Load(subScenes[i], cancelLoadToken, syncInitToken, 0.05f + num2 * (float)i, 0.05f + num2 * (float)(i + 1)).Forget();
		}
		await UniTask.WaitUntil(AllBlocksLoaded, PlayerLoopTiming.Update, cancelLoadToken);
		SceneChunkLoadUnloadUtils.ReportSubProgress(1f);
	}

	private bool AllBlocksLoaded()
	{
		if (_blockControls == null)
		{
			return true;
		}
		SceneChunkRuntimeStateNodeControl[] blockControls = _blockControls;
		for (int i = 0; i < blockControls.Length; i++)
		{
			if (!blockControls[i].IsLoaded)
			{
				return false;
			}
		}
		return true;
	}
}

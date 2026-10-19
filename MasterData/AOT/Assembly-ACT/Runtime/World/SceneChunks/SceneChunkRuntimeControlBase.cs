using System.Threading;
using ACT;
using ACT.World.SceneChunks;
using Cysharp.Threading.Tasks;

namespace Runtime.World.SceneChunks;

public abstract class SceneChunkRuntimeControlBase : ISceneChunkControl
{
	public abstract bool StateIsChanged { get; }

	public int ChunkId { get; private set; }

	public int WorldConfigId => Data.WorldConfigId;

	public int MapId => Data.MapId;

	public int AreaId => Data.AreaId;

	internal SceneChunk Data { get; private set; }

	internal abstract SceneBlock ActiveStateData { get; }

	public abstract SceneBlock GetConditionAvailableBlock();

	protected SceneChunkRuntimeControlBase(SceneChunk chunk)
	{
		Data = chunk;
		ChunkId = chunk.ChunkId;
	}

	internal async UniTask Load(CancellationToken cancelLoadToken, CancellationToken syncInitToken, LoadInstruction instruction = null)
	{
		await ExecuteLoad(cancelLoadToken, syncInitToken, instruction);
	}

	internal abstract UniTask ExecuteLoad(CancellationToken cancelLoadToken, CancellationToken syncInitToken, LoadInstruction instruction = null);

	internal async UniTask Unload()
	{
		GameManager.trajectorySystem.TryToRemoveAll();
		GameManager.effectSystem.ClearAllNoBindEffects();
		GameManager.monsterSystem.ReleaseAllMonster();
		await ExecuteUnload();
	}

	internal abstract UniTask ExecuteUnload();

	public async UniTask Release()
	{
		await Unload();
		OnRelease();
	}

	protected virtual void OnRelease()
	{
	}
}

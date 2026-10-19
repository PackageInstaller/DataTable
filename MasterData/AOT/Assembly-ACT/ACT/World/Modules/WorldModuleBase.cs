using ACT.World.SceneChunks;

namespace ACT.World.Modules;

public abstract class WorldModuleBase
{
	internal abstract bool NeedGotChunkChange { get; }

	internal void EnterWorld(WorldBase world)
	{
		ResetModule();
		OnEnterWorld(world);
	}

	internal void LeaveWorld(WorldBase world)
	{
		OnLeaveWorld(world);
	}

	internal void SwitchActiveChunk(int activeWorldId, SceneChunk chunkData, SceneBlock chunkActiveStateData)
	{
		OnSwitchActiveChunk(activeWorldId, chunkData, chunkActiveStateData);
	}

	protected virtual void OnSwitchActiveChunk(int activeWorldId, SceneChunk chunkData, SceneBlock chunkActiveStateData)
	{
	}

	internal void Update()
	{
		OnUpdate();
	}

	internal void FixedUpdate()
	{
		OnFixedUpdate();
	}

	internal void LateUpdate()
	{
		OnLateUpdate();
	}

	internal void DrawGizmos()
	{
		OnDrawGizmos();
	}

	private void ResetModule()
	{
		OnResetModule();
	}

	protected virtual void OnUpdate()
	{
	}

	protected virtual void OnLateUpdate()
	{
	}

	protected virtual void OnFixedUpdate()
	{
	}

	protected virtual void OnEnterWorld(WorldBase world)
	{
	}

	protected virtual void OnLeaveWorld(WorldBase world)
	{
	}

	protected virtual void OnResetModule()
	{
	}

	protected virtual void OnDrawGizmos()
	{
	}

	internal void ClearLastChunk()
	{
		OnClearLastChunk();
	}

	protected virtual void OnClearLastChunk()
	{
	}
}

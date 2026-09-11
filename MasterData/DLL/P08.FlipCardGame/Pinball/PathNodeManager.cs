using Pinball.Runtime;
using UnityEngine;

namespace Pinball;

public class PathNodeManager : BallPolygon
{
	private NormalBlock mountedBlock;

	private int cacheBlockUID;

	public PathNodeManager(int uniqueId, GameObject go, BlockPathData pathData, int cacheBlockUID = 0)
		: base(uniqueId, go, Vector2.zero, 1, PolygonType.pathNode)
	{
		vertexCount = 0;
		vertex = new Vector2[0];
		normal = new Vector2[0];
		mountedBlock = null;
		this.cacheBlockUID = cacheBlockUID;
		if (pathData != null)
		{
			InitMovePath(pathData);
		}
		else
		{
			ResetMove();
		}
	}

	public override void Release()
	{
		base.Release();
		mountedBlock = null;
	}

	public override BallPolygon Clone()
	{
		_ = go == null;
		return new PathNodeManager(uniqueId, null, pathData, cacheBlockUID);
	}

	public override void AdjustVerticesAndNormals()
	{
	}

	public override float CheckCollision(Vector2 ballPosition, Vector2 ballVelocity, float ballRadius, out Vector2 newPosition, out Vector2 newVelocity)
	{
		newPosition = ballPosition;
		newVelocity = ballVelocity;
		return 560000f;
	}

	public override void OnCollision(Ball ball)
	{
	}

	public override int OnRoundAfter()
	{
		return 0;
	}

	public override void TriggerPolygonEffect()
	{
	}

	public override void TriggerPolygonEffect(Ball ball)
	{
	}

	public override void TriggerPolygonCallBackEffect()
	{
	}

	public void MountBlock(NormalBlock block)
	{
		mountedBlock = block;
		if (block != null && go != null)
		{
			block?.UpdatePosition(go.transform.localPosition);
		}
	}

	public void UnmountBlock()
	{
		mountedBlock = null;
	}

	public NormalBlock GetMountedBlock()
	{
		return mountedBlock;
	}

	public int GetCacheMountedBlockUID()
	{
		return cacheBlockUID;
	}

	public void SetCacheMountedBlockUID(int id)
	{
		cacheBlockUID = id;
	}

	public override void UpdateMove(float deltaTime)
	{
		base.UpdateMove(deltaTime);
		if (mountedBlock != null && mountedBlock != null)
		{
			mountedBlock.UpdatePosition(go.transform.localPosition);
		}
	}
}

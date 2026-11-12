#define LOG_TRACE
using System.Collections.Generic;
using Pathfinding;
using Pathfinding.RVO;
using Pathfinding.Util;
using TrueSync;
using UnityEngine;

[RequireComponent(typeof(TrueSyncTransform))]
public class DeterministicMovementBlocker : VersionedMonoBehaviour, IDeterministicMovementBlocker
{
	[Tooltip("开启移动阻挡")]
	[SerializeField]
	protected bool _canBlock = true;

	[SerializeField]
	protected RVOLayer _blockLayer = RVOLayer.DefaultAgent;

	[SerializeField]
	protected RVOLayer _blockWith = (RVOLayer)(-1);

	[Tooltip("blockPriority大者可以阻挡blockPriority小者")]
	[TSFPRange(0f, 1f)]
	[SerializeField]
	protected FP _blockPriority = 1f;

	[Tooltip("阻挡移动阻尼")]
	[TSFPRange(0f, 1f)]
	[SerializeField]
	protected FP _blockDamp = 1f;

	[Tooltip("阻挡半径")]
	[SerializeField]
	protected FP _blockerRadius = 0.5f;

	protected TrueSyncTransform _tsTransform;

	public static readonly List<IDeterministicMovementBlocker> activedBlockers = new List<IDeterministicMovementBlocker>();

	private static readonly FP[] _pushAngleSamples = new FP[5] { 30, 60, 90, 120, 150 };

	public bool canBlock
	{
		get
		{
			return _canBlock;
		}
		set
		{
			_canBlock = value;
		}
	}

	public RVOLayer blockLayer
	{
		get
		{
			return _blockLayer;
		}
		set
		{
			_blockLayer = value;
		}
	}

	public RVOLayer blockWith
	{
		get
		{
			return _blockWith;
		}
		set
		{
			_blockWith = value;
		}
	}

	public FP blockPriority
	{
		get
		{
			return _blockPriority;
		}
		set
		{
			_blockPriority = value;
		}
	}

	public FP blockDamp
	{
		get
		{
			return _blockDamp;
		}
		set
		{
			_blockDamp = value;
		}
	}

	public FP blockerRadius
	{
		get
		{
			return _blockerRadius;
		}
		set
		{
			_blockerRadius = value;
		}
	}

	public TSVector blockerPosition
	{
		get
		{
			if (!(_tsTransform != null))
			{
				return transform.position.ToTSVector();
			}
			return _tsTransform.Position3D;
		}
	}

	protected void OnEnable()
	{
		if (_tsTransform == null)
		{
			_tsTransform = GetComponent<TrueSyncTransform>();
		}
		activedBlockers.Add(this);
	}

	protected void OnDisable()
	{
		activedBlockers.Remove(this);
	}

	public static void MovementBlock(IDeterministicMovementBlocker self, ref TSVector nextPosition, AdventureActor actor)
	{
		int num = (int)(long)self.blockPriority;
		for (int i = 0; i < activedBlockers.Count; i++)
		{
			IDeterministicMovementBlocker deterministicMovementBlocker = activedBlockers.get_Item(i);
			int num2 = (int)(long)deterministicMovementBlocker.blockPriority;
			if (deterministicMovementBlocker == self || !deterministicMovementBlocker.canBlock || (deterministicMovementBlocker.blockLayer & self.blockWith) == 0 || num > num2)
			{
				continue;
			}
			TSVector tSVector = deterministicMovementBlocker.blockerPosition;
			TSVector2 tSVector2 = new TSVector2(tSVector.x, tSVector.z);
			TSVector2 tSVector3 = new TSVector2(nextPosition.x, nextPosition.z);
			FP fP = TSVector2.DistanceSquared(tSVector2, tSVector3);
			FP fP2 = deterministicMovementBlocker.blockerRadius + self.blockerRadius;
			FP fP3 = fP2 * fP2;
			if (fP >= fP3)
			{
				continue;
			}
			FP fP4 = FP.Sqrt(fP);
			TSVector2 tSVector4 = (tSVector3 - tSVector2).normalized;
			if (tSVector3.Equals(tSVector2) || tSVector4.Equals(TSVector2.zero))
			{
				NovaLogger.Trace("block, 两者位置重叠，按自身反方向进行推挤");
				tSVector4 = ((actor != null) ? actor.tsTransform.Back.normalized : TSVector2.right);
			}
			FP fP5 = fP2 - fP4;
			FP fP6 = ((num == num2) ? 0.5f : 1f) * fP5 * self.blockDamp;
			TSVector2 tSVector5 = tSVector4 * fP6;
			TSVector tSVector6 = nextPosition + new TSVector(tSVector5.x, 0f, tSVector5.y);
			if (actor != null && deterministicMovementBlocker is DeterministicMovementAgent)
			{
				if (actor.QueryPositionWalkable(new TSVector2(tSVector6.x, tSVector6.z)) && actor.QueryPositionReachable(new TSVector2(tSVector6.x, tSVector6.z)))
				{
					nextPosition = tSVector6;
					continue;
				}
				bool flag = false;
				for (int j = 0; j < _pushAngleSamples.Length; j++)
				{
					if (flag)
					{
						break;
					}
					FP fP7 = _pushAngleSamples[j];
					for (int k = 0; k < 2; k++)
					{
						if (flag)
						{
							break;
						}
						FP degrees = ((k == 0) ? fP7 : (-fP7));
						TSVector2 tSVector7 = TSVector2.Rotate(tSVector4, degrees) * fP6;
						TSVector tSVector8 = nextPosition + new TSVector(tSVector7.x, 0f, tSVector7.y);
						TSVector2 position = new TSVector2(tSVector8.x, tSVector8.z);
						if (actor.QueryPositionWalkable(position) && actor.QueryPositionReachable(position))
						{
							nextPosition = tSVector8;
							flag = true;
						}
					}
				}
				if (!flag)
				{
					NovaLogger.Trace("block, 扇形扫描全部不可行走，保持原 nextPosition 不动");
				}
			}
			else
			{
				nextPosition = tSVector6;
			}
		}
	}

	private void OnDrawGizmos()
	{
		if (_canBlock)
		{
			Draw.Gizmos.Cylinder(transform.position, Vector3.up, 2f, (float)_blockerRadius, new Color(0.8f, 0.7f, 0.012f, 1f));
		}
	}
}

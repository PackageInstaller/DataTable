using System.Collections.Generic;
using TrueSync;
using TrueSync.Physics2D;

public class OrbitNode
{
	public List<AttachNode> attachNodes = new List<AttachNode>();

	private OrbitEntity parent;

	private FP radius;

	private FP rotSpeed;

	private TSVector2 localPos;

	private FP localRot;

	private Transform rotationTransfrom;

	public OrbitNode(FP _radius, FP _rotSpeed)
	{
		radius = _radius;
		rotSpeed = _rotSpeed;
	}

	public void Init(OrbitEntity _parent)
	{
		localPos = TSVector2.zero;
		localRot = 0;
		parent = _parent;
		rotationTransfrom.Set(localPos, localRot);
	}

	public void Update(bool updateAtkTarget = true)
	{
		if (parent.EnableRot)
		{
			FP fP = rotSpeed * parent.LogicDeltaTime;
			localRot += fP;
			localRot = (localRot + 360f) % 360f;
			localPos = TSVector2.zero;
			rotationTransfrom.Set(localPos, localRot);
		}
		UpdateAttachs();
	}

	public void UpdateAttachs(bool forceSync = false, bool updateAtkTarget = true)
	{
		for (int i = 0; i < attachNodes.Count; i++)
		{
			AttachNode attachNode = attachNodes.get_Item(i);
			if (!(attachNode.attachEntity == null))
			{
				if (updateAtkTarget)
				{
					attachNode.attachEntity.monsterTarget = parent.atkTarget;
				}
				var (position, rotation, forward) = CalcTRS(attachNode);
				attachNode.attachEntity.tsTransform.Position = position;
				attachNode.attachEntity.tsTransform.Rotation = rotation;
				attachNode.attachEntity.tsTransform.Forward = forward;
				if (!attachNode.FirstSyn | forceSync)
				{
					attachNode.attachEntity.SyncMovementLocation();
					attachNode.FirstSyn = true;
				}
			}
		}
	}

	public (TSVector2, FP, TSVector2) CalcTRS(AttachNode attachNode)
	{
		FP x = radius * TSMath.Cos(attachNode.attachOffsetRot * TSMath.Deg2Rad);
		FP y = radius * TSMath.Sin(attachNode.attachOffsetRot * TSMath.Deg2Rad);
		TSVector2 point = MathUtils.Mul(ref rotationTransfrom, new TSVector2(x, y));
		FP fP = localRot + attachNode.attachOffsetRot;
		TSVector2 tSVector = parent.tsTransform.TransformLocalPointToWorldSpace(point);
		FP item = parent.tsTransform.Rotation + fP;
		TSVector2 normalized = (parent.tsTransform.Position - tSVector).normalized;
		return (tSVector, item, normalized);
	}

	public void ResetAtkTarget()
	{
		for (int i = 0; i < attachNodes.Count; i++)
		{
			attachNodes.get_Item(i).ResetAtkTarget();
		}
	}

	public void FadeOut()
	{
		for (int i = 0; i < attachNodes.Count; i++)
		{
			attachNodes.get_Item(i).FadeOut();
		}
	}

	public bool CheckFadeOutCompleted()
	{
		bool flag = true;
		for (int i = 0; i < attachNodes.Count; i++)
		{
			flag &= attachNodes.get_Item(i).CheckFadeOutComplete();
		}
		return flag;
	}

	public void FadeIn()
	{
		for (int i = 0; i < attachNodes.Count; i++)
		{
			attachNodes.get_Item(i).FadeIn();
		}
	}

	public bool CheckFadeInCompleted()
	{
		bool flag = true;
		for (int i = 0; i < attachNodes.Count; i++)
		{
			flag &= attachNodes.get_Item(i).CheckFadeInComplete();
		}
		return flag;
	}

	public bool CheckSpawnCompleted()
	{
		bool flag = true;
		for (int i = 0; i < attachNodes.Count; i++)
		{
			flag &= attachNodes.get_Item(i).CheckSpawnComplete();
		}
		return flag;
	}

	public void Finish()
	{
		for (int i = 0; i < attachNodes.Count; i++)
		{
			attachNodes.get_Item(i).Finish();
		}
		attachNodes.Clear();
	}
}

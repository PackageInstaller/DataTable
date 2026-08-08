using Config;
using Entitas;

[Sim]
public class EntityShape : IComponent, IEntityShape
{
	public Int3 mOffset;

	public ShapePartType mPartType;

	public ISimShape mShape;

	public uint mLayer;

	public int mWeight;

	public ShapePartInfo mShapePartInfo;

	public Int3 GetOffset()
	{
		return mOffset;
	}

	public ISimShape GetShape()
	{
		return mShape;
	}

	public int GetWeight()
	{
		return mWeight;
	}

	public void SetEnable(bool isEnable)
	{
		if (mShape != null)
		{
			mShape.IsEnable = isEnable;
		}
	}

	public virtual int GetPart()
	{
		return (int)mPartType;
	}

	public Int GetRadius()
	{
		return mShape.AvgCollisionRadius;
	}

	public uint GetLayer()
	{
		return mLayer;
	}
}

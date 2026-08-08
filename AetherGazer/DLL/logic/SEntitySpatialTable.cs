using System;
using System.Collections.Generic;
using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[Unique]
public class SEntitySpatialTable : IComponent
{
	private const int cGridHeight = 256;

	private const int cGridHeightMask = 255;

	private const int cGridWidth = 256;

	private const int cGridWidthMask = 255;

	private Int Height;

	private Int Width;

	private VFactor mHeightMultiplier;

	private VFactor mWidthMultiplier;

	private SimEntity[,] mTable = new SimEntity[256, 256];

	public Int2 mMin;

	public Int2 mMax;

	public void Clear()
	{
		Array.Clear(mTable, 0, 65536);
	}

	private void Init(Int2 min, Int2 max)
	{
		mTable = new SimEntity[256, 256];
		mMin = min;
		mMax = max;
		Width = max.x - min.x;
		Height = max.y - min.y;
		mWidthMultiplier = new VFactor(256L, Width.i);
		mHeightMultiplier = new VFactor(256L, Height.i);
	}

	private void PointToBucket(int x, int y, out int i, out int j)
	{
		VFactor vFactor = (x - mMin.x) * mWidthMultiplier;
		i = (int)IntMath.Divide(vFactor.nom, vFactor.den);
		i = ((i >= 0) ? ((i >= 256) ? 255 : i) : 0);
		VFactor vFactor2 = (y - mMin.y) * mHeightMultiplier;
		j = (int)IntMath.Divide(vFactor2.nom, vFactor2.den);
		j = ((j >= 0) ? ((j >= 256) ? 255 : j) : 0);
	}

	public void InsertEntity(SimEntity entity)
	{
		if (entity.hasEntityPositon)
		{
			int i = -1;
			int j = -1;
			EntityPositon entityPositon = entity.entityPositon;
			PointToBucket(entityPositon.mPosition.x, entityPositon.mPosition.y, out i, out j);
			if (mTable[i, j] == null)
			{
				entity.mLinkNext = null;
				entity.mLinkNext.mLinePre = null;
				mTable[i, j] = entity;
			}
			else
			{
				(entity.mLinkNext = mTable[i, j]).mLinePre = entity;
				entity.mLinkNext.mLinePre = null;
				mTable[i, j] = entity;
			}
			entity.x = i;
			entity.z = j;
		}
	}

	public void RemoveEntity(SimEntity entity)
	{
		int x = entity.x;
		int z = entity.z;
		if (mTable[x, z] == entity)
		{
			mTable[x, z] = entity.mLinkNext;
			return;
		}
		for (SimEntity simEntity = mTable[x, z]; simEntity != null; simEntity = simEntity.mLinkNext)
		{
			if (simEntity == entity)
			{
				if (simEntity.mLinePre == null)
				{
					mTable[x, z] = entity.mLinkNext;
				}
				else
				{
					entity.mLinePre.mLinkNext = entity.mLinkNext;
					if (entity.mLinkNext != null)
					{
						entity.mLinkNext.mLinePre = entity.mLinePre;
					}
				}
			}
		}
	}

	public void FindEntitiesInCircle(Int3 center, Int radius, List<SimEntity> entitiesInCircle)
	{
		Int obj = center.x;
		Int obj2 = center.z;
		PointToBucket((obj - radius).i, (obj2 - radius).i, out var i, out var j);
		PointToBucket((obj + radius).i, (obj2 + radius).i, out var i2, out var j2);
		if (++i2 >= 256)
		{
			i2 = 255;
		}
		if (++j2 >= 256)
		{
			j2 = 255;
		}
		for (int k = i; k <= i2; k++)
		{
			for (int l = j; l <= j2; l++)
			{
				for (SimEntity simEntity = mTable[k, l]; simEntity != null; simEntity = simEntity.mLinkNext)
				{
					EntityPositon entityPositon = simEntity.entityPositon;
					Int3 mPosition = entityPositon.mPosition;
					Int obj3 = mPosition.x - obj;
					Int obj4 = mPosition.z - obj2;
					if (obj3 * obj3 + obj4 * obj4 <= radius * radius)
					{
						entitiesInCircle.Add(simEntity);
					}
				}
			}
		}
	}

	public void FindEntitiesInRectangle(Int3 v0, Int3 v1, List<Entity> entitiesInRectangle)
	{
		int x;
		int x2;
		if (v0.x < v1.x)
		{
			x = v0.x;
			x2 = v1.x;
		}
		else
		{
			x = v1.x;
			x2 = v0.x;
		}
		int z;
		int z2;
		if (v0.z < v1.z)
		{
			z = v0.z;
			z2 = v1.z;
		}
		else
		{
			z = v1.z;
			z2 = v0.z;
		}
		PointToBucket(x, z, out var i, out var j);
		PointToBucket(x2, z2, out var i2, out var j2);
		if (++i2 >= 256)
		{
			i2 = 255;
		}
		if (++j2 >= 256)
		{
			j2 = 255;
		}
		for (int k = i; k <= i2; k++)
		{
			for (int l = j; l <= j2; l++)
			{
				for (SimEntity simEntity = mTable[k, l]; simEntity != null; simEntity = simEntity.mLinkNext)
				{
					Int3 mPosition = simEntity.entityPositon.mPosition;
					if (mPosition.x >= x && mPosition.x <= x2 && mPosition.z >= z && mPosition.y <= z2)
					{
						entitiesInRectangle.Add(simEntity);
					}
				}
			}
		}
	}
}

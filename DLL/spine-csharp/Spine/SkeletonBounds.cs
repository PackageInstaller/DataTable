using System;

namespace Spine;

public class SkeletonBounds
{
	private ExposedList<Polygon> polygonPool = new ExposedList<Polygon>();

	private float minX;

	private float minY;

	private float maxX;

	private float maxY;

	public ExposedList<BoundingBoxAttachment> BoundingBoxes { get; private set; }

	public ExposedList<Polygon> Polygons { get; private set; }

	public float MinX
	{
		get
		{
			return minX;
		}
		set
		{
			minX = value;
		}
	}

	public float MinY
	{
		get
		{
			return minY;
		}
		set
		{
			minY = value;
		}
	}

	public float MaxX
	{
		get
		{
			return maxX;
		}
		set
		{
			maxX = value;
		}
	}

	public float MaxY
	{
		get
		{
			return maxY;
		}
		set
		{
			maxY = value;
		}
	}

	public float Width => maxX - minX;

	public float Height => maxY - minY;

	public SkeletonBounds()
	{
		BoundingBoxes = new ExposedList<BoundingBoxAttachment>();
		Polygons = new ExposedList<Polygon>();
	}

	public void Update(Skeleton skeleton, bool updateAabb)
	{
		ExposedList<BoundingBoxAttachment> boundingBoxes = BoundingBoxes;
		ExposedList<Polygon> polygons = Polygons;
		Slot[] items = skeleton.slots.Items;
		int count = skeleton.slots.Count;
		boundingBoxes.Clear();
		int i = 0;
		for (int count2 = polygons.Count; i < count2; i++)
		{
			polygonPool.Add(polygons.Items[i]);
		}
		polygons.Clear();
		for (int j = 0; j < count; j++)
		{
			Slot slot = items[j];
			if (slot.bone.active && slot.attachment is BoundingBoxAttachment boundingBoxAttachment)
			{
				boundingBoxes.Add(boundingBoxAttachment);
				Polygon polygon = null;
				int count3 = polygonPool.Count;
				if (count3 > 0)
				{
					polygon = polygonPool.Items[count3 - 1];
					polygonPool.RemoveAt(count3 - 1);
				}
				else
				{
					polygon = new Polygon();
				}
				polygons.Add(polygon);
				int num = (polygon.Count = boundingBoxAttachment.worldVerticesLength);
				if (polygon.Vertices.Length < num)
				{
					polygon.Vertices = new float[num];
				}
				boundingBoxAttachment.ComputeWorldVertices(slot, polygon.Vertices);
			}
		}
		if (updateAabb)
		{
			AabbCompute();
			return;
		}
		minX = -2.1474836E+09f;
		minY = -2.1474836E+09f;
		maxX = 2.1474836E+09f;
		maxY = 2.1474836E+09f;
	}

	private void AabbCompute()
	{
		float val = 2.1474836E+09f;
		float val2 = 2.1474836E+09f;
		float val3 = -2.1474836E+09f;
		float val4 = -2.1474836E+09f;
		Polygon[] items = Polygons.Items;
		int i = 0;
		for (int count = Polygons.Count; i < count; i++)
		{
			Polygon obj = items[i];
			float[] vertices = obj.Vertices;
			int j = 0;
			for (int count2 = obj.Count; j < count2; j += 2)
			{
				float val5 = vertices[j];
				float val6 = vertices[j + 1];
				val = Math.Min(val, val5);
				val2 = Math.Min(val2, val6);
				val3 = Math.Max(val3, val5);
				val4 = Math.Max(val4, val6);
			}
		}
		minX = val;
		minY = val2;
		maxX = val3;
		maxY = val4;
	}

	public bool AabbContainsPoint(float x, float y)
	{
		if (x >= minX && x <= maxX && y >= minY)
		{
			return y <= maxY;
		}
		return false;
	}

	public bool AabbIntersectsSegment(float x1, float y1, float x2, float y2)
	{
		float num = minX;
		float num2 = minY;
		float num3 = maxX;
		float num4 = maxY;
		if ((x1 <= num && x2 <= num) || (y1 <= num2 && y2 <= num2) || (x1 >= num3 && x2 >= num3) || (y1 >= num4 && y2 >= num4))
		{
			return false;
		}
		float num5 = (y2 - y1) / (x2 - x1);
		float num6 = num5 * (num - x1) + y1;
		if (num6 > num2 && num6 < num4)
		{
			return true;
		}
		num6 = num5 * (num3 - x1) + y1;
		if (num6 > num2 && num6 < num4)
		{
			return true;
		}
		float num7 = (num2 - y1) / num5 + x1;
		if (num7 > num && num7 < num3)
		{
			return true;
		}
		num7 = (num4 - y1) / num5 + x1;
		if (num7 > num && num7 < num3)
		{
			return true;
		}
		return false;
	}

	public bool AabbIntersectsSkeleton(SkeletonBounds bounds)
	{
		if (minX < bounds.maxX && maxX > bounds.minX && minY < bounds.maxY)
		{
			return maxY > bounds.minY;
		}
		return false;
	}

	public bool ContainsPoint(Polygon polygon, float x, float y)
	{
		float[] vertices = polygon.Vertices;
		int count = polygon.Count;
		int num = count - 2;
		bool flag = false;
		for (int i = 0; i < count; i += 2)
		{
			float num2 = vertices[i + 1];
			float num3 = vertices[num + 1];
			if ((num2 < y && num3 >= y) || (num3 < y && num2 >= y))
			{
				float num4 = vertices[i];
				if (num4 + (y - num2) / (num3 - num2) * (vertices[num] - num4) < x)
				{
					flag = !flag;
				}
			}
			num = i;
		}
		return flag;
	}

	public BoundingBoxAttachment ContainsPoint(float x, float y)
	{
		Polygon[] items = Polygons.Items;
		int i = 0;
		for (int count = Polygons.Count; i < count; i++)
		{
			if (ContainsPoint(items[i], x, y))
			{
				return BoundingBoxes.Items[i];
			}
		}
		return null;
	}

	public BoundingBoxAttachment IntersectsSegment(float x1, float y1, float x2, float y2)
	{
		Polygon[] items = Polygons.Items;
		int i = 0;
		for (int count = Polygons.Count; i < count; i++)
		{
			if (IntersectsSegment(items[i], x1, y1, x2, y2))
			{
				return BoundingBoxes.Items[i];
			}
		}
		return null;
	}

	public bool IntersectsSegment(Polygon polygon, float x1, float y1, float x2, float y2)
	{
		float[] vertices = polygon.Vertices;
		int count = polygon.Count;
		float num = x1 - x2;
		float num2 = y1 - y2;
		float num3 = x1 * y2 - y1 * x2;
		float num4 = vertices[count - 2];
		float num5 = vertices[count - 1];
		for (int i = 0; i < count; i += 2)
		{
			float num6 = vertices[i];
			float num7 = vertices[i + 1];
			float num8 = num4 * num7 - num5 * num6;
			float num9 = num4 - num6;
			float num10 = num5 - num7;
			float num11 = num * num10 - num2 * num9;
			float num12 = (num3 * num9 - num * num8) / num11;
			if (((num12 >= num4 && num12 <= num6) || (num12 >= num6 && num12 <= num4)) && ((num12 >= x1 && num12 <= x2) || (num12 >= x2 && num12 <= x1)))
			{
				float num13 = (num3 * num10 - num2 * num8) / num11;
				if (((num13 >= num5 && num13 <= num7) || (num13 >= num7 && num13 <= num5)) && ((num13 >= y1 && num13 <= y2) || (num13 >= y2 && num13 <= y1)))
				{
					return true;
				}
			}
			num4 = num6;
			num5 = num7;
		}
		return false;
	}

	public Polygon GetPolygon(BoundingBoxAttachment attachment)
	{
		int num = BoundingBoxes.IndexOf(attachment);
		if (num != -1)
		{
			return Polygons.Items[num];
		}
		return null;
	}
}

using System;

namespace Spine;

public class Triangulator
{
	private readonly ExposedList<ExposedList<float>> convexPolygons = new ExposedList<ExposedList<float>>();

	private readonly ExposedList<ExposedList<int>> convexPolygonsIndices = new ExposedList<ExposedList<int>>();

	private readonly ExposedList<int> indicesArray = new ExposedList<int>();

	private readonly ExposedList<bool> isConcaveArray = new ExposedList<bool>();

	private readonly ExposedList<int> triangles = new ExposedList<int>();

	private readonly Pool<ExposedList<float>> polygonPool = new Pool<ExposedList<float>>();

	private readonly Pool<ExposedList<int>> polygonIndicesPool = new Pool<ExposedList<int>>();

	public ExposedList<int> Triangulate(ExposedList<float> verticesArray)
	{
		float[] items = verticesArray.Items;
		int num = verticesArray.Count >> 1;
		ExposedList<int> exposedList = indicesArray;
		exposedList.Clear();
		int[] items2 = exposedList.Resize(num).Items;
		for (int i = 0; i < num; i++)
		{
			items2[i] = i;
		}
		ExposedList<bool> exposedList2 = isConcaveArray;
		bool[] items3 = exposedList2.Resize(num).Items;
		int j = 0;
		for (int num2 = num; j < num2; j++)
		{
			items3[j] = IsConcave(j, num, items, items2);
		}
		ExposedList<int> exposedList3 = triangles;
		exposedList3.Clear();
		exposedList3.EnsureCapacity(Math.Max(0, num - 2) << 2);
		while (num > 3)
		{
			int num3 = num - 1;
			int num4 = 0;
			int num5 = 1;
			while (true)
			{
				if (!items3[num4])
				{
					int num6 = items2[num3] << 1;
					int num7 = items2[num4] << 1;
					int num8 = items2[num5] << 1;
					float num9 = items[num6];
					float num10 = items[num6 + 1];
					float num11 = items[num7];
					float num12 = items[num7 + 1];
					float num13 = items[num8];
					float num14 = items[num8 + 1];
					for (int num15 = (num5 + 1) % num; num15 != num3; num15 = (num15 + 1) % num)
					{
						if (!items3[num15])
						{
							continue;
						}
						int num16 = items2[num15] << 1;
						float p3x = items[num16];
						float p3y = items[num16 + 1];
						if (!PositiveArea(num13, num14, num9, num10, p3x, p3y) || !PositiveArea(num9, num10, num11, num12, p3x, p3y) || !PositiveArea(num11, num12, num13, num14, p3x, p3y))
						{
							continue;
						}
						goto IL_0169;
					}
					break;
				}
				goto IL_0169;
				IL_0169:
				if (num5 == 0)
				{
					while (items3[num4])
					{
						num4--;
						if (num4 <= 0)
						{
							break;
						}
					}
					break;
				}
				num3 = num4;
				num4 = num5;
				num5 = (num5 + 1) % num;
			}
			exposedList3.Add(items2[(num + num4 - 1) % num]);
			exposedList3.Add(items2[num4]);
			exposedList3.Add(items2[(num4 + 1) % num]);
			exposedList.RemoveAt(num4);
			exposedList2.RemoveAt(num4);
			num--;
			int num17 = (num + num4 - 1) % num;
			int num18 = ((num4 != num) ? num4 : 0);
			items3[num17] = IsConcave(num17, num, items, items2);
			items3[num18] = IsConcave(num18, num, items, items2);
		}
		if (num == 3)
		{
			exposedList3.Add(items2[2]);
			exposedList3.Add(items2[0]);
			exposedList3.Add(items2[1]);
		}
		return exposedList3;
	}

	public ExposedList<ExposedList<float>> Decompose(ExposedList<float> verticesArray, ExposedList<int> triangles)
	{
		float[] items = verticesArray.Items;
		ExposedList<ExposedList<float>> exposedList = convexPolygons;
		int i = 0;
		for (int count = exposedList.Count; i < count; i++)
		{
			polygonPool.Free(exposedList.Items[i]);
		}
		exposedList.Clear();
		ExposedList<ExposedList<int>> exposedList2 = convexPolygonsIndices;
		int j = 0;
		for (int count2 = exposedList2.Count; j < count2; j++)
		{
			polygonIndicesPool.Free(exposedList2.Items[j]);
		}
		exposedList2.Clear();
		ExposedList<int> exposedList3 = polygonIndicesPool.Obtain();
		exposedList3.Clear();
		ExposedList<float> exposedList4 = polygonPool.Obtain();
		exposedList4.Clear();
		int num = -1;
		int num2 = 0;
		int[] items2 = triangles.Items;
		int k = 0;
		for (int count3 = triangles.Count; k < count3; k += 3)
		{
			int num3 = items2[k] << 1;
			int num4 = items2[k + 1] << 1;
			int num5 = items2[k + 2] << 1;
			float num6 = items[num3];
			float num7 = items[num3 + 1];
			float num8 = items[num4];
			float num9 = items[num4 + 1];
			float num10 = items[num5];
			float num11 = items[num5 + 1];
			bool flag = false;
			if (num == num3)
			{
				int num12 = exposedList4.Count - 4;
				float[] items3 = exposedList4.Items;
				int num13 = Winding(items3[num12], items3[num12 + 1], items3[num12 + 2], items3[num12 + 3], num10, num11);
				int num14 = Winding(num10, num11, items3[0], items3[1], items3[2], items3[3]);
				if (num13 == num2 && num14 == num2)
				{
					exposedList4.Add(num10);
					exposedList4.Add(num11);
					exposedList3.Add(num5);
					flag = true;
				}
			}
			if (!flag)
			{
				if (exposedList4.Count > 0)
				{
					exposedList.Add(exposedList4);
					exposedList2.Add(exposedList3);
				}
				else
				{
					polygonPool.Free(exposedList4);
					polygonIndicesPool.Free(exposedList3);
				}
				exposedList4 = polygonPool.Obtain();
				exposedList4.Clear();
				exposedList4.Add(num6);
				exposedList4.Add(num7);
				exposedList4.Add(num8);
				exposedList4.Add(num9);
				exposedList4.Add(num10);
				exposedList4.Add(num11);
				exposedList3 = polygonIndicesPool.Obtain();
				exposedList3.Clear();
				exposedList3.Add(num3);
				exposedList3.Add(num4);
				exposedList3.Add(num5);
				num2 = Winding(num6, num7, num8, num9, num10, num11);
				num = num3;
			}
		}
		if (exposedList4.Count > 0)
		{
			exposedList.Add(exposedList4);
			exposedList2.Add(exposedList3);
		}
		int l = 0;
		for (int count4 = exposedList.Count; l < count4; l++)
		{
			exposedList3 = exposedList2.Items[l];
			if (exposedList3.Count == 0)
			{
				continue;
			}
			int num15 = exposedList3.Items[0];
			int num16 = exposedList3.Items[exposedList3.Count - 1];
			exposedList4 = exposedList.Items[l];
			int num17 = exposedList4.Count - 4;
			float[] items4 = exposedList4.Items;
			float p1x = items4[num17];
			float p1y = items4[num17 + 1];
			float num18 = items4[num17 + 2];
			float num19 = items4[num17 + 3];
			float num20 = items4[0];
			float num21 = items4[1];
			float p3x = items4[2];
			float p3y = items4[3];
			int num22 = Winding(p1x, p1y, num18, num19, num20, num21);
			for (int m = 0; m < count4; m++)
			{
				if (m == l)
				{
					continue;
				}
				ExposedList<int> exposedList5 = exposedList2.Items[m];
				if (exposedList5.Count != 3)
				{
					continue;
				}
				int num23 = exposedList5.Items[0];
				int num24 = exposedList5.Items[1];
				int item = exposedList5.Items[2];
				ExposedList<float> exposedList6 = exposedList.Items[m];
				float num25 = exposedList6.Items[exposedList6.Count - 2];
				float num26 = exposedList6.Items[exposedList6.Count - 1];
				if (num23 == num15 && num24 == num16)
				{
					int num27 = Winding(p1x, p1y, num18, num19, num25, num26);
					int num28 = Winding(num25, num26, num20, num21, p3x, p3y);
					if (num27 == num22 && num28 == num22)
					{
						exposedList6.Clear();
						exposedList5.Clear();
						exposedList4.Add(num25);
						exposedList4.Add(num26);
						exposedList3.Add(item);
						p1x = num18;
						p1y = num19;
						num18 = num25;
						num19 = num26;
						m = 0;
					}
				}
			}
		}
		for (int num29 = exposedList.Count - 1; num29 >= 0; num29--)
		{
			exposedList4 = exposedList.Items[num29];
			if (exposedList4.Count == 0)
			{
				exposedList.RemoveAt(num29);
				polygonPool.Free(exposedList4);
				exposedList3 = exposedList2.Items[num29];
				exposedList2.RemoveAt(num29);
				polygonIndicesPool.Free(exposedList3);
			}
		}
		return exposedList;
	}

	private static bool IsConcave(int index, int vertexCount, float[] vertices, int[] indices)
	{
		int num = indices[(vertexCount + index - 1) % vertexCount] << 1;
		int num2 = indices[index] << 1;
		int num3 = indices[(index + 1) % vertexCount] << 1;
		return !PositiveArea(vertices[num], vertices[num + 1], vertices[num2], vertices[num2 + 1], vertices[num3], vertices[num3 + 1]);
	}

	private static bool PositiveArea(float p1x, float p1y, float p2x, float p2y, float p3x, float p3y)
	{
		return p1x * (p3y - p2y) + p2x * (p1y - p3y) + p3x * (p2y - p1y) >= 0f;
	}

	private static int Winding(float p1x, float p1y, float p2x, float p2y, float p3x, float p3y)
	{
		float num = p2x - p1x;
		float num2 = p2y - p1y;
		if (!(p3x * num2 - p3y * num + num * p1y - p1x * num2 >= 0f))
		{
			return -1;
		}
		return 1;
	}
}

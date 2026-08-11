namespace Spine;

public class SkeletonClipping
{
	internal readonly Triangulator triangulator = new Triangulator();

	internal readonly ExposedList<float> clippingPolygon = new ExposedList<float>();

	internal readonly ExposedList<float> clipOutput = new ExposedList<float>(128);

	internal readonly ExposedList<float> clippedVertices = new ExposedList<float>(128);

	internal readonly ExposedList<int> clippedTriangles = new ExposedList<int>(128);

	internal readonly ExposedList<float> clippedUVs = new ExposedList<float>(128);

	internal readonly ExposedList<float> scratch = new ExposedList<float>();

	internal ClippingAttachment clipAttachment;

	internal ExposedList<ExposedList<float>> clippingPolygons;

	public ExposedList<float> ClippedVertices => clippedVertices;

	public ExposedList<int> ClippedTriangles => clippedTriangles;

	public ExposedList<float> ClippedUVs => clippedUVs;

	public bool IsClipping => clipAttachment != null;

	public int ClipStart(Slot slot, ClippingAttachment clip)
	{
		if (clipAttachment != null)
		{
			return 0;
		}
		clipAttachment = clip;
		int worldVerticesLength = clip.worldVerticesLength;
		float[] items = clippingPolygon.Resize(worldVerticesLength).Items;
		clip.ComputeWorldVertices(slot, 0, worldVerticesLength, items, 0);
		MakeClockwise(clippingPolygon);
		clippingPolygons = triangulator.Decompose(clippingPolygon, triangulator.Triangulate(clippingPolygon));
		foreach (ExposedList<float> clippingPolygon in clippingPolygons)
		{
			MakeClockwise(clippingPolygon);
			clippingPolygon.Add(clippingPolygon.Items[0]);
			clippingPolygon.Add(clippingPolygon.Items[1]);
		}
		return clippingPolygons.Count;
	}

	public void ClipEnd(Slot slot)
	{
		if (clipAttachment != null && clipAttachment.endSlot == slot.data)
		{
			ClipEnd();
		}
	}

	public void ClipEnd()
	{
		if (clipAttachment != null)
		{
			clipAttachment = null;
			clippingPolygons = null;
			clippedVertices.Clear();
			clippedTriangles.Clear();
			clippingPolygon.Clear();
		}
	}

	public void ClipTriangles(float[] vertices, int[] triangles, int trianglesLength)
	{
		ExposedList<float> exposedList = clipOutput;
		ExposedList<float> exposedList2 = clippedVertices;
		ExposedList<int> exposedList3 = clippedTriangles;
		ExposedList<float>[] items = clippingPolygons.Items;
		int count = clippingPolygons.Count;
		int num = 0;
		exposedList2.Clear();
		exposedList3.Clear();
		for (int i = 0; i < trianglesLength; i += 3)
		{
			int num2 = triangles[i] << 1;
			float num3 = vertices[num2];
			float num4 = vertices[num2 + 1];
			num2 = triangles[i + 1] << 1;
			float num5 = vertices[num2];
			float num6 = vertices[num2 + 1];
			num2 = triangles[i + 2] << 1;
			float num7 = vertices[num2];
			float num8 = vertices[num2 + 1];
			for (int j = 0; j < count; j++)
			{
				int num9 = exposedList2.Count;
				if (Clip(num3, num4, num5, num6, num7, num8, items[j], exposedList))
				{
					int count2 = exposedList.Count;
					if (count2 != 0)
					{
						int num10 = count2 >> 1;
						float[] items2 = exposedList.Items;
						float[] items3 = exposedList2.Resize(num9 + num10 * 2).Items;
						int num11 = 0;
						while (num11 < count2)
						{
							float num12 = items2[num11];
							float num13 = items2[num11 + 1];
							items3[num9] = num12;
							items3[num9 + 1] = num13;
							num11 += 2;
							num9 += 2;
						}
						num9 = exposedList3.Count;
						int[] items4 = exposedList3.Resize(num9 + 3 * (num10 - 2)).Items;
						num10--;
						int num14 = 1;
						while (num14 < num10)
						{
							items4[num9] = num;
							items4[num9 + 1] = num + num14;
							items4[num9 + 2] = num + num14 + 1;
							num14++;
							num9 += 3;
						}
						num += num10 + 1;
					}
					continue;
				}
				float[] items5 = exposedList2.Resize(num9 + 6).Items;
				items5[num9] = num3;
				items5[num9 + 1] = num4;
				items5[num9 + 2] = num5;
				items5[num9 + 3] = num6;
				items5[num9 + 4] = num7;
				items5[num9 + 5] = num8;
				num9 = exposedList3.Count;
				int[] items6 = exposedList3.Resize(num9 + 3).Items;
				items6[num9] = num;
				items6[num9 + 1] = num + 1;
				items6[num9 + 2] = num + 2;
				num += 3;
				break;
			}
		}
	}

	public void ClipTriangles(float[] vertices, int[] triangles, int trianglesLength, float[] uvs)
	{
		ExposedList<float> exposedList = clipOutput;
		ExposedList<float> exposedList2 = clippedVertices;
		ExposedList<int> exposedList3 = clippedTriangles;
		ExposedList<float>[] items = clippingPolygons.Items;
		int count = clippingPolygons.Count;
		int num = 0;
		exposedList2.Clear();
		clippedUVs.Clear();
		exposedList3.Clear();
		for (int i = 0; i < trianglesLength; i += 3)
		{
			int num2 = triangles[i] << 1;
			float num3 = vertices[num2];
			float num4 = vertices[num2 + 1];
			float num5 = uvs[num2];
			float num6 = uvs[num2 + 1];
			num2 = triangles[i + 1] << 1;
			float num7 = vertices[num2];
			float num8 = vertices[num2 + 1];
			float num9 = uvs[num2];
			float num10 = uvs[num2 + 1];
			num2 = triangles[i + 2] << 1;
			float num11 = vertices[num2];
			float num12 = vertices[num2 + 1];
			float num13 = uvs[num2];
			float num14 = uvs[num2 + 1];
			for (int j = 0; j < count; j++)
			{
				int num15 = exposedList2.Count;
				if (Clip(num3, num4, num7, num8, num11, num12, items[j], exposedList))
				{
					int count2 = exposedList.Count;
					if (count2 != 0)
					{
						float num16 = num8 - num12;
						float num17 = num11 - num7;
						float num18 = num3 - num11;
						float num19 = num12 - num4;
						float num20 = 1f / (num16 * num18 + num17 * (num4 - num12));
						int num21 = count2 >> 1;
						float[] items2 = exposedList.Items;
						float[] items3 = exposedList2.Resize(num15 + num21 * 2).Items;
						float[] items4 = clippedUVs.Resize(num15 + num21 * 2).Items;
						int num22 = 0;
						while (num22 < count2)
						{
							float num23 = items2[num22];
							float num24 = items2[num22 + 1];
							items3[num15] = num23;
							items3[num15 + 1] = num24;
							float num25 = num23 - num11;
							float num26 = num24 - num12;
							float num27 = (num16 * num25 + num17 * num26) * num20;
							float num28 = (num19 * num25 + num18 * num26) * num20;
							float num29 = 1f - num27 - num28;
							items4[num15] = num5 * num27 + num9 * num28 + num13 * num29;
							items4[num15 + 1] = num6 * num27 + num10 * num28 + num14 * num29;
							num22 += 2;
							num15 += 2;
						}
						num15 = exposedList3.Count;
						int[] items5 = exposedList3.Resize(num15 + 3 * (num21 - 2)).Items;
						num21--;
						int num30 = 1;
						while (num30 < num21)
						{
							items5[num15] = num;
							items5[num15 + 1] = num + num30;
							items5[num15 + 2] = num + num30 + 1;
							num30++;
							num15 += 3;
						}
						num += num21 + 1;
					}
					continue;
				}
				float[] items6 = exposedList2.Resize(num15 + 6).Items;
				float[] items7 = clippedUVs.Resize(num15 + 6).Items;
				items6[num15] = num3;
				items6[num15 + 1] = num4;
				items6[num15 + 2] = num7;
				items6[num15 + 3] = num8;
				items6[num15 + 4] = num11;
				items6[num15 + 5] = num12;
				items7[num15] = num5;
				items7[num15 + 1] = num6;
				items7[num15 + 2] = num9;
				items7[num15 + 3] = num10;
				items7[num15 + 4] = num13;
				items7[num15 + 5] = num14;
				num15 = exposedList3.Count;
				int[] items8 = exposedList3.Resize(num15 + 3).Items;
				items8[num15] = num;
				items8[num15 + 1] = num + 1;
				items8[num15 + 2] = num + 2;
				num += 3;
				break;
			}
		}
	}

	internal bool Clip(float x1, float y1, float x2, float y2, float x3, float y3, ExposedList<float> clippingArea, ExposedList<float> output)
	{
		ExposedList<float> exposedList = output;
		bool result = false;
		ExposedList<float> exposedList2 = null;
		if (clippingArea.Count % 4 >= 2)
		{
			exposedList2 = output;
			output = scratch;
		}
		else
		{
			exposedList2 = scratch;
		}
		exposedList2.Clear();
		exposedList2.Add(x1);
		exposedList2.Add(y1);
		exposedList2.Add(x2);
		exposedList2.Add(y2);
		exposedList2.Add(x3);
		exposedList2.Add(y3);
		exposedList2.Add(x1);
		exposedList2.Add(y1);
		output.Clear();
		int num = clippingArea.Count - 4;
		float[] items = clippingArea.Items;
		int num2 = 0;
		while (true)
		{
			float num3 = items[num2];
			float num4 = items[num2 + 1];
			float num5 = num3 - items[num2 + 2];
			float num6 = num4 - items[num2 + 3];
			int count = output.Count;
			float[] items2 = exposedList2.Items;
			int num7 = 0;
			int num8 = exposedList2.Count - 2;
			while (num7 < num8)
			{
				float num9 = items2[num7];
				float num10 = items2[num7 + 1];
				num7 += 2;
				float num11 = items2[num7];
				float num12 = items2[num7 + 1];
				bool flag = num6 * (num3 - num11) > num5 * (num4 - num12);
				float num13 = num6 * (num3 - num9) - num5 * (num4 - num10);
				if (num13 > 0f)
				{
					if (flag)
					{
						output.Add(num11);
						output.Add(num12);
						continue;
					}
					float num14 = num11 - num9;
					float num15 = num12 - num10;
					float num16 = num13 / (num14 * num6 - num15 * num5);
					if (!(num16 >= 0f) || !(num16 <= 1f))
					{
						output.Add(num11);
						output.Add(num12);
						continue;
					}
					output.Add(num9 + num14 * num16);
					output.Add(num10 + num15 * num16);
				}
				else if (flag)
				{
					float num17 = num11 - num9;
					float num18 = num12 - num10;
					float num19 = num13 / (num17 * num6 - num18 * num5);
					if (!(num19 >= 0f) || !(num19 <= 1f))
					{
						output.Add(num11);
						output.Add(num12);
						continue;
					}
					output.Add(num9 + num17 * num19);
					output.Add(num10 + num18 * num19);
					output.Add(num11);
					output.Add(num12);
				}
				result = true;
			}
			if (count == output.Count)
			{
				exposedList.Clear();
				return true;
			}
			output.Add(output.Items[0]);
			output.Add(output.Items[1]);
			if (num2 == num)
			{
				break;
			}
			ExposedList<float> exposedList3 = output;
			output = exposedList2;
			output.Clear();
			exposedList2 = exposedList3;
			num2 += 2;
		}
		if (exposedList != output)
		{
			exposedList.Clear();
			int i = 0;
			for (int num20 = output.Count - 2; i < num20; i++)
			{
				exposedList.Add(output.Items[i]);
			}
		}
		else
		{
			exposedList.Resize(exposedList.Count - 2);
		}
		return result;
	}

	public static void MakeClockwise(ExposedList<float> polygon)
	{
		float[] items = polygon.Items;
		int count = polygon.Count;
		float num = items[count - 2] * items[1] - items[0] * items[count - 1];
		int i = 0;
		for (int num2 = count - 3; i < num2; i += 2)
		{
			float num3 = items[i];
			float num4 = items[i + 1];
			float num5 = items[i + 2];
			float num6 = items[i + 3];
			num += num3 * num6 - num5 * num4;
		}
		if (!(num < 0f))
		{
			int j = 0;
			int num7 = count - 2;
			for (int num8 = count >> 1; j < num8; j += 2)
			{
				float num9 = items[j];
				float num10 = items[j + 1];
				int num11 = num7 - j;
				items[j] = items[num11];
				items[j + 1] = items[num11 + 1];
				items[num11] = num9;
				items[num11 + 1] = num10;
			}
		}
	}
}

using System;

namespace Spine;

public class DeformTimeline : CurveTimeline, ISlotTimeline
{
	private readonly int slotIndex;

	private readonly VertexAttachment attachment;

	internal float[][] vertices;

	public int SlotIndex => slotIndex;

	public VertexAttachment Attachment => attachment;

	public float[][] Vertices => vertices;

	public DeformTimeline(int frameCount, int bezierCount, int slotIndex, VertexAttachment attachment)
		: base(frameCount, bezierCount, 12 + "|" + slotIndex + "|" + attachment.Id)
	{
		this.slotIndex = slotIndex;
		this.attachment = attachment;
		vertices = new float[frameCount][];
	}

	public void SetFrame(int frame, float time, float[] vertices)
	{
		frames[frame] = time;
		this.vertices[frame] = vertices;
	}

	public void setBezier(int bezier, int frame, int value, float time1, float value1, float cx1, float cy1, float cx2, float cy2, float time2, float value2)
	{
		float[] array = curves;
		int i = FrameCount + bezier * 18;
		if (value == 0)
		{
			array[frame] = 2 + i;
		}
		float num = (time1 - cx1 * 2f + cx2) * 0.03f;
		float num2 = cy2 * 0.03f - cy1 * 0.06f;
		float num3 = ((cx1 - cx2) * 3f - time1 + time2) * 0.006f;
		float num4 = (cy1 - cy2 + 1f / 3f) * 0.018f;
		float num5 = num * 2f + num3;
		float num6 = num2 * 2f + num4;
		float num7 = (cx1 - time1) * 0.3f + num + num3 * (1f / 6f);
		float num8 = cy1 * 0.3f + num2 + num4 * (1f / 6f);
		float num9 = time1 + num7;
		float num10 = num8;
		for (int num11 = i + 18; i < num11; i += 2)
		{
			array[i] = num9;
			array[i + 1] = num10;
			num7 += num5;
			num8 += num6;
			num5 += num3;
			num6 += num4;
			num9 += num7;
			num10 += num8;
		}
	}

	private float GetCurvePercent(float time, int frame)
	{
		float[] array = curves;
		int num = (int)array[frame];
		switch (num)
		{
		case 0:
		{
			float num8 = frames[frame];
			return (time - num8) / (frames[frame + FrameEntries] - num8);
		}
		case 1:
			return 0f;
		default:
		{
			num -= 2;
			if (array[num] > time)
			{
				float num2 = frames[frame];
				return array[num + 1] * (time - num2) / (array[num] - num2);
			}
			int num3 = num + 18;
			for (num += 2; num < num3; num += 2)
			{
				if (array[num] >= time)
				{
					float num4 = array[num - 2];
					float num5 = array[num - 1];
					return num5 + (time - num4) / (array[num] - num4) * (array[num + 1] - num5);
				}
			}
			float num6 = array[num3 - 2];
			float num7 = array[num3 - 1];
			return num7 + (1f - num7) * (time - num6) / (frames[frame + FrameEntries] - num6);
		}
		}
	}

	public override void Apply(Skeleton skeleton, float lastTime, float time, ExposedList<Event> firedEvents, float alpha, MixBlend blend, MixDirection direction)
	{
		Slot slot = skeleton.slots.Items[slotIndex];
		if (!slot.bone.active || !(slot.attachment is VertexAttachment vertexAttachment) || vertexAttachment.TimelineAttachment != attachment)
		{
			return;
		}
		ExposedList<float> deform = slot.deform;
		if (deform.Count == 0)
		{
			blend = MixBlend.Setup;
		}
		float[][] array = vertices;
		int num = array[0].Length;
		float[] array2 = frames;
		float[] items;
		if (time < array2[0])
		{
			switch (blend)
			{
			case MixBlend.Setup:
				deform.Clear();
				break;
			case MixBlend.First:
				if (alpha == 1f)
				{
					deform.Clear();
					break;
				}
				if (deform.Capacity < num)
				{
					deform.Capacity = num;
				}
				deform.Count = num;
				items = deform.Items;
				if (vertexAttachment.bones == null)
				{
					float[] array3 = vertexAttachment.vertices;
					for (int i = 0; i < num; i++)
					{
						items[i] += (array3[i] - items[i]) * alpha;
					}
				}
				else
				{
					alpha = 1f - alpha;
					for (int j = 0; j < num; j++)
					{
						items[j] *= alpha;
					}
				}
				break;
			}
			return;
		}
		if (deform.Capacity < num)
		{
			deform.Capacity = num;
		}
		deform.Count = num;
		items = deform.Items;
		if (time >= array2[array2.Length - 1])
		{
			float[] array4 = array[array2.Length - 1];
			if (alpha == 1f)
			{
				if (blend == MixBlend.Add)
				{
					if (vertexAttachment.bones == null)
					{
						float[] array5 = vertexAttachment.vertices;
						for (int k = 0; k < num; k++)
						{
							items[k] += array4[k] - array5[k];
						}
					}
					else
					{
						for (int l = 0; l < num; l++)
						{
							items[l] += array4[l];
						}
					}
				}
				else
				{
					Array.Copy(array4, 0, items, 0, num);
				}
				return;
			}
			switch (blend)
			{
			case MixBlend.Setup:
				if (vertexAttachment.bones == null)
				{
					float[] array7 = vertexAttachment.vertices;
					for (int num2 = 0; num2 < num; num2++)
					{
						float num3 = array7[num2];
						items[num2] = num3 + (array4[num2] - num3) * alpha;
					}
				}
				else
				{
					for (int num4 = 0; num4 < num; num4++)
					{
						items[num4] = array4[num4] * alpha;
					}
				}
				break;
			case MixBlend.First:
			case MixBlend.Replace:
			{
				for (int num5 = 0; num5 < num; num5++)
				{
					items[num5] += (array4[num5] - items[num5]) * alpha;
				}
				break;
			}
			case MixBlend.Add:
				if (vertexAttachment.bones == null)
				{
					float[] array6 = vertexAttachment.vertices;
					for (int m = 0; m < num; m++)
					{
						items[m] += (array4[m] - array6[m]) * alpha;
					}
				}
				else
				{
					for (int n = 0; n < num; n++)
					{
						items[n] += array4[n] * alpha;
					}
				}
				break;
			}
			return;
		}
		int num6 = Timeline.Search(array2, time);
		float curvePercent = GetCurvePercent(time, num6);
		float[] array8 = array[num6];
		float[] array9 = array[num6 + 1];
		if (alpha == 1f)
		{
			if (blend == MixBlend.Add)
			{
				if (vertexAttachment.bones == null)
				{
					float[] array10 = vertexAttachment.vertices;
					for (int num7 = 0; num7 < num; num7++)
					{
						float num8 = array8[num7];
						items[num7] += num8 + (array9[num7] - num8) * curvePercent - array10[num7];
					}
				}
				else
				{
					for (int num9 = 0; num9 < num; num9++)
					{
						float num10 = array8[num9];
						items[num9] += num10 + (array9[num9] - num10) * curvePercent;
					}
				}
			}
			else
			{
				for (int num11 = 0; num11 < num; num11++)
				{
					float num12 = array8[num11];
					items[num11] = num12 + (array9[num11] - num12) * curvePercent;
				}
			}
			return;
		}
		switch (blend)
		{
		case MixBlend.Setup:
			if (vertexAttachment.bones == null)
			{
				float[] array12 = vertexAttachment.vertices;
				for (int num17 = 0; num17 < num; num17++)
				{
					float num18 = array8[num17];
					float num19 = array12[num17];
					items[num17] = num19 + (num18 + (array9[num17] - num18) * curvePercent - num19) * alpha;
				}
			}
			else
			{
				for (int num20 = 0; num20 < num; num20++)
				{
					float num21 = array8[num20];
					items[num20] = (num21 + (array9[num20] - num21) * curvePercent) * alpha;
				}
			}
			break;
		case MixBlend.First:
		case MixBlend.Replace:
		{
			for (int num22 = 0; num22 < num; num22++)
			{
				float num23 = array8[num22];
				items[num22] += (num23 + (array9[num22] - num23) * curvePercent - items[num22]) * alpha;
			}
			break;
		}
		case MixBlend.Add:
			if (vertexAttachment.bones == null)
			{
				float[] array11 = vertexAttachment.vertices;
				for (int num13 = 0; num13 < num; num13++)
				{
					float num14 = array8[num13];
					items[num13] += (num14 + (array9[num13] - num14) * curvePercent - array11[num13]) * alpha;
				}
			}
			else
			{
				for (int num15 = 0; num15 < num; num15++)
				{
					float num16 = array8[num15];
					items[num15] += (num16 + (array9[num15] - num16) * curvePercent) * alpha;
				}
			}
			break;
		}
	}
}

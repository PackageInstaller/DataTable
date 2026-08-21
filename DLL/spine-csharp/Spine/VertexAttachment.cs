using System;

namespace Spine;

public abstract class VertexAttachment : Attachment
{
	private static int nextID = 0;

	private static readonly object nextIdLock = new object();

	internal readonly int id;

	internal VertexAttachment timelineAttachment;

	internal int[] bones;

	internal float[] vertices;

	internal int worldVerticesLength;

	public int Id => id;

	public int[] Bones
	{
		get
		{
			return bones;
		}
		set
		{
			bones = value;
		}
	}

	public float[] Vertices
	{
		get
		{
			return vertices;
		}
		set
		{
			vertices = value;
		}
	}

	public int WorldVerticesLength
	{
		get
		{
			return worldVerticesLength;
		}
		set
		{
			worldVerticesLength = value;
		}
	}

	public VertexAttachment TimelineAttachment
	{
		get
		{
			return timelineAttachment;
		}
		set
		{
			timelineAttachment = value;
		}
	}

	public VertexAttachment(string name)
		: base(name)
	{
		lock (nextIdLock)
		{
			id = nextID++;
		}
		timelineAttachment = this;
	}

	public VertexAttachment(VertexAttachment other)
		: base(other)
	{
		lock (nextIdLock)
		{
			id = nextID++;
		}
		timelineAttachment = other.timelineAttachment;
		if (other.bones != null)
		{
			bones = new int[other.bones.Length];
			Array.Copy(other.bones, 0, bones, 0, bones.Length);
		}
		else
		{
			bones = null;
		}
		if (other.vertices != null)
		{
			vertices = new float[other.vertices.Length];
			Array.Copy(other.vertices, 0, vertices, 0, vertices.Length);
		}
		else
		{
			vertices = null;
		}
		worldVerticesLength = other.worldVerticesLength;
	}

	public void ComputeWorldVertices(Slot slot, float[] worldVertices)
	{
		ComputeWorldVertices(slot, 0, worldVerticesLength, worldVertices, 0);
	}

	public virtual void ComputeWorldVertices(Slot slot, int start, int count, float[] worldVertices, int offset, int stride = 2)
	{
		count = offset + (count >> 1) * stride;
		ExposedList<float> deform = slot.deform;
		float[] items = vertices;
		int[] array = bones;
		if (array == null)
		{
			if (deform.Count > 0)
			{
				items = deform.Items;
			}
			Bone bone = slot.bone;
			float worldX = bone.worldX;
			float worldY = bone.worldY;
			float a = bone.a;
			float b = bone.b;
			float c = bone.c;
			float d = bone.d;
			int num = start;
			for (int i = offset; i < count; i += stride)
			{
				float num2 = items[num];
				float num3 = items[num + 1];
				worldVertices[i] = num2 * a + num3 * b + worldX;
				worldVertices[i + 1] = num2 * c + num3 * d + worldY;
				num += 2;
			}
			return;
		}
		int num4 = 0;
		int num5 = 0;
		for (int j = 0; j < start; j += 2)
		{
			int num6 = array[num4];
			num4 += num6 + 1;
			num5 += num6;
		}
		Bone[] items2 = slot.bone.skeleton.bones.Items;
		if (deform.Count == 0)
		{
			int k = offset;
			int num7 = num5 * 3;
			for (; k < count; k += stride)
			{
				float num8 = 0f;
				float num9 = 0f;
				int num10 = array[num4++];
				num10 += num4;
				while (num4 < num10)
				{
					Bone bone2 = items2[array[num4]];
					float num11 = items[num7];
					float num12 = items[num7 + 1];
					float num13 = items[num7 + 2];
					num8 += (num11 * bone2.a + num12 * bone2.b + bone2.worldX) * num13;
					num9 += (num11 * bone2.c + num12 * bone2.d + bone2.worldY) * num13;
					num4++;
					num7 += 3;
				}
				worldVertices[k] = num8;
				worldVertices[k + 1] = num9;
			}
			return;
		}
		float[] items3 = deform.Items;
		int l = offset;
		int num14 = num5 * 3;
		int num15 = num5 << 1;
		for (; l < count; l += stride)
		{
			float num16 = 0f;
			float num17 = 0f;
			int num18 = array[num4++];
			num18 += num4;
			while (num4 < num18)
			{
				Bone bone3 = items2[array[num4]];
				float num19 = items[num14] + items3[num15];
				float num20 = items[num14 + 1] + items3[num15 + 1];
				float num21 = items[num14 + 2];
				num16 += (num19 * bone3.a + num20 * bone3.b + bone3.worldX) * num21;
				num17 += (num19 * bone3.c + num20 * bone3.d + bone3.worldY) * num21;
				num4++;
				num14 += 3;
				num15 += 2;
			}
			worldVertices[l] = num16;
			worldVertices[l + 1] = num17;
		}
	}
}

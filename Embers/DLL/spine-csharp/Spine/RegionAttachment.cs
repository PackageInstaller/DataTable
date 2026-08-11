using System;

namespace Spine;

public class RegionAttachment : Attachment, IHasTextureRegion
{
	public const int BLX = 0;

	public const int BLY = 1;

	public const int ULX = 2;

	public const int ULY = 3;

	public const int URX = 4;

	public const int URY = 5;

	public const int BRX = 6;

	public const int BRY = 7;

	internal TextureRegion region;

	internal float x;

	internal float y;

	internal float rotation;

	internal float scaleX = 1f;

	internal float scaleY = 1f;

	internal float width;

	internal float height;

	internal float[] offset = new float[8];

	internal float[] uvs = new float[8];

	internal float r = 1f;

	internal float g = 1f;

	internal float b = 1f;

	internal float a = 1f;

	internal Sequence sequence;

	public float X
	{
		get
		{
			return x;
		}
		set
		{
			x = value;
		}
	}

	public float Y
	{
		get
		{
			return y;
		}
		set
		{
			y = value;
		}
	}

	public float Rotation
	{
		get
		{
			return rotation;
		}
		set
		{
			rotation = value;
		}
	}

	public float ScaleX
	{
		get
		{
			return scaleX;
		}
		set
		{
			scaleX = value;
		}
	}

	public float ScaleY
	{
		get
		{
			return scaleY;
		}
		set
		{
			scaleY = value;
		}
	}

	public float Width
	{
		get
		{
			return width;
		}
		set
		{
			width = value;
		}
	}

	public float Height
	{
		get
		{
			return height;
		}
		set
		{
			height = value;
		}
	}

	public float R
	{
		get
		{
			return r;
		}
		set
		{
			r = value;
		}
	}

	public float G
	{
		get
		{
			return g;
		}
		set
		{
			g = value;
		}
	}

	public float B
	{
		get
		{
			return b;
		}
		set
		{
			b = value;
		}
	}

	public float A
	{
		get
		{
			return a;
		}
		set
		{
			a = value;
		}
	}

	public string Path { get; set; }

	public TextureRegion Region
	{
		get
		{
			return region;
		}
		set
		{
			region = value;
		}
	}

	public float[] Offset => offset;

	public float[] UVs => uvs;

	public Sequence Sequence
	{
		get
		{
			return sequence;
		}
		set
		{
			sequence = value;
		}
	}

	public RegionAttachment(string name)
		: base(name)
	{
	}

	public RegionAttachment(RegionAttachment other)
		: base(other)
	{
		region = other.region;
		Path = other.Path;
		x = other.x;
		y = other.y;
		scaleX = other.scaleX;
		scaleY = other.scaleY;
		rotation = other.rotation;
		width = other.width;
		height = other.height;
		Array.Copy(other.uvs, 0, uvs, 0, 8);
		Array.Copy(other.offset, 0, offset, 0, 8);
		r = other.r;
		g = other.g;
		b = other.b;
		a = other.a;
		sequence = ((other.sequence == null) ? null : new Sequence(other.sequence));
	}

	public void UpdateRegion()
	{
		float[] array = uvs;
		if (region == null)
		{
			array[0] = 0f;
			array[1] = 0f;
			array[2] = 0f;
			array[3] = 1f;
			array[4] = 1f;
			array[5] = 1f;
			array[6] = 1f;
			array[7] = 0f;
			return;
		}
		float num = Width;
		float num2 = Height;
		float num3 = num / 2f;
		float num4 = num2 / 2f;
		float num5 = 0f - num3;
		float num6 = 0f - num4;
		bool flag = false;
		if (region is AtlasRegion)
		{
			AtlasRegion atlasRegion = (AtlasRegion)region;
			num5 += atlasRegion.offsetX / (float)atlasRegion.originalWidth * num;
			num6 += atlasRegion.offsetY / (float)atlasRegion.originalHeight * num2;
			if (atlasRegion.degrees == 90)
			{
				flag = true;
				num3 -= ((float)atlasRegion.originalWidth - atlasRegion.offsetX - (float)atlasRegion.packedHeight) / (float)atlasRegion.originalWidth * num;
				num4 -= ((float)atlasRegion.originalHeight - atlasRegion.offsetY - (float)atlasRegion.packedWidth) / (float)atlasRegion.originalHeight * num2;
			}
			else
			{
				num3 -= ((float)atlasRegion.originalWidth - atlasRegion.offsetX - (float)atlasRegion.packedWidth) / (float)atlasRegion.originalWidth * num;
				num4 -= ((float)atlasRegion.originalHeight - atlasRegion.offsetY - (float)atlasRegion.packedHeight) / (float)atlasRegion.originalHeight * num2;
			}
		}
		float num7 = ScaleX;
		float num8 = ScaleY;
		num5 *= num7;
		num6 *= num8;
		num3 *= num7;
		num4 *= num8;
		float num9 = Rotation * (MathF.PI / 180f);
		float num10 = (float)Math.Cos(num9);
		float num11 = (float)Math.Sin(num9);
		float num12 = X;
		float num13 = Y;
		float num14 = num5 * num10 + num12;
		float num15 = num5 * num11;
		float num16 = num6 * num10 + num13;
		float num17 = num6 * num11;
		float num18 = num3 * num10 + num12;
		float num19 = num3 * num11;
		float num20 = num4 * num10 + num13;
		float num21 = num4 * num11;
		float[] array2 = offset;
		array2[0] = num14 - num17;
		array2[1] = num16 + num15;
		array2[2] = num14 - num21;
		array2[3] = num20 + num15;
		array2[4] = num18 - num21;
		array2[5] = num20 + num19;
		array2[6] = num18 - num17;
		array2[7] = num16 + num19;
		if (flag)
		{
			array[0] = region.u2;
			array[1] = region.v;
			array[2] = region.u2;
			array[3] = region.v2;
			array[4] = region.u;
			array[5] = region.v2;
			array[6] = region.u;
			array[7] = region.v;
		}
		else
		{
			array[0] = region.u2;
			array[1] = region.v2;
			array[2] = region.u;
			array[3] = region.v2;
			array[4] = region.u;
			array[5] = region.v;
			array[6] = region.u2;
			array[7] = region.v;
		}
	}

	public void ComputeWorldVertices(Slot slot, float[] worldVertices, int offset, int stride = 2)
	{
		if (sequence != null)
		{
			sequence.Apply(slot, this);
		}
		float[] array = this.offset;
		Bone bone = slot.Bone;
		float worldX = bone.worldX;
		float worldY = bone.worldY;
		float num = bone.a;
		float num2 = bone.b;
		float c = bone.c;
		float d = bone.d;
		float num3 = array[6];
		float num4 = array[7];
		worldVertices[offset] = num3 * num + num4 * num2 + worldX;
		worldVertices[offset + 1] = num3 * c + num4 * d + worldY;
		offset += stride;
		num3 = array[0];
		num4 = array[1];
		worldVertices[offset] = num3 * num + num4 * num2 + worldX;
		worldVertices[offset + 1] = num3 * c + num4 * d + worldY;
		offset += stride;
		num3 = array[2];
		num4 = array[3];
		worldVertices[offset] = num3 * num + num4 * num2 + worldX;
		worldVertices[offset + 1] = num3 * c + num4 * d + worldY;
		offset += stride;
		num3 = array[4];
		num4 = array[5];
		worldVertices[offset] = num3 * num + num4 * num2 + worldX;
		worldVertices[offset + 1] = num3 * c + num4 * d + worldY;
	}

	public override Attachment Copy()
	{
		return new RegionAttachment(this);
	}
}

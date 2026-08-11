using System;

namespace Spine;

public class MeshAttachment : VertexAttachment, IHasTextureRegion
{
	internal TextureRegion region;

	internal string path;

	internal float[] regionUVs;

	internal float[] uvs;

	internal int[] triangles;

	internal float r = 1f;

	internal float g = 1f;

	internal float b = 1f;

	internal float a = 1f;

	internal int hullLength;

	private MeshAttachment parentMesh;

	private Sequence sequence;

	public TextureRegion Region
	{
		get
		{
			return region;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("region", "region cannot be null.");
			}
			region = value;
		}
	}

	public int HullLength
	{
		get
		{
			return hullLength;
		}
		set
		{
			hullLength = value;
		}
	}

	public float[] RegionUVs
	{
		get
		{
			return regionUVs;
		}
		set
		{
			regionUVs = value;
		}
	}

	public float[] UVs
	{
		get
		{
			return uvs;
		}
		set
		{
			uvs = value;
		}
	}

	public int[] Triangles
	{
		get
		{
			return triangles;
		}
		set
		{
			triangles = value;
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

	public string Path
	{
		get
		{
			return path;
		}
		set
		{
			path = value;
		}
	}

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

	public MeshAttachment ParentMesh
	{
		get
		{
			return parentMesh;
		}
		set
		{
			parentMesh = value;
			if (value != null)
			{
				bones = value.bones;
				vertices = value.vertices;
				worldVerticesLength = value.worldVerticesLength;
				regionUVs = value.regionUVs;
				triangles = value.triangles;
				HullLength = value.HullLength;
				Edges = value.Edges;
				Width = value.Width;
				Height = value.Height;
			}
		}
	}

	public int[] Edges { get; set; }

	public float Width { get; set; }

	public float Height { get; set; }

	public MeshAttachment(string name)
		: base(name)
	{
	}

	protected MeshAttachment(MeshAttachment other)
		: base(other)
	{
		if (parentMesh != null)
		{
			throw new ArgumentException("Use newLinkedMesh to copy a linked mesh.");
		}
		region = other.region;
		path = other.path;
		r = other.r;
		g = other.g;
		b = other.b;
		a = other.a;
		regionUVs = new float[other.regionUVs.Length];
		Array.Copy(other.regionUVs, 0, regionUVs, 0, regionUVs.Length);
		uvs = new float[other.uvs.Length];
		Array.Copy(other.uvs, 0, uvs, 0, uvs.Length);
		triangles = new int[other.triangles.Length];
		Array.Copy(other.triangles, 0, triangles, 0, triangles.Length);
		hullLength = other.hullLength;
		sequence = ((other.sequence == null) ? null : new Sequence(other.sequence));
		if (other.Edges != null)
		{
			Edges = new int[other.Edges.Length];
			Array.Copy(other.Edges, 0, Edges, 0, Edges.Length);
		}
		Width = other.Width;
		Height = other.Height;
	}

	public void UpdateRegion()
	{
		float[] array = regionUVs;
		if (uvs == null || uvs.Length != array.Length)
		{
			uvs = new float[array.Length];
		}
		float[] array2 = uvs;
		int num = array2.Length;
		float u;
		float v;
		float num4;
		float num5;
		if (region is AtlasRegion)
		{
			u = region.u;
			v = region.v;
			AtlasRegion atlasRegion = (AtlasRegion)region;
			float num2 = (float)region.width / (atlasRegion.u2 - atlasRegion.u);
			float num3 = (float)region.height / (atlasRegion.v2 - atlasRegion.v);
			switch (atlasRegion.degrees)
			{
			case 90:
			{
				u -= ((float)atlasRegion.originalHeight - atlasRegion.offsetY - (float)atlasRegion.packedWidth) / num2;
				v -= ((float)atlasRegion.originalWidth - atlasRegion.offsetX - (float)atlasRegion.packedHeight) / num3;
				num4 = (float)atlasRegion.originalHeight / num2;
				num5 = (float)atlasRegion.originalWidth / num3;
				for (int j = 0; j < num; j += 2)
				{
					array2[j] = u + array[j + 1] * num4;
					array2[j + 1] = v + (1f - array[j]) * num5;
				}
				return;
			}
			case 180:
			{
				u -= ((float)atlasRegion.originalWidth - atlasRegion.offsetX - (float)atlasRegion.packedWidth) / num2;
				v -= atlasRegion.offsetY / num3;
				num4 = (float)atlasRegion.originalWidth / num2;
				num5 = (float)atlasRegion.originalHeight / num3;
				for (int k = 0; k < num; k += 2)
				{
					array2[k] = u + (1f - array[k]) * num4;
					array2[k + 1] = v + (1f - array[k + 1]) * num5;
				}
				return;
			}
			case 270:
			{
				u -= atlasRegion.offsetY / num2;
				v -= atlasRegion.offsetX / num3;
				num4 = (float)atlasRegion.originalHeight / num2;
				num5 = (float)atlasRegion.originalWidth / num3;
				for (int i = 0; i < num; i += 2)
				{
					array2[i] = u + (1f - array[i + 1]) * num4;
					array2[i + 1] = v + array[i] * num5;
				}
				return;
			}
			}
			u -= atlasRegion.offsetX / num2;
			v -= ((float)atlasRegion.originalHeight - atlasRegion.offsetY - (float)atlasRegion.packedHeight) / num3;
			num4 = (float)atlasRegion.originalWidth / num2;
			num5 = (float)atlasRegion.originalHeight / num3;
		}
		else if (region == null)
		{
			u = (v = 0f);
			num4 = (num5 = 1f);
		}
		else
		{
			u = region.u;
			v = region.v;
			num4 = region.u2 - u;
			num5 = region.v2 - v;
		}
		for (int l = 0; l < num; l += 2)
		{
			array2[l] = u + array[l] * num4;
			array2[l + 1] = v + array[l + 1] * num5;
		}
	}

	public override void ComputeWorldVertices(Slot slot, int start, int count, float[] worldVertices, int offset, int stride = 2)
	{
		if (sequence != null)
		{
			sequence.Apply(slot, this);
		}
		base.ComputeWorldVertices(slot, start, count, worldVertices, offset, stride);
	}

	public MeshAttachment NewLinkedMesh()
	{
		MeshAttachment meshAttachment = new MeshAttachment(base.Name);
		meshAttachment.timelineAttachment = timelineAttachment;
		meshAttachment.region = region;
		meshAttachment.path = path;
		meshAttachment.r = r;
		meshAttachment.g = g;
		meshAttachment.b = b;
		meshAttachment.a = a;
		meshAttachment.ParentMesh = ((parentMesh != null) ? parentMesh : this);
		if (meshAttachment.Region != null)
		{
			meshAttachment.UpdateRegion();
		}
		return meshAttachment;
	}

	public override Attachment Copy()
	{
		if (parentMesh == null)
		{
			return new MeshAttachment(this);
		}
		return NewLinkedMesh();
	}
}

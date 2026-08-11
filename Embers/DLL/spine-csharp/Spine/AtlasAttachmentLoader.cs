using System;

namespace Spine;

public class AtlasAttachmentLoader : AttachmentLoader
{
	private Atlas[] atlasArray;

	public AtlasAttachmentLoader(params Atlas[] atlasArray)
	{
		if (atlasArray == null)
		{
			throw new ArgumentNullException("atlas", "atlas array cannot be null.");
		}
		this.atlasArray = atlasArray;
	}

	private void LoadSequence(string name, string basePath, Sequence sequence)
	{
		TextureRegion[] regions = sequence.Regions;
		int i = 0;
		for (int num = regions.Length; i < num; i++)
		{
			string path = sequence.GetPath(basePath, i);
			regions[i] = FindRegion(path);
			if (regions[i] == null)
			{
				throw new ArgumentException($"Region not found in atlas: {path} (region attachment: {name})");
			}
		}
	}

	public RegionAttachment NewRegionAttachment(Skin skin, string name, string path, Sequence sequence)
	{
		RegionAttachment regionAttachment = new RegionAttachment(name);
		if (sequence != null)
		{
			LoadSequence(name, path, sequence);
		}
		else
		{
			AtlasRegion atlasRegion = FindRegion(path);
			if (atlasRegion == null)
			{
				throw new ArgumentException($"Region not found in atlas: {path} (region attachment: {name})");
			}
			regionAttachment.Region = atlasRegion;
		}
		return regionAttachment;
	}

	public MeshAttachment NewMeshAttachment(Skin skin, string name, string path, Sequence sequence)
	{
		MeshAttachment meshAttachment = new MeshAttachment(name);
		if (sequence != null)
		{
			LoadSequence(name, path, sequence);
		}
		else
		{
			AtlasRegion atlasRegion = FindRegion(path);
			if (atlasRegion == null)
			{
				throw new ArgumentException($"Region not found in atlas: {path} (region attachment: {name})");
			}
			meshAttachment.Region = atlasRegion;
		}
		return meshAttachment;
	}

	public BoundingBoxAttachment NewBoundingBoxAttachment(Skin skin, string name)
	{
		return new BoundingBoxAttachment(name);
	}

	public PathAttachment NewPathAttachment(Skin skin, string name)
	{
		return new PathAttachment(name);
	}

	public PointAttachment NewPointAttachment(Skin skin, string name)
	{
		return new PointAttachment(name);
	}

	public ClippingAttachment NewClippingAttachment(Skin skin, string name)
	{
		return new ClippingAttachment(name);
	}

	public AtlasRegion FindRegion(string name)
	{
		for (int i = 0; i < atlasArray.Length; i++)
		{
			AtlasRegion atlasRegion = atlasArray[i].FindRegion(name);
			if (atlasRegion != null)
			{
				return atlasRegion;
			}
		}
		return null;
	}
}

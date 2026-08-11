using System;

namespace Spine;

public abstract class SkeletonLoader
{
	protected readonly AttachmentLoader attachmentLoader;

	protected float scale = 1f;

	public float Scale
	{
		get
		{
			return scale;
		}
		set
		{
			if (scale == 0f)
			{
				throw new ArgumentNullException("scale", "scale cannot be 0.");
			}
			scale = value;
		}
	}

	public SkeletonLoader(params Atlas[] atlasArray)
	{
		attachmentLoader = new AtlasAttachmentLoader(atlasArray);
	}

	public SkeletonLoader(AttachmentLoader attachmentLoader)
	{
		if (attachmentLoader == null)
		{
			throw new ArgumentNullException("attachmentLoader", "attachmentLoader cannot be null.");
		}
		this.attachmentLoader = attachmentLoader;
	}

	public abstract SkeletonData ReadSkeletonData(string path);
}

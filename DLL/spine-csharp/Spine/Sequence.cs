using System;
using System.Text;

namespace Spine;

public class Sequence
{
	private static int nextID = 0;

	private static readonly object nextIdLock = new object();

	internal readonly int id;

	internal readonly TextureRegion[] regions;

	internal int start;

	internal int digits;

	internal int setupIndex;

	public int Start
	{
		get
		{
			return start;
		}
		set
		{
			start = value;
		}
	}

	public int Digits
	{
		get
		{
			return digits;
		}
		set
		{
			digits = value;
		}
	}

	public int SetupIndex
	{
		get
		{
			return setupIndex;
		}
		set
		{
			setupIndex = value;
		}
	}

	public TextureRegion[] Regions => regions;

	public int Id => id;

	public Sequence(int count)
	{
		lock (nextIdLock)
		{
			id = nextID++;
		}
		regions = new TextureRegion[count];
	}

	public Sequence(Sequence other)
	{
		lock (nextIdLock)
		{
			id = nextID++;
		}
		regions = new TextureRegion[other.regions.Length];
		Array.Copy(other.regions, 0, regions, 0, regions.Length);
		start = other.start;
		digits = other.digits;
		setupIndex = other.setupIndex;
	}

	public void Apply(Slot slot, IHasTextureRegion attachment)
	{
		int num = slot.SequenceIndex;
		if (num == -1)
		{
			num = setupIndex;
		}
		if (num >= regions.Length)
		{
			num = regions.Length - 1;
		}
		TextureRegion textureRegion = regions[num];
		if (attachment.Region != textureRegion)
		{
			attachment.Region = textureRegion;
			attachment.UpdateRegion();
		}
	}

	public string GetPath(string basePath, int index)
	{
		StringBuilder stringBuilder = new StringBuilder(basePath.Length + digits);
		stringBuilder.Append(basePath);
		string text = (start + index).ToString();
		for (int num = digits - text.Length; num > 0; num--)
		{
			stringBuilder.Append('0');
		}
		stringBuilder.Append(text);
		return stringBuilder.ToString();
	}
}

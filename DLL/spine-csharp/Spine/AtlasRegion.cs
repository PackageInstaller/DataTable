namespace Spine;

public class AtlasRegion : TextureRegion
{
	public AtlasPage page;

	public string name;

	public int x;

	public int y;

	public float offsetX;

	public float offsetY;

	public int originalWidth;

	public int originalHeight;

	public int degrees;

	public bool rotate;

	public int index;

	public string[] names;

	public int[][] values;

	public int packedWidth
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

	public int packedHeight
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

	public override int OriginalWidth => originalWidth;

	public override int OriginalHeight => originalHeight;

	public AtlasRegion Clone()
	{
		return MemberwiseClone() as AtlasRegion;
	}
}

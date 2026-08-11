namespace Ase;

public class TaotieEatHeadItemData : OptionBase
{
	private bool hasHero;

	private float zHeadRotateAngle;

	private float zRootRotateAngle;

	private string iconName;

	public float ZHeadRotateAngle
	{
		get
		{
			return zHeadRotateAngle;
		}
		set
		{
			Set(ref zHeadRotateAngle, value, "ZHeadRotateAngle");
		}
	}

	public float ZRootRotateAngle
	{
		get
		{
			return zRootRotateAngle;
		}
		set
		{
			Set(ref zRootRotateAngle, value, "ZRootRotateAngle");
		}
	}

	public bool HasHero
	{
		get
		{
			return hasHero;
		}
		set
		{
			Set(ref hasHero, value, "HasHero");
		}
	}

	public string IconName
	{
		get
		{
			return iconName;
		}
		set
		{
			Set(ref iconName, value, "IconName");
		}
	}

	public TaotieEatHeadItemData(OptionBase parent)
	{
		base.parent = parent;
	}
}

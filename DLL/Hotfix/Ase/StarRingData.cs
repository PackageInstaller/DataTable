using GameFramework.Runtime;

namespace Ase;

public class StarRingData : ViewModelBase
{
	private DRHeroStarRing config;

	private int id;

	private int heroId;

	private int layer;

	private int starRingType;

	public DRHeroStarRing Config => config;

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
		}
	}

	public int HeroId
	{
		get
		{
			return heroId;
		}
		private set
		{
			Set(ref heroId, value, "HeroId");
		}
	}

	public int Layer
	{
		get
		{
			return layer;
		}
		private set
		{
			Set(ref layer, value, "Layer");
		}
	}

	public int StarRingType
	{
		get
		{
			return starRingType;
		}
		private set
		{
			Set(ref starRingType, value, "StarRingType");
		}
	}

	public static StarRingData Create(DRHeroStarRing starRing)
	{
		return new StarRingData
		{
			config = starRing,
			id = starRing.Id,
			heroId = starRing.HeroId,
			layer = starRing.Layer,
			starRingType = starRing.StarRingType
		};
	}
}

using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.Globalization;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
public class RegionInfo
{
	private static RegionInfo currentRegion;

	private int regionId;

	private string iso2Name;

	private string iso3Name;

	private string win3Name;

	private string englishName;

	private string nativeName;

	private string currencySymbol;

	private string isoCurrencySymbol;

	private string currencyEnglishName;

	private string currencyNativeName;

	public static RegionInfo CurrentRegion
	{
		get
		{
			RegionInfo regionInfo = currentRegion;
			if (regionInfo == null)
			{
				CultureInfo currentCulture = CultureInfo.CurrentCulture;
				if (currentCulture != null)
				{
					regionInfo = new RegionInfo(currentCulture);
				}
				if (Interlocked.CompareExchange(ref currentRegion, regionInfo, null) != null)
				{
					regionInfo = currentRegion;
				}
			}
			return regionInfo;
		}
	}

	[ComVisible(false)]
	public virtual string CurrencyEnglishName => currencyEnglishName;

	public virtual string CurrencySymbol => currencySymbol;

	[MonoTODO("DisplayName currently only returns the EnglishName")]
	public virtual string DisplayName => englishName;

	public virtual string EnglishName => englishName;

	[ComVisible(false)]
	public virtual int GeoId => regionId;

	public virtual bool IsMetric
	{
		get
		{
			string text = iso2Name;
			if (text == "US" || text == "UK")
			{
				return false;
			}
			return true;
		}
	}

	public virtual string ISOCurrencySymbol => isoCurrencySymbol;

	[ComVisible(false)]
	public virtual string NativeName => nativeName;

	[ComVisible(false)]
	public virtual string CurrencyNativeName => currencyNativeName;

	public virtual string Name => iso2Name;

	public virtual string ThreeLetterISORegionName => iso3Name;

	public virtual string ThreeLetterWindowsRegionName => win3Name;

	public virtual string TwoLetterISORegionName => iso2Name;

	public RegionInfo(int culture)
	{
		if (!GetByTerritory(CultureInfo.GetCultureInfo(culture)))
		{
			throw new ArgumentException(string.Format("Region ID {0} (0x{0:X4}) is not a supported region.", culture), "culture");
		}
	}

	public RegionInfo(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException();
		}
		if (construct_internal_region_from_name(name.ToUpperInvariant()) || GetByTerritory(CultureInfo.GetCultureInfo(name)))
		{
			return;
		}
		throw new ArgumentException($"Region name {name} is not supported.", "name");
	}

	private RegionInfo(CultureInfo ci)
	{
		if (ci.LCID == 127)
		{
			regionId = 244;
			iso2Name = "IV";
			iso3Name = "ivc";
			win3Name = "IVC";
			nativeName = (englishName = "Invariant Country");
			currencySymbol = "¤";
			isoCurrencySymbol = "XDR";
			currencyEnglishName = (currencyNativeName = "International Monetary Fund");
		}
		else
		{
			if (ci.Territory == null)
			{
				throw new NotImplementedException("Neutral region info");
			}
			construct_internal_region_from_name(ci.Territory.ToUpperInvariant());
		}
	}

	private bool GetByTerritory(CultureInfo ci)
	{
		if (ci == null)
		{
			throw new Exception("INTERNAL ERROR: should not happen.");
		}
		if (ci.IsNeutralCulture || ci.Territory == null)
		{
			return false;
		}
		return construct_internal_region_from_name(ci.Territory.ToUpperInvariant());
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool construct_internal_region_from_name(string name);

	public override bool Equals(object value)
	{
		if (value is RegionInfo regionInfo)
		{
			return Name == regionInfo.Name;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return Name.GetHashCode();
	}

	public override string ToString()
	{
		return Name;
	}

	internal static void ClearCachedData()
	{
		currentRegion = null;
	}
}

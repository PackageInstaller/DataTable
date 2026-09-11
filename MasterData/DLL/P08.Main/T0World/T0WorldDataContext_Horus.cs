using UnityEngine;

namespace T0World;

public class T0WorldDataContext_Horus : T0WorldDataBaseContext
{
	private const string BathSelectTag = "T0HorusBathSelect";

	private HorusBathCharacterEnum _bathSelect = HorusBathCharacterEnum.RANDOM;

	public HorusCookSelectEnum cookSelectType = HorusCookSelectEnum.NONE;

	public HorusBathCharacterEnum bathSelect
	{
		get
		{
			return _bathSelect;
		}
		set
		{
			_bathSelect = value;
			PlayerPrefs.SetInt("T0HorusBathSelect", (int)value);
		}
	}

	public override void Init()
	{
		base.Init();
		InitData();
	}

	private void InitData()
	{
		if (PlayerPrefs.HasKey("T0HorusBathSelect"))
		{
			_bathSelect = (HorusBathCharacterEnum)PlayerPrefs.GetInt("T0HorusBathSelect");
		}
	}
}

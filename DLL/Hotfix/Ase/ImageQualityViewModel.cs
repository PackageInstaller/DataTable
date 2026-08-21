using UnityEngine;

namespace Ase;

public class ImageQualityViewModel : OptionBase
{
	private int curGraphicLevel;

	private int recommendLevel;

	public int CurGraphicLevel
	{
		get
		{
			return curGraphicLevel;
		}
		set
		{
			Set(ref curGraphicLevel, value, "CurGraphicLevel");
		}
	}

	public int RecommendLevel
	{
		get
		{
			return recommendLevel;
		}
		set
		{
			Set(ref recommendLevel, value, "RecommendLevel");
		}
	}

	public ImageQualityViewModel()
	{
		PlayerPrefs.SetInt("SelectImageQuality", 1);
		curGraphicLevel = Singleton<GraphicsSetting>.Instance.GetCurQuality();
		recommendLevel = curGraphicLevel;
	}

	public void SetGraphicLevel(int graphicLevel)
	{
		CurGraphicLevel = graphicLevel;
	}

	public void ClickConfirm()
	{
		Singleton<GraphicsSetting>.Instance.SelectQuality(curGraphicLevel);
		Close();
	}
}

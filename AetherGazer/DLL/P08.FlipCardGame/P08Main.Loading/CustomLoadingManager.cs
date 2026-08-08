using System.Collections.Generic;
using LuaInterface;

namespace P08Main.Loading;

public class CustomLoadingManager
{
	private static CustomLoadingManager _inst;

	private Dictionary<LoadingImpl, CustomLoadingBase> loadingMap;

	public static CustomLoadingManager inst
	{
		get
		{
			if (_inst == null)
			{
				_inst = new CustomLoadingManager();
			}
			return _inst;
		}
	}

	private CustomLoadingManager()
	{
		loadingMap = new Dictionary<LoadingImpl, CustomLoadingBase>();
	}

	[NoToLua]
	public void SetUIProgress(LoadingImpl impl, float value)
	{
		if (loadingMap.TryGetValue(impl, out var value2))
		{
			value2?.SetUIProgress(value);
		}
	}

	[NoToLua]
	public void ShowLoadUI(LoadingImpl impl)
	{
		if (loadingMap.TryGetValue(impl, out var value) && value == null)
		{
			loadingMap.Remove(impl);
		}
		if (value == null)
		{
			value = GetNewLoadingUI(impl);
			loadingMap.Add(impl, value);
		}
		value.ShowLoadUI();
	}

	public void ShowLoadUI(int type)
	{
		ShowLoadUI((LoadingImpl)type);
	}

	[NoToLua]
	private CustomLoadingBase GetNewLoadingUI(LoadingImpl impl)
	{
		switch (impl)
		{
		case LoadingImpl.BilliardGame_Day:
		{
			BilliardGameLoadingDay billiardGameLoadingDay = new BilliardGameLoadingDay();
			billiardGameLoadingDay.InitLoading();
			return billiardGameLoadingDay;
		}
		case LoadingImpl.BilliardGame_Night:
		{
			BilliardGameLoadingNight billiardGameLoadingNight = new BilliardGameLoadingNight();
			billiardGameLoadingNight.InitLoading();
			return billiardGameLoadingNight;
		}
		case LoadingImpl.BilliardGame_Loading:
		{
			BilliardGameLoading_Common billiardGameLoading_Common = new BilliardGameLoading_Common();
			billiardGameLoading_Common.InitLoading();
			return billiardGameLoading_Common;
		}
		case LoadingImpl.AshGame_Loading:
		{
			AshGameLoading_Common ashGameLoading_Common = new AshGameLoading_Common();
			ashGameLoading_Common.InitLoading();
			return ashGameLoading_Common;
		}
		case LoadingImpl.SkuldT0_Loading:
		{
			SkuldT0GameLoading skuldT0GameLoading = new SkuldT0GameLoading();
			skuldT0GameLoading.InitLoading();
			return skuldT0GameLoading;
		}
		case LoadingImpl.Oath_Loading:
		{
			OathGameLoading oathGameLoading = new OathGameLoading();
			oathGameLoading.InitLoading();
			return oathGameLoading;
		}
		case LoadingImpl.HorusT0_Loading:
		{
			HorusT0GameLoading horusT0GameLoading = new HorusT0GameLoading();
			horusT0GameLoading.InitLoading();
			return horusT0GameLoading;
		}
		default:
			return null;
		}
	}

	[NoToLua]
	public void CloseLoadUI(LoadingImpl impl)
	{
		if (loadingMap.TryGetValue(impl, out var value))
		{
			value?.CloseLoadUI();
		}
	}

	public void CloseLoadUI(int type)
	{
		CloseLoadUI((LoadingImpl)type);
	}
}

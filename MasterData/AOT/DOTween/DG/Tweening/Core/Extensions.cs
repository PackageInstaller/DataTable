using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Core;

public static class Extensions
{
	public static T SetSpecialStartupMode<T>(this T t, SpecialStartupMode mode) where T : Tween
	{
		t.specialStartupMode = mode;
		return t;
	}

	public static TweenerCore<T1, T2, TPlugOptions> Blendable<T1, T2, TPlugOptions>(this TweenerCore<T1, T2, TPlugOptions> t) where TPlugOptions : struct, IPlugOptions
	{
		t.isBlendable = true;
		return t;
	}

	public static TweenerCore<T1, T2, TPlugOptions> NoFrom<T1, T2, TPlugOptions>(this TweenerCore<T1, T2, TPlugOptions> t) where TPlugOptions : struct, IPlugOptions
	{
		t.isFromAllowed = false;
		return t;
	}
}

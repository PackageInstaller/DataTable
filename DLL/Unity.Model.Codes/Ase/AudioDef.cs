using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public static class AudioDef
{
	public static readonly List<string> baseBankAssets = new List<string> { "Master", "Master.strings" };

	public static readonly LanguageFix DefaultFix = new LanguageFix
	{
		prefix = "DefaultLanguage/",
		suffix = ""
	};

	public static readonly string EventPathPrefix = "event:/Voice/";

	public static readonly string BGMFadeParamVolume = "Volume reduce";

	public static readonly string BGMFadeParamAmbience = "Ambience";

	public static readonly int GLOBAL_SNAPSHOTGROUP_ID = 0;

	public static Vector2 DefaultFadeInParams = new Vector2(0f, 10f);

	public static Vector2 DefaultFadeOutParams = new Vector2(1f, 10f);

	public static readonly float DefaultWaitTime = 2f;

	public const float DefaultFadeTime = 3f;
}

using System;
using System.Runtime.CompilerServices;
using ACT.Utility;

namespace ACT.Drama;

public class ConversationSettings
{
	private static readonly string AutoPlayKey = GetKey("AutoPlayKey");

	public static bool AutoPlay
	{
		get
		{
			return ServerPlayerPrefs.GetBool(AutoPlayKey);
		}
		set
		{
			if (AutoPlay != value)
			{
				OnAutoPlayChanged?.Invoke(value);
				ServerPlayerPrefs.SetBool(AutoPlayKey, value);
				ServerPlayerPrefs.Save();
			}
		}
	}

	public static event Action<bool> OnAutoPlayChanged;

	private static string GetKey([CallerMemberName] string memberName = null)
	{
		return "ConversationManager." + memberName;
	}
}

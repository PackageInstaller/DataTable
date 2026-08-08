public static class SummerRaceCombatAudioCueRouter
{
	private const string SummerRace52Sheet = "minigame_activity_5_2";

	private const string SummerRace51Sheet = "minigame_activity_5_1";

	public static readonly SummerRaceAudioCue VehicleCollisionCue = new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_collide");

	public static readonly SummerRaceAudioCue VehicleDriveCue = new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_drive");

	public static readonly SummerRaceAudioCue DamageTextCue = new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_harm");

	public static SummerRaceAudioCue ResolveWeaponCue(WeaponKind weaponKind, SummerRacePresentationPhase phase)
	{
		switch (weaponKind)
		{
		case WeaponKind.MachineGun:
			if (phase != SummerRacePresentationPhase.Fired)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_gun");
		case WeaponKind.RocketLauncher:
			if (phase != SummerRacePresentationPhase.Fired)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_rocket");
		case WeaponKind.LaserCannon:
			if (phase != SummerRacePresentationPhase.Fired)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_cannon");
		case WeaponKind.ScatterShell:
			if (phase != SummerRacePresentationPhase.Fired)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_scattershel");
		case WeaponKind.Boomerang:
			if (phase != SummerRacePresentationPhase.Fired)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_rotating");
		case WeaponKind.Shovel:
			if (phase != SummerRacePresentationPhase.Impact)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_hit01");
		case WeaponKind.RotatingSaw:
			if (phase != SummerRacePresentationPhase.Impact)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_hit02");
		case WeaponKind.Drill:
			return phase switch
			{
				SummerRacePresentationPhase.Activated => new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_hit03"), 
				SummerRacePresentationPhase.ActiveExpired => new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_hit03_stop"), 
				_ => default(SummerRaceAudioCue), 
			};
		default:
			return default(SummerRaceAudioCue);
		}
	}

	public static SummerRaceAudioCue ResolveEquipCue(EquipKind equipKind, SummerRacePresentationPhase phase)
	{
		switch (equipKind)
		{
		case EquipKind.ElectricNet:
			return phase switch
			{
				SummerRacePresentationPhase.Activated => new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_material"), 
				SummerRacePresentationPhase.Impact => new SummerRaceAudioCue("minigame_activity_5_1", "minigame_activity_5_1_marble_buff_2003"), 
				_ => default(SummerRaceAudioCue), 
			};
		case EquipKind.ShieldGenerator:
			if (phase != SummerRacePresentationPhase.Activated)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_shield");
		case EquipKind.Hook:
			if (phase != SummerRacePresentationPhase.Activated)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_hook");
		case EquipKind.BoxingGlove:
			if (phase != SummerRacePresentationPhase.Impact)
			{
				return default(SummerRaceAudioCue);
			}
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_boxing");
		default:
			return default(SummerRaceAudioCue);
		}
	}

	public static SummerRaceAudioCue ResolveDefeatCue(string effectPath)
	{
		if (string.IsNullOrWhiteSpace(effectPath))
		{
			return default(SummerRaceAudioCue);
		}
		string text = effectPath.ToLowerInvariant();
		if (text.Contains("boom_2") || text.Contains("boom2") || text.Contains("boom02"))
		{
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_boom02");
		}
		if (text.Contains("boom_1") || text.Contains("boom1") || text.Contains("boom01"))
		{
			return new SummerRaceAudioCue("minigame_activity_5_2", "minigame_activity_5_2_weapon_boom01");
		}
		return default(SummerRaceAudioCue);
	}
}

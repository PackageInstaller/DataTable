namespace ACT.DialogueSystem;

public static class LuminDialogueSettings
{
	public const int MINIMUN_TYPER_WRITER_SPEED = 35;

	public const string MINIMUN_TYPER_WRITER_SPEED_TEXT = "35";

	public const float AUTO_NEXT_DEFAULT_DELAY = 0.5f;

	public const string AUTO_NEXT_DEFAULT_DELAY_TEXT = "0.5";

	public const string PLAYER_NAME = "<playername/>";

	public const int PLAYER_ID = 10001;

	public const int PLAYER_ID_FEMALE = 10001;

	public const int PLAYER_ID_MALE = 10002;

	public const int SPEAKER_TYPE_NONE = 0;

	public const int SPEAKER_TYPE_PLAYER = 1;

	public const int SPEAKER_TYPE_OTHER = 0;

	public const float BG_MASK_FADE_SPEED = 0.3f;

	public const string BODY_ANIM_IDLE = "idle";

	public static string[] PlayerAvatarNames = new string[11]
	{
		"默认", "微笑", "眯眼笑", "委屈", "悲伤", "大笑", "生气(张嘴)", "惊讶", "冷漠", "严肃(仅女主)",
		"严肃(闭眼)"
	};

	public static int[] FemalePlayerAvatarIds = new int[11]
	{
		1000101, 1000102, 1000103, 1000104, 1000105, 1000106, 1000107, 1000108, 1000109, 1000110,
		1000111
	};

	public static int[] MalePlayerAvatarIds = new int[11]
	{
		1000201, 1000202, 1000203, 1000204, 1000205, 1000206, 1000207, 1000208, 1000209, 1000210,
		1000211
	};

	public static int[] GoldFemalePlayerAvatarIds = new int[11]
	{
		1000301, 1000302, 1000303, 1000304, 1000305, 1000306, 1000307, 1000308, 1000309, 1000310,
		1000311
	};

	public static int[] GoldMalePlayerAvatarIds = new int[11]
	{
		1000401, 1000402, 1000403, 1000404, 1000405, 1000406, 1000407, 1000408, 1000409, 1000410,
		1000411
	};
}

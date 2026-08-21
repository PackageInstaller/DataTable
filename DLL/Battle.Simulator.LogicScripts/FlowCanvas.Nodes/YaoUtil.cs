namespace FlowCanvas.Nodes;

public class YaoUtil
{
	public const int YU_COUNT_INDEX = 107600220;

	public const int YU_1_INDEX = 107600221;

	public const int YU_2_INDEX = 107600222;

	public const int YU_3_INDEX = 107600223;

	public const int YU_4_INDEX = 107600224;

	public const int AVOIDE_TARGET_POSITION_X_INDEX = 107630502;

	public const int AVOIDE_TARGET_POSITION_Y_INDEX = 107630503;

	public const int AVOIDE_TARGET_POSITION_Z_INDEX = 107630504;

	public const int AVOIDE_DIRECTION_INDEX = 107630505;

	public static long GetYu(bool key)
	{
		return key ? 1 : (-1);
	}
}

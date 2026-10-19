namespace Com.ForbiddenByte.OSA.Core;

public class OSAConst
{
	public const string OSA_VERSION_STRING = "7.2.1";

	public const int MAX_ITEMS = 2147483646;

	public const int MAX_ITEMS_WHILE_LOOPING_TO_ALLOW_TWIN_PASS = 800000000;

	public const int MAX_ITEMS_TO_SUPPORT_ITEM_RESIZING = 1000000000;

	internal const double OPTIMIZE_JUMP__MIN_DRAG_AMOUNT_AS_FACTOR_OF_VIEWPORT_SIZE = 2.0;

	internal const double RECYCLE_ALL__MIN_DRAG_AMOUNT_AS_FACTOR_OF_VIEWPORT_SIZE = 10.0;

	internal const string DEBUG_FLOAT_FORMAT = "#################0.#";

	internal const string EXCEPTION_SCHEDULE_TWIN_PASS_CALL_ALLOWANCE = "ScheduleComputeVisibilityTwinPass() can only be called during UpdateViewsHolder() or OnItemIndexChangedDueInsertOrRemove() !!!";

	public const int MAX_CELLS_PER_GROUP_FACTOR_WHEN_INFERRING = 5;

	public const float SCROLL_DIR_X_MULTIPLIER = 1f;

	public const float SCROLL_DIR_Y_MULTIPLIER = 1f;

	public const string DOUBLE_TO_STRING_CONVERSION_SPECIFIER_PRESERVE_PRECISION = "G17";

	public const string FLOAT_TO_STRING_CONVERSION_SPECIFIER_PRESERVE_PRECISION = "G9";

	public const string OSA_PATH_IN_RESOURCES = "Com.ForbiddenByte.OSA";
}

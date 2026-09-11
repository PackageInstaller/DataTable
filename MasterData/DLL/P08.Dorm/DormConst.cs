using System.Collections.Generic;
using UnityEngine;

public static class DormConst
{
	public const string GROUND_TAG = "ground";

	public const string EXTEND_TAG = "extend";

	public static int GROUND_LAYER_ID = LayerMask.NameToLayer("ground");

	public static int CHARA_LAYER_ID = LayerMask.NameToLayer("Character");

	public static int OBSTACLE_LAYER_ID = LayerMask.NameToLayer("obstacle");

	public static int GROUND_LAYER_MASK = LayerMask.GetMask("ground");

	public static int CHARA_LAYER_MASK = LayerMask.GetMask("Character");

	public static int OBSTACLE_LAYER_MASK = LayerMask.GetMask("obstacle");

	public static int EVENT_LAYER_ID = LayerMask.GetMask("LevelEvent");

	public const float TILE_SIZE = 0.25f;

	public const int ASTAR_PATH_TILE_NUM = 10;

	public const float DEFAULT_ENTITY_RADIUS = 0.25f;

	public const float DEFAULT_ENTITY_HEIGHT = 1f;

	public const float COORDINATE_DEVIATION = 0.1f;

	public const float NOT_WALKABLE_RATE = 0.25f;

	public static List<Vector3> DIR_MAP = new List<Vector3>
	{
		new Vector3(0.25f, 0f, 0.25f),
		new Vector3(0.25f, 0f, 0.25f),
		new Vector3(0.25f, 0.25f, 0f),
		new Vector3(0.25f, 0.25f, 0f),
		new Vector3(0f, 0.25f, 0.25f),
		new Vector3(0f, 0.25f, 0.25f)
	};

	public const int WALL_NUM = 6;

	public const int TILE_GRID_NUM = 1;

	public const string CHARACTER_ANIMATION_CLIP = "";

	public static List<Vector3> POS_EDIT = new List<Vector3>
	{
		new Vector3(0f, 0.02f, 0f),
		new Vector3(0f, -0.02f, 0f),
		new Vector3(0f, 0f, 0.02f),
		new Vector3(0f, 0f, -0.02f),
		new Vector3(-0.02f, 0f, 0f),
		new Vector3(0.02f, 0f, 0f)
	};

	public static List<Vector3> POS_PLACED = new List<Vector3>
	{
		new Vector3(0f, 0.01f, 0f),
		new Vector3(0f, 0f, 0f),
		new Vector3(0f, 0f, 0f),
		new Vector3(0f, 0f, 0f),
		new Vector3(0f, 0f, 0f),
		new Vector3(0f, 0f, 0f)
	};

	public const int WHOLE_ANGLE = 360;

	public const int HALF_ANGLE = 180;

	public const int ROTATE_ANGLE = 90;

	public const int ROTATE_OFFSET = 10;

	public static Color COLOR_BLUE = new Color(0.5019f, 0.9647f, 1.498f);

	public static Color COLOR_RED = new Color(1.5921f, 0.0313f, 0f);

	public static Vector3 DORM_ROLE_DUMMY_OFFSET = new Vector3(0f, -0.6f, 0f);

	public const string INTERACT_VFX_ATTACH_POINT = "gua_fx_interaction";

	public const string DORM_FX_DIR = "Dorm/Effect/houzhai/";

	public const string FX_PATH_INTERACT_POS_AVAILABLE = "Dorm/Effect/houzhai/fx_pos_interact_available";

	public const string FX_PATH_INTERACT_POS_BLOCKED = "Dorm/Effect/houzhai/fx_pos_interact_blocked";

	public const string FX_PATH_INTERACT_FURNITURE_AVAILABLE = "Dorm/Effect/houzhai/fx_furniture_interact_available";

	public const string FX_PATH_INTERACT_FURNITURE_BLOCKED = "Dorm/Effect/houzhai/fx_furniture_interact_blocked";
}

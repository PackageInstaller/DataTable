using System.Collections.Generic;
using UnityEngine;

namespace WaterPipeGame;

public static class WaterPipeConst
{
	public const string waterPipeCueSheet = "minigame_activity_3_9";

	public const string waterPipeRotate = "minigame_activity_3_9_pipe_rotate";

	public const string waterPipeRight = "minigame_activity_3_9_pipe_success";

	public static string pipeImgBasePath = "TextureConfig/VersionUI/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipe/";

	public static string pipeImgNormal = pipeImgBasePath + "BaichaoUI_3_9_{0}_normal";

	public static string pipeImgLink = pipeImgBasePath + "BaichaoUI_3_9_{0}_link";

	public static string pipeImgFinish = pipeImgBasePath + "BaichaoUI_3_9_{0}_finish";

	public static string pipeImgName = pipeImgBasePath + "{0}";

	public static string mapDataPath = "Assets/ABResources/WaterPipe/{0}.json";

	public static string assetMapDataPath = "WaterPipe/{0}";

	public static Dictionary<DIR, Vector3> dirDic = new Dictionary<DIR, Vector3>
	{
		{
			DIR.UP,
			Vector3.zero
		},
		{
			DIR.RIGHT,
			new Vector3(0f, 0f, 270f)
		},
		{
			DIR.DOWN,
			new Vector3(0f, 0f, 180f)
		},
		{
			DIR.LEFT,
			new Vector3(0f, 0f, 90f)
		}
	};

	public static Dictionary<PipeType, DIR[]> pipeTypeDir = new Dictionary<PipeType, DIR[]>
	{
		{
			PipeType.I_PIPE,
			new DIR[2]
			{
				DIR.RIGHT,
				DIR.LEFT
			}
		},
		{
			PipeType.L_PIPE,
			new DIR[2]
			{
				DIR.LEFT,
				DIR.UP
			}
		},
		{
			PipeType.T_PIPE,
			new DIR[3]
			{
				(DIR)1818848083,
				(DIR)1718503788,
				(DIR)111
			}
		},
		{
			PipeType.DEFAULT,
			new DIR[4]
			{
				(DIR)779248999,
				(DIR)29539,
				(DIR)256,
				(DIR)1348228608
			}
		}
	};

	public static Dictionary<PipeType, string> pipeTypeName = new Dictionary<PipeType, string>
	{
		{
			PipeType.BOX,
			"BaichaoUI_3_9_Box"
		},
		{
			PipeType.EVENT,
			"BaichaoUI_3_9_Event"
		},
		{
			PipeType.NPC,
			"BaichaoUI_3_9_Npc"
		}
	};

	public static Dictionary<PipeType, string> pipeMapName = new Dictionary<PipeType, string>
	{
		{
			PipeType.DEFAULT,
			"ALL"
		},
		{
			PipeType.I_PIPE,
			"I"
		},
		{
			PipeType.L_PIPE,
			"L"
		},
		{
			PipeType.T_PIPE,
			"T"
		}
	};
}

using System;
using UnityEngine;

namespace TangramGame;

public static class TangramGameConst
{
	[Serializable]
	public struct TangramGameBaseInfo
	{
		public int width;

		public int height;

		public string stageID;
	}

	public enum TILE_DATA_TYPE
	{
		SINGLE,
		TIGGER
	}

	public enum TILE_TYPE
	{
		LEFT_LOW,
		LEFT_HIGH,
		RIGHT_HIGH,
		RIGHT_LOW,
		EMPTY,
		FULL
	}

	public static Color[] COLOR_LIST = new Color[12]
	{
		Color.black,
		Color.blue,
		Color.green,
		Color.red,
		Color.yellow,
		new Color(1f, 0.5f, 0.2f),
		new Color(0.4f, 0.3f, 0.7f),
		new Color(0.7f, 0.2f, 0.6f),
		new Color(0.1f, 0.2f, 0.2f),
		new Color(0.5f, 0.5f, 0.5f),
		new Color(0.1f, 0.1f, 0.8f),
		new Color(0.1f, 0.8f, 1f)
	};

	public const string tangramSheet = "minigame_activity_3_5";

	public const string tangramPick = "minigame_activity_3_5_key_up";

	public const string tangramDown = "minigame_activity_3_5_key_down";
}

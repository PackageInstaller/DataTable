using System;
using UnityEngine;

namespace ACT.Config;

public class SeparateSegmentConfigs : ScriptableObject
{
	public enum Difficulty
	{
		Easy,
		Normal,
		Hard
	}

	[Serializable]
	public struct SeparateSegmentDifficulty
	{
		public Difficulty Difficulty;

		public SeparateSegmentConfig Config;
	}

	public SeparateSegmentDifficulty[] DifficultiesConfigs;
}

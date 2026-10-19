using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[CreateAssetMenu(fileName = "GlideParachuteOffsetConfig", menuName = "ACT/Config/Glide Parachute Offset")]
public class GlideParachuteOffsetConfig : ScriptableObject
{
	[Serializable]
	public struct RoleOffset
	{
		public int characterId;

		public Vector3 offset;
	}

	[SerializeField]
	private Vector3 _defaultOffset;

	[SerializeField]
	private RoleOffset[] _roleOffsets;

	public Vector3 GetOffset(int characterId)
	{
		if (_roleOffsets != null)
		{
			for (int i = 0; i < _roleOffsets.Length; i++)
			{
				if (_roleOffsets[i].characterId == characterId)
				{
					return _roleOffsets[i].offset;
				}
			}
		}
		return _defaultOffset;
	}
}

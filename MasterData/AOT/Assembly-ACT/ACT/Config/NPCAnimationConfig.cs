using System;
using System.Collections.Generic;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.Config;

public class NPCAnimationConfig : LuminSerializedScriptableObject
{
	[Serializable]
	public struct NPCStateConfig
	{
		public bool dontAutoMatch;

		public AnimationClip enter;

		public AnimationClip idle;

		public AnimationClip exit;
	}

	public struct NPCStateConfigKey
	{
		public int npcId;
	}

	public const string GENERIC_STATE_1 = "OnEnterInteract";

	public const string GENERIC_STATE_2 = "OnEnterInteractLoop";

	public const string GENERIC_STATE_3 = "OnExitInteract";

	[OdinSerialize]
	public Dictionary<NPCStateConfigKey, NPCStateConfig> NpcStateConfigs;
}

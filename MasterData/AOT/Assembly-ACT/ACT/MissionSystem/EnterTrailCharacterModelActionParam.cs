using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class EnterTrailCharacterModelActionParam
{
	public int probationId1;

	public int probationId2;

	public int probationId3;

	[Range(0f, 2f)]
	public int battleIndex;

	public int trialPotionId;
}

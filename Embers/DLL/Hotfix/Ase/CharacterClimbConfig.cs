using System;
using UnityEngine;

namespace Ase;

[Serializable]
public class CharacterClimbConfig
{
	public int HeroId;

	public float speed = 2f;

	[HideInInspector]
	public float stepDistance = 0.8f;

	[Space(18f)]
	public ClimbConfig ClimbUpStartConfig;

	public float climbUpEndDistance = 3f;

	[Space(5f)]
	public ClimbConfig ClimbUpEndConfig;

	[Space(18f)]
	public ClimbConfig ClimbDownStartConfig;

	public float climbDownEndDistance = 3f;

	public ClimbConfig ClimbDownEndConfig;
}

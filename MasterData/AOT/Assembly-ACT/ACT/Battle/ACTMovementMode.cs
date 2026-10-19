using UnityEngine;

namespace ACT.Battle;

public enum ACTMovementMode
{
	None,
	Walking,
	Falling,
	Flying,
	Swimming,
	Climbing,
	Carrayed,
	Custom,
	Adsorbing,
	ClimbCompensate,
	Recalling,
	GrabHook,
	Spring,
	[Tooltip("被投技携带了")]
	BeCarryed,
	WallClimbing,
	Glide,
	TeleportMove,
	PathSwitchRootMotion,
	Orbital360
}

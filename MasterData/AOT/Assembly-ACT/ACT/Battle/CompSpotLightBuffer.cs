using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class CompSpotLightBuffer : EcsComponent
{
	public Vector3 pos;

	public float radius;

	public float biasAngle;

	public float halfAngle;

	public uint colorIndex;

	public float height;

	public bool spawn;

	public List<Entity> inViewEr = new List<Entity>();

	public bool followPlayer;

	public float followTime;

	public float followVelocity;

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		pos = default;
		radius = 0f;
		biasAngle = 0f;
		halfAngle = 0f;
		colorIndex = 0u;
		height = 0f;
		spawn = false;
		inViewEr.Clear();
		followPlayer = false;
		followTime = 0f;
		followVelocity = 0f;
	}
}

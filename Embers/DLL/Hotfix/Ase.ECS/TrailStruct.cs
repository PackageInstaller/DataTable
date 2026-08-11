using UnityEngine;

namespace Ase.ECS;

public struct TrailStruct
{
	public TrailRenderer TrailRenderer;

	public float speed;

	public void Init(TrailRenderer trailRenderer)
	{
		TrailRenderer = trailRenderer;
		speed = trailRenderer.time;
	}

	public void Pause()
	{
		TrailRenderer.time = 0f;
	}

	public void Play()
	{
		TrailRenderer.time = speed;
	}
}

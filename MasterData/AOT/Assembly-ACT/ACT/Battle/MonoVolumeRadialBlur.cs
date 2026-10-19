using UnityEngine;

namespace ACT.Battle;

public class MonoVolumeRadialBlur : MonoEffect
{
	public float blurCount = 12f;

	public float sampleDist = 2.5f;

	public float sampleStrength = 2f;

	private float m_Timer;

	public Animation anim;
}

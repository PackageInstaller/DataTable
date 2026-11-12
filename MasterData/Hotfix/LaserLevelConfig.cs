using System;
using TrueSync;
using UnityEngine;

[Serializable]
public class LaserLevelConfig
{
	public int level;

	public int hitDamgeId;

	public FP laserWidth = 0.1;

	public FP laserLength = 20f;

	public float scale = 1f;

	public AdventureFXPlayer linkFxPrefab;

	public GameObject hittedPrefab;

	public AdventurePlayerFeedbackEffectConfigureData hitFeedbackEffectConfigureData;
}

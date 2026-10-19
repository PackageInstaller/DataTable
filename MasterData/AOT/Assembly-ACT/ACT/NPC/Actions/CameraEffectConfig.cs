using System;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
public class CameraEffectConfig
{
	public float FOV = 20f;

	public int lensDistance = 160;

	public float focus = 3f;

	public float cameraPushDuration = 0.5f;

	public float cameraPullOutDuration = 0.5f;

	public Vector3 offset = Vector3.zero;

	public Vector3 rotation = Vector3.zero;
}

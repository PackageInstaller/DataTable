using System;
using UnityEngine;

[Serializable]
public class CameraCfg
{
	public bool warpX;

	public float minScreenX;

	public float maxScreenX;

	public float defaultX;

	public float minComposerX;

	public float maxComposerX = 1f;

	public float defaultComposerX = 0.5f;

	public bool warpY;

	public float minScreenY;

	public float maxScreenY;

	public float defaultY;

	public float radius;

	public Vector3 rigHeight;

	public Vector3 dummyPosition;

	[Range(1f, 179f)]
	public float fov = -1f;

	[Range(-180f, 180f)]
	public float dutch = -99999f;

	public float minAxisY => 0f;

	public float maxAxisY => 1f;

	public float defaultAxisY => 0.5f;
}

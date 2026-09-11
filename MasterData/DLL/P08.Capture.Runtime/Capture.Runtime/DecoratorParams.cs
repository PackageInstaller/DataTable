using System;
using UnityEngine;

namespace Capture.Runtime;

[Serializable]
public struct DecoratorParams
{
	[SerializeField]
	public Vector3 spawnPos;

	[SerializeField]
	public Vector3 spawnRot;

	[SerializeField]
	public float spawnScale;

	[SerializeField]
	public Vector3 spawnScaleV3;

	[SerializeField]
	public string tag;

	[SerializeField]
	public string prefabName;
}

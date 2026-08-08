using System;
using System.Collections.Generic;
using UnityEngine;

namespace Capture.Runtime;

[Serializable]
public struct CharacterParams
{
	[SerializeField]
	public List<Vector3> spawnPos;

	[SerializeField]
	public List<Vector3> spawnRot;
}

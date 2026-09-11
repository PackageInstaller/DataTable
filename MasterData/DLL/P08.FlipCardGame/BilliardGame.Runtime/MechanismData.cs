using System;
using UnityEngine;

namespace BilliardGame.Runtime;

[Serializable]
public class MechanismData
{
	public int entityId;

	public string path;

	public int createWave = 1;

	public bool hideWhenMagnify;

	public Vector3 position;

	public Vector3 rotation;

	public Vector3 scale;
}

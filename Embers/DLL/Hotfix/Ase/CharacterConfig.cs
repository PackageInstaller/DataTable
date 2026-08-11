using System;
using UnityEngine;

namespace Ase;

[Serializable]
[CreateAssetMenu(menuName = "CharacterConfig")]
public class CharacterConfig : ScriptableObject
{
	public bool viewLerp;

	public float stableMovementSharpness;

	public float stableRotationSharpness;
}

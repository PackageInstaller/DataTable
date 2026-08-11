using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[CreateAssetMenu(menuName = "SkinUniversalBtnData")]
public class SkinUniversalBtnData : ScriptableObject, ISerializationCallbackReceiver
{
	public List<bool> UseSkinImages;

	public List<bool> UseSkinEffects;

	public Color DistanceCancelColor;

	public void OnBeforeSerialize()
	{
	}

	public void OnAfterDeserialize()
	{
	}
}

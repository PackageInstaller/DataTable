using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
public class BedInteractPosGameData
{
	public Vector3 interactShowPos;

	public BedPosEnum posType = BedPosEnum.HEAD;

	public string beginAni = string.Empty;

	public string returnAni = string.Empty;

	public string posAni;

	public Vector3 handlePointPos;

	public List<string> selectedEmotions = new List<string>();
}

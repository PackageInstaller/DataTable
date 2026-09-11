using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class HeroRaiseTrackData : ScriptableObject
{
	public List<HeroRaiseCameraNode> nodes = new List<HeroRaiseCameraNode>();
}

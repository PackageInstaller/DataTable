using System;
using ACT.Sound;
using FMODUnity;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class RegionNameData : IDataToBake
{
	public LocalizedString regionName = new LocalizedString();

	public LocalizedString secondaryRegionName = new LocalizedString();

	public EventReference regionSound;

	public AudioEventReference audioRegionSound;

	[HideInInspector]
	public Bounds bounds;

	public BoxCollider box;
}

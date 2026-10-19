using System;
using Cinemachine;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class CinemachineVirtualCameraConfig
{
	public Vector3 position;

	public int priority;

	public LensSettings lensSettings;
}

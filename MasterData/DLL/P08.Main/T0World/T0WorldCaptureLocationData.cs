using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0WorldCaptureLocationData
{
	public int locationID;

	public Vector3 backCharaterPos;

	public Vector3 backCharaterRot;

	public Vector3 backPlayerPos;

	public Vector3 backPlayerRot;

	public Vector3 spawnCharaterPos;

	public Vector3 spawnCharaterRot;

	public float beginCameraX;

	public float beginCameraY;

	public T0WorldCaptureRigParams rigParams;
}

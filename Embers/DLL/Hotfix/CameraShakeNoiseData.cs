using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "CameraShakeNoiseData")]
public class CameraShakeNoiseData : ScriptableObject
{
	public List<NoiseData> cameraShakeNoiseDataList = new List<NoiseData>();

	public List<CurveData> cameraShakeIntensityCurveDataList = new List<CurveData>();

	public List<CurveData> cameraShakefrequencyCurveDataList = new List<CurveData>();

	public List<CurveData> impulseRangeCurveDataList = new List<CurveData>();
}

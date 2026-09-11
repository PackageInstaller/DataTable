using System;
using System.Collections.Generic;
using UnityEngine;

namespace T0World;

[Serializable]
[CreateAssetMenu(menuName = "T0小场景/拍照相机参数")]
public class T0WorldCaptureData : ScriptableObject
{
	public List<T0WorldCaptureLocationData> captureLocationDataList;

	public List<T0WorldCaptureAniData> captureAniDataList;
}

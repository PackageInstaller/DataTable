using System;
using System.Collections.Generic;
using UnityEngine;

namespace Capture.Runtime;

[Serializable]
public class StageData
{
	[SerializeField]
	public string baseScenePath;

	[SerializeField]
	public CaptureGameMode mode;

	[SerializeField]
	public CameraParams cameraParams;

	[SerializeField]
	public CharacterParams characterParams;

	[SerializeField]
	public List<DecoratorParams> decoratorParams;
}

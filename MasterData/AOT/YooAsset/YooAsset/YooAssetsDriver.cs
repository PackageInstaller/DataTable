using System.Diagnostics;
using UnityEngine;

namespace YooAsset;

internal class YooAssetsDriver : MonoBehaviour
{
	private static int LastestUpdateFrame;

	private void Update()
	{
		YooAssets.Update();
	}

	[Conditional("DEBUG")]
	private void DebugCheckDuplicateDriver()
	{
		if (LastestUpdateFrame > 0 && LastestUpdateFrame == Time.frameCount)
		{
			YooLogger.Warning("There are two YooAssetsDriver in the scene. Please ensure there is always exactly one driver in the scene.");
		}
		LastestUpdateFrame = Time.frameCount;
	}
}

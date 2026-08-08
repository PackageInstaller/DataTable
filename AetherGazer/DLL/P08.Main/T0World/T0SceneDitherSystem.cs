using Qworld.Runtime.SceneDither;
using UnityEngine;
using Vella.UnityNativeHull;

namespace T0World;

public class T0SceneDitherSystem : QWSceneDitherSystem
{
	public override Camera GetMainCamera()
	{
		return T0WorldScene.Scene.chineBrain.OutputCamera;
	}

	public override void GetObb()
	{
		T0CaptureDitherData ditherData = T0WorldScene.Scene.captureManager.GetDitherData();
		HullHelper.GetClipSpaceOBBFromColliderData(ditherData.obbTrs, ref obb, ditherData.colRadius, ditherData.colRadius, ditherData.colCenter);
	}

	public override MortonTreeLeafNode GetPlayerChunck()
	{
		Vector3 position = T0WorldScene.Scene.captureManager.captureContext.modelObj.transform.position;
		return base.Chunk.GetMortonChunk(position);
	}

	public override MortonTreeLeafNode GetCameraChunck()
	{
		Vector3 position = T0WorldScene.Scene.captureManager.captureContext.cameraCollder.transform.position;
		return base.Chunk.GetMortonChunk(position);
	}
}

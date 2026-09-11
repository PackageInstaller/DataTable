using Qworld.Runtime.SceneDither;
using T0World;
using UnityEngine;
using Vella.UnityNativeHull;

namespace Oath;

public class OathSceneDitherSystem : QWSceneDitherSystem
{
	public override Camera GetMainCamera()
	{
		return OathSceneLoader.Scene.context.chineBrain.OutputCamera;
	}

	public override void GetObb()
	{
		T0CaptureDitherData ditherData = OathSceneLoader.Scene.context.captureManager.GetDitherData();
		HullHelper.GetClipSpaceOBBFromColliderData(ditherData.obbTrs, ref obb, ditherData.colRadius, ditherData.colRadius, ditherData.colCenter);
	}

	public override MortonTreeLeafNode GetPlayerChunck()
	{
		Vector3 position = OathSceneLoader.Scene.context.captureManager.captureContext.modelObj.transform.position;
		return base.Chunk.GetMortonChunk(position);
	}

	public override MortonTreeLeafNode GetCameraChunck()
	{
		Vector3 position = OathSceneLoader.Scene.context.captureManager.captureContext.cameraCollder.transform.position;
		return base.Chunk.GetMortonChunk(position);
	}
}

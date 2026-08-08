using FlowCanvas;
using UnityEngine;

public class CameraAnimationCallBack : MonoBehaviour
{
	public FlowOutput output;

	public Flow f;

	public GameObject cameraAsset;

	public void CallBack()
	{
		if (output != null)
		{
			output.Call(f);
		}
		output = null;
		if (cameraAsset != null)
		{
			PooledAsset.DestroyOrReturn(cameraAsset);
		}
		cameraAsset = null;
	}
}

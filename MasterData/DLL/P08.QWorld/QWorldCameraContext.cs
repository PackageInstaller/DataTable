using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class QWorldCameraContext
{
	public static string CustomCameraBasePath = "QWWorld/Camera/Custom/";

	public static int PlayerOrStoryDefaultLayer = 40;

	public static int ForcePlayerOrStoryLayer = 1;

	public QWCameraFlag cameraFlag = QWCameraFlag.Player;

	public CustomCameraStack customCameraLayer;

	public QWFocusCamera focusPlayerCamera;

	public float lastSwitchCameraBlendTimestamp;

	public float blendDuration;

	public int cutBlendDirty;

	public bool BlendRestoreDirty;

	public QWCustomCamera lastBlendCamera;

	public Vector3 virtualCameraPos;

	public Camera mainCam;

	public Light _directionalLight;

	public SimMainLight _simMainLight;
}

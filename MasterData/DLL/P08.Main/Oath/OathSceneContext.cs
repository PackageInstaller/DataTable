using Cinemachine;

namespace Oath;

public class OathSceneContext
{
	public int characterID;

	public string sceneName;

	public OathConst.OathSceneMode sceneMode;

	public CinemachineBrain chineBrain;

	public OathInterationManager interationManager;

	public OathCaptureManager captureManager;

	public OathCaptureViewUI captureViewUI;

	public bool isAlreadyOath;

	public void Dispose()
	{
		captureManager?.Dispose();
		captureManager = null;
		interationManager?.Dispose();
		interationManager = null;
	}
}

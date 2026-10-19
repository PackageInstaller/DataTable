using UnityEngine.SceneManagement;

namespace YooAsset;

internal abstract class FSLoadSceneOperation : AsyncOperationBase
{
	public Scene Result;

	public abstract void UnSuspendLoad();
}

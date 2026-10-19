using UnityEngine.Scripting;

namespace UnityEngine.Playables;

public interface IPlayableBehaviour
{
	[RequiredByNativeCode]
	void OnGraphStart(Playable playable);

	[RequiredByNativeCode]
	void OnGraphStop(Playable playable);

	[RequiredByNativeCode]
	void OnPlayableCreate(Playable playable);

	[RequiredByNativeCode]
	void OnPlayableDestroy(Playable playable);

	[RequiredByNativeCode]
	void OnBehaviourPlay(Playable playable, FrameData info);

	[RequiredByNativeCode]
	void OnBehaviourPause(Playable playable, FrameData info);

	[RequiredByNativeCode]
	void PrepareFrame(Playable playable, FrameData info);

	[RequiredByNativeCode]
	void ProcessFrame(Playable playable, FrameData info, object playerData);
}

using System;

namespace Ase;

public interface ISpineAnimationPlayer
{
	bool PlayAction(string aniName, Action onActionFinish = null);

	bool PlayLegacyAction(string aniName, Action onActionFinish = null);

	bool PlayLegacyAction(string aniName, int track, Action onActionFinish = null);

	bool HasAction(string aniName);

	void PlayIdle(bool playAudio = true);

	void ResetToIdle(bool stopAudio = true);

	void StopAnimation();
}

namespace GameFramework.Sound;

public interface ISoundGroup
{
	string Name { get; }

	int SoundAgentCount { get; }

	bool AvoidBeingReplacedBySamePriority { get; set; }

	bool Mute { get; set; }

	float Volume { get; set; }

	ISoundGroupHelper Helper { get; }

	void StopAllLoadedSounds();

	void StopAllLoadedSounds(float fadeOutSeconds);
}

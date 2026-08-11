using System.Collections.Generic;
using GameFramework.Resource;

namespace GameFramework.Sound;

public interface ISoundManager
{
	int SoundGroupCount { get; }

	void SetResourceManager(IResourceManager resourceManager);

	void SetSoundHelper(ISoundHelper soundHelper);

	bool HasSoundGroup(string soundGroupName);

	ISoundGroup GetSoundGroup(string soundGroupName);

	ISoundGroup[] GetAllSoundGroups();

	void GetAllSoundGroups(List<ISoundGroup> results);

	bool AddSoundGroup(string soundGroupName, ISoundGroupHelper soundGroupHelper);

	bool AddSoundGroup(string soundGroupName, bool soundGroupAvoidBeingReplacedBySamePriority, bool soundGroupMute, float soundGroupVolume, ISoundGroupHelper soundGroupHelper);

	void AddSoundAgentHelper(string soundGroupName, ISoundAgentHelper soundAgentHelper);

	int[] GetAllLoadingSoundSerialIds();

	void GetAllLoadingSoundSerialIds(List<int> results);

	bool IsLoadingSound(int serialId);

	int PlaySound(string soundAssetName, string soundGroupName);

	int PlaySound(string soundAssetName, string soundGroupName, int priority);

	int PlaySound(string soundAssetName, string soundGroupName, PlaySoundParams playSoundParams);

	int PlaySound(string soundAssetName, string soundGroupName, object userData);

	int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams);

	int PlaySound(string soundAssetName, string soundGroupName, int priority, object userData);

	int PlaySound(string soundAssetName, string soundGroupName, PlaySoundParams playSoundParams, object userData);

	int PlaySound(string soundAssetName, string soundGroupName, int priority, PlaySoundParams playSoundParams, object userData);

	bool StopSound(int serialId);

	bool StopSound(int serialId, float fadeOutSeconds);

	void StopAllLoadedSounds();

	void StopAllLoadedSounds(float fadeOutSeconds);

	void StopAllLoadingSounds();

	void PauseSound(int serialId);

	void PauseSound(int serialId, float fadeOutSeconds);

	void ResumeSound(int serialId);

	void ResumeSound(int serialId, float fadeInSeconds);
}

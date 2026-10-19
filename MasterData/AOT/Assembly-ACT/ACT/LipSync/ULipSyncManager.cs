using System.Collections.Generic;
using Fundamental;

namespace ACT.LipSync;

public class ULipSyncManager : Singleton<ULipSyncManager>
{
	private readonly Dictionary<int, List<NewFMODLipSyncBakeDataPlayer>> _registeredCharacters = new Dictionary<int, List<NewFMODLipSyncBakeDataPlayer>>();

	private bool _isPaused;

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		_isPaused = false;
	}

	public override void UnInit()
	{
		StopAllCharacters();
		_registeredCharacters.Clear();
		_isPaused = false;
	}

	public void RegisterCharacter(int characterId, NewFMODLipSyncBakeDataPlayer newFMODLipSyncBakeDataPlayer)
	{
		if (!newFMODLipSyncBakeDataPlayer)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		if (!_registeredCharacters.TryGetValue(characterId, out var value))
		{
			value = new List<NewFMODLipSyncBakeDataPlayer>();
			_registeredCharacters.Add(characterId, value);
		}
		if (value.Contains(newFMODLipSyncBakeDataPlayer))
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		value.Add(newFMODLipSyncBakeDataPlayer);
		_ = LuminApplication.LogEnabled;
	}

	public void UnregisterCharacter(int characterId)
	{
		if (!_registeredCharacters.TryGetValue(characterId, out var value))
		{
			return;
		}
		foreach (NewFMODLipSyncBakeDataPlayer item in value)
		{
			StopAndClearCharacter(item);
		}
		_registeredCharacters.Remove(characterId);
		_ = LuminApplication.LogEnabled;
	}

	public void UnregisterCharacter(int characterId, NewFMODLipSyncBakeDataPlayer newFMODLipSyncBakeDataPlayer)
	{
		if (_registeredCharacters.TryGetValue(characterId, out var value) && value.Remove(newFMODLipSyncBakeDataPlayer))
		{
			StopAndClearCharacter(newFMODLipSyncBakeDataPlayer);
			if (value.Count == 0)
			{
				_registeredCharacters.Remove(characterId);
			}
			_ = LuminApplication.LogEnabled;
		}
	}

	public void PlayULipSyncAnimation(int characterId, ULipSyncBakeData data)
	{
		StopAllCharacters();
		if (!_registeredCharacters.TryGetValue(characterId, out var value))
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		bool flag = false;
		for (int num = value.Count - 1; num >= 0; num--)
		{
			NewFMODLipSyncBakeDataPlayer newFMODLipSyncBakeDataPlayer = value[num];
			if (!newFMODLipSyncBakeDataPlayer)
			{
				value.RemoveAt(num);
			}
			else
			{
				newFMODLipSyncBakeDataPlayer.Play(data);
				if (_isPaused)
				{
					newFMODLipSyncBakeDataPlayer.Pause();
				}
				flag = true;
			}
		}
		if (value.Count == 0)
		{
			_registeredCharacters.Remove(characterId);
		}
		if (!flag)
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public void SetULipSyncPaused(bool paused)
	{
		if (_isPaused == paused)
		{
			return;
		}
		_isPaused = paused;
		foreach (List<NewFMODLipSyncBakeDataPlayer> value in _registeredCharacters.Values)
		{
			for (int num = value.Count - 1; num >= 0; num--)
			{
				NewFMODLipSyncBakeDataPlayer newFMODLipSyncBakeDataPlayer = value[num];
				if (!newFMODLipSyncBakeDataPlayer)
				{
					value.RemoveAt(num);
				}
				else if (paused)
				{
					newFMODLipSyncBakeDataPlayer.Pause();
				}
				else
				{
					newFMODLipSyncBakeDataPlayer.Resume();
				}
			}
		}
	}

	public void StopULipSyncAnimation()
	{
		_isPaused = false;
		StopAllCharacters();
	}

	private void StopAllCharacters()
	{
		foreach (List<NewFMODLipSyncBakeDataPlayer> value in _registeredCharacters.Values)
		{
			for (int num = value.Count - 1; num >= 0; num--)
			{
				NewFMODLipSyncBakeDataPlayer newFMODLipSyncBakeDataPlayer = value[num];
				if (!newFMODLipSyncBakeDataPlayer)
				{
					value.RemoveAt(num);
				}
				else
				{
					newFMODLipSyncBakeDataPlayer.Stop();
					newFMODLipSyncBakeDataPlayer.bakedData = null;
				}
			}
		}
	}

	private static void StopAndClearCharacter(NewFMODLipSyncBakeDataPlayer character)
	{
		if ((bool)character)
		{
			character.Stop();
			character.bakedData = null;
		}
	}
}

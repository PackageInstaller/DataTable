using System;
using System.Collections.Generic;
using System.IO;
using CriWare;
using UnityEngine;

namespace YS.CustomTimelineTrack;

public class CriAtomTimelinePreviewer : IDisposable
{
	private struct PlayerSource
	{
		public readonly CriAtomExPlayer player = new CriAtomExPlayer();

		public readonly CriAtomEx3dSource source3d = new CriAtomEx3dSource();

		public PlayerSource(CriAtomEx3dListener listener)
		{
			source3d.SetPosition(0f, 0f, 0f);
			source3d.Update();
			player.Set3dSource(source3d);
			player.Set3dListener(listener);
			player.UpdateAll();
		}
	}

	private static CriAtomTimelinePreviewer instance;

	private string lastAcfFile = "";

	private Dictionary<string, CriAtomExAcb> acbTable;

	private Dictionary<Guid, PlayerSource> playerTable;

	private CriAtomEx3dListener listener3d;

	private const string ACFFILE = "Eyes_of_deep_space.acf";

	public static CriAtomTimelinePreviewer Instance
	{
		get
		{
			if (instance == null)
			{
				instance = new CriAtomTimelinePreviewer();
			}
			return instance;
		}
	}

	public static bool IsInitialized
	{
		get
		{
			if (instance == null)
			{
				return false;
			}
			return true;
		}
	}

	public static void InstanceDispose()
	{
		if (instance != null)
		{
			instance.Dispose();
			instance = null;
		}
	}

	public CriAtomTimelinePreviewer()
	{
		acbTable = new Dictionary<string, CriAtomExAcb>();
		playerTable = new Dictionary<Guid, PlayerSource>();
		if (listener3d == null)
		{
			listener3d = new CriAtomEx3dListener();
			listener3d.SetPosition(0f, 0f, 0f);
			listener3d.Update();
		}
	}

	public CriAtomExPlayer GetPlayer(Guid trackId)
	{
		if (playerTable.ContainsKey(trackId))
		{
			return playerTable[trackId].player;
		}
		PlayerSource value = new PlayerSource(listener3d);
		try
		{
			playerTable.Add(trackId, value);
		}
		catch (Exception ex)
		{
			Debug.LogError("[CRIWARE] Timeline Previewer: Failed adding preview player (" + ex.Message + ")");
		}
		return value.player;
	}

	public void SetCue(Guid trackId, CriAtomExAcb acb, string cueName)
	{
		if (acb != null && !string.IsNullOrEmpty(cueName))
		{
			GetPlayer(trackId).SetCue(acb, cueName);
		}
		else
		{
			Debug.LogWarning("[CRIWARE] Timeline Previewer: insufficient ACB or cue name");
		}
	}

	public CriAtomExAcb GetAcb(string cueSheetName)
	{
		if (string.IsNullOrEmpty(cueSheetName))
		{
			Debug.LogWarning("[CRIWARE] Timeline Previewer: cuesheet name is vacant");
			return null;
		}
		if (lastAcfFile != "Eyes_of_deep_space.acf")
		{
			string pFilePath = "Eyes_of_deep_space.acf";
			CriAtomEx.UnregisterAcf();
			if (!CriWareExtension.TryGetFilePath(pFilePath, out pFilePath) && Common.IsStreamingAssetsPath(pFilePath))
			{
				pFilePath = Path.Combine(Common.streamingAssetsPath, pFilePath);
			}
			CriAtomEx.RegisterAcf(null, pFilePath);
			lastAcfFile = "Eyes_of_deep_space.acf";
		}
		if (acbTable.ContainsKey(cueSheetName))
		{
			return acbTable[cueSheetName];
		}
		if (string.IsNullOrEmpty(cueSheetName))
		{
			return null;
		}
		string pFilePath2 = cueSheetName + ".acb";
		if (!CriWareExtension.TryGetFilePath(pFilePath2, out pFilePath2) && Common.IsStreamingAssetsPath(pFilePath2))
		{
			pFilePath2 = Path.Combine(Common.streamingAssetsPath, pFilePath2);
		}
		string pFilePath3 = cueSheetName + ".awb";
		if (!string.IsNullOrEmpty(pFilePath3) && !CriWareExtension.TryGetFilePath(pFilePath3, out pFilePath3) && Common.IsStreamingAssetsPath(pFilePath3))
		{
			pFilePath3 = Path.Combine(Common.streamingAssetsPath, pFilePath3);
		}
		CriAtomExAcb criAtomExAcb = CriAtomExAcb.LoadAcbFile(null, pFilePath2, pFilePath3);
		if (criAtomExAcb != null)
		{
			try
			{
				acbTable.Add(cueSheetName, criAtomExAcb);
			}
			catch (Exception ex)
			{
				if (ex is ArgumentException)
				{
					Debug.LogWarning("[CRIWARE] Timeline Previewer: ACB already existing.");
				}
				else
				{
					Debug.LogWarning("[CRIWARE] Timeline Previewer: ACB Dictionary exception: " + ex.Message);
				}
			}
		}
		else
		{
			Debug.LogWarning("[CRIWARE] Timeline Previewer: Failed loading ACB/AWB file.");
		}
		return criAtomExAcb;
	}

	public CriAtomExPlayback Play(Guid trackId)
	{
		return GetPlayer(trackId).Start();
	}

	public void StopTrack(Guid trackId, bool stopWithoutRelease = true)
	{
		if (stopWithoutRelease)
		{
			GetPlayer(trackId).StopWithoutReleaseTime();
		}
		else
		{
			GetPlayer(trackId).Stop();
		}
	}

	public void StopAllTracks(bool stopWithoutRelease = true)
	{
		foreach (KeyValuePair<Guid, PlayerSource> item in playerTable)
		{
			if (stopWithoutRelease)
			{
				item.Value.player.StopWithoutReleaseTime();
			}
			else
			{
				item.Value.player.Stop();
			}
		}
	}

	public void SetStartTime(Guid trackId, long startTimeMs)
	{
		GetPlayer(trackId).SetStartTime(startTimeMs);
	}

	public void SetLoop(Guid trackId, bool sw)
	{
		GetPlayer(trackId).Loop(sw);
	}

	public void SetVolume(Guid trackId, float volume)
	{
		GetPlayer(trackId).SetVolume(volume);
	}

	public void SetPitch(Guid trackId, float pitch)
	{
		GetPlayer(trackId).SetPitch(pitch);
	}

	public void SetAISAC(Guid trackId, string controlName, float value)
	{
		GetPlayer(trackId).SetAisacControl(controlName, value);
	}

	public void PlayerUpdateParameter(Guid trackId, CriAtomExPlayback atomExPlayback)
	{
		GetPlayer(trackId).Update(atomExPlayback);
	}

	~CriAtomTimelinePreviewer()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	private void Dispose(bool disposing)
	{
		foreach (PlayerSource value in playerTable.Values)
		{
			if (value.player != null)
			{
				value.player.Stop();
				value.player.Set3dListener(null);
				value.player.Set3dSource(null);
				value.player.Dispose();
			}
			if (value.source3d != null)
			{
				value.source3d.Dispose();
			}
		}
		playerTable.Clear();
		foreach (CriAtomExAcb value2 in acbTable.Values)
		{
			value2.Dispose();
		}
		acbTable.Clear();
		if (listener3d != null)
		{
			listener3d.Dispose();
			listener3d = null;
		}
	}
}

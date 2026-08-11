using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class GameVerificationViewModel
{
	private Action _refreshRoom;

	private string _lockStepDirectoryPath;

	private string _gameDataDirectoryPath;

	private DataStorageOss _dataStorage;

	public Dictionary<string, RoomData> RoomDic = new Dictionary<string, RoomData>();

	public List<RoomData> RoomList = new List<RoomData>();

	public GameVerificationViewModel(Action refreshRoom)
	{
		_refreshRoom = refreshRoom;
		string text = Path.Combine(Application.dataPath, "../GameBackData");
		if (!Directory.Exists(text))
		{
			Directory.CreateDirectory(text);
		}
		_lockStepDirectoryPath = text + "/RemoteLockStepFile";
		if (!Directory.Exists(_lockStepDirectoryPath))
		{
			Directory.CreateDirectory(_lockStepDirectoryPath);
		}
		_gameDataDirectoryPath = text + "/LocalPlayBackData";
		if (!Directory.Exists(_gameDataDirectoryPath))
		{
			Directory.CreateDirectory(_gameDataDirectoryPath);
		}
		_dataStorage = new DataStorageOss();
	}

	public void DelRoom(string roomId)
	{
		if (RoomDic.TryGetValue(roomId, out var value))
		{
			RoomList.Remove(value);
			RoomDic.Remove(roomId);
		}
		_refreshRoom?.Invoke();
	}

	public void RefreshRoom()
	{
		_dataStorage.AsyncListObjects("lockstepdata", AnalysisData);
	}

	private void AnalysisData(List<string> fileKeyList)
	{
		RoomDic.Clear();
		RoomList.Clear();
		foreach (string fileKey in fileKeyList)
		{
			string[] array = fileKey.Split('/');
			if (array.Length == 2 && !RoomDic.ContainsKey(array[0]))
			{
				RoomData roomData = RoomData.Create(array[0], this, _dataStorage, _lockStepDirectoryPath, _gameDataDirectoryPath);
				RoomDic.Add(array[0], roomData);
				RoomList.Add(roomData);
			}
		}
		Debug.Log($"房间数量 {RoomDic.Count}");
	}

	private VerificationPlayerData CreatePlayerLockStepFileData(string[] content, string key)
	{
		return new VerificationPlayerData
		{
			ConfigId = content[8],
			EntityId = content[6],
			RemoveDownloadFullPath = key,
			DownloadFullPath = key.Split("/")[0] + key.Split("/")[1]
		};
	}
}

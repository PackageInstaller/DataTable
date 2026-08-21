using System;
using System.IO;
using System.Threading.Tasks;
using Ase;
using Ase.ECS;
using Cysharp.Text;
using UnityEngine;

public class LockstepData
{
	private static LockstepData _instance;

	private string _dumpPath = Path.Combine(Application.dataPath, "../FramePacketRecords");

	private Utf16ValueStringBuilder _stringBuilder;

	private int _actorId;

	private long _roomId;

	private int _playerNumber;

	private int _heroConfigId;

	private string _timeStamp;

	public static LockstepData Instance => null;

	private static bool IsWriteLog => LockStepConstant.LockStepLogLevel == LockStepLogLevelEnum.Local;

	public void InitData(int actorId, long roomId, int playerNumber, int heroConfig)
	{
		if (IsWriteLog)
		{
			_timeStamp = $"{DateTime.Now.Hour}+{DateTime.Now.Minute}+{DateTime.Now.Second}";
			_stringBuilder = ZString.CreateStringBuilder();
			_actorId = actorId;
			_roomId = roomId;
			_playerNumber = playerNumber;
			_heroConfigId = heroConfig;
		}
	}

	public void WriteAuthorityEntityId(string str, BaseEntity entity, string level = "normal")
	{
		if (entity != null && IsWriteLog && _actorId != 0 && entity.GetSystem<BattleSystem>().BattleMode == BattleWorldMode.SyncBattle)
		{
			_stringBuilder.AppendLine($"实体类型 {entity.EntityId}  实体帧号 {entity.Tick}  {str}");
		}
	}

	public void WriteAuthorityEntityId(string str, string level = "normal")
	{
		if (IsWriteLog && _actorId != 0)
		{
			_stringBuilder.AppendLine(str ?? "");
		}
	}

	public void SyncSave()
	{
		if (IsWriteLog && _actorId != 0)
		{
			Task.Run((Action)RecodeData);
		}
	}

	private void RecodeData()
	{
		if (!Directory.Exists(_dumpPath))
		{
			Directory.CreateDirectory(_dumpPath);
		}
		string path = $"{_dumpPath}/RoomID_{_roomId}PlayerNumber_{_playerNumber}_ActorID{_actorId}_{_timeStamp}.txt";
		if (!File.Exists(path))
		{
			WriteFile(path, _stringBuilder);
		}
	}

	private void WriteFile(string path, Utf16ValueStringBuilder content)
	{
		using StreamWriter streamWriter = new StreamWriter(path, append: true);
		streamWriter.WriteLine(content);
		streamWriter.Flush();
		streamWriter.Dispose();
	}
}

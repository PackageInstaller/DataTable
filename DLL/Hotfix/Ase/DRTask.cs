using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string TaskName { get; private set; }

	public int CopyOpen { get; private set; }

	public int TaskType { get; private set; }

	public string TaskDesc { get; private set; }

	public string TaskTitle { get; private set; }

	public int TaskTitleID { get; private set; }

	public string TargetDesc { get; private set; }

	public int TaskTargetType { get; private set; }

	public List<int> TargetIdList { get; private set; }

	public int TargetValue { get; private set; }

	public int TargetLevelId { get; private set; }

	public List<int> ChildTaskList { get; private set; }

	public int ChildTaskType { get; private set; }

	public int ParentTask { get; private set; }

	public List<int> CheckTasks { get; private set; }

	public string MapDataAssetPath { get; private set; }

	public List<int> MapDataUsedAreaIds { get; private set; }

	public int MapDataLevel { get; private set; }

	public List<int> NextTask { get; private set; }

	public List<int> PreviousCondition { get; private set; }

	public List<int> PreviousParams { get; private set; }

	public string PreviousDesc { get; private set; }

	public int Priority { get; private set; }

	public int TimeLock { get; private set; }

	public int DailyTaskLevel { get; private set; }

	public bool Questaccept { get; private set; }

	public bool Questfinish { get; private set; }

	public bool Chapterstart { get; private set; }

	public bool Chapterend { get; private set; }

	public bool SpaceChapter { get; private set; }

	public int Timelineid { get; private set; }

	public List<int> RewardId { get; private set; }

	public List<int> RewardType { get; private set; }

	public List<int> RewardQuantity { get; private set; }

	public int GetReward { get; private set; }

	public int LevelMapProgress { get; private set; }

	public int LevelMapId { get; private set; }

	public List<List<float>> TaskPosition { get; private set; }

	public List<float> TaskRadius { get; private set; }

	public int ParallelTaskType { get; private set; }

	public int CavernId { get; private set; }

	public List<int> CavernPoint { get; private set; }

	public int TaskExtra { get; private set; }

	public string TaskExtraRes { get; private set; }

	public List<int> ConflictTaskId { get; private set; }

	public int ClientTrigger { get; private set; }

	public List<List<float>> UIPosition { get; private set; }

	public List<float> UIRadius { get; private set; }

	public bool DailyOpen { get; private set; }

	public override bool ParseDataRow(string dataRowString, object userData)
	{
		string[] array = dataRowString.Split(DataTableExtension.DataSplitSeparators);
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = array[i].Trim(DataTableExtension.DataTrimSeparators);
		}
		int num = 0;
		num++;
		m_Id = int.Parse(array[num++]);
		TaskName = array[num++];
		CopyOpen = int.Parse(array[num++]);
		TaskType = int.Parse(array[num++]);
		TaskDesc = array[num++];
		TaskTitle = array[num++];
		TaskTitleID = int.Parse(array[num++]);
		TargetDesc = array[num++];
		TaskTargetType = int.Parse(array[num++]);
		TargetIdList = DataTableExtension.ParseListInt(array[num++]);
		TargetValue = int.Parse(array[num++]);
		TargetLevelId = int.Parse(array[num++]);
		ChildTaskList = DataTableExtension.ParseListInt(array[num++]);
		ChildTaskType = int.Parse(array[num++]);
		ParentTask = int.Parse(array[num++]);
		CheckTasks = DataTableExtension.ParseListInt(array[num++]);
		MapDataAssetPath = array[num++];
		MapDataUsedAreaIds = DataTableExtension.ParseListInt(array[num++]);
		MapDataLevel = int.Parse(array[num++]);
		NextTask = DataTableExtension.ParseListInt(array[num++]);
		PreviousCondition = DataTableExtension.ParseListInt(array[num++]);
		PreviousParams = DataTableExtension.ParseListInt(array[num++]);
		PreviousDesc = array[num++];
		Priority = int.Parse(array[num++]);
		TimeLock = int.Parse(array[num++]);
		DailyTaskLevel = int.Parse(array[num++]);
		Questaccept = bool.Parse(array[num++]);
		Questfinish = bool.Parse(array[num++]);
		Chapterstart = bool.Parse(array[num++]);
		Chapterend = bool.Parse(array[num++]);
		SpaceChapter = bool.Parse(array[num++]);
		Timelineid = int.Parse(array[num++]);
		RewardId = DataTableExtension.ParseListInt(array[num++]);
		RewardType = DataTableExtension.ParseListInt(array[num++]);
		RewardQuantity = DataTableExtension.ParseListInt(array[num++]);
		GetReward = int.Parse(array[num++]);
		LevelMapProgress = int.Parse(array[num++]);
		LevelMapId = int.Parse(array[num++]);
		TaskPosition = DataTableExtension.ParseListFloatList(array[num++]);
		TaskRadius = DataTableExtension.ParseListFloat(array[num++]);
		ParallelTaskType = int.Parse(array[num++]);
		CavernId = int.Parse(array[num++]);
		CavernPoint = DataTableExtension.ParseListInt(array[num++]);
		TaskExtra = int.Parse(array[num++]);
		TaskExtraRes = array[num++];
		ConflictTaskId = DataTableExtension.ParseListInt(array[num++]);
		ClientTrigger = int.Parse(array[num++]);
		UIPosition = DataTableExtension.ParseListFloatList(array[num++]);
		UIRadius = DataTableExtension.ParseListFloat(array[num++]);
		DailyOpen = bool.Parse(array[num++]);
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream memoryStream = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			byte[] array = AesXorEncryption.DecryptAllData(memoryStream.ToArray());
			using MemoryStream input = new MemoryStream(array, 0, array.Length, writable: false);
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			TaskName = binaryReader.ReadString();
			CopyOpen = binaryReader.Read7BitEncodedInt32();
			TaskType = binaryReader.Read7BitEncodedInt32();
			TaskDesc = binaryReader.ReadString();
			TaskTitle = binaryReader.ReadString();
			TaskTitleID = binaryReader.Read7BitEncodedInt32();
			TargetDesc = binaryReader.ReadString();
			TaskTargetType = binaryReader.Read7BitEncodedInt32();
			TargetIdList = binaryReader.ReadListInt();
			TargetValue = binaryReader.Read7BitEncodedInt32();
			TargetLevelId = binaryReader.Read7BitEncodedInt32();
			ChildTaskList = binaryReader.ReadListInt();
			ChildTaskType = binaryReader.Read7BitEncodedInt32();
			ParentTask = binaryReader.Read7BitEncodedInt32();
			CheckTasks = binaryReader.ReadListInt();
			MapDataAssetPath = binaryReader.ReadString();
			MapDataUsedAreaIds = binaryReader.ReadListInt();
			MapDataLevel = binaryReader.Read7BitEncodedInt32();
			NextTask = binaryReader.ReadListInt();
			PreviousCondition = binaryReader.ReadListInt();
			PreviousParams = binaryReader.ReadListInt();
			PreviousDesc = binaryReader.ReadString();
			Priority = binaryReader.Read7BitEncodedInt32();
			TimeLock = binaryReader.Read7BitEncodedInt32();
			DailyTaskLevel = binaryReader.Read7BitEncodedInt32();
			Questaccept = binaryReader.ReadBoolean();
			Questfinish = binaryReader.ReadBoolean();
			Chapterstart = binaryReader.ReadBoolean();
			Chapterend = binaryReader.ReadBoolean();
			SpaceChapter = binaryReader.ReadBoolean();
			Timelineid = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.ReadListInt();
			RewardType = binaryReader.ReadListInt();
			RewardQuantity = binaryReader.ReadListInt();
			GetReward = binaryReader.Read7BitEncodedInt32();
			LevelMapProgress = binaryReader.Read7BitEncodedInt32();
			LevelMapId = binaryReader.Read7BitEncodedInt32();
			TaskPosition = binaryReader.ReadListFloatList();
			TaskRadius = binaryReader.ReadListFloat();
			ParallelTaskType = binaryReader.Read7BitEncodedInt32();
			CavernId = binaryReader.Read7BitEncodedInt32();
			CavernPoint = binaryReader.ReadListInt();
			TaskExtra = binaryReader.Read7BitEncodedInt32();
			TaskExtraRes = binaryReader.ReadString();
			ConflictTaskId = binaryReader.ReadListInt();
			ClientTrigger = binaryReader.Read7BitEncodedInt32();
			UIPosition = binaryReader.ReadListFloatList();
			UIRadius = binaryReader.ReadListFloat();
			DailyOpen = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

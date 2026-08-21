using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCopy : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public bool IsBoss { get; private set; }

	public bool IsMulti { get; private set; }

	public bool IsRepeat { get; private set; }

	public bool IsNeedFirst { get; private set; }

	public int CopyBuff { get; private set; }

	public int CopyType { get; private set; }

	public int TeamSet { get; private set; }

	public string ActivityMapData { get; private set; }

	public string SceneName { get; private set; }

	public int NavMeshId { get; private set; }

	public string MapData { get; private set; }

	public List<int> BossId { get; private set; }

	public List<int> BossType { get; private set; }

	public List<int> Wave { get; private set; }

	public string BossIcon { get; private set; }

	public List<int> Buff { get; private set; }

	public int CopyRank { get; private set; }

	public string CopyRankName { get; private set; }

	public string DepthsIcon { get; private set; }

	public int DepthsBuff { get; private set; }

	public int DepthsBuffType { get; private set; }

	public bool IsHighDifficulty { get; private set; }

	public int AdvLevel { get; private set; }

	public int Open { get; private set; }

	public int TaskCompleted { get; private set; }

	public int MatchTeamLevel { get; private set; }

	public int CostType { get; private set; }

	public int CostId { get; private set; }

	public int CostNum { get; private set; }

	public int UseEnergy { get; private set; }

	public int PermitLvNeed { get; private set; }

	public int Drops { get; private set; }

	public bool RankRecord { get; private set; }

	public int RankRecordUI { get; private set; }

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
		Name = array[num++];
		Desc = array[num++];
		IsBoss = bool.Parse(array[num++]);
		IsMulti = bool.Parse(array[num++]);
		IsRepeat = bool.Parse(array[num++]);
		IsNeedFirst = bool.Parse(array[num++]);
		CopyBuff = int.Parse(array[num++]);
		CopyType = int.Parse(array[num++]);
		TeamSet = int.Parse(array[num++]);
		ActivityMapData = array[num++];
		SceneName = array[num++];
		NavMeshId = int.Parse(array[num++]);
		MapData = array[num++];
		BossId = DataTableExtension.ParseListInt(array[num++]);
		BossType = DataTableExtension.ParseListInt(array[num++]);
		Wave = DataTableExtension.ParseListInt(array[num++]);
		BossIcon = array[num++];
		Buff = DataTableExtension.ParseListInt(array[num++]);
		CopyRank = int.Parse(array[num++]);
		CopyRankName = array[num++];
		DepthsIcon = array[num++];
		DepthsBuff = int.Parse(array[num++]);
		DepthsBuffType = int.Parse(array[num++]);
		IsHighDifficulty = bool.Parse(array[num++]);
		AdvLevel = int.Parse(array[num++]);
		Open = int.Parse(array[num++]);
		TaskCompleted = int.Parse(array[num++]);
		MatchTeamLevel = int.Parse(array[num++]);
		CostType = int.Parse(array[num++]);
		CostId = int.Parse(array[num++]);
		CostNum = int.Parse(array[num++]);
		UseEnergy = int.Parse(array[num++]);
		PermitLvNeed = int.Parse(array[num++]);
		Drops = int.Parse(array[num++]);
		RankRecord = bool.Parse(array[num++]);
		RankRecordUI = int.Parse(array[num++]);
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
			Name = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			IsBoss = binaryReader.ReadBoolean();
			IsMulti = binaryReader.ReadBoolean();
			IsRepeat = binaryReader.ReadBoolean();
			IsNeedFirst = binaryReader.ReadBoolean();
			CopyBuff = binaryReader.Read7BitEncodedInt32();
			CopyType = binaryReader.Read7BitEncodedInt32();
			TeamSet = binaryReader.Read7BitEncodedInt32();
			ActivityMapData = binaryReader.ReadString();
			SceneName = binaryReader.ReadString();
			NavMeshId = binaryReader.Read7BitEncodedInt32();
			MapData = binaryReader.ReadString();
			BossId = binaryReader.ReadListInt();
			BossType = binaryReader.ReadListInt();
			Wave = binaryReader.ReadListInt();
			BossIcon = binaryReader.ReadString();
			Buff = binaryReader.ReadListInt();
			CopyRank = binaryReader.Read7BitEncodedInt32();
			CopyRankName = binaryReader.ReadString();
			DepthsIcon = binaryReader.ReadString();
			DepthsBuff = binaryReader.Read7BitEncodedInt32();
			DepthsBuffType = binaryReader.Read7BitEncodedInt32();
			IsHighDifficulty = binaryReader.ReadBoolean();
			AdvLevel = binaryReader.Read7BitEncodedInt32();
			Open = binaryReader.Read7BitEncodedInt32();
			TaskCompleted = binaryReader.Read7BitEncodedInt32();
			MatchTeamLevel = binaryReader.Read7BitEncodedInt32();
			CostType = binaryReader.Read7BitEncodedInt32();
			CostId = binaryReader.Read7BitEncodedInt32();
			CostNum = binaryReader.Read7BitEncodedInt32();
			UseEnergy = binaryReader.Read7BitEncodedInt32();
			PermitLvNeed = binaryReader.Read7BitEncodedInt32();
			Drops = binaryReader.Read7BitEncodedInt32();
			RankRecord = binaryReader.ReadBoolean();
			RankRecordUI = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

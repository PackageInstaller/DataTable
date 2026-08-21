using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRAchievementMedal : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public List<int> SettlementcheckPamIndex { get; private set; }

	public BattleObserverEventEnum BattleObserverEventEnum { get; private set; }

	public List<int> Condition { get; private set; }

	public List<int> Target { get; private set; }

	public List<List<int>> BattleTarget { get; private set; }

	public List<int> CompareFlag { get; private set; }

	public int Value { get; private set; }

	public int Flag { get; private set; }

	public List<int> Rewards { get; private set; }

	public List<int> RewardsType { get; private set; }

	public List<int> RewardsNum { get; private set; }

	public int MedalType { get; private set; }

	public int MedalId { get; private set; }

	public int Rank { get; private set; }

	public int Rarity { get; private set; }

	public int AchievementType { get; private set; }

	public string MedalIcon { get; private set; }

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
		SettlementcheckPamIndex = DataTableExtension.ParseListInt(array[num++]);
		BattleObserverEventEnum = DataTableExtension.ParseEnum<BattleObserverEventEnum>(array[num++]);
		Condition = DataTableExtension.ParseListInt(array[num++]);
		Target = DataTableExtension.ParseListInt(array[num++]);
		BattleTarget = DataTableExtension.ParseListIntList(array[num++]);
		CompareFlag = DataTableExtension.ParseListInt(array[num++]);
		Value = int.Parse(array[num++]);
		Flag = int.Parse(array[num++]);
		Rewards = DataTableExtension.ParseListInt(array[num++]);
		RewardsType = DataTableExtension.ParseListInt(array[num++]);
		RewardsNum = DataTableExtension.ParseListInt(array[num++]);
		MedalType = int.Parse(array[num++]);
		MedalId = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		Rarity = int.Parse(array[num++]);
		AchievementType = int.Parse(array[num++]);
		MedalIcon = array[num++];
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
			SettlementcheckPamIndex = binaryReader.ReadListInt();
			BattleObserverEventEnum = binaryReader.ReadEnum<BattleObserverEventEnum>();
			Condition = binaryReader.ReadListInt();
			Target = binaryReader.ReadListInt();
			BattleTarget = binaryReader.ReadListIntList();
			CompareFlag = binaryReader.ReadListInt();
			Value = binaryReader.Read7BitEncodedInt32();
			Flag = binaryReader.Read7BitEncodedInt32();
			Rewards = binaryReader.ReadListInt();
			RewardsType = binaryReader.ReadListInt();
			RewardsNum = binaryReader.ReadListInt();
			MedalType = binaryReader.Read7BitEncodedInt32();
			MedalId = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			Rarity = binaryReader.Read7BitEncodedInt32();
			AchievementType = binaryReader.Read7BitEncodedInt32();
			MedalIcon = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

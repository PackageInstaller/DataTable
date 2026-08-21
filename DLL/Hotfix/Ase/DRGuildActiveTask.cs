using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuildActiveTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TaskType { get; private set; }

	public int TaskQuality { get; private set; }

	public int TargetType { get; private set; }

	public int Condition { get; private set; }

	public int RequireId { get; private set; }

	public int TargetValue { get; private set; }

	public string TaskDesc { get; private set; }

	public List<int> RewardType { get; private set; }

	public List<int> RewardId { get; private set; }

	public List<int> RewardNum { get; private set; }

	public int Enable { get; private set; }

	public int ActiveReward { get; private set; }

	public int UnionActiveReward { get; private set; }

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
		TaskType = int.Parse(array[num++]);
		TaskQuality = int.Parse(array[num++]);
		TargetType = int.Parse(array[num++]);
		Condition = int.Parse(array[num++]);
		RequireId = int.Parse(array[num++]);
		TargetValue = int.Parse(array[num++]);
		TaskDesc = array[num++];
		RewardType = DataTableExtension.ParseListInt(array[num++]);
		RewardId = DataTableExtension.ParseListInt(array[num++]);
		RewardNum = DataTableExtension.ParseListInt(array[num++]);
		Enable = int.Parse(array[num++]);
		ActiveReward = int.Parse(array[num++]);
		UnionActiveReward = int.Parse(array[num++]);
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
			TaskType = binaryReader.Read7BitEncodedInt32();
			TaskQuality = binaryReader.Read7BitEncodedInt32();
			TargetType = binaryReader.Read7BitEncodedInt32();
			Condition = binaryReader.Read7BitEncodedInt32();
			RequireId = binaryReader.Read7BitEncodedInt32();
			TargetValue = binaryReader.Read7BitEncodedInt32();
			TaskDesc = binaryReader.ReadString();
			RewardType = binaryReader.ReadListInt();
			RewardId = binaryReader.ReadListInt();
			RewardNum = binaryReader.ReadListInt();
			Enable = binaryReader.Read7BitEncodedInt32();
			ActiveReward = binaryReader.Read7BitEncodedInt32();
			UnionActiveReward = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

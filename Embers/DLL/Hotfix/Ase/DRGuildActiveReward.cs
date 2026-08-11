using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGuildActiveReward : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActiveLev { get; private set; }

	public int ActiveReward { get; private set; }

	public List<int> RewardTypes { get; private set; }

	public List<int> RewardIds { get; private set; }

	public List<int> RewardNums { get; private set; }

	public int UnionFundReward { get; private set; }

	public string RewardIcon { get; private set; }

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
		ActiveLev = int.Parse(array[num++]);
		ActiveReward = int.Parse(array[num++]);
		RewardTypes = DataTableExtension.ParseListInt(array[num++]);
		RewardIds = DataTableExtension.ParseListInt(array[num++]);
		RewardNums = DataTableExtension.ParseListInt(array[num++]);
		UnionFundReward = int.Parse(array[num++]);
		RewardIcon = array[num++];
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
			ActiveLev = binaryReader.Read7BitEncodedInt32();
			ActiveReward = binaryReader.Read7BitEncodedInt32();
			RewardTypes = binaryReader.ReadListInt();
			RewardIds = binaryReader.ReadListInt();
			RewardNums = binaryReader.ReadListInt();
			UnionFundReward = binaryReader.Read7BitEncodedInt32();
			RewardIcon = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

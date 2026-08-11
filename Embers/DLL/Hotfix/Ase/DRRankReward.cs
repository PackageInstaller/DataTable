using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRankReward : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int RankId { get; private set; }

	public List<int> Range { get; private set; }

	public List<int> RewardType { get; private set; }

	public List<int> RewardId { get; private set; }

	public List<int> RewardNum { get; private set; }

	public int HeroRankTitle { get; private set; }

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
		RankId = int.Parse(array[num++]);
		Range = DataTableExtension.ParseListInt(array[num++]);
		RewardType = DataTableExtension.ParseListInt(array[num++]);
		RewardId = DataTableExtension.ParseListInt(array[num++]);
		RewardNum = DataTableExtension.ParseListInt(array[num++]);
		HeroRankTitle = int.Parse(array[num++]);
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
			RankId = binaryReader.Read7BitEncodedInt32();
			Range = binaryReader.ReadListInt();
			RewardType = binaryReader.ReadListInt();
			RewardId = binaryReader.ReadListInt();
			RewardNum = binaryReader.ReadListInt();
			HeroRankTitle = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

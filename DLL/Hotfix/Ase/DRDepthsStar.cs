using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDepthsStar : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Zone { get; private set; }

	public int Index { get; private set; }

	public int StarNum { get; private set; }

	public List<int> StarReward { get; private set; }

	public List<int> StarRewardType { get; private set; }

	public List<int> StarRewardNum { get; private set; }

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
		Zone = int.Parse(array[num++]);
		Index = int.Parse(array[num++]);
		StarNum = int.Parse(array[num++]);
		StarReward = DataTableExtension.ParseListInt(array[num++]);
		StarRewardType = DataTableExtension.ParseListInt(array[num++]);
		StarRewardNum = DataTableExtension.ParseListInt(array[num++]);
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
			Zone = binaryReader.Read7BitEncodedInt32();
			Index = binaryReader.Read7BitEncodedInt32();
			StarNum = binaryReader.Read7BitEncodedInt32();
			StarReward = binaryReader.ReadListInt();
			StarRewardType = binaryReader.ReadListInt();
			StarRewardNum = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

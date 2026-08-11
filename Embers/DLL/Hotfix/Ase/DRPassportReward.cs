using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPassportReward : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Grade { get; private set; }

	public int Level { get; private set; }

	public int PointNeed { get; private set; }

	public List<int> RewardType { get; private set; }

	public List<int> RewardID { get; private set; }

	public List<int> RewardNum { get; private set; }

	public bool RarityBool { get; private set; }

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
		Grade = int.Parse(array[num++]);
		Level = int.Parse(array[num++]);
		PointNeed = int.Parse(array[num++]);
		RewardType = DataTableExtension.ParseListInt(array[num++]);
		RewardID = DataTableExtension.ParseListInt(array[num++]);
		RewardNum = DataTableExtension.ParseListInt(array[num++]);
		RarityBool = bool.Parse(array[num++]);
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
			Grade = binaryReader.Read7BitEncodedInt32();
			Level = binaryReader.Read7BitEncodedInt32();
			PointNeed = binaryReader.Read7BitEncodedInt32();
			RewardType = binaryReader.ReadListInt();
			RewardID = binaryReader.ReadListInt();
			RewardNum = binaryReader.ReadListInt();
			RarityBool = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTowerTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string TaskDesc { get; private set; }

	public int TaskType { get; private set; }

	public int TargetType { get; private set; }

	public int RequireId { get; private set; }

	public int RequireValue { get; private set; }

	public List<int> RateShowFlag { get; private set; }

	public int Sort { get; private set; }

	public int RewardId { get; private set; }

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
		TaskDesc = array[num++];
		TaskType = int.Parse(array[num++]);
		TargetType = int.Parse(array[num++]);
		RequireId = int.Parse(array[num++]);
		RequireValue = int.Parse(array[num++]);
		RateShowFlag = DataTableExtension.ParseListInt(array[num++]);
		Sort = int.Parse(array[num++]);
		RewardId = int.Parse(array[num++]);
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
			TaskDesc = binaryReader.ReadString();
			TaskType = binaryReader.Read7BitEncodedInt32();
			TargetType = binaryReader.Read7BitEncodedInt32();
			RequireId = binaryReader.Read7BitEncodedInt32();
			RequireValue = binaryReader.Read7BitEncodedInt32();
			RateShowFlag = binaryReader.ReadListInt();
			Sort = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

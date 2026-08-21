using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActivityTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TaskType { get; private set; }

	public int CounterType { get; private set; }

	public int TargetType { get; private set; }

	public List<int> RequireId { get; private set; }

	public List<int> RequireValue { get; private set; }

	public List<int> RateShowFlag { get; private set; }

	public string TargetDesc { get; private set; }

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
		CounterType = int.Parse(array[num++]);
		TargetType = int.Parse(array[num++]);
		RequireId = DataTableExtension.ParseListInt(array[num++]);
		RequireValue = DataTableExtension.ParseListInt(array[num++]);
		RateShowFlag = DataTableExtension.ParseListInt(array[num++]);
		TargetDesc = array[num++];
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
			CounterType = binaryReader.Read7BitEncodedInt32();
			TargetType = binaryReader.Read7BitEncodedInt32();
			RequireId = binaryReader.ReadListInt();
			RequireValue = binaryReader.ReadListInt();
			RateShowFlag = binaryReader.ReadListInt();
			TargetDesc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

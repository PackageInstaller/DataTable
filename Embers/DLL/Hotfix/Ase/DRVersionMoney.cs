using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRVersionMoney : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityId { get; private set; }

	public int PropId { get; private set; }

	public int PropType { get; private set; }

	public int ShowType { get; private set; }

	public int Limit { get; private set; }

	public int Time { get; private set; }

	public List<int> ViewPath { get; private set; }

	public int Shop { get; private set; }

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
		ActivityId = int.Parse(array[num++]);
		PropId = int.Parse(array[num++]);
		PropType = int.Parse(array[num++]);
		ShowType = int.Parse(array[num++]);
		Limit = int.Parse(array[num++]);
		Time = int.Parse(array[num++]);
		ViewPath = DataTableExtension.ParseListInt(array[num++]);
		Shop = int.Parse(array[num++]);
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
			ActivityId = binaryReader.Read7BitEncodedInt32();
			PropId = binaryReader.Read7BitEncodedInt32();
			PropType = binaryReader.Read7BitEncodedInt32();
			ShowType = binaryReader.Read7BitEncodedInt32();
			Limit = binaryReader.Read7BitEncodedInt32();
			Time = binaryReader.Read7BitEncodedInt32();
			ViewPath = binaryReader.ReadListInt();
			Shop = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

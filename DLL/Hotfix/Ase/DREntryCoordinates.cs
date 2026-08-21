using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREntryCoordinates : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int EntryId { get; private set; }

	public int Level { get; private set; }

	public int EntryID { get; private set; }

	public int EntryType { get; private set; }

	public List<int> EntryKey { get; private set; }

	public List<float> EntryValue { get; private set; }

	public int EntryColor { get; private set; }

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
		EntryId = int.Parse(array[num++]);
		Level = int.Parse(array[num++]);
		EntryID = int.Parse(array[num++]);
		EntryType = int.Parse(array[num++]);
		EntryKey = DataTableExtension.ParseListInt(array[num++]);
		EntryValue = DataTableExtension.ParseListFloat(array[num++]);
		EntryColor = int.Parse(array[num++]);
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
			EntryId = binaryReader.Read7BitEncodedInt32();
			Level = binaryReader.Read7BitEncodedInt32();
			EntryID = binaryReader.Read7BitEncodedInt32();
			EntryType = binaryReader.Read7BitEncodedInt32();
			EntryKey = binaryReader.ReadListInt();
			EntryValue = binaryReader.ReadListFloat();
			EntryColor = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

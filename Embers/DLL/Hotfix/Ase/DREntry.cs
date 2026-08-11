using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREntry : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public string DetailDesc { get; private set; }

	public int EntryId { get; private set; }

	public int Level { get; private set; }

	public int EntryID { get; private set; }

	public int EntryType { get; private set; }

	public List<int> EntryKey { get; private set; }

	public List<float> EntryValue { get; private set; }

	public int EntryColor { get; private set; }

	public int SpecialEntry { get; private set; }

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
		DetailDesc = array[num++];
		EntryId = int.Parse(array[num++]);
		Level = int.Parse(array[num++]);
		EntryID = int.Parse(array[num++]);
		EntryType = int.Parse(array[num++]);
		EntryKey = DataTableExtension.ParseListInt(array[num++]);
		EntryValue = DataTableExtension.ParseListFloat(array[num++]);
		EntryColor = int.Parse(array[num++]);
		SpecialEntry = int.Parse(array[num++]);
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
			DetailDesc = binaryReader.ReadString();
			EntryId = binaryReader.Read7BitEncodedInt32();
			Level = binaryReader.Read7BitEncodedInt32();
			EntryID = binaryReader.Read7BitEncodedInt32();
			EntryType = binaryReader.Read7BitEncodedInt32();
			EntryKey = binaryReader.ReadListInt();
			EntryValue = binaryReader.ReadListFloat();
			EntryColor = binaryReader.Read7BitEncodedInt32();
			SpecialEntry = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

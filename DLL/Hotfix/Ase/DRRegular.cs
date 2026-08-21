using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRegular : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Attribute { get; private set; }

	public int Lv { get; private set; }

	public int Rank { get; private set; }

	public List<int> EntryId { get; private set; }

	public List<int> EntryLv { get; private set; }

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
		Attribute = int.Parse(array[num++]);
		Lv = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		EntryId = DataTableExtension.ParseListInt(array[num++]);
		EntryLv = DataTableExtension.ParseListInt(array[num++]);
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream input = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			Attribute = binaryReader.Read7BitEncodedInt32();
			Lv = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			EntryId = binaryReader.ReadListInt();
			EntryLv = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

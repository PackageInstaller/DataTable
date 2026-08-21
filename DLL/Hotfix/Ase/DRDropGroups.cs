using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDropGroups : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int GroupId { get; private set; }

	public List<int> ChildrenSetId { get; private set; }

	public List<int> ChildrenSetIdMin { get; private set; }

	public List<int> ChildrenSetIdMax { get; private set; }

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
		GroupId = int.Parse(array[num++]);
		ChildrenSetId = DataTableExtension.ParseListInt(array[num++]);
		ChildrenSetIdMin = DataTableExtension.ParseListInt(array[num++]);
		ChildrenSetIdMax = DataTableExtension.ParseListInt(array[num++]);
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
			GroupId = binaryReader.Read7BitEncodedInt32();
			ChildrenSetId = binaryReader.ReadListInt();
			ChildrenSetIdMin = binaryReader.ReadListInt();
			ChildrenSetIdMax = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

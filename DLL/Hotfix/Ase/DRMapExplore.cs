using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMapExplore : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int MapId { get; private set; }

	public int ExplorationType { get; private set; }

	public List<int> ItemTypeId { get; private set; }

	public List<int> Num { get; private set; }

	public List<int> Weight { get; private set; }

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
		MapId = int.Parse(array[num++]);
		ExplorationType = int.Parse(array[num++]);
		ItemTypeId = DataTableExtension.ParseListInt(array[num++]);
		Num = DataTableExtension.ParseListInt(array[num++]);
		Weight = DataTableExtension.ParseListInt(array[num++]);
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
			MapId = binaryReader.Read7BitEncodedInt32();
			ExplorationType = binaryReader.Read7BitEncodedInt32();
			ItemTypeId = binaryReader.ReadListInt();
			Num = binaryReader.ReadListInt();
			Weight = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSuitboxEntryStore : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int StoreId { get; private set; }

	public int EntryId { get; private set; }

	public int EntryLv { get; private set; }

	public int EntryRate { get; private set; }

	public int MaxLv { get; private set; }

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
		StoreId = int.Parse(array[num++]);
		EntryId = int.Parse(array[num++]);
		EntryLv = int.Parse(array[num++]);
		EntryRate = int.Parse(array[num++]);
		MaxLv = int.Parse(array[num++]);
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
			StoreId = binaryReader.Read7BitEncodedInt32();
			EntryId = binaryReader.Read7BitEncodedInt32();
			EntryLv = binaryReader.Read7BitEncodedInt32();
			EntryRate = binaryReader.Read7BitEncodedInt32();
			MaxLv = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

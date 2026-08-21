using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCharm : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int Rarity { get; private set; }

	public int Rank { get; private set; }

	public int AttributeNum { get; private set; }

	public List<int> AttributeType { get; private set; }

	public List<int> AttributeValue { get; private set; }

	public int EntryNum { get; private set; }

	public int EntryStore { get; private set; }

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
		Rarity = int.Parse(array[num++]);
		Rank = int.Parse(array[num++]);
		AttributeNum = int.Parse(array[num++]);
		AttributeType = DataTableExtension.ParseListInt(array[num++]);
		AttributeValue = DataTableExtension.ParseListInt(array[num++]);
		EntryNum = int.Parse(array[num++]);
		EntryStore = int.Parse(array[num++]);
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
			Rarity = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.Read7BitEncodedInt32();
			AttributeNum = binaryReader.Read7BitEncodedInt32();
			AttributeType = binaryReader.ReadListInt();
			AttributeValue = binaryReader.ReadListInt();
			EntryNum = binaryReader.Read7BitEncodedInt32();
			EntryStore = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

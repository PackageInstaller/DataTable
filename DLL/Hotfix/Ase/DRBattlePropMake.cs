using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBattlePropMake : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TeamId { get; private set; }

	public int Level { get; private set; }

	public string Name { get; private set; }

	public List<int> Item { get; private set; }

	public List<int> Num { get; private set; }

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
		TeamId = int.Parse(array[num++]);
		Level = int.Parse(array[num++]);
		Name = array[num++];
		Item = DataTableExtension.ParseListInt(array[num++]);
		Num = DataTableExtension.ParseListInt(array[num++]);
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
			TeamId = binaryReader.Read7BitEncodedInt32();
			Level = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			Item = binaryReader.ReadListInt();
			Num = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

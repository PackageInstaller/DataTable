using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCGNote : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string PrePath { get; private set; }

	public string CGForMale { get; private set; }

	public string CGForFemale { get; private set; }

	public string Desc { get; private set; }

	public int Type { get; private set; }

	public int Chapter { get; private set; }

	public int OpenNum { get; private set; }

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
		PrePath = array[num++];
		CGForMale = array[num++];
		CGForFemale = array[num++];
		Desc = array[num++];
		Type = int.Parse(array[num++]);
		Chapter = int.Parse(array[num++]);
		OpenNum = int.Parse(array[num++]);
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
			PrePath = binaryReader.ReadString();
			CGForMale = binaryReader.ReadString();
			CGForFemale = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			Type = binaryReader.Read7BitEncodedInt32();
			Chapter = binaryReader.Read7BitEncodedInt32();
			OpenNum = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

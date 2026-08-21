using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRManual : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Index { get; private set; }

	public int Type { get; private set; }

	public string Name { get; private set; }

	public List<string> PageName { get; private set; }

	public List<string> Img { get; private set; }

	public List<string> Desc { get; private set; }

	public int Release { get; private set; }

	public int ReleaseConfig { get; private set; }

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
		Index = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		Name = array[num++];
		PageName = DataTableExtension.ParseListString(array[num++]);
		Img = DataTableExtension.ParseListString(array[num++]);
		Desc = DataTableExtension.ParseListString(array[num++]);
		Release = int.Parse(array[num++]);
		ReleaseConfig = int.Parse(array[num++]);
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
			Index = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			Name = binaryReader.ReadString();
			PageName = binaryReader.ReadListString();
			Img = binaryReader.ReadListString();
			Desc = binaryReader.ReadListString();
			Release = binaryReader.Read7BitEncodedInt32();
			ReleaseConfig = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

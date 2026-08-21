using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRSkinMessage : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Message { get; private set; }

	public List<int> ListID { get; private set; }

	public List<string> ListName { get; private set; }

	public List<string> Prefab { get; private set; }

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
		Message = array[num++];
		ListID = DataTableExtension.ParseListInt(array[num++]);
		ListName = DataTableExtension.ParseListString(array[num++]);
		Prefab = DataTableExtension.ParseListString(array[num++]);
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
			Message = binaryReader.ReadString();
			ListID = binaryReader.ReadListInt();
			ListName = binaryReader.ReadListString();
			Prefab = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

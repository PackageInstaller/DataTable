using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDialogChain : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<List<int>> PrologueList { get; private set; }

	public int NoButtonResult { get; private set; }

	public List<List<int>> ButtonGroupList { get; private set; }

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
		PrologueList = DataTableExtension.ParseListIntList(array[num++]);
		NoButtonResult = int.Parse(array[num++]);
		ButtonGroupList = DataTableExtension.ParseListIntList(array[num++]);
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
			PrologueList = binaryReader.ReadListIntList();
			NoButtonResult = binaryReader.Read7BitEncodedInt32();
			ButtonGroupList = binaryReader.ReadListIntList();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

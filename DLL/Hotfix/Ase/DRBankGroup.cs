using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBankGroup : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int GroupType { get; private set; }

	public List<string> Banks { get; private set; }

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
		GroupType = int.Parse(array[num++]);
		Banks = DataTableExtension.ParseListString(array[num++]);
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
			GroupType = binaryReader.Read7BitEncodedInt32();
			Banks = binaryReader.ReadListString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

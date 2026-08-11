using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRDrawCardDrop : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> UpGoldId { get; private set; }

	public List<int> UpGoldType { get; private set; }

	public List<int> UpPurpleId { get; private set; }

	public List<int> UpPurpleType { get; private set; }

	public int Guarantee { get; private set; }

	public int BigGuarantee { get; private set; }

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
		UpGoldId = DataTableExtension.ParseListInt(array[num++]);
		UpGoldType = DataTableExtension.ParseListInt(array[num++]);
		UpPurpleId = DataTableExtension.ParseListInt(array[num++]);
		UpPurpleType = DataTableExtension.ParseListInt(array[num++]);
		Guarantee = int.Parse(array[num++]);
		BigGuarantee = int.Parse(array[num++]);
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
			UpGoldId = binaryReader.ReadListInt();
			UpGoldType = binaryReader.ReadListInt();
			UpPurpleId = binaryReader.ReadListInt();
			UpPurpleType = binaryReader.ReadListInt();
			Guarantee = binaryReader.Read7BitEncodedInt32();
			BigGuarantee = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

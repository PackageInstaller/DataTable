using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCavernPoint : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CavernlId { get; private set; }

	public string CavernName { get; private set; }

	public List<float> CavernIn { get; private set; }

	public List<float> CavernOut { get; private set; }

	public int ActiveState { get; private set; }

	public List<List<float>> CavernPosition { get; private set; }

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
		CavernlId = int.Parse(array[num++]);
		CavernName = array[num++];
		CavernIn = DataTableExtension.ParseListFloat(array[num++]);
		CavernOut = DataTableExtension.ParseListFloat(array[num++]);
		ActiveState = int.Parse(array[num++]);
		CavernPosition = DataTableExtension.ParseListFloatList(array[num++]);
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
			CavernlId = binaryReader.Read7BitEncodedInt32();
			CavernName = binaryReader.ReadString();
			CavernIn = binaryReader.ReadListFloat();
			CavernOut = binaryReader.ReadListFloat();
			ActiveState = binaryReader.Read7BitEncodedInt32();
			CavernPosition = binaryReader.ReadListFloatList();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

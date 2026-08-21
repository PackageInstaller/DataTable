using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRandomMonster : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<List<int>> MonsterGroup { get; private set; }

	public List<List<int>> MonsterRandomWeight { get; private set; }

	public List<List<int>> MonsterReduceWeight { get; private set; }

	public List<int> GroupRamdomWeight { get; private set; }

	public List<int> GroupReduceWeight { get; private set; }

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
		MonsterGroup = DataTableExtension.ParseListIntList(array[num++]);
		MonsterRandomWeight = DataTableExtension.ParseListIntList(array[num++]);
		MonsterReduceWeight = DataTableExtension.ParseListIntList(array[num++]);
		GroupRamdomWeight = DataTableExtension.ParseListInt(array[num++]);
		GroupReduceWeight = DataTableExtension.ParseListInt(array[num++]);
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
			MonsterGroup = binaryReader.ReadListIntList();
			MonsterRandomWeight = binaryReader.ReadListIntList();
			MonsterReduceWeight = binaryReader.ReadListIntList();
			GroupRamdomWeight = binaryReader.ReadListInt();
			GroupReduceWeight = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

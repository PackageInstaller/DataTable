using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMonsterDrops : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int MonsterId { get; private set; }

	public List<int> Rank { get; private set; }

	public List<int> GroupId { get; private set; }

	public int ChapterLevel { get; private set; }

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
		MonsterId = int.Parse(array[num++]);
		Rank = DataTableExtension.ParseListInt(array[num++]);
		GroupId = DataTableExtension.ParseListInt(array[num++]);
		ChapterLevel = int.Parse(array[num++]);
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
			MonsterId = binaryReader.Read7BitEncodedInt32();
			Rank = binaryReader.ReadListInt();
			GroupId = binaryReader.ReadListInt();
			ChapterLevel = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRChallengeCopy : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityId { get; private set; }

	public int RefreshType { get; private set; }

	public List<int> RefreshConfig { get; private set; }

	public List<int> Buff { get; private set; }

	public List<int> BuffType { get; private set; }

	public int TaskId { get; private set; }

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
		ActivityId = int.Parse(array[num++]);
		RefreshType = int.Parse(array[num++]);
		RefreshConfig = DataTableExtension.ParseListInt(array[num++]);
		Buff = DataTableExtension.ParseListInt(array[num++]);
		BuffType = DataTableExtension.ParseListInt(array[num++]);
		TaskId = int.Parse(array[num++]);
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
			ActivityId = binaryReader.Read7BitEncodedInt32();
			RefreshType = binaryReader.Read7BitEncodedInt32();
			RefreshConfig = binaryReader.ReadListInt();
			Buff = binaryReader.ReadListInt();
			BuffType = binaryReader.ReadListInt();
			TaskId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMapItemPreloadConfig : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int MapItemId { get; private set; }

	public int LevelId { get; private set; }

	public int CopyId { get; private set; }

	public int LevelMaxNumber { get; private set; }

	public int CopyMaxNumber { get; private set; }

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
		MapItemId = int.Parse(array[num++]);
		LevelId = int.Parse(array[num++]);
		CopyId = int.Parse(array[num++]);
		LevelMaxNumber = int.Parse(array[num++]);
		CopyMaxNumber = int.Parse(array[num++]);
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
			MapItemId = binaryReader.Read7BitEncodedInt32();
			LevelId = binaryReader.Read7BitEncodedInt32();
			CopyId = binaryReader.Read7BitEncodedInt32();
			LevelMaxNumber = binaryReader.Read7BitEncodedInt32();
			CopyMaxNumber = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

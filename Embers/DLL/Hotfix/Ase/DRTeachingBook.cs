using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRTeachingBook : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int LevelType { get; private set; }

	public string HeroImg { get; private set; }

	public int TeachingId { get; private set; }

	public int Open { get; private set; }

	public int OpenConfig { get; private set; }

	public string Desc { get; private set; }

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
		LevelType = int.Parse(array[num++]);
		HeroImg = array[num++];
		TeachingId = int.Parse(array[num++]);
		Open = int.Parse(array[num++]);
		OpenConfig = int.Parse(array[num++]);
		Desc = array[num++];
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
			LevelType = binaryReader.Read7BitEncodedInt32();
			HeroImg = binaryReader.ReadString();
			TeachingId = binaryReader.Read7BitEncodedInt32();
			Open = binaryReader.Read7BitEncodedInt32();
			OpenConfig = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

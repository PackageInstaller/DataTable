using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMatchConfig : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CopyId { get; private set; }

	public int Difficulty { get; private set; }

	public int StarInitial { get; private set; }

	public int CopyType { get; private set; }

	public int MatchType { get; private set; }

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
		CopyId = int.Parse(array[num++]);
		Difficulty = int.Parse(array[num++]);
		StarInitial = int.Parse(array[num++]);
		CopyType = int.Parse(array[num++]);
		MatchType = int.Parse(array[num++]);
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
			CopyId = binaryReader.Read7BitEncodedInt32();
			Difficulty = binaryReader.Read7BitEncodedInt32();
			StarInitial = binaryReader.Read7BitEncodedInt32();
			CopyType = binaryReader.Read7BitEncodedInt32();
			MatchType = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

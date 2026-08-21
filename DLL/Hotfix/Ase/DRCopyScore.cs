using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCopyScore : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CopyType { get; private set; }

	public int CopyRank { get; private set; }

	public int KillScore { get; private set; }

	public int TimeScore { get; private set; }

	public int SecDeduction { get; private set; }

	public float Times { get; private set; }

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
		CopyType = int.Parse(array[num++]);
		CopyRank = int.Parse(array[num++]);
		KillScore = int.Parse(array[num++]);
		TimeScore = int.Parse(array[num++]);
		SecDeduction = int.Parse(array[num++]);
		Times = float.Parse(array[num++]);
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
			CopyType = binaryReader.Read7BitEncodedInt32();
			CopyRank = binaryReader.Read7BitEncodedInt32();
			KillScore = binaryReader.Read7BitEncodedInt32();
			TimeScore = binaryReader.Read7BitEncodedInt32();
			SecDeduction = binaryReader.Read7BitEncodedInt32();
			Times = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

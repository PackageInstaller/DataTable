using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRank : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string RankName { get; private set; }

	public int RankType { get; private set; }

	public int RankTarget { get; private set; }

	public bool NoSubDisplay { get; private set; }

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
		RankName = array[num++];
		RankType = int.Parse(array[num++]);
		RankTarget = int.Parse(array[num++]);
		NoSubDisplay = bool.Parse(array[num++]);
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
			RankName = binaryReader.ReadString();
			RankType = binaryReader.Read7BitEncodedInt32();
			RankTarget = binaryReader.Read7BitEncodedInt32();
			NoSubDisplay = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

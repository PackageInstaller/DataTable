using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRRankTime : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string StartTime { get; private set; }

	public string EndTime { get; private set; }

	public string OffTime { get; private set; }

	public int RankType { get; private set; }

	public int RacingNum { get; private set; }

	public int CopyTypeId { get; private set; }

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
		StartTime = array[num++];
		EndTime = array[num++];
		OffTime = array[num++];
		RankType = int.Parse(array[num++]);
		RacingNum = int.Parse(array[num++]);
		CopyTypeId = int.Parse(array[num++]);
		num++;
		GeneratePropertyArray();
		return true;
	}

	public override bool ParseDataRow(byte[] dataRowBytes, int startIndex, int length, object userData)
	{
		using (MemoryStream input = new MemoryStream(dataRowBytes, startIndex, length, writable: false))
		{
			using BinaryReader binaryReader = new BinaryReader(input, Encoding.UTF8);
			m_Id = binaryReader.Read7BitEncodedInt32();
			StartTime = binaryReader.ReadString();
			EndTime = binaryReader.ReadString();
			OffTime = binaryReader.ReadString();
			RankType = binaryReader.Read7BitEncodedInt32();
			RacingNum = binaryReader.Read7BitEncodedInt32();
			CopyTypeId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

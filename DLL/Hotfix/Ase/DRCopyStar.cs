using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCopyStar : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Rank { get; private set; }

	public int StarNum { get; private set; }

	public int StarRewardShow { get; private set; }

	public int StarRewardType { get; private set; }

	public int StarRewardNum { get; private set; }

	public int StarReward { get; private set; }

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
		Rank = int.Parse(array[num++]);
		StarNum = int.Parse(array[num++]);
		StarRewardShow = int.Parse(array[num++]);
		StarRewardType = int.Parse(array[num++]);
		StarRewardNum = int.Parse(array[num++]);
		StarReward = int.Parse(array[num++]);
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
			Rank = binaryReader.Read7BitEncodedInt32();
			StarNum = binaryReader.Read7BitEncodedInt32();
			StarRewardShow = binaryReader.Read7BitEncodedInt32();
			StarRewardType = binaryReader.Read7BitEncodedInt32();
			StarRewardNum = binaryReader.Read7BitEncodedInt32();
			StarReward = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

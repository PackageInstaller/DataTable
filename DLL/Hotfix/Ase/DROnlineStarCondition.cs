using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DROnlineStarCondition : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CopyId { get; private set; }

	public int Difficult { get; private set; }

	public int BossId { get; private set; }

	public int Star { get; private set; }

	public int StarCondition { get; private set; }

	public float StarConditionNum { get; private set; }

	public int StarReward { get; private set; }

	public int JudgingCondition { get; private set; }

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
		Difficult = int.Parse(array[num++]);
		BossId = int.Parse(array[num++]);
		Star = int.Parse(array[num++]);
		StarCondition = int.Parse(array[num++]);
		StarConditionNum = float.Parse(array[num++]);
		StarReward = int.Parse(array[num++]);
		JudgingCondition = int.Parse(array[num++]);
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
			CopyId = binaryReader.Read7BitEncodedInt32();
			Difficult = binaryReader.Read7BitEncodedInt32();
			BossId = binaryReader.Read7BitEncodedInt32();
			Star = binaryReader.Read7BitEncodedInt32();
			StarCondition = binaryReader.Read7BitEncodedInt32();
			StarConditionNum = binaryReader.ReadSingle();
			StarReward = binaryReader.Read7BitEncodedInt32();
			JudgingCondition = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

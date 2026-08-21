using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRScoreReward : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ScoreTaskType { get; private set; }

	public int Index { get; private set; }

	public int ScoreTaskTarget { get; private set; }

	public int ScoreTaskNum { get; private set; }

	public List<int> ScoreReward { get; private set; }

	public List<int> ScoreRewardType { get; private set; }

	public List<int> ScoreRewardNum { get; private set; }

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
		ScoreTaskType = int.Parse(array[num++]);
		Index = int.Parse(array[num++]);
		ScoreTaskTarget = int.Parse(array[num++]);
		ScoreTaskNum = int.Parse(array[num++]);
		ScoreReward = DataTableExtension.ParseListInt(array[num++]);
		ScoreRewardType = DataTableExtension.ParseListInt(array[num++]);
		ScoreRewardNum = DataTableExtension.ParseListInt(array[num++]);
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
			ScoreTaskType = binaryReader.Read7BitEncodedInt32();
			Index = binaryReader.Read7BitEncodedInt32();
			ScoreTaskTarget = binaryReader.Read7BitEncodedInt32();
			ScoreTaskNum = binaryReader.Read7BitEncodedInt32();
			ScoreReward = binaryReader.ReadListInt();
			ScoreRewardType = binaryReader.ReadListInt();
			ScoreRewardNum = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

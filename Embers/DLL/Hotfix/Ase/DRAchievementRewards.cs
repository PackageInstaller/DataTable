using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRAchievementRewards : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Desc { get; private set; }

	public int Num { get; private set; }

	public int AchievementType { get; private set; }

	public int Rewards { get; private set; }

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
		Desc = array[num++];
		Num = int.Parse(array[num++]);
		AchievementType = int.Parse(array[num++]);
		Rewards = int.Parse(array[num++]);
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
			Desc = binaryReader.ReadString();
			Num = binaryReader.Read7BitEncodedInt32();
			AchievementType = binaryReader.Read7BitEncodedInt32();
			Rewards = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

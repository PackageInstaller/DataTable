using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRLibTask : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string TaskDesc { get; private set; }

	public int LibType { get; private set; }

	public int TargetType { get; private set; }

	public int RequireValue { get; private set; }

	public int RateShowFlag { get; private set; }

	public int Sort { get; private set; }

	public int RewardId { get; private set; }

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
		TaskDesc = array[num++];
		LibType = int.Parse(array[num++]);
		TargetType = int.Parse(array[num++]);
		RequireValue = int.Parse(array[num++]);
		RateShowFlag = int.Parse(array[num++]);
		Sort = int.Parse(array[num++]);
		RewardId = int.Parse(array[num++]);
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
			TaskDesc = binaryReader.ReadString();
			LibType = binaryReader.Read7BitEncodedInt32();
			TargetType = binaryReader.Read7BitEncodedInt32();
			RequireValue = binaryReader.Read7BitEncodedInt32();
			RateShowFlag = binaryReader.Read7BitEncodedInt32();
			Sort = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

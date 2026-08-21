using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActiveReward : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActiveType { get; private set; }

	public int ActiveLev { get; private set; }

	public int ActiveReward { get; private set; }

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
		ActiveType = int.Parse(array[num++]);
		ActiveLev = int.Parse(array[num++]);
		ActiveReward = int.Parse(array[num++]);
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
			ActiveType = binaryReader.Read7BitEncodedInt32();
			ActiveLev = binaryReader.Read7BitEncodedInt32();
			ActiveReward = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

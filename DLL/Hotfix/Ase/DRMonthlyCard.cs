using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMonthlyCard : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Price { get; private set; }

	public string UIPrice { get; private set; }

	public int BuyRewardID { get; private set; }

	public int BuyRewardNum { get; private set; }

	public int DailyRewardID { get; private set; }

	public int DailyRewardNum { get; private set; }

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
		Price = int.Parse(array[num++]);
		UIPrice = array[num++];
		BuyRewardID = int.Parse(array[num++]);
		BuyRewardNum = int.Parse(array[num++]);
		DailyRewardID = int.Parse(array[num++]);
		DailyRewardNum = int.Parse(array[num++]);
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
			Price = binaryReader.Read7BitEncodedInt32();
			UIPrice = binaryReader.ReadString();
			BuyRewardID = binaryReader.Read7BitEncodedInt32();
			BuyRewardNum = binaryReader.Read7BitEncodedInt32();
			DailyRewardID = binaryReader.Read7BitEncodedInt32();
			DailyRewardNum = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

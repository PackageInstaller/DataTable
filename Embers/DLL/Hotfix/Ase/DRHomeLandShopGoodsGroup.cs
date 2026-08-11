using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHomeLandShopGoodsGroup : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int SellGroup { get; private set; }

	public int ItemId { get; private set; }

	public int ItemType { get; private set; }

	public int Weight { get; private set; }

	public int EachCount { get; private set; }

	public int SelfBuyLimit { get; private set; }

	public int FriendBuyLimit { get; private set; }

	public int PriceType { get; private set; }

	public int Price { get; private set; }

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
		SellGroup = int.Parse(array[num++]);
		ItemId = int.Parse(array[num++]);
		ItemType = int.Parse(array[num++]);
		Weight = int.Parse(array[num++]);
		EachCount = int.Parse(array[num++]);
		SelfBuyLimit = int.Parse(array[num++]);
		FriendBuyLimit = int.Parse(array[num++]);
		PriceType = int.Parse(array[num++]);
		Price = int.Parse(array[num++]);
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
			SellGroup = binaryReader.Read7BitEncodedInt32();
			ItemId = binaryReader.Read7BitEncodedInt32();
			ItemType = binaryReader.Read7BitEncodedInt32();
			Weight = binaryReader.Read7BitEncodedInt32();
			EachCount = binaryReader.Read7BitEncodedInt32();
			SelfBuyLimit = binaryReader.Read7BitEncodedInt32();
			FriendBuyLimit = binaryReader.Read7BitEncodedInt32();
			PriceType = binaryReader.Read7BitEncodedInt32();
			Price = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

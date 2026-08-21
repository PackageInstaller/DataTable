using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRActivityPacksChain : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public int ActivityId { get; private set; }

	public int PackShopId { get; private set; }

	public bool SoldOneTime { get; private set; }

	public int PricePropType { get; private set; }

	public int PricePropId { get; private set; }

	public int CurPriceProp { get; private set; }

	public int OriPriceProp { get; private set; }

	public float CurPriceRMB { get; private set; }

	public float OriPriceRMB { get; private set; }

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
		Name = array[num++];
		Desc = array[num++];
		ActivityId = int.Parse(array[num++]);
		PackShopId = int.Parse(array[num++]);
		SoldOneTime = bool.Parse(array[num++]);
		PricePropType = int.Parse(array[num++]);
		PricePropId = int.Parse(array[num++]);
		CurPriceProp = int.Parse(array[num++]);
		OriPriceProp = int.Parse(array[num++]);
		CurPriceRMB = float.Parse(array[num++]);
		OriPriceRMB = float.Parse(array[num++]);
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
			Name = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			ActivityId = binaryReader.Read7BitEncodedInt32();
			PackShopId = binaryReader.Read7BitEncodedInt32();
			SoldOneTime = binaryReader.ReadBoolean();
			PricePropType = binaryReader.Read7BitEncodedInt32();
			PricePropId = binaryReader.Read7BitEncodedInt32();
			CurPriceProp = binaryReader.Read7BitEncodedInt32();
			OriPriceProp = binaryReader.Read7BitEncodedInt32();
			CurPriceRMB = binaryReader.ReadSingle();
			OriPriceRMB = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPacksChainInclude : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ActivityTypeId { get; private set; }

	public int ActivityPacksChainId { get; private set; }

	public int UnlockTaskId { get; private set; }

	public int Order { get; private set; }

	public int ActivityTaskId { get; private set; }

	public int RewardId { get; private set; }

	public int PackShopId { get; private set; }

	public int PricePropType { get; private set; }

	public int PricePropId { get; private set; }

	public int CurPriceProp { get; private set; }

	public int ActPriceProp { get; private set; }

	public float CurPriceRMB { get; private set; }

	public float ActPriceRMB { get; private set; }

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
		ActivityTypeId = int.Parse(array[num++]);
		ActivityPacksChainId = int.Parse(array[num++]);
		UnlockTaskId = int.Parse(array[num++]);
		Order = int.Parse(array[num++]);
		ActivityTaskId = int.Parse(array[num++]);
		RewardId = int.Parse(array[num++]);
		PackShopId = int.Parse(array[num++]);
		PricePropType = int.Parse(array[num++]);
		PricePropId = int.Parse(array[num++]);
		CurPriceProp = int.Parse(array[num++]);
		ActPriceProp = int.Parse(array[num++]);
		CurPriceRMB = float.Parse(array[num++]);
		ActPriceRMB = float.Parse(array[num++]);
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
			ActivityTypeId = binaryReader.Read7BitEncodedInt32();
			ActivityPacksChainId = binaryReader.Read7BitEncodedInt32();
			UnlockTaskId = binaryReader.Read7BitEncodedInt32();
			Order = binaryReader.Read7BitEncodedInt32();
			ActivityTaskId = binaryReader.Read7BitEncodedInt32();
			RewardId = binaryReader.Read7BitEncodedInt32();
			PackShopId = binaryReader.Read7BitEncodedInt32();
			PricePropType = binaryReader.Read7BitEncodedInt32();
			PricePropId = binaryReader.Read7BitEncodedInt32();
			CurPriceProp = binaryReader.Read7BitEncodedInt32();
			ActPriceProp = binaryReader.Read7BitEncodedInt32();
			CurPriceRMB = binaryReader.ReadSingle();
			ActPriceRMB = binaryReader.ReadSingle();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

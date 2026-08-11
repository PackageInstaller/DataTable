using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPay : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Price { get; private set; }

	public int Diamond { get; private set; }

	public int DiamondAdd { get; private set; }

	public int FirstDiamondAdd { get; private set; }

	public string Icon { get; private set; }

	public string PriceUI { get; private set; }

	public bool Show { get; private set; }

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
		Diamond = int.Parse(array[num++]);
		DiamondAdd = int.Parse(array[num++]);
		FirstDiamondAdd = int.Parse(array[num++]);
		Icon = array[num++];
		PriceUI = array[num++];
		Show = bool.Parse(array[num++]);
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
			Diamond = binaryReader.Read7BitEncodedInt32();
			DiamondAdd = binaryReader.Read7BitEncodedInt32();
			FirstDiamondAdd = binaryReader.Read7BitEncodedInt32();
			Icon = binaryReader.ReadString();
			PriceUI = binaryReader.ReadString();
			Show = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

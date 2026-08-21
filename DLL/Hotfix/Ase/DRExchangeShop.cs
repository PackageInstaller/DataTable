using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRExchangeShop : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ExchangeProp { get; private set; }

	public int Sort { get; private set; }

	public bool SoldOutShow { get; private set; }

	public int UnlockType { get; private set; }

	public int UnlockNum { get; private set; }

	public string CustomTagIcon { get; private set; }

	public string CustomTagText { get; private set; }

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
		ExchangeProp = int.Parse(array[num++]);
		Sort = int.Parse(array[num++]);
		SoldOutShow = bool.Parse(array[num++]);
		UnlockType = int.Parse(array[num++]);
		UnlockNum = int.Parse(array[num++]);
		CustomTagIcon = array[num++];
		CustomTagText = array[num++];
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
			ExchangeProp = binaryReader.Read7BitEncodedInt32();
			Sort = binaryReader.Read7BitEncodedInt32();
			SoldOutShow = binaryReader.ReadBoolean();
			UnlockType = binaryReader.Read7BitEncodedInt32();
			UnlockNum = binaryReader.Read7BitEncodedInt32();
			CustomTagIcon = binaryReader.ReadString();
			CustomTagText = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRMainShopList : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string ShopName { get; private set; }

	public string TabIcon { get; private set; }

	public string TabIconSelected { get; private set; }

	public string TabEnglish { get; private set; }

	public int ShopPosition { get; private set; }

	public int Sort { get; private set; }

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
		ShopName = array[num++];
		TabIcon = array[num++];
		TabIconSelected = array[num++];
		TabEnglish = array[num++];
		ShopPosition = int.Parse(array[num++]);
		Sort = int.Parse(array[num++]);
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
			ShopName = binaryReader.ReadString();
			TabIcon = binaryReader.ReadString();
			TabIconSelected = binaryReader.ReadString();
			TabEnglish = binaryReader.ReadString();
			ShopPosition = binaryReader.Read7BitEncodedInt32();
			Sort = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

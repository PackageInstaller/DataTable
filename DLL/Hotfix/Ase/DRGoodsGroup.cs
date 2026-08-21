using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRGoodsGroup : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int ChildSetId { get; private set; }

	public int GoodsId { get; private set; }

	public int Type { get; private set; }

	public int GoodsMin { get; private set; }

	public int GoodsMax { get; private set; }

	public int Weight { get; private set; }

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
		ChildSetId = int.Parse(array[num++]);
		GoodsId = int.Parse(array[num++]);
		Type = int.Parse(array[num++]);
		GoodsMin = int.Parse(array[num++]);
		GoodsMax = int.Parse(array[num++]);
		Weight = int.Parse(array[num++]);
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
			ChildSetId = binaryReader.Read7BitEncodedInt32();
			GoodsId = binaryReader.Read7BitEncodedInt32();
			Type = binaryReader.Read7BitEncodedInt32();
			GoodsMin = binaryReader.Read7BitEncodedInt32();
			GoodsMax = binaryReader.Read7BitEncodedInt32();
			Weight = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

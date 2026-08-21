using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCardByProduct : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int CardType { get; private set; }

	public int CardSetRarity { get; private set; }

	public List<int> FirstProductId { get; private set; }

	public List<int> FirstProductType { get; private set; }

	public List<int> FirstProductNum { get; private set; }

	public List<int> ByProductId { get; private set; }

	public List<int> ByProductType { get; private set; }

	public List<int> ByProductNum { get; private set; }

	public int ScoreCount { get; private set; }

	public int HeroSeatCount { get; private set; }

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
		CardType = int.Parse(array[num++]);
		CardSetRarity = int.Parse(array[num++]);
		FirstProductId = DataTableExtension.ParseListInt(array[num++]);
		FirstProductType = DataTableExtension.ParseListInt(array[num++]);
		FirstProductNum = DataTableExtension.ParseListInt(array[num++]);
		ByProductId = DataTableExtension.ParseListInt(array[num++]);
		ByProductType = DataTableExtension.ParseListInt(array[num++]);
		ByProductNum = DataTableExtension.ParseListInt(array[num++]);
		ScoreCount = int.Parse(array[num++]);
		HeroSeatCount = int.Parse(array[num++]);
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
			CardType = binaryReader.Read7BitEncodedInt32();
			CardSetRarity = binaryReader.Read7BitEncodedInt32();
			FirstProductId = binaryReader.ReadListInt();
			FirstProductType = binaryReader.ReadListInt();
			FirstProductNum = binaryReader.ReadListInt();
			ByProductId = binaryReader.ReadListInt();
			ByProductType = binaryReader.ReadListInt();
			ByProductNum = binaryReader.ReadListInt();
			ScoreCount = binaryReader.Read7BitEncodedInt32();
			HeroSeatCount = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

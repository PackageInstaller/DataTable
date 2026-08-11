using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroStar : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int TargetStar { get; private set; }

	public int NeedLv { get; private set; }

	public int AccountLv { get; private set; }

	public int HeroId { get; private set; }

	public List<int> NeedItem { get; private set; }

	public List<int> ItemNum { get; private set; }

	public int NeedGold { get; private set; }

	public List<int> ReturnItem { get; private set; }

	public List<int> ReturnItemNum { get; private set; }

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
		TargetStar = int.Parse(array[num++]);
		NeedLv = int.Parse(array[num++]);
		AccountLv = int.Parse(array[num++]);
		HeroId = int.Parse(array[num++]);
		NeedItem = DataTableExtension.ParseListInt(array[num++]);
		ItemNum = DataTableExtension.ParseListInt(array[num++]);
		NeedGold = int.Parse(array[num++]);
		ReturnItem = DataTableExtension.ParseListInt(array[num++]);
		ReturnItemNum = DataTableExtension.ParseListInt(array[num++]);
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
			TargetStar = binaryReader.Read7BitEncodedInt32();
			NeedLv = binaryReader.Read7BitEncodedInt32();
			AccountLv = binaryReader.Read7BitEncodedInt32();
			HeroId = binaryReader.Read7BitEncodedInt32();
			NeedItem = binaryReader.ReadListInt();
			ItemNum = binaryReader.ReadListInt();
			NeedGold = binaryReader.Read7BitEncodedInt32();
			ReturnItem = binaryReader.ReadListInt();
			ReturnItemNum = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

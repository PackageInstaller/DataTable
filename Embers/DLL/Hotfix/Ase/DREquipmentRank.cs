using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREquipmentRank : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int Rarity { get; private set; }

	public int TargetRank { get; private set; }

	public int PlayerLv { get; private set; }

	public int NeedLv { get; private set; }

	public int Rate { get; private set; }

	public List<float> RarityUpRate { get; private set; }

	public List<float> RankUpRate { get; private set; }

	public int NeedGlod { get; private set; }

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
		Rarity = int.Parse(array[num++]);
		TargetRank = int.Parse(array[num++]);
		PlayerLv = int.Parse(array[num++]);
		NeedLv = int.Parse(array[num++]);
		Rate = int.Parse(array[num++]);
		RarityUpRate = DataTableExtension.ParseListFloat(array[num++]);
		RankUpRate = DataTableExtension.ParseListFloat(array[num++]);
		NeedGlod = int.Parse(array[num++]);
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
			Rarity = binaryReader.Read7BitEncodedInt32();
			TargetRank = binaryReader.Read7BitEncodedInt32();
			PlayerLv = binaryReader.Read7BitEncodedInt32();
			NeedLv = binaryReader.Read7BitEncodedInt32();
			Rate = binaryReader.Read7BitEncodedInt32();
			RarityUpRate = binaryReader.ReadListFloat();
			RankUpRate = binaryReader.ReadListFloat();
			NeedGlod = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

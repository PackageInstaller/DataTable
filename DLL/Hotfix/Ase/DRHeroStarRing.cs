using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroStarRing : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroId { get; private set; }

	public int Layer { get; private set; }

	public int NeedStar { get; private set; }

	public List<int> NeedId { get; private set; }

	public List<int> NeedNum { get; private set; }

	public int NeedGold { get; private set; }

	public int StarRingType { get; private set; }

	public int EntryId { get; private set; }

	public int EntryLv { get; private set; }

	public int SkillId { get; private set; }

	public int SkillStartId { get; private set; }

	public int BuffId { get; private set; }

	public List<int> EffectAttribute { get; private set; }

	public List<float> AttributeNum { get; private set; }

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
		HeroId = int.Parse(array[num++]);
		Layer = int.Parse(array[num++]);
		NeedStar = int.Parse(array[num++]);
		NeedId = DataTableExtension.ParseListInt(array[num++]);
		NeedNum = DataTableExtension.ParseListInt(array[num++]);
		NeedGold = int.Parse(array[num++]);
		StarRingType = int.Parse(array[num++]);
		EntryId = int.Parse(array[num++]);
		EntryLv = int.Parse(array[num++]);
		SkillId = int.Parse(array[num++]);
		SkillStartId = int.Parse(array[num++]);
		BuffId = int.Parse(array[num++]);
		EffectAttribute = DataTableExtension.ParseListInt(array[num++]);
		AttributeNum = DataTableExtension.ParseListFloat(array[num++]);
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
			HeroId = binaryReader.Read7BitEncodedInt32();
			Layer = binaryReader.Read7BitEncodedInt32();
			NeedStar = binaryReader.Read7BitEncodedInt32();
			NeedId = binaryReader.ReadListInt();
			NeedNum = binaryReader.ReadListInt();
			NeedGold = binaryReader.Read7BitEncodedInt32();
			StarRingType = binaryReader.Read7BitEncodedInt32();
			EntryId = binaryReader.Read7BitEncodedInt32();
			EntryLv = binaryReader.Read7BitEncodedInt32();
			SkillId = binaryReader.Read7BitEncodedInt32();
			SkillStartId = binaryReader.Read7BitEncodedInt32();
			BuffId = binaryReader.Read7BitEncodedInt32();
			EffectAttribute = binaryReader.ReadListInt();
			AttributeNum = binaryReader.ReadListFloat();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

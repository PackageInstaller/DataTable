using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRPresetHeroData : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public int HeroId { get; private set; }

	public int HeroSkin { get; private set; }

	public int HeroStarLv { get; private set; }

	public int HeroLv { get; private set; }

	public int HerosoulLv { get; private set; }

	public int TalentBigLv { get; private set; }

	public List<int> TalentSmallLv { get; private set; }

	public int Weapon { get; private set; }

	public int WeaponLv { get; private set; }

	public int WeaponRefine { get; private set; }

	public List<int> Attribute { get; private set; }

	public List<float> AttributeNum { get; private set; }

	public List<int> Entry { get; private set; }

	public List<int> EntryLev { get; private set; }

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
		HeroSkin = int.Parse(array[num++]);
		HeroStarLv = int.Parse(array[num++]);
		HeroLv = int.Parse(array[num++]);
		HerosoulLv = int.Parse(array[num++]);
		TalentBigLv = int.Parse(array[num++]);
		TalentSmallLv = DataTableExtension.ParseListInt(array[num++]);
		Weapon = int.Parse(array[num++]);
		WeaponLv = int.Parse(array[num++]);
		WeaponRefine = int.Parse(array[num++]);
		Attribute = DataTableExtension.ParseListInt(array[num++]);
		AttributeNum = DataTableExtension.ParseListFloat(array[num++]);
		Entry = DataTableExtension.ParseListInt(array[num++]);
		EntryLev = DataTableExtension.ParseListInt(array[num++]);
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
			HeroSkin = binaryReader.Read7BitEncodedInt32();
			HeroStarLv = binaryReader.Read7BitEncodedInt32();
			HeroLv = binaryReader.Read7BitEncodedInt32();
			HerosoulLv = binaryReader.Read7BitEncodedInt32();
			TalentBigLv = binaryReader.Read7BitEncodedInt32();
			TalentSmallLv = binaryReader.ReadListInt();
			Weapon = binaryReader.Read7BitEncodedInt32();
			WeaponLv = binaryReader.Read7BitEncodedInt32();
			WeaponRefine = binaryReader.Read7BitEncodedInt32();
			Attribute = binaryReader.ReadListInt();
			AttributeNum = binaryReader.ReadListFloat();
			Entry = binaryReader.ReadListInt();
			EntryLev = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

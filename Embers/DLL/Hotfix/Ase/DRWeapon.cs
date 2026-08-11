using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRWeapon : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public WeaponEnum WeaponEnum { get; private set; }

	public string Icon { get; private set; }

	public List<string> Tag { get; private set; }

	public List<string> TagColor { get; private set; }

	public int Rarity { get; private set; }

	public int Stars { get; private set; }

	public int LvInit { get; private set; }

	public int LvMax { get; private set; }

	public int RefineMax { get; private set; }

	public int Strength { get; private set; }

	public List<int> Attribute { get; private set; }

	public List<int> AttributeBase { get; private set; }

	public List<List<int>> AttributeGrow { get; private set; }

	public List<List<int>> AddAttack { get; private set; }

	public List<int> EntryId { get; private set; }

	public List<int> EntryLevMin { get; private set; }

	public List<int> EntryLevUp { get; private set; }

	public string WeaponEffectName { get; private set; }

	public string WeaponEffectDesc { get; private set; }

	public List<List<int>> WeaponEffectId { get; private set; }

	public List<List<float>> EffectValue { get; private set; }

	public int DropId { get; private set; }

	public string Desc { get; private set; }

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
		Name = array[num++];
		WeaponEnum = DataTableExtension.ParseEnum<WeaponEnum>(array[num++]);
		Icon = array[num++];
		Tag = DataTableExtension.ParseListString(array[num++]);
		TagColor = DataTableExtension.ParseListString(array[num++]);
		Rarity = int.Parse(array[num++]);
		Stars = int.Parse(array[num++]);
		LvInit = int.Parse(array[num++]);
		LvMax = int.Parse(array[num++]);
		RefineMax = int.Parse(array[num++]);
		Strength = int.Parse(array[num++]);
		Attribute = DataTableExtension.ParseListInt(array[num++]);
		AttributeBase = DataTableExtension.ParseListInt(array[num++]);
		AttributeGrow = DataTableExtension.ParseListIntList(array[num++]);
		AddAttack = DataTableExtension.ParseListIntList(array[num++]);
		EntryId = DataTableExtension.ParseListInt(array[num++]);
		EntryLevMin = DataTableExtension.ParseListInt(array[num++]);
		EntryLevUp = DataTableExtension.ParseListInt(array[num++]);
		WeaponEffectName = array[num++];
		WeaponEffectDesc = array[num++];
		WeaponEffectId = DataTableExtension.ParseListIntList(array[num++]);
		EffectValue = DataTableExtension.ParseListFloatList(array[num++]);
		DropId = int.Parse(array[num++]);
		Desc = array[num++];
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
			Name = binaryReader.ReadString();
			WeaponEnum = binaryReader.ReadEnum<WeaponEnum>();
			Icon = binaryReader.ReadString();
			Tag = binaryReader.ReadListString();
			TagColor = binaryReader.ReadListString();
			Rarity = binaryReader.Read7BitEncodedInt32();
			Stars = binaryReader.Read7BitEncodedInt32();
			LvInit = binaryReader.Read7BitEncodedInt32();
			LvMax = binaryReader.Read7BitEncodedInt32();
			RefineMax = binaryReader.Read7BitEncodedInt32();
			Strength = binaryReader.Read7BitEncodedInt32();
			Attribute = binaryReader.ReadListInt();
			AttributeBase = binaryReader.ReadListInt();
			AttributeGrow = binaryReader.ReadListIntList();
			AddAttack = binaryReader.ReadListIntList();
			EntryId = binaryReader.ReadListInt();
			EntryLevMin = binaryReader.ReadListInt();
			EntryLevUp = binaryReader.ReadListInt();
			WeaponEffectName = binaryReader.ReadString();
			WeaponEffectDesc = binaryReader.ReadString();
			WeaponEffectId = binaryReader.ReadListIntList();
			EffectValue = binaryReader.ReadListFloatList();
			DropId = binaryReader.Read7BitEncodedInt32();
			Desc = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

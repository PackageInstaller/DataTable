using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DREquipment : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public int TypeId { get; private set; }

	public int Position { get; private set; }

	public ArmourEnum ArmourEnum { get; private set; }

	public string Icon { get; private set; }

	public int Rarity { get; private set; }

	public int RankMin { get; private set; }

	public int RankMax { get; private set; }

	public int LvInit { get; private set; }

	public int LvMax { get; private set; }

	public List<int> DefenseAttribute { get; private set; }

	public List<int> DefenseBase { get; private set; }

	public List<int> DefenseGrow { get; private set; }

	public List<List<int>> AttributeNum { get; private set; }

	public int AttributeMaxNum { get; private set; }

	public int AttributeStore { get; private set; }

	public int EntryNum { get; private set; }

	public int ExEntryStore { get; private set; }

	public int UnlockEntry { get; private set; }

	public int PreEntryNum { get; private set; }

	public List<int> Regular { get; private set; }

	public List<int> RegularLv { get; private set; }

	public int RefreshItem { get; private set; }

	public int RefreshNum { get; private set; }

	public int RefreshGold { get; private set; }

	public string EquipmentEffectName { get; private set; }

	public string EquipmentEffectDesc { get; private set; }

	public int EquipmentEffectId { get; private set; }

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
		TypeId = int.Parse(array[num++]);
		Position = int.Parse(array[num++]);
		ArmourEnum = DataTableExtension.ParseEnum<ArmourEnum>(array[num++]);
		Icon = array[num++];
		Rarity = int.Parse(array[num++]);
		RankMin = int.Parse(array[num++]);
		RankMax = int.Parse(array[num++]);
		LvInit = int.Parse(array[num++]);
		LvMax = int.Parse(array[num++]);
		DefenseAttribute = DataTableExtension.ParseListInt(array[num++]);
		DefenseBase = DataTableExtension.ParseListInt(array[num++]);
		DefenseGrow = DataTableExtension.ParseListInt(array[num++]);
		AttributeNum = DataTableExtension.ParseListIntList(array[num++]);
		AttributeMaxNum = int.Parse(array[num++]);
		AttributeStore = int.Parse(array[num++]);
		EntryNum = int.Parse(array[num++]);
		ExEntryStore = int.Parse(array[num++]);
		UnlockEntry = int.Parse(array[num++]);
		PreEntryNum = int.Parse(array[num++]);
		Regular = DataTableExtension.ParseListInt(array[num++]);
		RegularLv = DataTableExtension.ParseListInt(array[num++]);
		RefreshItem = int.Parse(array[num++]);
		RefreshNum = int.Parse(array[num++]);
		RefreshGold = int.Parse(array[num++]);
		EquipmentEffectName = array[num++];
		EquipmentEffectDesc = array[num++];
		EquipmentEffectId = int.Parse(array[num++]);
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
			TypeId = binaryReader.Read7BitEncodedInt32();
			Position = binaryReader.Read7BitEncodedInt32();
			ArmourEnum = binaryReader.ReadEnum<ArmourEnum>();
			Icon = binaryReader.ReadString();
			Rarity = binaryReader.Read7BitEncodedInt32();
			RankMin = binaryReader.Read7BitEncodedInt32();
			RankMax = binaryReader.Read7BitEncodedInt32();
			LvInit = binaryReader.Read7BitEncodedInt32();
			LvMax = binaryReader.Read7BitEncodedInt32();
			DefenseAttribute = binaryReader.ReadListInt();
			DefenseBase = binaryReader.ReadListInt();
			DefenseGrow = binaryReader.ReadListInt();
			AttributeNum = binaryReader.ReadListIntList();
			AttributeMaxNum = binaryReader.Read7BitEncodedInt32();
			AttributeStore = binaryReader.Read7BitEncodedInt32();
			EntryNum = binaryReader.Read7BitEncodedInt32();
			ExEntryStore = binaryReader.Read7BitEncodedInt32();
			UnlockEntry = binaryReader.Read7BitEncodedInt32();
			PreEntryNum = binaryReader.Read7BitEncodedInt32();
			Regular = binaryReader.ReadListInt();
			RegularLv = binaryReader.ReadListInt();
			RefreshItem = binaryReader.Read7BitEncodedInt32();
			RefreshNum = binaryReader.Read7BitEncodedInt32();
			RefreshGold = binaryReader.Read7BitEncodedInt32();
			EquipmentEffectName = binaryReader.ReadString();
			EquipmentEffectDesc = binaryReader.ReadString();
			EquipmentEffectId = binaryReader.Read7BitEncodedInt32();
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

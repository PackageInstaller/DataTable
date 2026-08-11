using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroInfo : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Name { get; private set; }

	public string Fgimage { get; private set; }

	public string Original { get; private set; }

	public int Rarity { get; private set; }

	public WeaponEnum WeaponEnum { get; private set; }

	public int InitialWeapon { get; private set; }

	public HeroAttributeEnum HeroAttributeEnum { get; private set; }

	public HeroLocationEnum HeroLocationEnum { get; private set; }

	public List<int> Label { get; private set; }

	public string Faction { get; private set; }

	public int Area { get; private set; }

	public string FactionIcon { get; private set; }

	public float BaseHP { get; private set; }

	public List<float> GrowHP { get; private set; }

	public float BaseDefense { get; private set; }

	public List<float> GrowDefense { get; private set; }

	public float BaseAttack { get; private set; }

	public List<float> GrowAttack { get; private set; }

	public List<float> AddAttack { get; private set; }

	public List<float> AddHp { get; private set; }

	public List<float> AddDefense { get; private set; }

	public float BaseEnergy { get; private set; }

	public float BaseEnergyRecovery { get; private set; }

	public string Birthday { get; private set; }

	public string Story { get; private set; }

	public int HeroSeat { get; private set; }

	public string Title { get; private set; }

	public string Painter { get; private set; }

	public int SkillCount { get; private set; }

	public List<string> Tag { get; private set; }

	public List<string> TagColor { get; private set; }

	public List<int> FavorGift { get; private set; }

	public List<int> ExTrust { get; private set; }

	public int RawSeat { get; private set; }

	public bool IsOpening { get; private set; }

	public int InitialHeroSkin { get; private set; }

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
		Fgimage = array[num++];
		Original = array[num++];
		Rarity = int.Parse(array[num++]);
		WeaponEnum = DataTableExtension.ParseEnum<WeaponEnum>(array[num++]);
		InitialWeapon = int.Parse(array[num++]);
		HeroAttributeEnum = DataTableExtension.ParseEnum<HeroAttributeEnum>(array[num++]);
		HeroLocationEnum = DataTableExtension.ParseEnum<HeroLocationEnum>(array[num++]);
		Label = DataTableExtension.ParseListInt(array[num++]);
		Faction = array[num++];
		Area = int.Parse(array[num++]);
		FactionIcon = array[num++];
		BaseHP = float.Parse(array[num++]);
		GrowHP = DataTableExtension.ParseListFloat(array[num++]);
		BaseDefense = float.Parse(array[num++]);
		GrowDefense = DataTableExtension.ParseListFloat(array[num++]);
		BaseAttack = float.Parse(array[num++]);
		GrowAttack = DataTableExtension.ParseListFloat(array[num++]);
		AddAttack = DataTableExtension.ParseListFloat(array[num++]);
		AddHp = DataTableExtension.ParseListFloat(array[num++]);
		AddDefense = DataTableExtension.ParseListFloat(array[num++]);
		BaseEnergy = float.Parse(array[num++]);
		BaseEnergyRecovery = float.Parse(array[num++]);
		Birthday = array[num++];
		Story = array[num++];
		HeroSeat = int.Parse(array[num++]);
		Title = array[num++];
		Painter = array[num++];
		SkillCount = int.Parse(array[num++]);
		Tag = DataTableExtension.ParseListString(array[num++]);
		TagColor = DataTableExtension.ParseListString(array[num++]);
		FavorGift = DataTableExtension.ParseListInt(array[num++]);
		ExTrust = DataTableExtension.ParseListInt(array[num++]);
		RawSeat = int.Parse(array[num++]);
		IsOpening = bool.Parse(array[num++]);
		InitialHeroSkin = int.Parse(array[num++]);
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
			Fgimage = binaryReader.ReadString();
			Original = binaryReader.ReadString();
			Rarity = binaryReader.Read7BitEncodedInt32();
			WeaponEnum = binaryReader.ReadEnum<WeaponEnum>();
			InitialWeapon = binaryReader.Read7BitEncodedInt32();
			HeroAttributeEnum = binaryReader.ReadEnum<HeroAttributeEnum>();
			HeroLocationEnum = binaryReader.ReadEnum<HeroLocationEnum>();
			Label = binaryReader.ReadListInt();
			Faction = binaryReader.ReadString();
			Area = binaryReader.Read7BitEncodedInt32();
			FactionIcon = binaryReader.ReadString();
			BaseHP = binaryReader.ReadSingle();
			GrowHP = binaryReader.ReadListFloat();
			BaseDefense = binaryReader.ReadSingle();
			GrowDefense = binaryReader.ReadListFloat();
			BaseAttack = binaryReader.ReadSingle();
			GrowAttack = binaryReader.ReadListFloat();
			AddAttack = binaryReader.ReadListFloat();
			AddHp = binaryReader.ReadListFloat();
			AddDefense = binaryReader.ReadListFloat();
			BaseEnergy = binaryReader.ReadSingle();
			BaseEnergyRecovery = binaryReader.ReadSingle();
			Birthday = binaryReader.ReadString();
			Story = binaryReader.ReadString();
			HeroSeat = binaryReader.Read7BitEncodedInt32();
			Title = binaryReader.ReadString();
			Painter = binaryReader.ReadString();
			SkillCount = binaryReader.Read7BitEncodedInt32();
			Tag = binaryReader.ReadListString();
			TagColor = binaryReader.ReadListString();
			FavorGift = binaryReader.ReadListInt();
			ExTrust = binaryReader.ReadListInt();
			RawSeat = binaryReader.Read7BitEncodedInt32();
			IsOpening = binaryReader.ReadBoolean();
			InitialHeroSkin = binaryReader.Read7BitEncodedInt32();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

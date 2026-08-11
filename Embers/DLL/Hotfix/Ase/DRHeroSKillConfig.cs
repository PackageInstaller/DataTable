using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHeroSKillConfig : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string Icon { get; private set; }

	public string Name { get; private set; }

	public string Desc { get; private set; }

	public int HeroId { get; private set; }

	public float CoolingTime { get; private set; }

	public List<string> SkillLabelTypeEnum { get; private set; }

	public bool IsChargeSkill { get; private set; }

	public bool IsChargeVisible { get; private set; }

	public int MaxChargeNumber { get; private set; }

	public float ChargeTime { get; private set; }

	public bool IsInitChargeSuccess { get; private set; }

	public bool IsCacheLayerSkill { get; private set; }

	public bool IsCacheLayerVisible { get; private set; }

	public int MaxCacheLayerNumber { get; private set; }

	public bool IsDeriveSkill { get; private set; }

	public float DeriveSkillWindowTime { get; private set; }

	public List<int> Buffs { get; private set; }

	public List<int> BreakStates { get; private set; }

	public int IndicatorType { get; private set; }

	public float SkillRange { get; private set; }

	public float SkillWidth { get; private set; }

	public float SkillAngle { get; private set; }

	public float SmallCircleLockRadius { get; private set; }

	public float LargeCircleLockRadius { get; private set; }

	public string ConsumeCondition { get; private set; }

	public string NecessaryCondition { get; private set; }

	public string NoNecessaryCondition { get; private set; }

	public string ButtonTag { get; private set; }

	public string SkillType { get; private set; }

	public bool IsPossessBuffCondition { get; private set; }

	public List<int> DefaultDeriveSkillId { get; private set; }

	public List<bool> HideDeriveDesc { get; private set; }

	public float BaseDamage { get; private set; }

	public float FixDamage { get; private set; }

	public float BaseTenacity { get; private set; }

	public float FixTenacity { get; private set; }

	public int SkillReleaseType { get; private set; }

	public float PropSkillTime { get; private set; }

	public bool IsPropSkill { get; private set; }

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
		Icon = array[num++];
		Name = array[num++];
		Desc = array[num++];
		HeroId = int.Parse(array[num++]);
		CoolingTime = float.Parse(array[num++]);
		SkillLabelTypeEnum = DataTableExtension.ParseListString(array[num++]);
		IsChargeSkill = bool.Parse(array[num++]);
		IsChargeVisible = bool.Parse(array[num++]);
		MaxChargeNumber = int.Parse(array[num++]);
		ChargeTime = float.Parse(array[num++]);
		IsInitChargeSuccess = bool.Parse(array[num++]);
		IsCacheLayerSkill = bool.Parse(array[num++]);
		IsCacheLayerVisible = bool.Parse(array[num++]);
		MaxCacheLayerNumber = int.Parse(array[num++]);
		IsDeriveSkill = bool.Parse(array[num++]);
		DeriveSkillWindowTime = float.Parse(array[num++]);
		Buffs = DataTableExtension.ParseListInt(array[num++]);
		BreakStates = DataTableExtension.ParseListInt(array[num++]);
		IndicatorType = int.Parse(array[num++]);
		SkillRange = float.Parse(array[num++]);
		SkillWidth = float.Parse(array[num++]);
		SkillAngle = float.Parse(array[num++]);
		SmallCircleLockRadius = float.Parse(array[num++]);
		LargeCircleLockRadius = float.Parse(array[num++]);
		ConsumeCondition = array[num++];
		NecessaryCondition = array[num++];
		NoNecessaryCondition = array[num++];
		ButtonTag = array[num++];
		SkillType = array[num++];
		IsPossessBuffCondition = bool.Parse(array[num++]);
		DefaultDeriveSkillId = DataTableExtension.ParseListInt(array[num++]);
		HideDeriveDesc = DataTableExtension.ParseListBool(array[num++]);
		BaseDamage = float.Parse(array[num++]);
		FixDamage = float.Parse(array[num++]);
		BaseTenacity = float.Parse(array[num++]);
		FixTenacity = float.Parse(array[num++]);
		SkillReleaseType = int.Parse(array[num++]);
		PropSkillTime = float.Parse(array[num++]);
		IsPropSkill = bool.Parse(array[num++]);
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
			Icon = binaryReader.ReadString();
			Name = binaryReader.ReadString();
			Desc = binaryReader.ReadString();
			HeroId = binaryReader.Read7BitEncodedInt32();
			CoolingTime = binaryReader.ReadSingle();
			SkillLabelTypeEnum = binaryReader.ReadListString();
			IsChargeSkill = binaryReader.ReadBoolean();
			IsChargeVisible = binaryReader.ReadBoolean();
			MaxChargeNumber = binaryReader.Read7BitEncodedInt32();
			ChargeTime = binaryReader.ReadSingle();
			IsInitChargeSuccess = binaryReader.ReadBoolean();
			IsCacheLayerSkill = binaryReader.ReadBoolean();
			IsCacheLayerVisible = binaryReader.ReadBoolean();
			MaxCacheLayerNumber = binaryReader.Read7BitEncodedInt32();
			IsDeriveSkill = binaryReader.ReadBoolean();
			DeriveSkillWindowTime = binaryReader.ReadSingle();
			Buffs = binaryReader.ReadListInt();
			BreakStates = binaryReader.ReadListInt();
			IndicatorType = binaryReader.Read7BitEncodedInt32();
			SkillRange = binaryReader.ReadSingle();
			SkillWidth = binaryReader.ReadSingle();
			SkillAngle = binaryReader.ReadSingle();
			SmallCircleLockRadius = binaryReader.ReadSingle();
			LargeCircleLockRadius = binaryReader.ReadSingle();
			ConsumeCondition = binaryReader.ReadString();
			NecessaryCondition = binaryReader.ReadString();
			NoNecessaryCondition = binaryReader.ReadString();
			ButtonTag = binaryReader.ReadString();
			SkillType = binaryReader.ReadString();
			IsPossessBuffCondition = binaryReader.ReadBoolean();
			DefaultDeriveSkillId = binaryReader.ReadListInt();
			HideDeriveDesc = binaryReader.ReadListBool();
			BaseDamage = binaryReader.ReadSingle();
			FixDamage = binaryReader.ReadSingle();
			BaseTenacity = binaryReader.ReadSingle();
			FixTenacity = binaryReader.ReadSingle();
			SkillReleaseType = binaryReader.Read7BitEncodedInt32();
			PropSkillTime = binaryReader.ReadSingle();
			IsPropSkill = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

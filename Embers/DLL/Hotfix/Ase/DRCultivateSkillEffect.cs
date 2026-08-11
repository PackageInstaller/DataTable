using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRCultivateSkillEffect : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string SkillEffectDesc { get; private set; }

	public List<int> DeriveSkillIdAdd { get; private set; }

	public List<int> DeriveSkillIdDec { get; private set; }

	public List<int> InfluenceSkillId { get; private set; }

	public float CoolingTime { get; private set; }

	public List<string> SkillLabelTypeAdd { get; private set; }

	public List<string> SkillLabelTypeDec { get; private set; }

	public int IsChargeSkill { get; private set; }

	public int IsChargeVisible { get; private set; }

	public int MaxChargeNumber { get; private set; }

	public float ChargeTime { get; private set; }

	public int IsInitChargeSuccess { get; private set; }

	public float DeriveSkillWindowTime { get; private set; }

	public int IsCacheLayerSkill { get; private set; }

	public int IsCacheLayerVisible { get; private set; }

	public int MaxCacheLayerNumber { get; private set; }

	public List<int> BreakStatesAdd { get; private set; }

	public List<int> BreakStatesDec { get; private set; }

	public int IndicatorType { get; private set; }

	public float SkillRange { get; private set; }

	public float SkillWidth { get; private set; }

	public float SkillAngle { get; private set; }

	public float LargeCircleLockRadius { get; private set; }

	public string ConsumeCondition { get; private set; }

	public string NecessaryCondition { get; private set; }

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
		SkillEffectDesc = array[num++];
		DeriveSkillIdAdd = DataTableExtension.ParseListInt(array[num++]);
		DeriveSkillIdDec = DataTableExtension.ParseListInt(array[num++]);
		InfluenceSkillId = DataTableExtension.ParseListInt(array[num++]);
		CoolingTime = float.Parse(array[num++]);
		SkillLabelTypeAdd = DataTableExtension.ParseListString(array[num++]);
		SkillLabelTypeDec = DataTableExtension.ParseListString(array[num++]);
		IsChargeSkill = int.Parse(array[num++]);
		IsChargeVisible = int.Parse(array[num++]);
		MaxChargeNumber = int.Parse(array[num++]);
		ChargeTime = float.Parse(array[num++]);
		IsInitChargeSuccess = int.Parse(array[num++]);
		DeriveSkillWindowTime = float.Parse(array[num++]);
		IsCacheLayerSkill = int.Parse(array[num++]);
		IsCacheLayerVisible = int.Parse(array[num++]);
		MaxCacheLayerNumber = int.Parse(array[num++]);
		BreakStatesAdd = DataTableExtension.ParseListInt(array[num++]);
		BreakStatesDec = DataTableExtension.ParseListInt(array[num++]);
		IndicatorType = int.Parse(array[num++]);
		SkillRange = float.Parse(array[num++]);
		SkillWidth = float.Parse(array[num++]);
		SkillAngle = float.Parse(array[num++]);
		LargeCircleLockRadius = float.Parse(array[num++]);
		ConsumeCondition = array[num++];
		NecessaryCondition = array[num++];
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
			SkillEffectDesc = binaryReader.ReadString();
			DeriveSkillIdAdd = binaryReader.ReadListInt();
			DeriveSkillIdDec = binaryReader.ReadListInt();
			InfluenceSkillId = binaryReader.ReadListInt();
			CoolingTime = binaryReader.ReadSingle();
			SkillLabelTypeAdd = binaryReader.ReadListString();
			SkillLabelTypeDec = binaryReader.ReadListString();
			IsChargeSkill = binaryReader.Read7BitEncodedInt32();
			IsChargeVisible = binaryReader.Read7BitEncodedInt32();
			MaxChargeNumber = binaryReader.Read7BitEncodedInt32();
			ChargeTime = binaryReader.ReadSingle();
			IsInitChargeSuccess = binaryReader.Read7BitEncodedInt32();
			DeriveSkillWindowTime = binaryReader.ReadSingle();
			IsCacheLayerSkill = binaryReader.Read7BitEncodedInt32();
			IsCacheLayerVisible = binaryReader.Read7BitEncodedInt32();
			MaxCacheLayerNumber = binaryReader.Read7BitEncodedInt32();
			BreakStatesAdd = binaryReader.ReadListInt();
			BreakStatesDec = binaryReader.ReadListInt();
			IndicatorType = binaryReader.Read7BitEncodedInt32();
			SkillRange = binaryReader.ReadSingle();
			SkillWidth = binaryReader.ReadSingle();
			SkillAngle = binaryReader.ReadSingle();
			LargeCircleLockRadius = binaryReader.ReadSingle();
			ConsumeCondition = binaryReader.ReadString();
			NecessaryCondition = binaryReader.ReadString();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRHero : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public string AssetPath { get; private set; }

	public string CastingPath { get; private set; }

	public int CollisionId { get; private set; }

	public int HitBoxId { get; private set; }

	public float Speed { get; private set; }

	public float TurnAroundSpeed { get; private set; }

	public float ChargeSpeed { get; private set; }

	public float InvincibleFrame { get; private set; }

	public int XpEnergyMax { get; private set; }

	public int HeroAngerMax { get; private set; }

	public float HeroAngerRatio { get; private set; }

	public float HeroAngerReduceTime { get; private set; }

	public int HeroAngerReduceSpeed { get; private set; }

	public float DamageConvertVirtualHpScale { get; private set; }

	public float VirtualHpReduceTime { get; private set; }

	public float VirtualHpReduceSpeed { get; private set; }

	public float ParryReduceEnergySpeed { get; private set; }

	public float DefenseConsume { get; private set; }

	public int HeroEnergyMax { get; private set; }

	public int EnergyCellValue { get; private set; }

	public float EnergyRecovery { get; private set; }

	public int BulletNumberMax { get; private set; }

	public List<int> KeennessLevel { get; private set; }

	public List<float> KeennessReduceTime { get; private set; }

	public List<int> KeennessReduceValue { get; private set; }

	public List<float> KeennessProtectTime { get; private set; }

	public List<List<int>> KeennessBuff { get; private set; }

	public List<float> AwakenParams { get; private set; }

	public List<float> AwakenCumulativeParams { get; private set; }

	public List<float> GunInit { get; private set; }

	public List<float> HammerInit { get; private set; }

	public List<float> LanceInit { get; private set; }

	public int AIParadoxId { get; private set; }

	public int BallisticsCategory { get; private set; }

	public int DeadStateId { get; private set; }

	public int RebornStateId { get; private set; }

	public int NearDeathStateId { get; private set; }

	public float SpCharge { get; private set; }

	public int EatApple { get; private set; }

	public float DodgeDistanceScale { get; private set; }

	public float NormalAttackEnergyAmend { get; private set; }

	public float WeaknessEnergyAmend { get; private set; }

	public float NormalTenacityAmend { get; private set; }

	public List<float> EneryUIOffset { get; private set; }

	public List<float> ChargeUIOffset { get; private set; }

	public string IndependentResData { get; private set; }

	public int IndependentResType { get; private set; }

	public List<int> SummonedID { get; private set; }

	public List<int> SummonedMaxNumber { get; private set; }

	public List<int> BankGroups { get; private set; }

	public List<int> IndicatorGroup { get; private set; }

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
		AssetPath = array[num++];
		CastingPath = array[num++];
		CollisionId = int.Parse(array[num++]);
		HitBoxId = int.Parse(array[num++]);
		Speed = float.Parse(array[num++]);
		TurnAroundSpeed = float.Parse(array[num++]);
		ChargeSpeed = float.Parse(array[num++]);
		InvincibleFrame = float.Parse(array[num++]);
		XpEnergyMax = int.Parse(array[num++]);
		HeroAngerMax = int.Parse(array[num++]);
		HeroAngerRatio = float.Parse(array[num++]);
		HeroAngerReduceTime = float.Parse(array[num++]);
		HeroAngerReduceSpeed = int.Parse(array[num++]);
		DamageConvertVirtualHpScale = float.Parse(array[num++]);
		VirtualHpReduceTime = float.Parse(array[num++]);
		VirtualHpReduceSpeed = float.Parse(array[num++]);
		ParryReduceEnergySpeed = float.Parse(array[num++]);
		DefenseConsume = float.Parse(array[num++]);
		HeroEnergyMax = int.Parse(array[num++]);
		EnergyCellValue = int.Parse(array[num++]);
		EnergyRecovery = float.Parse(array[num++]);
		BulletNumberMax = int.Parse(array[num++]);
		KeennessLevel = DataTableExtension.ParseListInt(array[num++]);
		KeennessReduceTime = DataTableExtension.ParseListFloat(array[num++]);
		KeennessReduceValue = DataTableExtension.ParseListInt(array[num++]);
		KeennessProtectTime = DataTableExtension.ParseListFloat(array[num++]);
		KeennessBuff = DataTableExtension.ParseListIntList(array[num++]);
		AwakenParams = DataTableExtension.ParseListFloat(array[num++]);
		AwakenCumulativeParams = DataTableExtension.ParseListFloat(array[num++]);
		GunInit = DataTableExtension.ParseListFloat(array[num++]);
		HammerInit = DataTableExtension.ParseListFloat(array[num++]);
		LanceInit = DataTableExtension.ParseListFloat(array[num++]);
		AIParadoxId = int.Parse(array[num++]);
		BallisticsCategory = int.Parse(array[num++]);
		DeadStateId = int.Parse(array[num++]);
		RebornStateId = int.Parse(array[num++]);
		NearDeathStateId = int.Parse(array[num++]);
		SpCharge = float.Parse(array[num++]);
		EatApple = int.Parse(array[num++]);
		DodgeDistanceScale = float.Parse(array[num++]);
		NormalAttackEnergyAmend = float.Parse(array[num++]);
		WeaknessEnergyAmend = float.Parse(array[num++]);
		NormalTenacityAmend = float.Parse(array[num++]);
		EneryUIOffset = DataTableExtension.ParseListFloat(array[num++]);
		ChargeUIOffset = DataTableExtension.ParseListFloat(array[num++]);
		IndependentResData = array[num++];
		IndependentResType = int.Parse(array[num++]);
		SummonedID = DataTableExtension.ParseListInt(array[num++]);
		SummonedMaxNumber = DataTableExtension.ParseListInt(array[num++]);
		BankGroups = DataTableExtension.ParseListInt(array[num++]);
		IndicatorGroup = DataTableExtension.ParseListInt(array[num++]);
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
			AssetPath = binaryReader.ReadString();
			CastingPath = binaryReader.ReadString();
			CollisionId = binaryReader.Read7BitEncodedInt32();
			HitBoxId = binaryReader.Read7BitEncodedInt32();
			Speed = binaryReader.ReadSingle();
			TurnAroundSpeed = binaryReader.ReadSingle();
			ChargeSpeed = binaryReader.ReadSingle();
			InvincibleFrame = binaryReader.ReadSingle();
			XpEnergyMax = binaryReader.Read7BitEncodedInt32();
			HeroAngerMax = binaryReader.Read7BitEncodedInt32();
			HeroAngerRatio = binaryReader.ReadSingle();
			HeroAngerReduceTime = binaryReader.ReadSingle();
			HeroAngerReduceSpeed = binaryReader.Read7BitEncodedInt32();
			DamageConvertVirtualHpScale = binaryReader.ReadSingle();
			VirtualHpReduceTime = binaryReader.ReadSingle();
			VirtualHpReduceSpeed = binaryReader.ReadSingle();
			ParryReduceEnergySpeed = binaryReader.ReadSingle();
			DefenseConsume = binaryReader.ReadSingle();
			HeroEnergyMax = binaryReader.Read7BitEncodedInt32();
			EnergyCellValue = binaryReader.Read7BitEncodedInt32();
			EnergyRecovery = binaryReader.ReadSingle();
			BulletNumberMax = binaryReader.Read7BitEncodedInt32();
			KeennessLevel = binaryReader.ReadListInt();
			KeennessReduceTime = binaryReader.ReadListFloat();
			KeennessReduceValue = binaryReader.ReadListInt();
			KeennessProtectTime = binaryReader.ReadListFloat();
			KeennessBuff = binaryReader.ReadListIntList();
			AwakenParams = binaryReader.ReadListFloat();
			AwakenCumulativeParams = binaryReader.ReadListFloat();
			GunInit = binaryReader.ReadListFloat();
			HammerInit = binaryReader.ReadListFloat();
			LanceInit = binaryReader.ReadListFloat();
			AIParadoxId = binaryReader.Read7BitEncodedInt32();
			BallisticsCategory = binaryReader.Read7BitEncodedInt32();
			DeadStateId = binaryReader.Read7BitEncodedInt32();
			RebornStateId = binaryReader.Read7BitEncodedInt32();
			NearDeathStateId = binaryReader.Read7BitEncodedInt32();
			SpCharge = binaryReader.ReadSingle();
			EatApple = binaryReader.Read7BitEncodedInt32();
			DodgeDistanceScale = binaryReader.ReadSingle();
			NormalAttackEnergyAmend = binaryReader.ReadSingle();
			WeaknessEnergyAmend = binaryReader.ReadSingle();
			NormalTenacityAmend = binaryReader.ReadSingle();
			EneryUIOffset = binaryReader.ReadListFloat();
			ChargeUIOffset = binaryReader.ReadListFloat();
			IndependentResData = binaryReader.ReadString();
			IndependentResType = binaryReader.Read7BitEncodedInt32();
			SummonedID = binaryReader.ReadListInt();
			SummonedMaxNumber = binaryReader.ReadListInt();
			BankGroups = binaryReader.ReadListInt();
			IndicatorGroup = binaryReader.ReadListInt();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

using System.Collections.Generic;
using System.IO;
using System.Text;
using GameFramework.Runtime;

namespace Ase;

public class DRBullet : DataRowBase
{
	private int m_Id;

	public override int Id => m_Id;

	public List<int> RelationType { get; private set; }

	public bool IsMelee { get; private set; }

	public int SkillId { get; private set; }

	public List<string> BulletLabel { get; private set; }

	public BulletRangeTypeEnum BulletRangeTypeEnum { get; private set; }

	public PrimitiveEnum PrimitiveEnum { get; private set; }

	public List<float> PrimitiveParam { get; private set; }

	public List<float> PositionOffset { get; private set; }

	public float OffsetHeight { get; private set; }

	public List<List<float>> MorphingTransform { get; private set; }

	public List<List<float>> MorphingSize { get; private set; }

	public List<List<float>> MorphingTime { get; private set; }

	public bool MorphingEffect { get; private set; }

	public BulletExtraHitEnum BulletExtraHitEnum { get; private set; }

	public MovementTrajectoryTypeEnum MovementTrajectoryTypeEnum { get; private set; }

	public List<float> MotionParameter { get; private set; }

	public BulletLifeTypeEnum BulletLifeTypeEnum { get; private set; }

	public float Duration { get; private set; }

	public BulletBuffTypeEnum BulletBuffTypeEnum { get; private set; }

	public BulletTriggerTypeEnum BulletTriggerTypeEnum { get; private set; }

	public float TriggerCd { get; private set; }

	public bool OriginTriggerAble { get; private set; }

	public int TriggerCount { get; private set; }

	public float Interval { get; private set; }

	public float TriggerDelay { get; private set; }

	public float DeathDelay { get; private set; }

	public float StopTriggerTime { get; private set; }

	public HeroAttributeEnum HeroAttributeEnum { get; private set; }

	public List<float> DamageRatio { get; private set; }

	public List<List<float>> DamageRatioModification { get; private set; }

	public List<string> DamageAdd { get; private set; }

	public DamageBonusTypeEnum DamageBonusTypeEnum { get; private set; }

	public float FixAddition { get; private set; }

	public int AttackPower { get; private set; }

	public int WeaknessAttackPower { get; private set; }

	public float AffectTenacity { get; private set; }

	public float AffectTenacityAmend { get; private set; }

	public float FixedAffectTenacity { get; private set; }

	public List<List<string>> MissProperty { get; private set; }

	public List<List<string>> HitProperty { get; private set; }

	public List<List<string>> KnockDownProperty { get; private set; }

	public List<List<string>> WeaknessProperty { get; private set; }

	public List<List<string>> BoxProperty { get; private set; }

	public float VirtualHpConvertHpScale { get; private set; }

	public List<int> State { get; private set; }

	public List<int> AbnormalState { get; private set; }

	public List<int> AbnormalStateValue { get; private set; }

	public List<int> HealTarget { get; private set; }

	public List<float> HealRatio { get; private set; }

	public List<string> HealAdd { get; private set; }

	public List<int> HealAddType { get; private set; }

	public List<int> HealAdditionFrom { get; private set; }

	public float HealFixAddition { get; private set; }

	public List<int> AddBuff { get; private set; }

	public List<int> BuffTarget { get; private set; }

	public bool IsRemoveTheBuff { get; private set; }

	public List<float> Attraction { get; private set; }

	public List<int> CreateAfterHit { get; private set; }

	public List<int> CreateAfterDestroy { get; private set; }

	public int SelfSfx { get; private set; }

	public List<float> SelfSfxOffset { get; private set; }

	public List<int> HitSfx { get; private set; }

	public List<float> HitEffectPositionYOffset { get; private set; }

	public List<float> HitEffectRotateYOffset { get; private set; }

	public int HitDestroySfx { get; private set; }

	public int TimeDestroySfx { get; private set; }

	public float FrozenSpeed { get; private set; }

	public int FrozenFrame { get; private set; }

	public int FrozenTarget { get; private set; }

	public int PulseStartTime { get; private set; }

	public List<float> PulseParameter { get; private set; }

	public List<string> PulseCurve { get; private set; }

	public float ShakeCameraWeight { get; private set; }

	public List<float> ShakeCameraStrength { get; private set; }

	public List<string> AmplitudeAttenuationCurve { get; private set; }

	public List<float> ShakeCameraFrequency { get; private set; }

	public List<string> FrequencyAttenuationCurve { get; private set; }

	public List<string> ShakeNoiseName { get; private set; }

	public List<bool> EnableRandomStart { get; private set; }

	public List<float> ShakeCameraDuration { get; private set; }

	public List<float> BlendTime { get; private set; }

	public bool IsGlobal { get; private set; }

	public bool IsIgnoreHit { get; private set; }

	public bool IsIgnoreParadoxHit { get; private set; }

	public List<int> IgnoreImmunityOnBulletHit { get; private set; }

	public float ShakeTime { get; private set; }

	public bool IsHitSetGlobalTime { get; private set; }

	public float GlobalTimeScale { get; private set; }

	public int GlobalTimePriority { get; private set; }

	public int GlobalTimeFrame { get; private set; }

	public bool GlobalTimeIsCtrlWeakness { get; private set; }

	public bool GlobalTimeIsCtrlGlobal { get; private set; }

	public bool GlobalTimeIsAIEffect { get; private set; }

	public bool IgnoreGlobalTimeScale { get; private set; }

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
		RelationType = DataTableExtension.ParseListInt(array[num++]);
		IsMelee = bool.Parse(array[num++]);
		SkillId = int.Parse(array[num++]);
		BulletLabel = DataTableExtension.ParseListString(array[num++]);
		BulletRangeTypeEnum = DataTableExtension.ParseEnum<BulletRangeTypeEnum>(array[num++]);
		PrimitiveEnum = DataTableExtension.ParseEnum<PrimitiveEnum>(array[num++]);
		PrimitiveParam = DataTableExtension.ParseListFloat(array[num++]);
		PositionOffset = DataTableExtension.ParseListFloat(array[num++]);
		OffsetHeight = float.Parse(array[num++]);
		MorphingTransform = DataTableExtension.ParseListsSemicolonFloatList(array[num++]);
		MorphingSize = DataTableExtension.ParseListsSemicolonFloatList(array[num++]);
		MorphingTime = DataTableExtension.ParseListsSemicolonFloatList(array[num++]);
		MorphingEffect = bool.Parse(array[num++]);
		BulletExtraHitEnum = DataTableExtension.ParseEnum<BulletExtraHitEnum>(array[num++]);
		MovementTrajectoryTypeEnum = DataTableExtension.ParseEnum<MovementTrajectoryTypeEnum>(array[num++]);
		MotionParameter = DataTableExtension.ParseListFloat(array[num++]);
		BulletLifeTypeEnum = DataTableExtension.ParseEnum<BulletLifeTypeEnum>(array[num++]);
		Duration = float.Parse(array[num++]);
		BulletBuffTypeEnum = DataTableExtension.ParseEnum<BulletBuffTypeEnum>(array[num++]);
		BulletTriggerTypeEnum = DataTableExtension.ParseEnum<BulletTriggerTypeEnum>(array[num++]);
		TriggerCd = float.Parse(array[num++]);
		OriginTriggerAble = bool.Parse(array[num++]);
		TriggerCount = int.Parse(array[num++]);
		Interval = float.Parse(array[num++]);
		TriggerDelay = float.Parse(array[num++]);
		DeathDelay = float.Parse(array[num++]);
		StopTriggerTime = float.Parse(array[num++]);
		HeroAttributeEnum = DataTableExtension.ParseEnum<HeroAttributeEnum>(array[num++]);
		DamageRatio = DataTableExtension.ParseListFloat(array[num++]);
		DamageRatioModification = DataTableExtension.ParseListsSemicolonFloatList(array[num++]);
		DamageAdd = DataTableExtension.ParseListString(array[num++]);
		DamageBonusTypeEnum = DataTableExtension.ParseEnum<DamageBonusTypeEnum>(array[num++]);
		FixAddition = float.Parse(array[num++]);
		AttackPower = int.Parse(array[num++]);
		WeaknessAttackPower = int.Parse(array[num++]);
		AffectTenacity = float.Parse(array[num++]);
		AffectTenacityAmend = float.Parse(array[num++]);
		FixedAffectTenacity = float.Parse(array[num++]);
		MissProperty = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		HitProperty = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		KnockDownProperty = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		WeaknessProperty = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		BoxProperty = DataTableExtension.ParseListsSemicolonStringList(array[num++]);
		VirtualHpConvertHpScale = float.Parse(array[num++]);
		State = DataTableExtension.ParseListInt(array[num++]);
		AbnormalState = DataTableExtension.ParseListInt(array[num++]);
		AbnormalStateValue = DataTableExtension.ParseListInt(array[num++]);
		HealTarget = DataTableExtension.ParseListInt(array[num++]);
		HealRatio = DataTableExtension.ParseListFloat(array[num++]);
		HealAdd = DataTableExtension.ParseListString(array[num++]);
		HealAddType = DataTableExtension.ParseListInt(array[num++]);
		HealAdditionFrom = DataTableExtension.ParseListInt(array[num++]);
		HealFixAddition = float.Parse(array[num++]);
		AddBuff = DataTableExtension.ParseListInt(array[num++]);
		BuffTarget = DataTableExtension.ParseListInt(array[num++]);
		IsRemoveTheBuff = bool.Parse(array[num++]);
		Attraction = DataTableExtension.ParseListFloat(array[num++]);
		CreateAfterHit = DataTableExtension.ParseListInt(array[num++]);
		CreateAfterDestroy = DataTableExtension.ParseListInt(array[num++]);
		SelfSfx = int.Parse(array[num++]);
		SelfSfxOffset = DataTableExtension.ParseListFloat(array[num++]);
		HitSfx = DataTableExtension.ParseListInt(array[num++]);
		HitEffectPositionYOffset = DataTableExtension.ParseListFloat(array[num++]);
		HitEffectRotateYOffset = DataTableExtension.ParseListFloat(array[num++]);
		HitDestroySfx = int.Parse(array[num++]);
		TimeDestroySfx = int.Parse(array[num++]);
		FrozenSpeed = float.Parse(array[num++]);
		FrozenFrame = int.Parse(array[num++]);
		FrozenTarget = int.Parse(array[num++]);
		PulseStartTime = int.Parse(array[num++]);
		PulseParameter = DataTableExtension.ParseListFloat(array[num++]);
		PulseCurve = DataTableExtension.ParseListString(array[num++]);
		ShakeCameraWeight = float.Parse(array[num++]);
		ShakeCameraStrength = DataTableExtension.ParseListFloat(array[num++]);
		AmplitudeAttenuationCurve = DataTableExtension.ParseListString(array[num++]);
		ShakeCameraFrequency = DataTableExtension.ParseListFloat(array[num++]);
		FrequencyAttenuationCurve = DataTableExtension.ParseListString(array[num++]);
		ShakeNoiseName = DataTableExtension.ParseListString(array[num++]);
		EnableRandomStart = DataTableExtension.ParseListBool(array[num++]);
		ShakeCameraDuration = DataTableExtension.ParseListFloat(array[num++]);
		BlendTime = DataTableExtension.ParseListFloat(array[num++]);
		IsGlobal = bool.Parse(array[num++]);
		IsIgnoreHit = bool.Parse(array[num++]);
		IsIgnoreParadoxHit = bool.Parse(array[num++]);
		IgnoreImmunityOnBulletHit = DataTableExtension.ParseListInt(array[num++]);
		ShakeTime = float.Parse(array[num++]);
		IsHitSetGlobalTime = bool.Parse(array[num++]);
		GlobalTimeScale = float.Parse(array[num++]);
		GlobalTimePriority = int.Parse(array[num++]);
		GlobalTimeFrame = int.Parse(array[num++]);
		GlobalTimeIsCtrlWeakness = bool.Parse(array[num++]);
		GlobalTimeIsCtrlGlobal = bool.Parse(array[num++]);
		GlobalTimeIsAIEffect = bool.Parse(array[num++]);
		IgnoreGlobalTimeScale = bool.Parse(array[num++]);
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
			RelationType = binaryReader.ReadListInt();
			IsMelee = binaryReader.ReadBoolean();
			SkillId = binaryReader.Read7BitEncodedInt32();
			BulletLabel = binaryReader.ReadListString();
			BulletRangeTypeEnum = binaryReader.ReadEnum<BulletRangeTypeEnum>();
			PrimitiveEnum = binaryReader.ReadEnum<PrimitiveEnum>();
			PrimitiveParam = binaryReader.ReadListFloat();
			PositionOffset = binaryReader.ReadListFloat();
			OffsetHeight = binaryReader.ReadSingle();
			MorphingTransform = binaryReader.ReadListsSemicolonFloatList();
			MorphingSize = binaryReader.ReadListsSemicolonFloatList();
			MorphingTime = binaryReader.ReadListsSemicolonFloatList();
			MorphingEffect = binaryReader.ReadBoolean();
			BulletExtraHitEnum = binaryReader.ReadEnum<BulletExtraHitEnum>();
			MovementTrajectoryTypeEnum = binaryReader.ReadEnum<MovementTrajectoryTypeEnum>();
			MotionParameter = binaryReader.ReadListFloat();
			BulletLifeTypeEnum = binaryReader.ReadEnum<BulletLifeTypeEnum>();
			Duration = binaryReader.ReadSingle();
			BulletBuffTypeEnum = binaryReader.ReadEnum<BulletBuffTypeEnum>();
			BulletTriggerTypeEnum = binaryReader.ReadEnum<BulletTriggerTypeEnum>();
			TriggerCd = binaryReader.ReadSingle();
			OriginTriggerAble = binaryReader.ReadBoolean();
			TriggerCount = binaryReader.Read7BitEncodedInt32();
			Interval = binaryReader.ReadSingle();
			TriggerDelay = binaryReader.ReadSingle();
			DeathDelay = binaryReader.ReadSingle();
			StopTriggerTime = binaryReader.ReadSingle();
			HeroAttributeEnum = binaryReader.ReadEnum<HeroAttributeEnum>();
			DamageRatio = binaryReader.ReadListFloat();
			DamageRatioModification = binaryReader.ReadListsSemicolonFloatList();
			DamageAdd = binaryReader.ReadListString();
			DamageBonusTypeEnum = binaryReader.ReadEnum<DamageBonusTypeEnum>();
			FixAddition = binaryReader.ReadSingle();
			AttackPower = binaryReader.Read7BitEncodedInt32();
			WeaknessAttackPower = binaryReader.Read7BitEncodedInt32();
			AffectTenacity = binaryReader.ReadSingle();
			AffectTenacityAmend = binaryReader.ReadSingle();
			FixedAffectTenacity = binaryReader.ReadSingle();
			MissProperty = binaryReader.ReadListsSemicolonStringList();
			HitProperty = binaryReader.ReadListsSemicolonStringList();
			KnockDownProperty = binaryReader.ReadListsSemicolonStringList();
			WeaknessProperty = binaryReader.ReadListsSemicolonStringList();
			BoxProperty = binaryReader.ReadListsSemicolonStringList();
			VirtualHpConvertHpScale = binaryReader.ReadSingle();
			State = binaryReader.ReadListInt();
			AbnormalState = binaryReader.ReadListInt();
			AbnormalStateValue = binaryReader.ReadListInt();
			HealTarget = binaryReader.ReadListInt();
			HealRatio = binaryReader.ReadListFloat();
			HealAdd = binaryReader.ReadListString();
			HealAddType = binaryReader.ReadListInt();
			HealAdditionFrom = binaryReader.ReadListInt();
			HealFixAddition = binaryReader.ReadSingle();
			AddBuff = binaryReader.ReadListInt();
			BuffTarget = binaryReader.ReadListInt();
			IsRemoveTheBuff = binaryReader.ReadBoolean();
			Attraction = binaryReader.ReadListFloat();
			CreateAfterHit = binaryReader.ReadListInt();
			CreateAfterDestroy = binaryReader.ReadListInt();
			SelfSfx = binaryReader.Read7BitEncodedInt32();
			SelfSfxOffset = binaryReader.ReadListFloat();
			HitSfx = binaryReader.ReadListInt();
			HitEffectPositionYOffset = binaryReader.ReadListFloat();
			HitEffectRotateYOffset = binaryReader.ReadListFloat();
			HitDestroySfx = binaryReader.Read7BitEncodedInt32();
			TimeDestroySfx = binaryReader.Read7BitEncodedInt32();
			FrozenSpeed = binaryReader.ReadSingle();
			FrozenFrame = binaryReader.Read7BitEncodedInt32();
			FrozenTarget = binaryReader.Read7BitEncodedInt32();
			PulseStartTime = binaryReader.Read7BitEncodedInt32();
			PulseParameter = binaryReader.ReadListFloat();
			PulseCurve = binaryReader.ReadListString();
			ShakeCameraWeight = binaryReader.ReadSingle();
			ShakeCameraStrength = binaryReader.ReadListFloat();
			AmplitudeAttenuationCurve = binaryReader.ReadListString();
			ShakeCameraFrequency = binaryReader.ReadListFloat();
			FrequencyAttenuationCurve = binaryReader.ReadListString();
			ShakeNoiseName = binaryReader.ReadListString();
			EnableRandomStart = binaryReader.ReadListBool();
			ShakeCameraDuration = binaryReader.ReadListFloat();
			BlendTime = binaryReader.ReadListFloat();
			IsGlobal = binaryReader.ReadBoolean();
			IsIgnoreHit = binaryReader.ReadBoolean();
			IsIgnoreParadoxHit = binaryReader.ReadBoolean();
			IgnoreImmunityOnBulletHit = binaryReader.ReadListInt();
			ShakeTime = binaryReader.ReadSingle();
			IsHitSetGlobalTime = binaryReader.ReadBoolean();
			GlobalTimeScale = binaryReader.ReadSingle();
			GlobalTimePriority = binaryReader.Read7BitEncodedInt32();
			GlobalTimeFrame = binaryReader.Read7BitEncodedInt32();
			GlobalTimeIsCtrlWeakness = binaryReader.ReadBoolean();
			GlobalTimeIsCtrlGlobal = binaryReader.ReadBoolean();
			GlobalTimeIsAIEffect = binaryReader.ReadBoolean();
			IgnoreGlobalTimeScale = binaryReader.ReadBoolean();
		}
		GeneratePropertyArray();
		return true;
	}

	private void GeneratePropertyArray()
	{
	}
}

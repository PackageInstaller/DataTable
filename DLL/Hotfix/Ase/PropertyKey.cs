using System;
using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct PropertyKey
{
	public const string Hp = "Hp";

	public const string HpRadio = "HpRadio";

	public const string FixHp = "FixHp";

	public const string TotalHp = "TotalHp";

	[Obsolete]
	public const string BUFFHp = "BUFFHp";

	[Obsolete]
	public const string BUFFHpRadio = "BUFFHpRadio";

	[Obsolete]
	public const string WeaponHpRadio = "WeaponHpRadio";

	public const string Attack = "Attack";

	public const string AttackRadio = "AttackRadio";

	public const string FixAttack = "FixAttack";

	public const string BaseTough = "BaseTough";

	[Obsolete]
	public const string BUFFAttack = "BUFFAttack";

	[Obsolete]
	public const string BUFFAttackRadio = "BUFFAttackRadio";

	[Obsolete]
	public const string WeaponAttackRadio = "WeaponAttackRadio";

	public const string Tenacity = "Tenacity";

	public const string EnergyRecoverySpeed = "EnergyRecoverySpeed";

	public const string BUFFEnergyRecoverySpeed = "BUFFEnergyRecoverySpeed";

	public const string EnergyRecoveryRatio = "EnergyRecoveryRatio";

	public const string ExtraEnergyRecover = "ExtraEnergyRecover";

	public const string OutCombatExtraEnergyRecover = "OutCombatExtraEnergyRecover";

	public const string OutCombatEnergyRecoveryRatio = "OutCombatEnergyRecoveryRatio";

	public const string Defence = "Defence";

	public const string DefenceRadio = "DefenceRadio";

	public const string FixDefence = "FixDefence";

	[Obsolete]
	public const string BUFFDefence = "BUFFDefence";

	[Obsolete]
	public const string BUFFDefenceRadio = "BUFFDefenceRadio";

	[Obsolete]
	public const string WeaponDefenceRadio = "WeaponDefenceRadio";

	public const string WeaponStrength = "WeaponStrength";

	public const string BUFFWeaponStrength = "BUFFWeaponStrength";

	public const string Level = "Level";

	public const string Crit = "Crit";

	[Obsolete]
	public const string BUFFCrit = "BUFFCrit";

	public const string BulletNumber = "BulletNumber";

	public const string CritRadio = "CritRadio";

	[Obsolete]
	public const string BUFFCritRadio = "BUFFCritRadio";

	public const string Shield = "Shield";

	public const string Speed = "Speed";

	public const string RotateSpeed = "RotateSpeed";

	public const string AttackDistance = "AttackDistance";

	public const string DodgeDistanceScale = "DodgeDistanceScale";

	public const string NormalAttackEnergyAmend = "NormalAttackEnergyAmend";

	public const string WeaknessEnergyAmend = "WeaknessEnergyAmend";

	public const string NormalTenacityAmend = "NormalTenacityAmend";

	public const string StateTime = "StateTime";

	public const string Energy = "Energy";

	public const string XpEnergy = "XpEnergy";

	public const string XpEnergyRatio = "XpEnergyRatio";

	public const string RescueTime = "RescueTime";

	public const string DefensePowerLevel = "DefensePowerLevel";

	public const string DefensePowerLevelExtra = "DefensePowerLevelExtra";

	public const string MonsterAnger = "MonsterAnger";

	public const string NearDeathSchedule = "NearDeathSchedule";

	public const string HeroAnger = "HeroAnger";

	public const string HeroAngerReduceTimeRatio = "HeroAngerReduceTimeRatio";

	public const string HeroAngerReduceSpeedRatio = "HeroAngerReduceSpeedRatio";

	public const string HeroAngerSwitch = "HeroAngerSwitch";

	public const string HeroHeat = "HeroHeat";

	public const string HeroHeatAdditionRatio = "HeroHeatAdditionRatio";

	public const string HeroHeatReduceRatio = "HeroHeatReduceRatio";

	public const string HeroHeatThreshold = "HeroHeatThreshold";

	public const string FullHeat = "FullHeat";

	public const string OverHeat = "OverHeat";

	public const string OverHeatable = "OverHeatable";

	public const string HeroChargedEnergy = "HeroChargedEnergy";

	public const string HeroChargedEnergyScale = "HeroChargedEnergyScale";

	public const string HeroChargedEnergyReduceTime = "HeroChargedEnergyReduceTime";

	public const string HammerChargeTime = "HammerChargeTime";

	public const string ChargedEnergyMax = "ChargedEnergyMax";

	public const string EachChargedEnergy = "EachChargedEnergy";

	public const string ChargedEnergyMaxTime = "ChargedEnergyMaxTime";

	public const string HeroAngerRatio = "HeroAngerRatio";

	public const string HeroEnergy = "HeroEnergy";

	[Obsolete]
	public const string SpCharge = "SpCharge";

	public const string EatApple = "EatApple";

	public const string KeennessLayer = "KeennessLayer";

	public const string KeennerssLayerRatio = "KeennerssLayerRatio";

	public const string KeennessLayerUnLockLayer = "KeennessLayerUnLockLayer";

	public const string KeennessAmpliValue = "KeennessAmpliValue";

	public const string AwakenBaseValue = "AwakenBaseValue";

	public const string AwakenBaseRatio = "AwakenBaseRatio";

	public const string AwakenExtraRatio = "AwakenExtraRatio";

	public const string AwakenStateSwitch = "AwakenStateSwitch";

	public const string AwakenCumulativeValue = "AwakenCumulativeValue";

	[Obsolete]
	public const string AwakenBaseValueAddition = "AwakenBaseValueAddition";

	public const string AwakenAutoReduceValueAddition = "AwakenAutoReduceValueAddition";

	[Obsolete]
	public const string AwakenAutoReduceTimeAddition = "AwakenAutoReduceTimeAddition";

	[Obsolete]
	public const string AwakenAutoReduceRefreshInterval = "AwakenAutoReduceRefreshInterval";

	public const string HeroCourage = "HeroCourage";

	public const string HeroCourageRatio = "HeroCourageRatio";

	public const string EachHeroCourage = "EachHeroCourage";

	public const string EachHeroCourageNum = "EachHeroCourageNum";

	[Obsolete]
	public const string HeroCourageState = "HeroCourageState";

	public const string HeroMightSwitch = "HeroMightSwitch";

	public const string HeroMight = "HeroMight";

	public const string EachHeroCourageNoMightHide = "EachHeroCourageNoMightHide";

	public const string DamageConvertVirtualHpScale = "DamageConvertVirtualHpScale";

	public const string VirtualHpReduceTime = "VirtualHpReduceTime";

	public const string VirtualHpReduceSpeed = "VirtualHpReduceSpeed";

	public const string VirtualHp = "VirtualHp";

	public const string ParryReduceEnergySpeed = "ParryReduceEnergySpeed";

	public const string DefenseConsume = "DefenseConsume";

	public const string DestinyLevel = "DestinyLevel";

	public const string ChargeSpeed = "ChargeSpeed";

	public const string InvincibleFrame = "InvincibleFrame";

	public const string AttractionMultiplier = "AttractionMultiplier";

	public const string AttractionPower = "AttractionPower";

	public const string AttractionResistance = "AttractionResistance";

	public const string LightCharacterAttackRadio = "LightCharacterAttackRadio";

	public const string DarkCharacterAttackRadio = "DarkCharacterAttackRadio";

	public const string WaterCharacterAttackRadio = "WaterCharacterAttackRadio";

	public const string FireCharacterAttackRadio = "FireCharacterAttackRadio";

	public const string WindCharacterAttackRadio = "WindCharacterAttackRadio";

	public const string SwordDamageAdditon = "SwordDamageAdditon";

	public const string SwordDamageAddition = "SwordDamageAddition";

	public const string GlovesDamageAddition = "GlovesDamageAddition";

	public const string BowDamageAddition = "BowDamageAddition";

	public const string GunDamageAddition = "GunDamageAddition";

	public const string HammerDamageAddition = "HammerDamageAddition";

	public const string LanceDamageAddition = "LanceDamageAddition";

	public const string SwordFrameAdditon = "SwordFrameAdditon";

	public const string SwordFrameAddition = "SwordFrameAddition";

	public const string GlovesFrameAddition = "GlovesFrameAddition";

	public const string BowFrameAddition = "BowFrameAddition";

	public const string GunFrameAddition = "GunFrameAddition";

	public const string HammerFrameAddition = "HammerFrameAddition";

	public const string LanceFrameAddition = "LanceFrameAddition";

	public const string SkillDamageAddition = "SkillDamageAddition";

	public const string FireDamageRadio = "FireDamageRadio";

	public const string WindDamageRadio = "WindDamageRadio";

	public const string WaterDamageRadio = "WaterDamageRadio";

	public const string LightDamageRadio = "LightDamageRadio";

	public const string DarkDamageRadio = "DarkDamageRadio";

	public const string IceDamageRadio = "IceDamageRadio";

	public const string ThunderDamageRadio = "ThunderDamageRadio";

	public const string RockDamageRadio = "RockDamageRadio";

	public const string DragonDamageRadio = "DragonDamageRadio";

	public const string WeaponFrame = "WeaponFrame";

	public const string RebornProgress = "RebornProgress";

	public const string RebornNeedProgress = "RebornNeedProgress";

	public const string RebornOnlySelfIncrease = "RebornOnlySelfIncrease";

	public const string RebornSelfIncrease = "RebornSelfIncrease";

	public const string RescueIncrease = "RescueIncrease";

	public const string RebornEneryRemaind = "RebornEneryRemaind";

	public const string RebornEneryProgress = "RebornEneryProgress";

	public const string RebornEnergyReduce = "RebornEnergyReduce";

	public const string IgnoreDefence = "IgnoreDefence";
}

using Google.Protobuf.Reflection;

namespace Config;

public enum BuffClass
{
	[OriginalName("BuffClass_none")]
	None = 0,
	[OriginalName("BuffClass_STATUS_TYPE_SLOW")]
	StatusTypeSlow = 1,
	[OriginalName("BuffClass_STATUS_TYPE_BLIND")]
	StatusTypeBlind = 2,
	[OriginalName("BuffClass_STATUS_TYPE_CHAOS")]
	StatusTypeChaos = 3,
	[OriginalName("BuffClass_STATUS_TYPE_DISARM")]
	StatusTypeDisarm = 4,
	[OriginalName("BuffClass_STATUS_TYPE_SILENT")]
	StatusTypeSilent = 5,
	[OriginalName("BuffClass_STATUS_TYPE_STOP")]
	StatusTypeStop = 6,
	[OriginalName("BuffClass_STATUS_TYPE_FROST")]
	StatusTypeFrost = 7,
	[OriginalName("BuffClass_STATUS_TYPE_SWIM")]
	StatusTypeSwim = 8,
	[OriginalName("BuffClass_STATUS_TYPE_PARALYSIS")]
	StatusTypeParalysis = 9,
	[OriginalName("BuffClass_STATUS_TYPE_THORNS")]
	StatusTypeThorns = 10,
	[OriginalName("BuffClass_STATUS_TYPE_FRAIL")]
	StatusTypeFrail = 11,
	[OriginalName("BuffClass_STATUS_TYPE_LOCK")]
	StatusTypeLock = 12,
	[OriginalName("BuffClass_STATUS_TYPE_BLOOD")]
	StatusTypeBlood = 13,
	[OriginalName("BuffClass_STATUS_TYPE_POISON")]
	StatusTypePoison = 14,
	[OriginalName("BuffClass_STATUS_TYPE_FIRING")]
	StatusTypeFiring = 15,
	[OriginalName("BuffClass_STATUS_TYPE_FEEBLE")]
	StatusTypeFeeble = 16,
	[OriginalName("BuffClass_STATUS_TYPE_BABA")]
	StatusTypeBaba = 17,
	[OriginalName("BuffClass_STATUS_TYPE_SUPERARMOR")]
	StatusTypeSuperarmor = 18,
	[OriginalName("BuffClass_STATUS_TYPE_RECOVER")]
	StatusTypeRecover = 19,
	[OriginalName("BuffClass_STATUS_TYPE_MAXHP")]
	StatusTypeMaxhp = 20,
	[OriginalName("BuffClass_STATUS_TYPE_ATTACK")]
	StatusTypeAttack = 21,
	[OriginalName("BuffClass_STATUS_TYPE_DEFENSE")]
	StatusTypeDefense = 22,
	[OriginalName("BuffClass_STATUS_TYPE_PHYDEFENSE")]
	StatusTypePhydefense = 23,
	[OriginalName("BuffClass_STATUS_TYPE_SPEDEFENSE")]
	StatusTypeSpedefense = 24,
	[OriginalName("BuffClass_STATUS_TYPE_DAMAGE")]
	StatusTypeDamage = 25,
	[OriginalName("BuffClass_STATUS_TYPE_ORDDAMAGE")]
	StatusTypeOrddamage = 26,
	[OriginalName("BuffClass_STATUS_TYPE_SKILLDAMAGE")]
	StatusTypeSkilldamage = 27,
	[OriginalName("BuffClass_STATUS_TYPE_CRIT")]
	StatusTypeCrit = 28,
	[OriginalName("BuffClass_STATUS_TYPE_CRITDAMAGE")]
	StatusTypeCritdamage = 29,
	[OriginalName("BuffClass_STATUS_TYPE_COOLDOWN")]
	StatusTypeCooldown = 30,
	[OriginalName("BuffClass_STATUS_TYPE_SPEED")]
	StatusTypeSpeed = 31,
	[OriginalName("BuffClass_STATUS_TYPE_TENACITY")]
	StatusTypeTenacity = 32,
	[OriginalName("BuffClass_STATUS_TYPE_HIT_ACTION_SPEED")]
	StatusTypeHitActionSpeed = 33,
	[OriginalName("BuffClass_STATUS_TYPE_1034_1")]
	StatusType10341 = 103401,
	[OriginalName("BuffClass_STATUS_TYPE_1034_2")]
	StatusType10342 = 103402,
	[OriginalName("BuffClass_STATUS_TYPE_1039_1")]
	StatusType10391 = 103901,
	[OriginalName("BuffClass_STATUS_TYPE_1046_1")]
	StatusType10461 = 104601,
	[OriginalName("BuffClass_STATUS_TYPE_1045_1")]
	StatusType10451 = 104501,
	[OriginalName("BuffClass_STATUS_TYPE_1048_1")]
	StatusType10481 = 104801,
	[OriginalName("BuffClass_STATUS_TYPE_1048_2")]
	StatusType10482 = 104802,
	[OriginalName("BuffClass_STATUS_TYPE_1050_1")]
	StatusType10501 = 105001,
	[OriginalName("BuffClass_STATUS_TYPE_1066_1")]
	StatusType10661 = 106601,
	[OriginalName("BuffClass_STATUS_TYPE_1066_2")]
	StatusType10662 = 106602,
	[OriginalName("BuffClass_STATUS_TYPE_1066_3")]
	StatusType10663 = 106603,
	[OriginalName("BuffClass_STATUS_TYPE_1066_4")]
	StatusType10664 = 106604,
	[OriginalName("BuffClass_STATUS_TYPE_1066_5")]
	StatusType10665 = 106605,
	[OriginalName("BuffClass_STATUS_TYPE_1066_6")]
	StatusType10666 = 106606
}

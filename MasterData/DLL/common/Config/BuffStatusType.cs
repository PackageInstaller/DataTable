using Google.Protobuf.Reflection;

namespace Config;

public enum BuffStatusType
{
	[OriginalName("BuffStatusType_none")]
	None,
	[OriginalName("BuffStatusType_bleed")]
	Bleed,
	[OriginalName("BuffStatusType_firing")]
	Firing,
	[OriginalName("BuffStatusType_entangle")]
	Entangle,
	[OriginalName("BuffStatusType_immobilize")]
	Immobilize,
	[OriginalName("BuffStatusType_stun")]
	Stun,
	[OriginalName("BuffStatusType_silence")]
	Silence,
	[OriginalName("BuffStatusType_sleep")]
	Sleep,
	[OriginalName("BuffStatusType_fear")]
	Fear,
	[OriginalName("BuffStatusType_poisoning")]
	Poisoning,
	[OriginalName("BuffStatusType_invincible")]
	Invincible,
	[OriginalName("BuffStatusType_lower_def")]
	LowerDef,
	[OriginalName("BuffStatusType_lower_accuracy")]
	LowerAccuracy,
	[OriginalName("BuffStatusType_continue_regain")]
	ContinueRegain,
	[OriginalName("BuffStatusType_enhance_def")]
	EnhanceDef,
	[OriginalName("BuffStatusType_enhance_atk")]
	EnhanceAtk,
	[OriginalName("BuffStatusType_death")]
	Death,
	[OriginalName("BuffStatusType_freeze")]
	Freeze,
	[OriginalName("BuffStatusType_paralysis")]
	Paralysis,
	[OriginalName("BuffStatusType_stupid")]
	Stupid,
	[OriginalName("BuffStatusType_disarm")]
	Disarm,
	[OriginalName("BuffStatusType_shield")]
	Shield,
	[OriginalName("BuffStatusType_leech_life")]
	LeechLife,
	[OriginalName("BuffStatusType_transform")]
	Transform
}

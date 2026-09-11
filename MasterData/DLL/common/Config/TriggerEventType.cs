using Google.Protobuf.Reflection;

namespace Config;

public enum TriggerEventType
{
	[OriginalName("TriggerEventType_MapInit")]
	MapInit,
	[OriginalName("TriggerEventType_UnitEnterArea")]
	UnitEnterArea,
	[OriginalName("TriggerEventType_UnitDie")]
	UnitDie,
	[OriginalName("TriggerEventType_UnitAttrChange")]
	UnitAttrChange,
	[OriginalName("TriggerEventType_UnitPrepareCast")]
	UnitPrepareCast,
	[OriginalName("TriggerEventType_ChangeAttarge")]
	ChangeAttarge,
	[OriginalName("TriggerEventType_UnitAcceptDamage")]
	UnitAcceptDamage
}

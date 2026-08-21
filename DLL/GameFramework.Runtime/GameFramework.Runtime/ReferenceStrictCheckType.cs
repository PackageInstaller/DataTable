namespace GameFramework.Runtime;

public enum ReferenceStrictCheckType : byte
{
	AlwaysEnable,
	OnlyEnableWhenDevelopment,
	OnlyEnableInEditor,
	AlwaysDisable
}

using System;

[Flags]
public enum BulletBlockFilter : byte
{
	None = 0,
	IsCloseBlock = 1,
	IsHideModel = 2,
	IsSneak = 4,
	IsHideOut = 8,
	IsPenetrate = 0x10,
	All = IsCloseBlock | IsHideModel | IsSneak | IsHideOut | IsPenetrate
}

using System;

namespace UnityEngine;

[Flags]
public enum DrivenTransformProperties
{
	None = 0,
	All = -1,
	AnchoredPositionX = 2,
	AnchoredPositionY = 4,
	AnchoredPositionZ = 8,
	Rotation = 0x10,
	ScaleX = 0x20,
	ScaleY = 0x40,
	ScaleZ = 0x80,
	AnchorMinX = 0x100,
	AnchorMinY = 0x200,
	AnchorMaxX = 0x400,
	AnchorMaxY = 0x800,
	SizeDeltaX = 0x1000,
	SizeDeltaY = 0x2000,
	PivotX = 0x4000,
	PivotY = 0x8000,
	AnchoredPosition = 6,
	AnchoredPosition3D = 0xE,
	Scale = 0xE0,
	AnchorMin = 0x300,
	AnchorMax = 0xC00,
	Anchors = 0xF00,
	SizeDelta = 0x3000,
	Pivot = 0xC000
}

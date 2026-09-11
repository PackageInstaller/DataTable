using System;

namespace ControllerExSpace;

[Serializable]
public enum GearType
{
	ACTIVE = 1,
	POSITION = 2,
	ROTATION = 4,
	SCALE = 8,
	FONT_SIZE = 0x10,
	FONT_COLOR = 0x20,
	IMG_SPRITE = 0x40,
	IMG_COLOR = 0x80,
	IMG_MATERIAL = 0x100,
	CANVAS_GROUP_ALPHA = 0x200,
	IGNORE_POSITION = 0x400,
	UI_BLUR_MIP_MAP = 0x800,
	POSITION_Z = 0x1000,
	CONTROLLER = 0x2000
}

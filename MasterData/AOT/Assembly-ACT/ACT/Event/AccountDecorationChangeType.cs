using System;

namespace ACT.Event;

[Flags]
public enum AccountDecorationChangeType
{
	None = 0,
	Avatar = 1,
	AvatarFrame = 2,
	Title = 4,
	Nickname = 8,
	Signature = 0x10
}

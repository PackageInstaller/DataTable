using Google.Protobuf.Reflection;

namespace Pb;

public enum LoungeTriggerPointType
{
	[OriginalName("LOUNGE_TRIGGER_POINT_TYPE_INVITE_CHARACTER")]
	InviteCharacter,
	[OriginalName("LOUNGE_TRIGGER_POINT_TYPE_INTERACT_CHARACTER")]
	InteractCharacter,
	[OriginalName("LOUNGE_TRIGGER_POINT_TYPE_STORY")]
	Story
}

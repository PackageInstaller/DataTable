using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public enum ClientModuleEnum
{
	[OriginalName("CLIENT_MODULE_ENUM_UI")]
	Ui,
	[OriginalName("CLIENT_MODULE_ENUM_INPUT")]
	Input
}

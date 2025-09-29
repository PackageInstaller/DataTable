-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgdebugger/MsgDebuggerConfig.lua

module("logic.extensions.msgdebugger.MsgDebuggerConfig", package.seeall)

local MsgDebuggerConfig = _M

MsgDebuggerConfig.UIROOT = "UIROOT"
MsgDebuggerConfig.UIPath = ResName.Msgdebuggerui
MsgDebuggerConfig.ViewPath = ResName.Msgdebuggerview
MsgDebuggerConfig.ItemPath = ResName.Msgdebuggeritem
MsgDebuggerConfig.ItemParamPath = ResName.Msgdebuggerparamitem
MsgDebuggerConfig.ModifyViewPath = ResName.Msgdebuggermodifyview
MsgDebuggerConfig.BlockAllWhenBlockOccur = true
MsgDebuggerConfig.IgnoreExtCmdList = {
	[10002] = true
}
MsgDebuggerConfig.NeedPrintStackTrace = true
MsgDebuggerConfig.ParamType = {
	nil,
	nil,
	"int64",
	"uint64",
	"int32",
	nil,
	nil,
	"bool",
	"string",
	nil,
	"proto",
	nil,
	"uint32",
	bool = "bool",
	proto = "proto",
	int32 = "int32",
	uint32 = "uint32",
	string = "string",
	int64 = "int64",
	uint64 = "uint64"
}
MsgDebuggerConfig.LabelType = {
	"optional",
	"required",
	"repeated",
	repeated = "repeated",
	optional = "optional",
	required = "required"
}
MsgDebuggerConfig.DefaultValue = {
	bool = {
		"true",
		"false"
	},
	int32 = {
		"0",
		"-1",
		"1",
		"2147483647",
		"-2147483648"
	},
	uint32 = {
		"0",
		"-1",
		"1",
		"4294967295",
		"2147483647",
		"-2147483648"
	},
	int64 = {
		"0",
		"-1",
		"1",
		"9223372036854775807",
		"-9223372036854775808"
	},
	uint64 = {
		"0",
		"-1",
		"1",
		"18446744073709551615",
		"9223372036854775807",
		"-9223372036854775808"
	},
	string = {
		""
	}
}

return MsgDebuggerConfig

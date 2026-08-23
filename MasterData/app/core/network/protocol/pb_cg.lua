local var_0_0 = ...
local protobuf = require("protobuf.protobuf")
local descriptor_helper = require("protobuf.descriptor_helper")
local var_0_3 = {
	MSG_G2C_Create = 10005,
	MSG_END = 10099,
	RET_LOGIC_CLEAR = 6,
	RET_USER_NOT_EXIST = 3,
	MSG_C2G_OfflineNew = 10015,
	RET_ERROR = 0,
	RET_USER_NAME_ILLEGAL = 10,
	RET_LOGIN_REPEAT = 5,
	MSG_G2C_Offline = 10011,
	MSG_NONE = 0,
	MSG_BEGIN = 10001,
	MSG_G2C_KeepAlive = 10007,
	MSG_C2G_Create = 10004,
	MSG_C2G_Offline = 10010,
	RET_USER_NAME_REPEAT = 4,
	MSG_C2G_KeepAlive = 10006,
	MSG_C2G_SayHi = 10008,
	RET_SERVER_MAINTAIN = 2,
	MSG_G2C_Broadcast = 10012,
	RET_OK = 1,
	MSG_G2C_Activate = 10014,
	MSG_G2C_OfflineNew = 10016,
	MSG_G2C_SayHi = 10009,
	MSG_G2C_Login = 10003,
	MSG_C2G_Activate = 10013,
	MSG_C2G_Login = 10002,
	RET_E = protobuf.EnumDescriptor(),
	RET_RET_ERROR_EI = protobuf.EnumValueDescriptor(),
	RET_RET_OK_EI = protobuf.EnumValueDescriptor(),
	RET_RET_SERVER_MAINTAIN_EI = protobuf.EnumValueDescriptor(),
	RET_RET_USER_NOT_EXIST_EI = protobuf.EnumValueDescriptor(),
	RET_RET_USER_NAME_REPEAT_EI = protobuf.EnumValueDescriptor(),
	RET_RET_LOGIN_REPEAT_EI = protobuf.EnumValueDescriptor(),
	RET_RET_LOGIC_CLEAR_EI = protobuf.EnumValueDescriptor(),
	RET_RET_USER_NAME_ILLEGAL_EI = protobuf.EnumValueDescriptor(),
	ID_E = protobuf.EnumDescriptor(),
	ID_MSG_NONE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_BEGIN_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_END_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_LOGIN_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_LOGIN_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_CREATE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_CREATE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_KEEPALIVE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_KEEPALIVE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_SAYHI_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_SAYHI_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_OFFLINE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_OFFLINE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_BROADCAST_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_ACTIVATE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_ACTIVATE_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_C2G_OFFLINENEW_EI = protobuf.EnumValueDescriptor(),
	ID_MSG_G2C_OFFLINENEW_EI = protobuf.EnumValueDescriptor(),
	C2G_LOGIN_ME = protobuf.Descriptor(),
	C2G_LOGIN_TOKEN_F = protobuf.FieldDescriptor(),
	C2G_LOGIN_SERVER_ID_F = protobuf.FieldDescriptor(),
	C2G_LOGIN_VERSION_F = protobuf.FieldDescriptor(),
	C2G_LOGIN_SEQUENCE_ID_F = protobuf.FieldDescriptor(),
	C2G_LOGIN_CLIENT_F = protobuf.FieldDescriptor(),
	C2G_LOGIN_UUID_REG_TIME_F = protobuf.FieldDescriptor(),
	C2G_LOGIN_GATEWAY_IP_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_ME = protobuf.Descriptor(),
	G2C_LOGIN_RET_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_UID_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_SID_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_VERSION_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_TIME_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_ZONE_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_SEQUENCE_ID_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_AUTO_FLUSH_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_GIT_VERSION_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_NEED_ACTIVATE_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_GIT_BRANCH_F = protobuf.FieldDescriptor(),
	G2C_LOGIN_JENKINS_BUILD_NUM_F = protobuf.FieldDescriptor(),
	C2G_CREATE_ME = protobuf.Descriptor(),
	C2G_CREATE_NAME_F = protobuf.FieldDescriptor(),
	C2G_CREATE_TYPE_F = protobuf.FieldDescriptor(),
	C2G_CREATE_SERVER_ID_F = protobuf.FieldDescriptor(),
	C2G_CREATE_LANGUAGE_F = protobuf.FieldDescriptor(),
	G2C_CREATE_ME = protobuf.Descriptor(),
	G2C_CREATE_RET_F = protobuf.FieldDescriptor(),
	G2C_CREATE_UID_F = protobuf.FieldDescriptor(),
	G2C_CREATE_SID_F = protobuf.FieldDescriptor(),
	C2G_SAYHI_ME = protobuf.Descriptor(),
	C2G_SAYHI_VERSION_F = protobuf.FieldDescriptor(),
	G2C_SAYHI_ME = protobuf.Descriptor(),
	G2C_SAYHI_ID_F = protobuf.FieldDescriptor(),
	G2C_SAYHI_CURRENT_F = protobuf.FieldDescriptor(),
	G2C_SAYHI_DEL_F = protobuf.FieldDescriptor(),
	G2C_SAYHI_VERSION_F = protobuf.FieldDescriptor(),
	C2G_KEEPALIVE_ME = protobuf.Descriptor(),
	G2C_KEEPALIVE_ME = protobuf.Descriptor(),
	C2G_OFFLINE_ME = protobuf.Descriptor(),
	G2C_OFFLINE_ME = protobuf.Descriptor(),
	G2C_OFFLINE_REASON_F = protobuf.FieldDescriptor(),
	C2G_OFFLINENEW_ME = protobuf.Descriptor(),
	G2C_OFFLINENEW_ME = protobuf.Descriptor(),
	G2C_OFFLINENEW_REASON_F = protobuf.FieldDescriptor(),
	G2C_BROADCAST_ME = protobuf.Descriptor(),
	G2C_BROADCAST_IDS_F = protobuf.FieldDescriptor(),
	G2C_BROADCAST_CMD_F = protobuf.FieldDescriptor(),
	G2C_BROADCAST_SID_F = protobuf.FieldDescriptor(),
	G2C_BROADCAST_INFO_F = protobuf.FieldDescriptor(),
	G2C_BROADCAST_TO_SIDS_F = protobuf.FieldDescriptor(),
	C2G_ACTIVATE_ME = protobuf.Descriptor(),
	C2G_ACTIVATE_TOKEN_F = protobuf.FieldDescriptor(),
	C2G_ACTIVATE_CODE_F = protobuf.FieldDescriptor(),
	C2G_ACTIVATE_SERVER_ID_F = protobuf.FieldDescriptor(),
	G2C_ACTIVATE_ME = protobuf.Descriptor(),
	G2C_ACTIVATE_RET_F = protobuf.FieldDescriptor()
}

descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_ERROR_EI, {
	"RET_ERROR",
	0,
	0
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_OK_EI, {
	"RET_OK",
	1,
	1
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_SERVER_MAINTAIN_EI, {
	"RET_SERVER_MAINTAIN",
	2,
	2
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_USER_NOT_EXIST_EI, {
	"RET_USER_NOT_EXIST",
	3,
	3
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_USER_NAME_REPEAT_EI, {
	"RET_USER_NAME_REPEAT",
	4,
	4
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_LOGIN_REPEAT_EI, {
	"RET_LOGIN_REPEAT",
	5,
	5
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_LOGIC_CLEAR_EI, {
	"RET_LOGIC_CLEAR",
	6,
	6
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.RET_RET_USER_NAME_ILLEGAL_EI, {
	"RET_USER_NAME_ILLEGAL",
	7,
	10
})
descriptor_helper.enumDescriptorFunc(var_0_3.RET_E, {
	"RET",
	".cg.RET",
	{
		var_0_3.RET_RET_ERROR_EI,
		var_0_3.RET_RET_OK_EI,
		var_0_3.RET_RET_SERVER_MAINTAIN_EI,
		var_0_3.RET_RET_USER_NOT_EXIST_EI,
		var_0_3.RET_RET_USER_NAME_REPEAT_EI,
		var_0_3.RET_RET_LOGIN_REPEAT_EI,
		var_0_3.RET_RET_LOGIC_CLEAR_EI,
		var_0_3.RET_RET_USER_NAME_ILLEGAL_EI
	}
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_NONE_EI, {
	"MSG_NONE",
	0,
	0
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_BEGIN_EI, {
	"MSG_BEGIN",
	1,
	10001
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_END_EI, {
	"MSG_END",
	2,
	10099
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_LOGIN_EI, {
	"MSG_C2G_Login",
	3,
	10002
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_LOGIN_EI, {
	"MSG_G2C_Login",
	4,
	10003
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_CREATE_EI, {
	"MSG_C2G_Create",
	5,
	10004
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_CREATE_EI, {
	"MSG_G2C_Create",
	6,
	10005
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_KEEPALIVE_EI, {
	"MSG_C2G_KeepAlive",
	7,
	10006
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_KEEPALIVE_EI, {
	"MSG_G2C_KeepAlive",
	8,
	10007
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_SAYHI_EI, {
	"MSG_C2G_SayHi",
	9,
	10008
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_SAYHI_EI, {
	"MSG_G2C_SayHi",
	10,
	10009
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_OFFLINE_EI, {
	"MSG_C2G_Offline",
	11,
	10010
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_OFFLINE_EI, {
	"MSG_G2C_Offline",
	12,
	10011
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_BROADCAST_EI, {
	"MSG_G2C_Broadcast",
	13,
	10012
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_ACTIVATE_EI, {
	"MSG_C2G_Activate",
	14,
	10013
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_ACTIVATE_EI, {
	"MSG_G2C_Activate",
	15,
	10014
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_C2G_OFFLINENEW_EI, {
	"MSG_C2G_OfflineNew",
	16,
	10015
})
descriptor_helper.enumValueDescriptorFunc(var_0_3.ID_MSG_G2C_OFFLINENEW_EI, {
	"MSG_G2C_OfflineNew",
	17,
	10016
})
descriptor_helper.enumDescriptorFunc(var_0_3.ID_E, {
	"ID",
	".cg.ID",
	{
		var_0_3.ID_MSG_NONE_EI,
		var_0_3.ID_MSG_BEGIN_EI,
		var_0_3.ID_MSG_END_EI,
		var_0_3.ID_MSG_C2G_LOGIN_EI,
		var_0_3.ID_MSG_G2C_LOGIN_EI,
		var_0_3.ID_MSG_C2G_CREATE_EI,
		var_0_3.ID_MSG_G2C_CREATE_EI,
		var_0_3.ID_MSG_C2G_KEEPALIVE_EI,
		var_0_3.ID_MSG_G2C_KEEPALIVE_EI,
		var_0_3.ID_MSG_C2G_SAYHI_EI,
		var_0_3.ID_MSG_G2C_SAYHI_EI,
		var_0_3.ID_MSG_C2G_OFFLINE_EI,
		var_0_3.ID_MSG_G2C_OFFLINE_EI,
		var_0_3.ID_MSG_G2C_BROADCAST_EI,
		var_0_3.ID_MSG_C2G_ACTIVATE_EI,
		var_0_3.ID_MSG_G2C_ACTIVATE_EI,
		var_0_3.ID_MSG_C2G_OFFLINENEW_EI,
		var_0_3.ID_MSG_G2C_OFFLINENEW_EI
	}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_TOKEN_F, {
	"token",
	".cg.C2G_Login.token",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_SERVER_ID_F, {
	"server_id",
	".cg.C2G_Login.server_id",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_VERSION_F, {
	"version",
	".cg.C2G_Login.version",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_SEQUENCE_ID_F, {
	"sequence_id",
	".cg.C2G_Login.sequence_id",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_CLIENT_F, {
	"client",
	".cg.C2G_Login.client",
	5,
	4,
	1,
	false,
	nil,
	(function(arg_1_0)
		if import then
			return import("." .. arg_1_0, var_0_0)
		else
			return require(arg_1_0)
		end
	end)("pb_out_base").CLIENT_ME,
	nil,
	11,
	10
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_UUID_REG_TIME_F, {
	"uuid_reg_time",
	".cg.C2G_Login.uuid_reg_time",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_LOGIN_GATEWAY_IP_F, {
	"gateway_ip",
	".cg.C2G_Login.gateway_ip",
	7,
	6,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_3.C2G_LOGIN_ME, {
	"C2G_Login",
	".cg.C2G_Login",
	{},
	{},
	{
		var_0_3.C2G_LOGIN_TOKEN_F,
		var_0_3.C2G_LOGIN_SERVER_ID_F,
		var_0_3.C2G_LOGIN_VERSION_F,
		var_0_3.C2G_LOGIN_SEQUENCE_ID_F,
		var_0_3.C2G_LOGIN_CLIENT_F,
		var_0_3.C2G_LOGIN_UUID_REG_TIME_F,
		var_0_3.C2G_LOGIN_GATEWAY_IP_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_RET_F, {
	"ret",
	".cg.G2C_Login.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_UID_F, {
	"uid",
	".cg.G2C_Login.uid",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_SID_F, {
	"sid",
	".cg.G2C_Login.sid",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_VERSION_F, {
	"version",
	".cg.G2C_Login.version",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_TIME_F, {
	"time",
	".cg.G2C_Login.time",
	5,
	4,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_ZONE_F, {
	"zone",
	".cg.G2C_Login.zone",
	6,
	5,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_SEQUENCE_ID_F, {
	"sequence_id",
	".cg.G2C_Login.sequence_id",
	7,
	6,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_AUTO_FLUSH_F, {
	"auto_flush",
	".cg.G2C_Login.auto_flush",
	8,
	7,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_GIT_VERSION_F, {
	"git_version",
	".cg.G2C_Login.git_version",
	9,
	8,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_NEED_ACTIVATE_F, {
	"need_activate",
	".cg.G2C_Login.need_activate",
	10,
	9,
	1,
	false,
	false,
	nil,
	nil,
	8,
	7
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_GIT_BRANCH_F, {
	"git_branch",
	".cg.G2C_Login.git_branch",
	11,
	10,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_LOGIN_JENKINS_BUILD_NUM_F, {
	"jenkins_build_num",
	".cg.G2C_Login.jenkins_build_num",
	12,
	11,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_3.G2C_LOGIN_ME, {
	"G2C_Login",
	".cg.G2C_Login",
	{},
	{},
	{
		var_0_3.G2C_LOGIN_RET_F,
		var_0_3.G2C_LOGIN_UID_F,
		var_0_3.G2C_LOGIN_SID_F,
		var_0_3.G2C_LOGIN_VERSION_F,
		var_0_3.G2C_LOGIN_TIME_F,
		var_0_3.G2C_LOGIN_ZONE_F,
		var_0_3.G2C_LOGIN_SEQUENCE_ID_F,
		var_0_3.G2C_LOGIN_AUTO_FLUSH_F,
		var_0_3.G2C_LOGIN_GIT_VERSION_F,
		var_0_3.G2C_LOGIN_NEED_ACTIVATE_F,
		var_0_3.G2C_LOGIN_GIT_BRANCH_F,
		var_0_3.G2C_LOGIN_JENKINS_BUILD_NUM_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_CREATE_NAME_F, {
	"name",
	".cg.C2G_Create.name",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_CREATE_TYPE_F, {
	"type",
	".cg.C2G_Create.type",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_CREATE_SERVER_ID_F, {
	"server_id",
	".cg.C2G_Create.server_id",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_CREATE_LANGUAGE_F, {
	"language",
	".cg.C2G_Create.language",
	4,
	3,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_3.C2G_CREATE_ME, {
	"C2G_Create",
	".cg.C2G_Create",
	{},
	{},
	{
		var_0_3.C2G_CREATE_NAME_F,
		var_0_3.C2G_CREATE_TYPE_F,
		var_0_3.C2G_CREATE_SERVER_ID_F,
		var_0_3.C2G_CREATE_LANGUAGE_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_CREATE_RET_F, {
	"ret",
	".cg.G2C_Create.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_CREATE_UID_F, {
	"uid",
	".cg.G2C_Create.uid",
	2,
	1,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_CREATE_SID_F, {
	"sid",
	".cg.G2C_Create.sid",
	3,
	2,
	1,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_3.G2C_CREATE_ME, {
	"G2C_Create",
	".cg.G2C_Create",
	{},
	{},
	{
		var_0_3.G2C_CREATE_RET_F,
		var_0_3.G2C_CREATE_UID_F,
		var_0_3.G2C_CREATE_SID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_SAYHI_VERSION_F, {
	"version",
	".cg.C2G_SayHi.version",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_3.C2G_SAYHI_ME, {
	"C2G_SayHi",
	".cg.C2G_SayHi",
	{},
	{},
	{
		var_0_3.C2G_SAYHI_VERSION_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_SAYHI_ID_F, {
	"id",
	".cg.G2C_SayHi.id",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_SAYHI_CURRENT_F, {
	"current",
	".cg.G2C_SayHi.current",
	2,
	1,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_SAYHI_DEL_F, {
	"del",
	".cg.G2C_SayHi.del",
	3,
	2,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_SAYHI_VERSION_F, {
	"version",
	".cg.G2C_SayHi.version",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.descriptorFunc(var_0_3.G2C_SAYHI_ME, {
	"G2C_SayHi",
	".cg.G2C_SayHi",
	{},
	{},
	{
		var_0_3.G2C_SAYHI_ID_F,
		var_0_3.G2C_SAYHI_CURRENT_F,
		var_0_3.G2C_SAYHI_DEL_F,
		var_0_3.G2C_SAYHI_VERSION_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_3.C2G_KEEPALIVE_ME, {
	"C2G_KeepAlive",
	".cg.C2G_KeepAlive",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_3.G2C_KEEPALIVE_ME, {
	"G2C_KeepAlive",
	".cg.G2C_KeepAlive",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_3.C2G_OFFLINE_ME, {
	"C2G_Offline",
	".cg.C2G_Offline",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_OFFLINE_REASON_F, {
	"reason",
	".cg.G2C_Offline.reason",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_3.G2C_OFFLINE_ME, {
	"G2C_Offline",
	".cg.G2C_Offline",
	{},
	{},
	{
		var_0_3.G2C_OFFLINE_REASON_F
	},
	false,
	{}
})
descriptor_helper.descriptorFunc(var_0_3.C2G_OFFLINENEW_ME, {
	"C2G_OfflineNew",
	".cg.C2G_OfflineNew",
	{},
	{},
	{},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_OFFLINENEW_REASON_F, {
	"reason",
	".cg.G2C_OfflineNew.reason",
	1,
	0,
	1,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_3.G2C_OFFLINENEW_ME, {
	"G2C_OfflineNew",
	".cg.G2C_OfflineNew",
	{},
	{},
	{
		var_0_3.G2C_OFFLINENEW_REASON_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_BROADCAST_IDS_F, {
	"ids",
	".cg.G2C_Broadcast.ids",
	1,
	0,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_BROADCAST_CMD_F, {
	"cmd",
	".cg.G2C_Broadcast.cmd",
	2,
	1,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_BROADCAST_SID_F, {
	"sid",
	".cg.G2C_Broadcast.sid",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_BROADCAST_INFO_F, {
	"info",
	".cg.G2C_Broadcast.info",
	4,
	3,
	1,
	false,
	"",
	nil,
	nil,
	12,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_BROADCAST_TO_SIDS_F, {
	"to_sids",
	".cg.G2C_Broadcast.to_sids",
	5,
	4,
	3,
	false,
	{},
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_3.G2C_BROADCAST_ME, {
	"G2C_Broadcast",
	".cg.G2C_Broadcast",
	{},
	{},
	{
		var_0_3.G2C_BROADCAST_IDS_F,
		var_0_3.G2C_BROADCAST_CMD_F,
		var_0_3.G2C_BROADCAST_SID_F,
		var_0_3.G2C_BROADCAST_INFO_F,
		var_0_3.G2C_BROADCAST_TO_SIDS_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_ACTIVATE_TOKEN_F, {
	"token",
	".cg.C2G_Activate.token",
	1,
	0,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_ACTIVATE_CODE_F, {
	"code",
	".cg.C2G_Activate.code",
	2,
	1,
	2,
	false,
	"",
	nil,
	nil,
	9,
	9
})
descriptor_helper.fieldDescriptorFunc(var_0_3.C2G_ACTIVATE_SERVER_ID_F, {
	"server_id",
	".cg.C2G_Activate.server_id",
	3,
	2,
	2,
	false,
	0,
	nil,
	nil,
	4,
	4
})
descriptor_helper.descriptorFunc(var_0_3.C2G_ACTIVATE_ME, {
	"C2G_Activate",
	".cg.C2G_Activate",
	{},
	{},
	{
		var_0_3.C2G_ACTIVATE_TOKEN_F,
		var_0_3.C2G_ACTIVATE_CODE_F,
		var_0_3.C2G_ACTIVATE_SERVER_ID_F
	},
	false,
	{}
})
descriptor_helper.fieldDescriptorFunc(var_0_3.G2C_ACTIVATE_RET_F, {
	"ret",
	".cg.G2C_Activate.ret",
	1,
	0,
	2,
	false,
	0,
	nil,
	nil,
	13,
	3
})
descriptor_helper.descriptorFunc(var_0_3.G2C_ACTIVATE_ME, {
	"G2C_Activate",
	".cg.G2C_Activate",
	{},
	{},
	{
		var_0_3.G2C_ACTIVATE_RET_F
	},
	false,
	{}
})

var_0_3.C2G_Activate = protobuf.Message(var_0_3.C2G_ACTIVATE_ME)
var_0_3.C2G_Create = protobuf.Message(var_0_3.C2G_CREATE_ME)
var_0_3.C2G_KeepAlive = protobuf.Message(var_0_3.C2G_KEEPALIVE_ME)
var_0_3.C2G_Login = protobuf.Message(var_0_3.C2G_LOGIN_ME)
var_0_3.C2G_Offline = protobuf.Message(var_0_3.C2G_OFFLINE_ME)
var_0_3.C2G_OfflineNew = protobuf.Message(var_0_3.C2G_OFFLINENEW_ME)
var_0_3.C2G_SayHi = protobuf.Message(var_0_3.C2G_SAYHI_ME)
var_0_3.G2C_Activate = protobuf.Message(var_0_3.G2C_ACTIVATE_ME)
var_0_3.G2C_Broadcast = protobuf.Message(var_0_3.G2C_BROADCAST_ME)
var_0_3.G2C_Create = protobuf.Message(var_0_3.G2C_CREATE_ME)
var_0_3.G2C_KeepAlive = protobuf.Message(var_0_3.G2C_KEEPALIVE_ME)
var_0_3.G2C_Login = protobuf.Message(var_0_3.G2C_LOGIN_ME)
var_0_3.G2C_Offline = protobuf.Message(var_0_3.G2C_OFFLINE_ME)
var_0_3.G2C_OfflineNew = protobuf.Message(var_0_3.G2C_OFFLINENEW_ME)
var_0_3.G2C_SayHi = protobuf.Message(var_0_3.G2C_SAYHI_ME)

return var_0_3

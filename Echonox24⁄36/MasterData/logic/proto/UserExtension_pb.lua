-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/UserExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.UserExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.ImportantInstantKey = protobuf.EnumDescriptor()
enum_item_descriptors.ImportantInstantKey_DAILY_FIVE = protobuf.EnumValueDescriptor()
enum_item_descriptors.ImportantInstantKey_MONDAY_FIVE = protobuf.EnumValueDescriptor()
enum_item_descriptors.ImportantInstantKey_CONFIG_UPDATE = protobuf.EnumValueDescriptor()
enum_item_descriptors.ImportantInstantKey_DAILY_ZERO = protobuf.EnumValueDescriptor()
enum_item_descriptors.ImportantInstantKey_MONDAY_ZERO = protobuf.EnumValueDescriptor()
type_descriptors.GetServerTimeReply = protobuf.Descriptor()
field_descriptors.GetServerTimeReply_timestamp = protobuf.FieldDescriptor()
field_descriptors.GetServerTimeReply_offset = protobuf.FieldDescriptor()
type_descriptors.RealNameNotifyPush = protobuf.Descriptor()
field_descriptors.RealNameNotifyPush_type = protobuf.FieldDescriptor()
field_descriptors.RealNameNotifyPush_title = protobuf.FieldDescriptor()
field_descriptors.RealNameNotifyPush_msg = protobuf.FieldDescriptor()
field_descriptors.RealNameNotifyPush_link = protobuf.FieldDescriptor()
type_descriptors.LogoutReply = protobuf.Descriptor()
type_descriptors.SendDeviceInfoReply = protobuf.Descriptor()
type_descriptors.SendDevicePerformanceMetricRequest = protobuf.Descriptor()
field_descriptors.SendDevicePerformanceMetricRequest_logic = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_deviceName = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_memory = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_resolution = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_hdr = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_platform = protobuf.FieldDescriptor()
field_descriptors.SendDevicePerformanceMetricRequest_level = protobuf.FieldDescriptor()
type_descriptors.ServerGitVersionPush = protobuf.Descriptor()
field_descriptors.ServerGitVersionPush_id = protobuf.FieldDescriptor()
field_descriptors.ServerGitVersionPush_user = protobuf.FieldDescriptor()
field_descriptors.ServerGitVersionPush_time = protobuf.FieldDescriptor()
field_descriptors.ServerGitVersionPush_branch = protobuf.FieldDescriptor()
field_descriptors.ServerGitVersionPush_dirty = protobuf.FieldDescriptor()
type_descriptors.UploadStatsRequest = protobuf.Descriptor()
field_descriptors.UploadStatsRequest_eventId = protobuf.FieldDescriptor()
field_descriptors.UploadStatsRequest_params = protobuf.FieldDescriptor()
type_descriptors.UploadStatsReply = protobuf.Descriptor()
type_descriptors.GetServerTimeRequest = protobuf.Descriptor()
type_descriptors.LogoutRequest = protobuf.Descriptor()
type_descriptors.SendDevicePerformanceMetricReply = protobuf.Descriptor()
type_descriptors.SendDeviceInfoRequest = protobuf.Descriptor()
field_descriptors.SendDeviceInfoRequest_infoJson = protobuf.FieldDescriptor()
type_descriptors.OnImportantInstantPush = protobuf.Descriptor()
field_descriptors.OnImportantInstantPush_key = protobuf.FieldDescriptor()
field_descriptors.OnImportantInstantPush_timestamp = protobuf.FieldDescriptor()
field_descriptors.OnImportantInstantPush_offset = protobuf.FieldDescriptor()
enum_item_descriptors.ImportantInstantKey_DAILY_FIVE.name = "DAILY_FIVE"
enum_item_descriptors.ImportantInstantKey_DAILY_FIVE.index = 0
enum_item_descriptors.ImportantInstantKey_DAILY_FIVE.number = 1
enum_item_descriptors.ImportantInstantKey_MONDAY_FIVE.name = "MONDAY_FIVE"
enum_item_descriptors.ImportantInstantKey_MONDAY_FIVE.index = 1
enum_item_descriptors.ImportantInstantKey_MONDAY_FIVE.number = 2
enum_item_descriptors.ImportantInstantKey_CONFIG_UPDATE.name = "CONFIG_UPDATE"
enum_item_descriptors.ImportantInstantKey_CONFIG_UPDATE.index = 2
enum_item_descriptors.ImportantInstantKey_CONFIG_UPDATE.number = 3
enum_item_descriptors.ImportantInstantKey_DAILY_ZERO.name = "DAILY_ZERO"
enum_item_descriptors.ImportantInstantKey_DAILY_ZERO.index = 3
enum_item_descriptors.ImportantInstantKey_DAILY_ZERO.number = 4
enum_item_descriptors.ImportantInstantKey_MONDAY_ZERO.name = "MONDAY_ZERO"
enum_item_descriptors.ImportantInstantKey_MONDAY_ZERO.index = 4
enum_item_descriptors.ImportantInstantKey_MONDAY_ZERO.number = 5
type_descriptors.ImportantInstantKey.name = "ImportantInstantKey"
type_descriptors.ImportantInstantKey.full_name = ".ImportantInstantKey"
type_descriptors.ImportantInstantKey.values = {
	enum_item_descriptors.ImportantInstantKey_DAILY_FIVE,
	enum_item_descriptors.ImportantInstantKey_MONDAY_FIVE,
	enum_item_descriptors.ImportantInstantKey_CONFIG_UPDATE,
	enum_item_descriptors.ImportantInstantKey_DAILY_ZERO,
	enum_item_descriptors.ImportantInstantKey_MONDAY_ZERO
}
field_descriptors.GetServerTimeReply_timestamp.name = "timestamp"
field_descriptors.GetServerTimeReply_timestamp.full_name = ".GetServerTimeReply.timestamp"
field_descriptors.GetServerTimeReply_timestamp.number = 1
field_descriptors.GetServerTimeReply_timestamp.index = 0
field_descriptors.GetServerTimeReply_timestamp.label = 1
field_descriptors.GetServerTimeReply_timestamp.has_default_value = false
field_descriptors.GetServerTimeReply_timestamp.default_value = 0
field_descriptors.GetServerTimeReply_timestamp.type = 5
field_descriptors.GetServerTimeReply_timestamp.cpp_type = 1
field_descriptors.GetServerTimeReply_offset.name = "offset"
field_descriptors.GetServerTimeReply_offset.full_name = ".GetServerTimeReply.offset"
field_descriptors.GetServerTimeReply_offset.number = 2
field_descriptors.GetServerTimeReply_offset.index = 1
field_descriptors.GetServerTimeReply_offset.label = 1
field_descriptors.GetServerTimeReply_offset.has_default_value = false
field_descriptors.GetServerTimeReply_offset.default_value = 0
field_descriptors.GetServerTimeReply_offset.type = 5
field_descriptors.GetServerTimeReply_offset.cpp_type = 1
type_descriptors.GetServerTimeReply.name = "GetServerTimeReply"
type_descriptors.GetServerTimeReply.full_name = ".GetServerTimeReply"
type_descriptors.GetServerTimeReply.nested_types = {}
type_descriptors.GetServerTimeReply.enum_types = {}
type_descriptors.GetServerTimeReply.fields = {
	field_descriptors.GetServerTimeReply_timestamp,
	field_descriptors.GetServerTimeReply_offset
}
type_descriptors.GetServerTimeReply.is_extendable = false
type_descriptors.GetServerTimeReply.extensions = {}
field_descriptors.RealNameNotifyPush_type.name = "type"
field_descriptors.RealNameNotifyPush_type.full_name = ".RealNameNotifyPush.type"
field_descriptors.RealNameNotifyPush_type.number = 1
field_descriptors.RealNameNotifyPush_type.index = 0
field_descriptors.RealNameNotifyPush_type.label = 2
field_descriptors.RealNameNotifyPush_type.has_default_value = false
field_descriptors.RealNameNotifyPush_type.default_value = 0
field_descriptors.RealNameNotifyPush_type.type = 5
field_descriptors.RealNameNotifyPush_type.cpp_type = 1
field_descriptors.RealNameNotifyPush_title.name = "title"
field_descriptors.RealNameNotifyPush_title.full_name = ".RealNameNotifyPush.title"
field_descriptors.RealNameNotifyPush_title.number = 2
field_descriptors.RealNameNotifyPush_title.index = 1
field_descriptors.RealNameNotifyPush_title.label = 1
field_descriptors.RealNameNotifyPush_title.has_default_value = false
field_descriptors.RealNameNotifyPush_title.default_value = ""
field_descriptors.RealNameNotifyPush_title.type = 9
field_descriptors.RealNameNotifyPush_title.cpp_type = 9
field_descriptors.RealNameNotifyPush_msg.name = "msg"
field_descriptors.RealNameNotifyPush_msg.full_name = ".RealNameNotifyPush.msg"
field_descriptors.RealNameNotifyPush_msg.number = 3
field_descriptors.RealNameNotifyPush_msg.index = 2
field_descriptors.RealNameNotifyPush_msg.label = 1
field_descriptors.RealNameNotifyPush_msg.has_default_value = false
field_descriptors.RealNameNotifyPush_msg.default_value = ""
field_descriptors.RealNameNotifyPush_msg.type = 9
field_descriptors.RealNameNotifyPush_msg.cpp_type = 9
field_descriptors.RealNameNotifyPush_link.name = "link"
field_descriptors.RealNameNotifyPush_link.full_name = ".RealNameNotifyPush.link"
field_descriptors.RealNameNotifyPush_link.number = 4
field_descriptors.RealNameNotifyPush_link.index = 3
field_descriptors.RealNameNotifyPush_link.label = 1
field_descriptors.RealNameNotifyPush_link.has_default_value = false
field_descriptors.RealNameNotifyPush_link.default_value = ""
field_descriptors.RealNameNotifyPush_link.type = 9
field_descriptors.RealNameNotifyPush_link.cpp_type = 9
type_descriptors.RealNameNotifyPush.name = "RealNameNotifyPush"
type_descriptors.RealNameNotifyPush.full_name = ".RealNameNotifyPush"
type_descriptors.RealNameNotifyPush.nested_types = {}
type_descriptors.RealNameNotifyPush.enum_types = {}
type_descriptors.RealNameNotifyPush.fields = {
	field_descriptors.RealNameNotifyPush_type,
	field_descriptors.RealNameNotifyPush_title,
	field_descriptors.RealNameNotifyPush_msg,
	field_descriptors.RealNameNotifyPush_link
}
type_descriptors.RealNameNotifyPush.is_extendable = false
type_descriptors.RealNameNotifyPush.extensions = {}
type_descriptors.LogoutReply.name = "LogoutReply"
type_descriptors.LogoutReply.full_name = ".LogoutReply"
type_descriptors.LogoutReply.nested_types = {}
type_descriptors.LogoutReply.enum_types = {}
type_descriptors.LogoutReply.fields = {}
type_descriptors.LogoutReply.is_extendable = false
type_descriptors.LogoutReply.extensions = {}
type_descriptors.SendDeviceInfoReply.name = "SendDeviceInfoReply"
type_descriptors.SendDeviceInfoReply.full_name = ".SendDeviceInfoReply"
type_descriptors.SendDeviceInfoReply.nested_types = {}
type_descriptors.SendDeviceInfoReply.enum_types = {}
type_descriptors.SendDeviceInfoReply.fields = {}
type_descriptors.SendDeviceInfoReply.is_extendable = false
type_descriptors.SendDeviceInfoReply.extensions = {}
field_descriptors.SendDevicePerformanceMetricRequest_logic.name = "logic"
field_descriptors.SendDevicePerformanceMetricRequest_logic.full_name = ".SendDevicePerformanceMetricRequest.logic"
field_descriptors.SendDevicePerformanceMetricRequest_logic.number = 1
field_descriptors.SendDevicePerformanceMetricRequest_logic.index = 0
field_descriptors.SendDevicePerformanceMetricRequest_logic.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_logic.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_logic.default_value = ""
field_descriptors.SendDevicePerformanceMetricRequest_logic.type = 9
field_descriptors.SendDevicePerformanceMetricRequest_logic.cpp_type = 9
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.name = "deviceName"
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.full_name = ".SendDevicePerformanceMetricRequest.deviceName"
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.number = 2
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.index = 1
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.default_value = ""
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.type = 9
field_descriptors.SendDevicePerformanceMetricRequest_deviceName.cpp_type = 9
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.name = "cpuModel"
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.full_name = ".SendDevicePerformanceMetricRequest.cpuModel"
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.number = 3
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.index = 2
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.default_value = ""
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.type = 9
field_descriptors.SendDevicePerformanceMetricRequest_cpuModel.cpp_type = 9
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.name = "gpuModel"
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.full_name = ".SendDevicePerformanceMetricRequest.gpuModel"
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.number = 4
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.index = 3
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.default_value = ""
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.type = 9
field_descriptors.SendDevicePerformanceMetricRequest_gpuModel.cpp_type = 9
field_descriptors.SendDevicePerformanceMetricRequest_memory.name = "memory"
field_descriptors.SendDevicePerformanceMetricRequest_memory.full_name = ".SendDevicePerformanceMetricRequest.memory"
field_descriptors.SendDevicePerformanceMetricRequest_memory.number = 5
field_descriptors.SendDevicePerformanceMetricRequest_memory.index = 4
field_descriptors.SendDevicePerformanceMetricRequest_memory.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_memory.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_memory.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_memory.type = 5
field_descriptors.SendDevicePerformanceMetricRequest_memory.cpp_type = 1
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.name = "realTimeFrameRate"
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.full_name = ".SendDevicePerformanceMetricRequest.realTimeFrameRate"
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.number = 6
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.index = 5
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.type = 2
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate.cpp_type = 6
field_descriptors.SendDevicePerformanceMetricRequest_resolution.name = "resolution"
field_descriptors.SendDevicePerformanceMetricRequest_resolution.full_name = ".SendDevicePerformanceMetricRequest.resolution"
field_descriptors.SendDevicePerformanceMetricRequest_resolution.number = 7
field_descriptors.SendDevicePerformanceMetricRequest_resolution.index = 6
field_descriptors.SendDevicePerformanceMetricRequest_resolution.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_resolution.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_resolution.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_resolution.type = 5
field_descriptors.SendDevicePerformanceMetricRequest_resolution.cpp_type = 1
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.name = "effectLevel"
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.full_name = ".SendDevicePerformanceMetricRequest.effectLevel"
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.number = 8
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.index = 7
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.type = 5
field_descriptors.SendDevicePerformanceMetricRequest_effectLevel.cpp_type = 1
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.name = "gameFrameRate"
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.full_name = ".SendDevicePerformanceMetricRequest.gameFrameRate"
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.number = 9
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.index = 8
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.type = 5
field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate.cpp_type = 1
field_descriptors.SendDevicePerformanceMetricRequest_hdr.name = "hdr"
field_descriptors.SendDevicePerformanceMetricRequest_hdr.full_name = ".SendDevicePerformanceMetricRequest.hdr"
field_descriptors.SendDevicePerformanceMetricRequest_hdr.number = 10
field_descriptors.SendDevicePerformanceMetricRequest_hdr.index = 9
field_descriptors.SendDevicePerformanceMetricRequest_hdr.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_hdr.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_hdr.default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_hdr.type = 8
field_descriptors.SendDevicePerformanceMetricRequest_hdr.cpp_type = 7
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.name = "antiAliasing"
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.full_name = ".SendDevicePerformanceMetricRequest.antiAliasing"
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.number = 11
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.index = 10
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.type = 8
field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing.cpp_type = 7
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.name = "realTimeFrameRateVar"
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.full_name = ".SendDevicePerformanceMetricRequest.realTimeFrameRateVar"
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.number = 12
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.index = 11
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.type = 2
field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar.cpp_type = 6
field_descriptors.SendDevicePerformanceMetricRequest_platform.name = "platform"
field_descriptors.SendDevicePerformanceMetricRequest_platform.full_name = ".SendDevicePerformanceMetricRequest.platform"
field_descriptors.SendDevicePerformanceMetricRequest_platform.number = 13
field_descriptors.SendDevicePerformanceMetricRequest_platform.index = 12
field_descriptors.SendDevicePerformanceMetricRequest_platform.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_platform.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_platform.default_value = ""
field_descriptors.SendDevicePerformanceMetricRequest_platform.type = 9
field_descriptors.SendDevicePerformanceMetricRequest_platform.cpp_type = 9
field_descriptors.SendDevicePerformanceMetricRequest_level.name = "level"
field_descriptors.SendDevicePerformanceMetricRequest_level.full_name = ".SendDevicePerformanceMetricRequest.level"
field_descriptors.SendDevicePerformanceMetricRequest_level.number = 14
field_descriptors.SendDevicePerformanceMetricRequest_level.index = 13
field_descriptors.SendDevicePerformanceMetricRequest_level.label = 1
field_descriptors.SendDevicePerformanceMetricRequest_level.has_default_value = false
field_descriptors.SendDevicePerformanceMetricRequest_level.default_value = 0
field_descriptors.SendDevicePerformanceMetricRequest_level.type = 5
field_descriptors.SendDevicePerformanceMetricRequest_level.cpp_type = 1
type_descriptors.SendDevicePerformanceMetricRequest.name = "SendDevicePerformanceMetricRequest"
type_descriptors.SendDevicePerformanceMetricRequest.full_name = ".SendDevicePerformanceMetricRequest"
type_descriptors.SendDevicePerformanceMetricRequest.nested_types = {}
type_descriptors.SendDevicePerformanceMetricRequest.enum_types = {}
type_descriptors.SendDevicePerformanceMetricRequest.fields = {
	field_descriptors.SendDevicePerformanceMetricRequest_logic,
	field_descriptors.SendDevicePerformanceMetricRequest_deviceName,
	field_descriptors.SendDevicePerformanceMetricRequest_cpuModel,
	field_descriptors.SendDevicePerformanceMetricRequest_gpuModel,
	field_descriptors.SendDevicePerformanceMetricRequest_memory,
	field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRate,
	field_descriptors.SendDevicePerformanceMetricRequest_resolution,
	field_descriptors.SendDevicePerformanceMetricRequest_effectLevel,
	field_descriptors.SendDevicePerformanceMetricRequest_gameFrameRate,
	field_descriptors.SendDevicePerformanceMetricRequest_hdr,
	field_descriptors.SendDevicePerformanceMetricRequest_antiAliasing,
	field_descriptors.SendDevicePerformanceMetricRequest_realTimeFrameRateVar,
	field_descriptors.SendDevicePerformanceMetricRequest_platform,
	field_descriptors.SendDevicePerformanceMetricRequest_level
}
type_descriptors.SendDevicePerformanceMetricRequest.is_extendable = false
type_descriptors.SendDevicePerformanceMetricRequest.extensions = {}
field_descriptors.ServerGitVersionPush_id.name = "id"
field_descriptors.ServerGitVersionPush_id.full_name = ".ServerGitVersionPush.id"
field_descriptors.ServerGitVersionPush_id.number = 1
field_descriptors.ServerGitVersionPush_id.index = 0
field_descriptors.ServerGitVersionPush_id.label = 2
field_descriptors.ServerGitVersionPush_id.has_default_value = false
field_descriptors.ServerGitVersionPush_id.default_value = ""
field_descriptors.ServerGitVersionPush_id.type = 9
field_descriptors.ServerGitVersionPush_id.cpp_type = 9
field_descriptors.ServerGitVersionPush_user.name = "user"
field_descriptors.ServerGitVersionPush_user.full_name = ".ServerGitVersionPush.user"
field_descriptors.ServerGitVersionPush_user.number = 2
field_descriptors.ServerGitVersionPush_user.index = 1
field_descriptors.ServerGitVersionPush_user.label = 2
field_descriptors.ServerGitVersionPush_user.has_default_value = false
field_descriptors.ServerGitVersionPush_user.default_value = ""
field_descriptors.ServerGitVersionPush_user.type = 9
field_descriptors.ServerGitVersionPush_user.cpp_type = 9
field_descriptors.ServerGitVersionPush_time.name = "time"
field_descriptors.ServerGitVersionPush_time.full_name = ".ServerGitVersionPush.time"
field_descriptors.ServerGitVersionPush_time.number = 3
field_descriptors.ServerGitVersionPush_time.index = 2
field_descriptors.ServerGitVersionPush_time.label = 2
field_descriptors.ServerGitVersionPush_time.has_default_value = false
field_descriptors.ServerGitVersionPush_time.default_value = ""
field_descriptors.ServerGitVersionPush_time.type = 9
field_descriptors.ServerGitVersionPush_time.cpp_type = 9
field_descriptors.ServerGitVersionPush_branch.name = "branch"
field_descriptors.ServerGitVersionPush_branch.full_name = ".ServerGitVersionPush.branch"
field_descriptors.ServerGitVersionPush_branch.number = 4
field_descriptors.ServerGitVersionPush_branch.index = 3
field_descriptors.ServerGitVersionPush_branch.label = 2
field_descriptors.ServerGitVersionPush_branch.has_default_value = false
field_descriptors.ServerGitVersionPush_branch.default_value = ""
field_descriptors.ServerGitVersionPush_branch.type = 9
field_descriptors.ServerGitVersionPush_branch.cpp_type = 9
field_descriptors.ServerGitVersionPush_dirty.name = "dirty"
field_descriptors.ServerGitVersionPush_dirty.full_name = ".ServerGitVersionPush.dirty"
field_descriptors.ServerGitVersionPush_dirty.number = 5
field_descriptors.ServerGitVersionPush_dirty.index = 4
field_descriptors.ServerGitVersionPush_dirty.label = 2
field_descriptors.ServerGitVersionPush_dirty.has_default_value = false
field_descriptors.ServerGitVersionPush_dirty.default_value = false
field_descriptors.ServerGitVersionPush_dirty.type = 8
field_descriptors.ServerGitVersionPush_dirty.cpp_type = 7
type_descriptors.ServerGitVersionPush.name = "ServerGitVersionPush"
type_descriptors.ServerGitVersionPush.full_name = ".ServerGitVersionPush"
type_descriptors.ServerGitVersionPush.nested_types = {}
type_descriptors.ServerGitVersionPush.enum_types = {}
type_descriptors.ServerGitVersionPush.fields = {
	field_descriptors.ServerGitVersionPush_id,
	field_descriptors.ServerGitVersionPush_user,
	field_descriptors.ServerGitVersionPush_time,
	field_descriptors.ServerGitVersionPush_branch,
	field_descriptors.ServerGitVersionPush_dirty
}
type_descriptors.ServerGitVersionPush.is_extendable = false
type_descriptors.ServerGitVersionPush.extensions = {}
field_descriptors.UploadStatsRequest_eventId.name = "eventId"
field_descriptors.UploadStatsRequest_eventId.full_name = ".UploadStatsRequest.eventId"
field_descriptors.UploadStatsRequest_eventId.number = 1
field_descriptors.UploadStatsRequest_eventId.index = 0
field_descriptors.UploadStatsRequest_eventId.label = 2
field_descriptors.UploadStatsRequest_eventId.has_default_value = false
field_descriptors.UploadStatsRequest_eventId.default_value = ""
field_descriptors.UploadStatsRequest_eventId.type = 9
field_descriptors.UploadStatsRequest_eventId.cpp_type = 9
field_descriptors.UploadStatsRequest_params.name = "params"
field_descriptors.UploadStatsRequest_params.full_name = ".UploadStatsRequest.params"
field_descriptors.UploadStatsRequest_params.number = 2
field_descriptors.UploadStatsRequest_params.index = 1
field_descriptors.UploadStatsRequest_params.label = 1
field_descriptors.UploadStatsRequest_params.has_default_value = false
field_descriptors.UploadStatsRequest_params.default_value = ""
field_descriptors.UploadStatsRequest_params.type = 9
field_descriptors.UploadStatsRequest_params.cpp_type = 9
type_descriptors.UploadStatsRequest.name = "UploadStatsRequest"
type_descriptors.UploadStatsRequest.full_name = ".UploadStatsRequest"
type_descriptors.UploadStatsRequest.nested_types = {}
type_descriptors.UploadStatsRequest.enum_types = {}
type_descriptors.UploadStatsRequest.fields = {
	field_descriptors.UploadStatsRequest_eventId,
	field_descriptors.UploadStatsRequest_params
}
type_descriptors.UploadStatsRequest.is_extendable = false
type_descriptors.UploadStatsRequest.extensions = {}
type_descriptors.UploadStatsReply.name = "UploadStatsReply"
type_descriptors.UploadStatsReply.full_name = ".UploadStatsReply"
type_descriptors.UploadStatsReply.nested_types = {}
type_descriptors.UploadStatsReply.enum_types = {}
type_descriptors.UploadStatsReply.fields = {}
type_descriptors.UploadStatsReply.is_extendable = false
type_descriptors.UploadStatsReply.extensions = {}
type_descriptors.GetServerTimeRequest.name = "GetServerTimeRequest"
type_descriptors.GetServerTimeRequest.full_name = ".GetServerTimeRequest"
type_descriptors.GetServerTimeRequest.nested_types = {}
type_descriptors.GetServerTimeRequest.enum_types = {}
type_descriptors.GetServerTimeRequest.fields = {}
type_descriptors.GetServerTimeRequest.is_extendable = false
type_descriptors.GetServerTimeRequest.extensions = {}
type_descriptors.LogoutRequest.name = "LogoutRequest"
type_descriptors.LogoutRequest.full_name = ".LogoutRequest"
type_descriptors.LogoutRequest.nested_types = {}
type_descriptors.LogoutRequest.enum_types = {}
type_descriptors.LogoutRequest.fields = {}
type_descriptors.LogoutRequest.is_extendable = false
type_descriptors.LogoutRequest.extensions = {}
type_descriptors.SendDevicePerformanceMetricReply.name = "SendDevicePerformanceMetricReply"
type_descriptors.SendDevicePerformanceMetricReply.full_name = ".SendDevicePerformanceMetricReply"
type_descriptors.SendDevicePerformanceMetricReply.nested_types = {}
type_descriptors.SendDevicePerformanceMetricReply.enum_types = {}
type_descriptors.SendDevicePerformanceMetricReply.fields = {}
type_descriptors.SendDevicePerformanceMetricReply.is_extendable = false
type_descriptors.SendDevicePerformanceMetricReply.extensions = {}
field_descriptors.SendDeviceInfoRequest_infoJson.name = "infoJson"
field_descriptors.SendDeviceInfoRequest_infoJson.full_name = ".SendDeviceInfoRequest.infoJson"
field_descriptors.SendDeviceInfoRequest_infoJson.number = 1
field_descriptors.SendDeviceInfoRequest_infoJson.index = 0
field_descriptors.SendDeviceInfoRequest_infoJson.label = 2
field_descriptors.SendDeviceInfoRequest_infoJson.has_default_value = false
field_descriptors.SendDeviceInfoRequest_infoJson.default_value = ""
field_descriptors.SendDeviceInfoRequest_infoJson.type = 9
field_descriptors.SendDeviceInfoRequest_infoJson.cpp_type = 9
type_descriptors.SendDeviceInfoRequest.name = "SendDeviceInfoRequest"
type_descriptors.SendDeviceInfoRequest.full_name = ".SendDeviceInfoRequest"
type_descriptors.SendDeviceInfoRequest.nested_types = {}
type_descriptors.SendDeviceInfoRequest.enum_types = {}
type_descriptors.SendDeviceInfoRequest.fields = {
	field_descriptors.SendDeviceInfoRequest_infoJson
}
type_descriptors.SendDeviceInfoRequest.is_extendable = false
type_descriptors.SendDeviceInfoRequest.extensions = {}
field_descriptors.OnImportantInstantPush_key.name = "key"
field_descriptors.OnImportantInstantPush_key.full_name = ".OnImportantInstantPush.key"
field_descriptors.OnImportantInstantPush_key.number = 1
field_descriptors.OnImportantInstantPush_key.index = 0
field_descriptors.OnImportantInstantPush_key.label = 1
field_descriptors.OnImportantInstantPush_key.has_default_value = false
field_descriptors.OnImportantInstantPush_key.default_value = nil
field_descriptors.OnImportantInstantPush_key.enum_type = type_descriptors.ImportantInstantKey
field_descriptors.OnImportantInstantPush_key.type = 14
field_descriptors.OnImportantInstantPush_key.cpp_type = 8
field_descriptors.OnImportantInstantPush_timestamp.name = "timestamp"
field_descriptors.OnImportantInstantPush_timestamp.full_name = ".OnImportantInstantPush.timestamp"
field_descriptors.OnImportantInstantPush_timestamp.number = 2
field_descriptors.OnImportantInstantPush_timestamp.index = 1
field_descriptors.OnImportantInstantPush_timestamp.label = 1
field_descriptors.OnImportantInstantPush_timestamp.has_default_value = false
field_descriptors.OnImportantInstantPush_timestamp.default_value = 0
field_descriptors.OnImportantInstantPush_timestamp.type = 5
field_descriptors.OnImportantInstantPush_timestamp.cpp_type = 1
field_descriptors.OnImportantInstantPush_offset.name = "offset"
field_descriptors.OnImportantInstantPush_offset.full_name = ".OnImportantInstantPush.offset"
field_descriptors.OnImportantInstantPush_offset.number = 3
field_descriptors.OnImportantInstantPush_offset.index = 2
field_descriptors.OnImportantInstantPush_offset.label = 1
field_descriptors.OnImportantInstantPush_offset.has_default_value = false
field_descriptors.OnImportantInstantPush_offset.default_value = 0
field_descriptors.OnImportantInstantPush_offset.type = 5
field_descriptors.OnImportantInstantPush_offset.cpp_type = 1
type_descriptors.OnImportantInstantPush.name = "OnImportantInstantPush"
type_descriptors.OnImportantInstantPush.full_name = ".OnImportantInstantPush"
type_descriptors.OnImportantInstantPush.nested_types = {}
type_descriptors.OnImportantInstantPush.enum_types = {}
type_descriptors.OnImportantInstantPush.fields = {
	field_descriptors.OnImportantInstantPush_key,
	field_descriptors.OnImportantInstantPush_timestamp,
	field_descriptors.OnImportantInstantPush_offset
}
type_descriptors.OnImportantInstantPush.is_extendable = false
type_descriptors.OnImportantInstantPush.extensions = {}
ImportantInstantKey = {
	CONFIG_UPDATE = 3,
	MONDAY_ZERO = 5,
	DAILY_FIVE = 1,
	DAILY_ZERO = 4,
	MONDAY_FIVE = 2
}
GetServerTimeReply = protobuf.Message(type_descriptors.GetServerTimeReply)
GetServerTimeRequest = protobuf.Message(type_descriptors.GetServerTimeRequest)
LogoutReply = protobuf.Message(type_descriptors.LogoutReply)
LogoutRequest = protobuf.Message(type_descriptors.LogoutRequest)
OnImportantInstantPush = protobuf.Message(type_descriptors.OnImportantInstantPush)
RealNameNotifyPush = protobuf.Message(type_descriptors.RealNameNotifyPush)
SendDeviceInfoReply = protobuf.Message(type_descriptors.SendDeviceInfoReply)
SendDeviceInfoRequest = protobuf.Message(type_descriptors.SendDeviceInfoRequest)
SendDevicePerformanceMetricReply = protobuf.Message(type_descriptors.SendDevicePerformanceMetricReply)
SendDevicePerformanceMetricRequest = protobuf.Message(type_descriptors.SendDevicePerformanceMetricRequest)
ServerGitVersionPush = protobuf.Message(type_descriptors.ServerGitVersionPush)
UploadStatsReply = protobuf.Message(type_descriptors.UploadStatsReply)
UploadStatsRequest = protobuf.Message(type_descriptors.UploadStatsRequest)

return _G["logic.proto.UserExtension_pb"]

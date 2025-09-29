-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/TacitExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.TaskExtension = require("logic.proto.TaskExtension_pb")

module("logic.proto.TacitExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.TakeTaskRewardRequest = protobuf.Descriptor()
field_descriptors.TakeTaskRewardRequest_taskId = protobuf.FieldDescriptor()
type_descriptors.NotifyTaskProgressPush = protobuf.Descriptor()
field_descriptors.NotifyTaskProgressPush_taskId = protobuf.FieldDescriptor()
field_descriptors.NotifyTaskProgressPush_progress = protobuf.FieldDescriptor()
type_descriptors.WakeupReply = protobuf.Descriptor()
type_descriptors.TakeTaskRewardReply = protobuf.Descriptor()
type_descriptors.GetPrimaryTaskInfoRequest = protobuf.Descriptor()
type_descriptors.MarkPrimaryTaskRequest = protobuf.Descriptor()
field_descriptors.MarkPrimaryTaskRequest_taskId = protobuf.FieldDescriptor()
type_descriptors.MarkPrimaryTaskReply = protobuf.Descriptor()
type_descriptors.WakeupRequest = protobuf.Descriptor()
field_descriptors.WakeupRequest_heroId = protobuf.FieldDescriptor()
type_descriptors.GetTaskInfoRequest = protobuf.Descriptor()
field_descriptors.GetTaskInfoRequest_hero = protobuf.FieldDescriptor()
type_descriptors.GetPrimaryTaskInfoReply = protobuf.Descriptor()
field_descriptors.GetPrimaryTaskInfoReply_tasks = protobuf.FieldDescriptor()
type_descriptors.GetTaskInfoReply = protobuf.Descriptor()
field_descriptors.GetTaskInfoReply_tasks = protobuf.FieldDescriptor()
field_descriptors.GetTaskInfoReply_primary = protobuf.FieldDescriptor()
field_descriptors.TakeTaskRewardRequest_taskId.name = "taskId"
field_descriptors.TakeTaskRewardRequest_taskId.full_name = ".TakeTaskRewardRequest.taskId"
field_descriptors.TakeTaskRewardRequest_taskId.number = 1
field_descriptors.TakeTaskRewardRequest_taskId.index = 0
field_descriptors.TakeTaskRewardRequest_taskId.label = 1
field_descriptors.TakeTaskRewardRequest_taskId.has_default_value = false
field_descriptors.TakeTaskRewardRequest_taskId.default_value = 0
field_descriptors.TakeTaskRewardRequest_taskId.type = 5
field_descriptors.TakeTaskRewardRequest_taskId.cpp_type = 1
type_descriptors.TakeTaskRewardRequest.name = "TakeTaskRewardRequest"
type_descriptors.TakeTaskRewardRequest.full_name = ".TakeTaskRewardRequest"
type_descriptors.TakeTaskRewardRequest.nested_types = {}
type_descriptors.TakeTaskRewardRequest.enum_types = {}
type_descriptors.TakeTaskRewardRequest.fields = {
	field_descriptors.TakeTaskRewardRequest_taskId
}
type_descriptors.TakeTaskRewardRequest.is_extendable = false
type_descriptors.TakeTaskRewardRequest.extensions = {}
field_descriptors.NotifyTaskProgressPush_taskId.name = "taskId"
field_descriptors.NotifyTaskProgressPush_taskId.full_name = ".NotifyTaskProgressPush.taskId"
field_descriptors.NotifyTaskProgressPush_taskId.number = 1
field_descriptors.NotifyTaskProgressPush_taskId.index = 0
field_descriptors.NotifyTaskProgressPush_taskId.label = 1
field_descriptors.NotifyTaskProgressPush_taskId.has_default_value = false
field_descriptors.NotifyTaskProgressPush_taskId.default_value = 0
field_descriptors.NotifyTaskProgressPush_taskId.type = 5
field_descriptors.NotifyTaskProgressPush_taskId.cpp_type = 1
field_descriptors.NotifyTaskProgressPush_progress.name = "progress"
field_descriptors.NotifyTaskProgressPush_progress.full_name = ".NotifyTaskProgressPush.progress"
field_descriptors.NotifyTaskProgressPush_progress.number = 2
field_descriptors.NotifyTaskProgressPush_progress.index = 1
field_descriptors.NotifyTaskProgressPush_progress.label = 1
field_descriptors.NotifyTaskProgressPush_progress.has_default_value = false
field_descriptors.NotifyTaskProgressPush_progress.default_value = 0
field_descriptors.NotifyTaskProgressPush_progress.type = 5
field_descriptors.NotifyTaskProgressPush_progress.cpp_type = 1
type_descriptors.NotifyTaskProgressPush.name = "NotifyTaskProgressPush"
type_descriptors.NotifyTaskProgressPush.full_name = ".NotifyTaskProgressPush"
type_descriptors.NotifyTaskProgressPush.nested_types = {}
type_descriptors.NotifyTaskProgressPush.enum_types = {}
type_descriptors.NotifyTaskProgressPush.fields = {
	field_descriptors.NotifyTaskProgressPush_taskId,
	field_descriptors.NotifyTaskProgressPush_progress
}
type_descriptors.NotifyTaskProgressPush.is_extendable = false
type_descriptors.NotifyTaskProgressPush.extensions = {}
type_descriptors.WakeupReply.name = "WakeupReply"
type_descriptors.WakeupReply.full_name = ".WakeupReply"
type_descriptors.WakeupReply.nested_types = {}
type_descriptors.WakeupReply.enum_types = {}
type_descriptors.WakeupReply.fields = {}
type_descriptors.WakeupReply.is_extendable = false
type_descriptors.WakeupReply.extensions = {}
type_descriptors.TakeTaskRewardReply.name = "TakeTaskRewardReply"
type_descriptors.TakeTaskRewardReply.full_name = ".TakeTaskRewardReply"
type_descriptors.TakeTaskRewardReply.nested_types = {}
type_descriptors.TakeTaskRewardReply.enum_types = {}
type_descriptors.TakeTaskRewardReply.fields = {}
type_descriptors.TakeTaskRewardReply.is_extendable = false
type_descriptors.TakeTaskRewardReply.extensions = {}
type_descriptors.GetPrimaryTaskInfoRequest.name = "GetPrimaryTaskInfoRequest"
type_descriptors.GetPrimaryTaskInfoRequest.full_name = ".GetPrimaryTaskInfoRequest"
type_descriptors.GetPrimaryTaskInfoRequest.nested_types = {}
type_descriptors.GetPrimaryTaskInfoRequest.enum_types = {}
type_descriptors.GetPrimaryTaskInfoRequest.fields = {}
type_descriptors.GetPrimaryTaskInfoRequest.is_extendable = false
type_descriptors.GetPrimaryTaskInfoRequest.extensions = {}
field_descriptors.MarkPrimaryTaskRequest_taskId.name = "taskId"
field_descriptors.MarkPrimaryTaskRequest_taskId.full_name = ".MarkPrimaryTaskRequest.taskId"
field_descriptors.MarkPrimaryTaskRequest_taskId.number = 1
field_descriptors.MarkPrimaryTaskRequest_taskId.index = 0
field_descriptors.MarkPrimaryTaskRequest_taskId.label = 1
field_descriptors.MarkPrimaryTaskRequest_taskId.has_default_value = false
field_descriptors.MarkPrimaryTaskRequest_taskId.default_value = 0
field_descriptors.MarkPrimaryTaskRequest_taskId.type = 5
field_descriptors.MarkPrimaryTaskRequest_taskId.cpp_type = 1
type_descriptors.MarkPrimaryTaskRequest.name = "MarkPrimaryTaskRequest"
type_descriptors.MarkPrimaryTaskRequest.full_name = ".MarkPrimaryTaskRequest"
type_descriptors.MarkPrimaryTaskRequest.nested_types = {}
type_descriptors.MarkPrimaryTaskRequest.enum_types = {}
type_descriptors.MarkPrimaryTaskRequest.fields = {
	field_descriptors.MarkPrimaryTaskRequest_taskId
}
type_descriptors.MarkPrimaryTaskRequest.is_extendable = false
type_descriptors.MarkPrimaryTaskRequest.extensions = {}
type_descriptors.MarkPrimaryTaskReply.name = "MarkPrimaryTaskReply"
type_descriptors.MarkPrimaryTaskReply.full_name = ".MarkPrimaryTaskReply"
type_descriptors.MarkPrimaryTaskReply.nested_types = {}
type_descriptors.MarkPrimaryTaskReply.enum_types = {}
type_descriptors.MarkPrimaryTaskReply.fields = {}
type_descriptors.MarkPrimaryTaskReply.is_extendable = false
type_descriptors.MarkPrimaryTaskReply.extensions = {}
field_descriptors.WakeupRequest_heroId.name = "heroId"
field_descriptors.WakeupRequest_heroId.full_name = ".WakeupRequest.heroId"
field_descriptors.WakeupRequest_heroId.number = 1
field_descriptors.WakeupRequest_heroId.index = 0
field_descriptors.WakeupRequest_heroId.label = 2
field_descriptors.WakeupRequest_heroId.has_default_value = false
field_descriptors.WakeupRequest_heroId.default_value = 0
field_descriptors.WakeupRequest_heroId.type = 5
field_descriptors.WakeupRequest_heroId.cpp_type = 1
type_descriptors.WakeupRequest.name = "WakeupRequest"
type_descriptors.WakeupRequest.full_name = ".WakeupRequest"
type_descriptors.WakeupRequest.nested_types = {}
type_descriptors.WakeupRequest.enum_types = {}
type_descriptors.WakeupRequest.fields = {
	field_descriptors.WakeupRequest_heroId
}
type_descriptors.WakeupRequest.is_extendable = false
type_descriptors.WakeupRequest.extensions = {}
field_descriptors.GetTaskInfoRequest_hero.name = "hero"
field_descriptors.GetTaskInfoRequest_hero.full_name = ".GetTaskInfoRequest.hero"
field_descriptors.GetTaskInfoRequest_hero.number = 1
field_descriptors.GetTaskInfoRequest_hero.index = 0
field_descriptors.GetTaskInfoRequest_hero.label = 1
field_descriptors.GetTaskInfoRequest_hero.has_default_value = false
field_descriptors.GetTaskInfoRequest_hero.default_value = 0
field_descriptors.GetTaskInfoRequest_hero.type = 5
field_descriptors.GetTaskInfoRequest_hero.cpp_type = 1
type_descriptors.GetTaskInfoRequest.name = "GetTaskInfoRequest"
type_descriptors.GetTaskInfoRequest.full_name = ".GetTaskInfoRequest"
type_descriptors.GetTaskInfoRequest.nested_types = {}
type_descriptors.GetTaskInfoRequest.enum_types = {}
type_descriptors.GetTaskInfoRequest.fields = {
	field_descriptors.GetTaskInfoRequest_hero
}
type_descriptors.GetTaskInfoRequest.is_extendable = false
type_descriptors.GetTaskInfoRequest.extensions = {}
field_descriptors.GetPrimaryTaskInfoReply_tasks.name = "tasks"
field_descriptors.GetPrimaryTaskInfoReply_tasks.full_name = ".GetPrimaryTaskInfoReply.tasks"
field_descriptors.GetPrimaryTaskInfoReply_tasks.number = 1
field_descriptors.GetPrimaryTaskInfoReply_tasks.index = 0
field_descriptors.GetPrimaryTaskInfoReply_tasks.label = 3
field_descriptors.GetPrimaryTaskInfoReply_tasks.has_default_value = false
field_descriptors.GetPrimaryTaskInfoReply_tasks.default_value = {}
field_descriptors.GetPrimaryTaskInfoReply_tasks.message_type = dependencies.TaskExtension.type_descriptors.TaskNO
field_descriptors.GetPrimaryTaskInfoReply_tasks.type = 11
field_descriptors.GetPrimaryTaskInfoReply_tasks.cpp_type = 10
type_descriptors.GetPrimaryTaskInfoReply.name = "GetPrimaryTaskInfoReply"
type_descriptors.GetPrimaryTaskInfoReply.full_name = ".GetPrimaryTaskInfoReply"
type_descriptors.GetPrimaryTaskInfoReply.nested_types = {}
type_descriptors.GetPrimaryTaskInfoReply.enum_types = {}
type_descriptors.GetPrimaryTaskInfoReply.fields = {
	field_descriptors.GetPrimaryTaskInfoReply_tasks
}
type_descriptors.GetPrimaryTaskInfoReply.is_extendable = false
type_descriptors.GetPrimaryTaskInfoReply.extensions = {}
field_descriptors.GetTaskInfoReply_tasks.name = "tasks"
field_descriptors.GetTaskInfoReply_tasks.full_name = ".GetTaskInfoReply.tasks"
field_descriptors.GetTaskInfoReply_tasks.number = 1
field_descriptors.GetTaskInfoReply_tasks.index = 0
field_descriptors.GetTaskInfoReply_tasks.label = 3
field_descriptors.GetTaskInfoReply_tasks.has_default_value = false
field_descriptors.GetTaskInfoReply_tasks.default_value = {}
field_descriptors.GetTaskInfoReply_tasks.message_type = dependencies.TaskExtension.type_descriptors.TaskNO
field_descriptors.GetTaskInfoReply_tasks.type = 11
field_descriptors.GetTaskInfoReply_tasks.cpp_type = 10
field_descriptors.GetTaskInfoReply_primary.name = "primary"
field_descriptors.GetTaskInfoReply_primary.full_name = ".GetTaskInfoReply.primary"
field_descriptors.GetTaskInfoReply_primary.number = 2
field_descriptors.GetTaskInfoReply_primary.index = 1
field_descriptors.GetTaskInfoReply_primary.label = 1
field_descriptors.GetTaskInfoReply_primary.has_default_value = false
field_descriptors.GetTaskInfoReply_primary.default_value = 0
field_descriptors.GetTaskInfoReply_primary.type = 5
field_descriptors.GetTaskInfoReply_primary.cpp_type = 1
type_descriptors.GetTaskInfoReply.name = "GetTaskInfoReply"
type_descriptors.GetTaskInfoReply.full_name = ".GetTaskInfoReply"
type_descriptors.GetTaskInfoReply.nested_types = {}
type_descriptors.GetTaskInfoReply.enum_types = {}
type_descriptors.GetTaskInfoReply.fields = {
	field_descriptors.GetTaskInfoReply_tasks,
	field_descriptors.GetTaskInfoReply_primary
}
type_descriptors.GetTaskInfoReply.is_extendable = false
type_descriptors.GetTaskInfoReply.extensions = {}
GetPrimaryTaskInfoReply = protobuf.Message(type_descriptors.GetPrimaryTaskInfoReply)
GetPrimaryTaskInfoRequest = protobuf.Message(type_descriptors.GetPrimaryTaskInfoRequest)
GetTaskInfoReply = protobuf.Message(type_descriptors.GetTaskInfoReply)
GetTaskInfoRequest = protobuf.Message(type_descriptors.GetTaskInfoRequest)
MarkPrimaryTaskReply = protobuf.Message(type_descriptors.MarkPrimaryTaskReply)
MarkPrimaryTaskRequest = protobuf.Message(type_descriptors.MarkPrimaryTaskRequest)
NotifyTaskProgressPush = protobuf.Message(type_descriptors.NotifyTaskProgressPush)
TakeTaskRewardReply = protobuf.Message(type_descriptors.TakeTaskRewardReply)
TakeTaskRewardRequest = protobuf.Message(type_descriptors.TakeTaskRewardRequest)
WakeupReply = protobuf.Message(type_descriptors.WakeupReply)
WakeupRequest = protobuf.Message(type_descriptors.WakeupRequest)

return _G["logic.proto.TacitExtension_pb"]

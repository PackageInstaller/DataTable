-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/GrowthPlanExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.TaskExtension = require("logic.proto.TaskExtension_pb")

module("logic.proto.GrowthPlanExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.PlanStartPush = protobuf.Descriptor()
field_descriptors.PlanStartPush_plan = protobuf.FieldDescriptor()
type_descriptors.GrowthTasksRequest = protobuf.Descriptor()
type_descriptors.GrowthPlanReply = protobuf.Descriptor()
field_descriptors.GrowthPlanReply_plan = protobuf.FieldDescriptor()
field_descriptors.GrowthPlanReply_stage = protobuf.FieldDescriptor()
type_descriptors.GrowthTaskRewardRequest = protobuf.Descriptor()
field_descriptors.GrowthTaskRewardRequest_id = protobuf.FieldDescriptor()
type_descriptors.GrowthStageRewardRequest = protobuf.Descriptor()
field_descriptors.GrowthStageRewardRequest_stage = protobuf.FieldDescriptor()
type_descriptors.GrowthTaskRewardReply = protobuf.Descriptor()
field_descriptors.GrowthTaskRewardReply_tasks = protobuf.FieldDescriptor()
type_descriptors.GrowthStageRewardReply = protobuf.Descriptor()
type_descriptors.GrowthPlanRequest = protobuf.Descriptor()
type_descriptors.GrowthTasksReply = protobuf.Descriptor()
field_descriptors.GrowthTasksReply_tasks = protobuf.FieldDescriptor()
field_descriptors.PlanStartPush_plan.name = "plan"
field_descriptors.PlanStartPush_plan.full_name = ".PlanStartPush.plan"
field_descriptors.PlanStartPush_plan.number = 1
field_descriptors.PlanStartPush_plan.index = 0
field_descriptors.PlanStartPush_plan.label = 1
field_descriptors.PlanStartPush_plan.has_default_value = false
field_descriptors.PlanStartPush_plan.default_value = 0
field_descriptors.PlanStartPush_plan.type = 5
field_descriptors.PlanStartPush_plan.cpp_type = 1
type_descriptors.PlanStartPush.name = "PlanStartPush"
type_descriptors.PlanStartPush.full_name = ".PlanStartPush"
type_descriptors.PlanStartPush.nested_types = {}
type_descriptors.PlanStartPush.enum_types = {}
type_descriptors.PlanStartPush.fields = {
	field_descriptors.PlanStartPush_plan
}
type_descriptors.PlanStartPush.is_extendable = false
type_descriptors.PlanStartPush.extensions = {}
type_descriptors.GrowthTasksRequest.name = "GrowthTasksRequest"
type_descriptors.GrowthTasksRequest.full_name = ".GrowthTasksRequest"
type_descriptors.GrowthTasksRequest.nested_types = {}
type_descriptors.GrowthTasksRequest.enum_types = {}
type_descriptors.GrowthTasksRequest.fields = {}
type_descriptors.GrowthTasksRequest.is_extendable = false
type_descriptors.GrowthTasksRequest.extensions = {}
field_descriptors.GrowthPlanReply_plan.name = "plan"
field_descriptors.GrowthPlanReply_plan.full_name = ".GrowthPlanReply.plan"
field_descriptors.GrowthPlanReply_plan.number = 1
field_descriptors.GrowthPlanReply_plan.index = 0
field_descriptors.GrowthPlanReply_plan.label = 1
field_descriptors.GrowthPlanReply_plan.has_default_value = false
field_descriptors.GrowthPlanReply_plan.default_value = 0
field_descriptors.GrowthPlanReply_plan.type = 5
field_descriptors.GrowthPlanReply_plan.cpp_type = 1
field_descriptors.GrowthPlanReply_stage.name = "stage"
field_descriptors.GrowthPlanReply_stage.full_name = ".GrowthPlanReply.stage"
field_descriptors.GrowthPlanReply_stage.number = 2
field_descriptors.GrowthPlanReply_stage.index = 1
field_descriptors.GrowthPlanReply_stage.label = 3
field_descriptors.GrowthPlanReply_stage.has_default_value = false
field_descriptors.GrowthPlanReply_stage.default_value = {}
field_descriptors.GrowthPlanReply_stage.type = 5
field_descriptors.GrowthPlanReply_stage.cpp_type = 1
type_descriptors.GrowthPlanReply.name = "GrowthPlanReply"
type_descriptors.GrowthPlanReply.full_name = ".GrowthPlanReply"
type_descriptors.GrowthPlanReply.nested_types = {}
type_descriptors.GrowthPlanReply.enum_types = {}
type_descriptors.GrowthPlanReply.fields = {
	field_descriptors.GrowthPlanReply_plan,
	field_descriptors.GrowthPlanReply_stage
}
type_descriptors.GrowthPlanReply.is_extendable = false
type_descriptors.GrowthPlanReply.extensions = {}
field_descriptors.GrowthTaskRewardRequest_id.name = "id"
field_descriptors.GrowthTaskRewardRequest_id.full_name = ".GrowthTaskRewardRequest.id"
field_descriptors.GrowthTaskRewardRequest_id.number = 1
field_descriptors.GrowthTaskRewardRequest_id.index = 0
field_descriptors.GrowthTaskRewardRequest_id.label = 1
field_descriptors.GrowthTaskRewardRequest_id.has_default_value = false
field_descriptors.GrowthTaskRewardRequest_id.default_value = 0
field_descriptors.GrowthTaskRewardRequest_id.type = 5
field_descriptors.GrowthTaskRewardRequest_id.cpp_type = 1
type_descriptors.GrowthTaskRewardRequest.name = "GrowthTaskRewardRequest"
type_descriptors.GrowthTaskRewardRequest.full_name = ".GrowthTaskRewardRequest"
type_descriptors.GrowthTaskRewardRequest.nested_types = {}
type_descriptors.GrowthTaskRewardRequest.enum_types = {}
type_descriptors.GrowthTaskRewardRequest.fields = {
	field_descriptors.GrowthTaskRewardRequest_id
}
type_descriptors.GrowthTaskRewardRequest.is_extendable = false
type_descriptors.GrowthTaskRewardRequest.extensions = {}
field_descriptors.GrowthStageRewardRequest_stage.name = "stage"
field_descriptors.GrowthStageRewardRequest_stage.full_name = ".GrowthStageRewardRequest.stage"
field_descriptors.GrowthStageRewardRequest_stage.number = 1
field_descriptors.GrowthStageRewardRequest_stage.index = 0
field_descriptors.GrowthStageRewardRequest_stage.label = 1
field_descriptors.GrowthStageRewardRequest_stage.has_default_value = false
field_descriptors.GrowthStageRewardRequest_stage.default_value = 0
field_descriptors.GrowthStageRewardRequest_stage.type = 5
field_descriptors.GrowthStageRewardRequest_stage.cpp_type = 1
type_descriptors.GrowthStageRewardRequest.name = "GrowthStageRewardRequest"
type_descriptors.GrowthStageRewardRequest.full_name = ".GrowthStageRewardRequest"
type_descriptors.GrowthStageRewardRequest.nested_types = {}
type_descriptors.GrowthStageRewardRequest.enum_types = {}
type_descriptors.GrowthStageRewardRequest.fields = {
	field_descriptors.GrowthStageRewardRequest_stage
}
type_descriptors.GrowthStageRewardRequest.is_extendable = false
type_descriptors.GrowthStageRewardRequest.extensions = {}
field_descriptors.GrowthTaskRewardReply_tasks.name = "tasks"
field_descriptors.GrowthTaskRewardReply_tasks.full_name = ".GrowthTaskRewardReply.tasks"
field_descriptors.GrowthTaskRewardReply_tasks.number = 1
field_descriptors.GrowthTaskRewardReply_tasks.index = 0
field_descriptors.GrowthTaskRewardReply_tasks.label = 1
field_descriptors.GrowthTaskRewardReply_tasks.has_default_value = false
field_descriptors.GrowthTaskRewardReply_tasks.default_value = nil
field_descriptors.GrowthTaskRewardReply_tasks.message_type = dependencies.TaskExtension.type_descriptors.TaskNO
field_descriptors.GrowthTaskRewardReply_tasks.type = 11
field_descriptors.GrowthTaskRewardReply_tasks.cpp_type = 10
type_descriptors.GrowthTaskRewardReply.name = "GrowthTaskRewardReply"
type_descriptors.GrowthTaskRewardReply.full_name = ".GrowthTaskRewardReply"
type_descriptors.GrowthTaskRewardReply.nested_types = {}
type_descriptors.GrowthTaskRewardReply.enum_types = {}
type_descriptors.GrowthTaskRewardReply.fields = {
	field_descriptors.GrowthTaskRewardReply_tasks
}
type_descriptors.GrowthTaskRewardReply.is_extendable = false
type_descriptors.GrowthTaskRewardReply.extensions = {}
type_descriptors.GrowthStageRewardReply.name = "GrowthStageRewardReply"
type_descriptors.GrowthStageRewardReply.full_name = ".GrowthStageRewardReply"
type_descriptors.GrowthStageRewardReply.nested_types = {}
type_descriptors.GrowthStageRewardReply.enum_types = {}
type_descriptors.GrowthStageRewardReply.fields = {}
type_descriptors.GrowthStageRewardReply.is_extendable = false
type_descriptors.GrowthStageRewardReply.extensions = {}
type_descriptors.GrowthPlanRequest.name = "GrowthPlanRequest"
type_descriptors.GrowthPlanRequest.full_name = ".GrowthPlanRequest"
type_descriptors.GrowthPlanRequest.nested_types = {}
type_descriptors.GrowthPlanRequest.enum_types = {}
type_descriptors.GrowthPlanRequest.fields = {}
type_descriptors.GrowthPlanRequest.is_extendable = false
type_descriptors.GrowthPlanRequest.extensions = {}
field_descriptors.GrowthTasksReply_tasks.name = "tasks"
field_descriptors.GrowthTasksReply_tasks.full_name = ".GrowthTasksReply.tasks"
field_descriptors.GrowthTasksReply_tasks.number = 1
field_descriptors.GrowthTasksReply_tasks.index = 0
field_descriptors.GrowthTasksReply_tasks.label = 3
field_descriptors.GrowthTasksReply_tasks.has_default_value = false
field_descriptors.GrowthTasksReply_tasks.default_value = {}
field_descriptors.GrowthTasksReply_tasks.message_type = dependencies.TaskExtension.type_descriptors.TaskNO
field_descriptors.GrowthTasksReply_tasks.type = 11
field_descriptors.GrowthTasksReply_tasks.cpp_type = 10
type_descriptors.GrowthTasksReply.name = "GrowthTasksReply"
type_descriptors.GrowthTasksReply.full_name = ".GrowthTasksReply"
type_descriptors.GrowthTasksReply.nested_types = {}
type_descriptors.GrowthTasksReply.enum_types = {}
type_descriptors.GrowthTasksReply.fields = {
	field_descriptors.GrowthTasksReply_tasks
}
type_descriptors.GrowthTasksReply.is_extendable = false
type_descriptors.GrowthTasksReply.extensions = {}
GrowthPlanReply = protobuf.Message(type_descriptors.GrowthPlanReply)
GrowthPlanRequest = protobuf.Message(type_descriptors.GrowthPlanRequest)
GrowthStageRewardReply = protobuf.Message(type_descriptors.GrowthStageRewardReply)
GrowthStageRewardRequest = protobuf.Message(type_descriptors.GrowthStageRewardRequest)
GrowthTaskRewardReply = protobuf.Message(type_descriptors.GrowthTaskRewardReply)
GrowthTaskRewardRequest = protobuf.Message(type_descriptors.GrowthTaskRewardRequest)
GrowthTasksReply = protobuf.Message(type_descriptors.GrowthTasksReply)
GrowthTasksRequest = protobuf.Message(type_descriptors.GrowthTasksRequest)
PlanStartPush = protobuf.Message(type_descriptors.PlanStartPush)

return _G["logic.proto.GrowthPlanExtension_pb"]

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/NewbieExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.NewbieExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.PlotEnum = protobuf.EnumDescriptor()
enum_item_descriptors.PlotEnum_NONE = protobuf.EnumValueDescriptor()
enum_item_descriptors.PlotEnum_DUNGEON = protobuf.EnumValueDescriptor()
type_descriptors.NewbieTaskNO = protobuf.Descriptor()
field_descriptors.NewbieTaskNO_id = protobuf.FieldDescriptor()
field_descriptors.NewbieTaskNO_count = protobuf.FieldDescriptor()
field_descriptors.NewbieTaskNO_finish = protobuf.FieldDescriptor()
type_descriptors.TakeStepRewardReply = protobuf.Descriptor()
field_descriptors.TakeStepRewardReply_info = protobuf.FieldDescriptor()
type_descriptors.PlotAnswerNO = protobuf.Descriptor()
field_descriptors.PlotAnswerNO_question = protobuf.FieldDescriptor()
field_descriptors.PlotAnswerNO_answer = protobuf.FieldDescriptor()
type_descriptors.GetTaskListReply = protobuf.Descriptor()
field_descriptors.GetTaskListReply_task = protobuf.FieldDescriptor()
field_descriptors.GetTaskListReply_takedInfo = protobuf.FieldDescriptor()
type_descriptors.GetGuideInfoRequest = protobuf.Descriptor()
type_descriptors.StepRewardInfo = protobuf.Descriptor()
field_descriptors.StepRewardInfo_group = protobuf.FieldDescriptor()
field_descriptors.StepRewardInfo_stepPoint = protobuf.FieldDescriptor()
type_descriptors.GetPlotAnswersRequest = protobuf.Descriptor()
type_descriptors.SetPlotAnswersRequest = protobuf.Descriptor()
field_descriptors.SetPlotAnswersRequest_answers = protobuf.FieldDescriptor()
type_descriptors.GetGuideInfoReply = protobuf.Descriptor()
field_descriptors.GetGuideInfoReply_finished = protobuf.FieldDescriptor()
type_descriptors.SetPlotAnswersReply = protobuf.Descriptor()
type_descriptors.JumpPlotReply = protobuf.Descriptor()
type_descriptors.FinishTaskRequest = protobuf.Descriptor()
field_descriptors.FinishTaskRequest_id = protobuf.FieldDescriptor()
type_descriptors.TakeStepRewardRequest = protobuf.Descriptor()
field_descriptors.TakeStepRewardRequest_info = protobuf.FieldDescriptor()
type_descriptors.JumpPlotRequest = protobuf.Descriptor()
field_descriptors.JumpPlotRequest_code = protobuf.FieldDescriptor()
field_descriptors.JumpPlotRequest_type = protobuf.FieldDescriptor()
type_descriptors.FinishGuideReply = protobuf.Descriptor()
type_descriptors.FinishGuideRequest = protobuf.Descriptor()
field_descriptors.FinishGuideRequest_code = protobuf.FieldDescriptor()
type_descriptors.FinishTaskReply = protobuf.Descriptor()
field_descriptors.FinishTaskReply_id = protobuf.FieldDescriptor()
type_descriptors.GetPlotAnswersReply = protobuf.Descriptor()
field_descriptors.GetPlotAnswersReply_answers = protobuf.FieldDescriptor()
type_descriptors.GetTaskListRequest = protobuf.Descriptor()
enum_item_descriptors.PlotEnum_NONE.name = "NONE"
enum_item_descriptors.PlotEnum_NONE.index = 0
enum_item_descriptors.PlotEnum_NONE.number = 0
enum_item_descriptors.PlotEnum_DUNGEON.name = "DUNGEON"
enum_item_descriptors.PlotEnum_DUNGEON.index = 1
enum_item_descriptors.PlotEnum_DUNGEON.number = 1
type_descriptors.PlotEnum.name = "PlotEnum"
type_descriptors.PlotEnum.full_name = ".PlotEnum"
type_descriptors.PlotEnum.values = {
	enum_item_descriptors.PlotEnum_NONE,
	enum_item_descriptors.PlotEnum_DUNGEON
}
field_descriptors.NewbieTaskNO_id.name = "id"
field_descriptors.NewbieTaskNO_id.full_name = ".NewbieTaskNO.id"
field_descriptors.NewbieTaskNO_id.number = 1
field_descriptors.NewbieTaskNO_id.index = 0
field_descriptors.NewbieTaskNO_id.label = 1
field_descriptors.NewbieTaskNO_id.has_default_value = false
field_descriptors.NewbieTaskNO_id.default_value = 0
field_descriptors.NewbieTaskNO_id.type = 5
field_descriptors.NewbieTaskNO_id.cpp_type = 1
field_descriptors.NewbieTaskNO_count.name = "count"
field_descriptors.NewbieTaskNO_count.full_name = ".NewbieTaskNO.count"
field_descriptors.NewbieTaskNO_count.number = 2
field_descriptors.NewbieTaskNO_count.index = 1
field_descriptors.NewbieTaskNO_count.label = 1
field_descriptors.NewbieTaskNO_count.has_default_value = false
field_descriptors.NewbieTaskNO_count.default_value = 0
field_descriptors.NewbieTaskNO_count.type = 5
field_descriptors.NewbieTaskNO_count.cpp_type = 1
field_descriptors.NewbieTaskNO_finish.name = "finish"
field_descriptors.NewbieTaskNO_finish.full_name = ".NewbieTaskNO.finish"
field_descriptors.NewbieTaskNO_finish.number = 3
field_descriptors.NewbieTaskNO_finish.index = 2
field_descriptors.NewbieTaskNO_finish.label = 1
field_descriptors.NewbieTaskNO_finish.has_default_value = false
field_descriptors.NewbieTaskNO_finish.default_value = false
field_descriptors.NewbieTaskNO_finish.type = 8
field_descriptors.NewbieTaskNO_finish.cpp_type = 7
type_descriptors.NewbieTaskNO.name = "NewbieTaskNO"
type_descriptors.NewbieTaskNO.full_name = ".NewbieTaskNO"
type_descriptors.NewbieTaskNO.nested_types = {}
type_descriptors.NewbieTaskNO.enum_types = {}
type_descriptors.NewbieTaskNO.fields = {
	field_descriptors.NewbieTaskNO_id,
	field_descriptors.NewbieTaskNO_count,
	field_descriptors.NewbieTaskNO_finish
}
type_descriptors.NewbieTaskNO.is_extendable = false
type_descriptors.NewbieTaskNO.extensions = {}
field_descriptors.TakeStepRewardReply_info.name = "info"
field_descriptors.TakeStepRewardReply_info.full_name = ".TakeStepRewardReply.info"
field_descriptors.TakeStepRewardReply_info.number = 1
field_descriptors.TakeStepRewardReply_info.index = 0
field_descriptors.TakeStepRewardReply_info.label = 2
field_descriptors.TakeStepRewardReply_info.has_default_value = false
field_descriptors.TakeStepRewardReply_info.default_value = nil
field_descriptors.TakeStepRewardReply_info.message_type = type_descriptors.StepRewardInfo
field_descriptors.TakeStepRewardReply_info.type = 11
field_descriptors.TakeStepRewardReply_info.cpp_type = 10
type_descriptors.TakeStepRewardReply.name = "TakeStepRewardReply"
type_descriptors.TakeStepRewardReply.full_name = ".TakeStepRewardReply"
type_descriptors.TakeStepRewardReply.nested_types = {}
type_descriptors.TakeStepRewardReply.enum_types = {}
type_descriptors.TakeStepRewardReply.fields = {
	field_descriptors.TakeStepRewardReply_info
}
type_descriptors.TakeStepRewardReply.is_extendable = false
type_descriptors.TakeStepRewardReply.extensions = {}
field_descriptors.PlotAnswerNO_question.name = "question"
field_descriptors.PlotAnswerNO_question.full_name = ".PlotAnswerNO.question"
field_descriptors.PlotAnswerNO_question.number = 1
field_descriptors.PlotAnswerNO_question.index = 0
field_descriptors.PlotAnswerNO_question.label = 1
field_descriptors.PlotAnswerNO_question.has_default_value = false
field_descriptors.PlotAnswerNO_question.default_value = 0
field_descriptors.PlotAnswerNO_question.type = 5
field_descriptors.PlotAnswerNO_question.cpp_type = 1
field_descriptors.PlotAnswerNO_answer.name = "answer"
field_descriptors.PlotAnswerNO_answer.full_name = ".PlotAnswerNO.answer"
field_descriptors.PlotAnswerNO_answer.number = 2
field_descriptors.PlotAnswerNO_answer.index = 1
field_descriptors.PlotAnswerNO_answer.label = 3
field_descriptors.PlotAnswerNO_answer.has_default_value = false
field_descriptors.PlotAnswerNO_answer.default_value = {}
field_descriptors.PlotAnswerNO_answer.type = 5
field_descriptors.PlotAnswerNO_answer.cpp_type = 1
type_descriptors.PlotAnswerNO.name = "PlotAnswerNO"
type_descriptors.PlotAnswerNO.full_name = ".PlotAnswerNO"
type_descriptors.PlotAnswerNO.nested_types = {}
type_descriptors.PlotAnswerNO.enum_types = {}
type_descriptors.PlotAnswerNO.fields = {
	field_descriptors.PlotAnswerNO_question,
	field_descriptors.PlotAnswerNO_answer
}
type_descriptors.PlotAnswerNO.is_extendable = false
type_descriptors.PlotAnswerNO.extensions = {}
field_descriptors.GetTaskListReply_task.name = "task"
field_descriptors.GetTaskListReply_task.full_name = ".GetTaskListReply.task"
field_descriptors.GetTaskListReply_task.number = 1
field_descriptors.GetTaskListReply_task.index = 0
field_descriptors.GetTaskListReply_task.label = 3
field_descriptors.GetTaskListReply_task.has_default_value = false
field_descriptors.GetTaskListReply_task.default_value = {}
field_descriptors.GetTaskListReply_task.message_type = type_descriptors.NewbieTaskNO
field_descriptors.GetTaskListReply_task.type = 11
field_descriptors.GetTaskListReply_task.cpp_type = 10
field_descriptors.GetTaskListReply_takedInfo.name = "takedInfo"
field_descriptors.GetTaskListReply_takedInfo.full_name = ".GetTaskListReply.takedInfo"
field_descriptors.GetTaskListReply_takedInfo.number = 2
field_descriptors.GetTaskListReply_takedInfo.index = 1
field_descriptors.GetTaskListReply_takedInfo.label = 3
field_descriptors.GetTaskListReply_takedInfo.has_default_value = false
field_descriptors.GetTaskListReply_takedInfo.default_value = {}
field_descriptors.GetTaskListReply_takedInfo.message_type = type_descriptors.StepRewardInfo
field_descriptors.GetTaskListReply_takedInfo.type = 11
field_descriptors.GetTaskListReply_takedInfo.cpp_type = 10
type_descriptors.GetTaskListReply.name = "GetTaskListReply"
type_descriptors.GetTaskListReply.full_name = ".GetTaskListReply"
type_descriptors.GetTaskListReply.nested_types = {}
type_descriptors.GetTaskListReply.enum_types = {}
type_descriptors.GetTaskListReply.fields = {
	field_descriptors.GetTaskListReply_task,
	field_descriptors.GetTaskListReply_takedInfo
}
type_descriptors.GetTaskListReply.is_extendable = false
type_descriptors.GetTaskListReply.extensions = {}
type_descriptors.GetGuideInfoRequest.name = "GetGuideInfoRequest"
type_descriptors.GetGuideInfoRequest.full_name = ".GetGuideInfoRequest"
type_descriptors.GetGuideInfoRequest.nested_types = {}
type_descriptors.GetGuideInfoRequest.enum_types = {}
type_descriptors.GetGuideInfoRequest.fields = {}
type_descriptors.GetGuideInfoRequest.is_extendable = false
type_descriptors.GetGuideInfoRequest.extensions = {}
field_descriptors.StepRewardInfo_group.name = "group"
field_descriptors.StepRewardInfo_group.full_name = ".StepRewardInfo.group"
field_descriptors.StepRewardInfo_group.number = 1
field_descriptors.StepRewardInfo_group.index = 0
field_descriptors.StepRewardInfo_group.label = 2
field_descriptors.StepRewardInfo_group.has_default_value = false
field_descriptors.StepRewardInfo_group.default_value = 0
field_descriptors.StepRewardInfo_group.type = 5
field_descriptors.StepRewardInfo_group.cpp_type = 1
field_descriptors.StepRewardInfo_stepPoint.name = "stepPoint"
field_descriptors.StepRewardInfo_stepPoint.full_name = ".StepRewardInfo.stepPoint"
field_descriptors.StepRewardInfo_stepPoint.number = 2
field_descriptors.StepRewardInfo_stepPoint.index = 1
field_descriptors.StepRewardInfo_stepPoint.label = 3
field_descriptors.StepRewardInfo_stepPoint.has_default_value = false
field_descriptors.StepRewardInfo_stepPoint.default_value = {}
field_descriptors.StepRewardInfo_stepPoint.type = 5
field_descriptors.StepRewardInfo_stepPoint.cpp_type = 1
type_descriptors.StepRewardInfo.name = "StepRewardInfo"
type_descriptors.StepRewardInfo.full_name = ".StepRewardInfo"
type_descriptors.StepRewardInfo.nested_types = {}
type_descriptors.StepRewardInfo.enum_types = {}
type_descriptors.StepRewardInfo.fields = {
	field_descriptors.StepRewardInfo_group,
	field_descriptors.StepRewardInfo_stepPoint
}
type_descriptors.StepRewardInfo.is_extendable = false
type_descriptors.StepRewardInfo.extensions = {}
type_descriptors.GetPlotAnswersRequest.name = "GetPlotAnswersRequest"
type_descriptors.GetPlotAnswersRequest.full_name = ".GetPlotAnswersRequest"
type_descriptors.GetPlotAnswersRequest.nested_types = {}
type_descriptors.GetPlotAnswersRequest.enum_types = {}
type_descriptors.GetPlotAnswersRequest.fields = {}
type_descriptors.GetPlotAnswersRequest.is_extendable = false
type_descriptors.GetPlotAnswersRequest.extensions = {}
field_descriptors.SetPlotAnswersRequest_answers.name = "answers"
field_descriptors.SetPlotAnswersRequest_answers.full_name = ".SetPlotAnswersRequest.answers"
field_descriptors.SetPlotAnswersRequest_answers.number = 1
field_descriptors.SetPlotAnswersRequest_answers.index = 0
field_descriptors.SetPlotAnswersRequest_answers.label = 3
field_descriptors.SetPlotAnswersRequest_answers.has_default_value = false
field_descriptors.SetPlotAnswersRequest_answers.default_value = {}
field_descriptors.SetPlotAnswersRequest_answers.message_type = type_descriptors.PlotAnswerNO
field_descriptors.SetPlotAnswersRequest_answers.type = 11
field_descriptors.SetPlotAnswersRequest_answers.cpp_type = 10
type_descriptors.SetPlotAnswersRequest.name = "SetPlotAnswersRequest"
type_descriptors.SetPlotAnswersRequest.full_name = ".SetPlotAnswersRequest"
type_descriptors.SetPlotAnswersRequest.nested_types = {}
type_descriptors.SetPlotAnswersRequest.enum_types = {}
type_descriptors.SetPlotAnswersRequest.fields = {
	field_descriptors.SetPlotAnswersRequest_answers
}
type_descriptors.SetPlotAnswersRequest.is_extendable = false
type_descriptors.SetPlotAnswersRequest.extensions = {}
field_descriptors.GetGuideInfoReply_finished.name = "finished"
field_descriptors.GetGuideInfoReply_finished.full_name = ".GetGuideInfoReply.finished"
field_descriptors.GetGuideInfoReply_finished.number = 1
field_descriptors.GetGuideInfoReply_finished.index = 0
field_descriptors.GetGuideInfoReply_finished.label = 3
field_descriptors.GetGuideInfoReply_finished.has_default_value = false
field_descriptors.GetGuideInfoReply_finished.default_value = {}
field_descriptors.GetGuideInfoReply_finished.type = 5
field_descriptors.GetGuideInfoReply_finished.cpp_type = 1
type_descriptors.GetGuideInfoReply.name = "GetGuideInfoReply"
type_descriptors.GetGuideInfoReply.full_name = ".GetGuideInfoReply"
type_descriptors.GetGuideInfoReply.nested_types = {}
type_descriptors.GetGuideInfoReply.enum_types = {}
type_descriptors.GetGuideInfoReply.fields = {
	field_descriptors.GetGuideInfoReply_finished
}
type_descriptors.GetGuideInfoReply.is_extendable = false
type_descriptors.GetGuideInfoReply.extensions = {}
type_descriptors.SetPlotAnswersReply.name = "SetPlotAnswersReply"
type_descriptors.SetPlotAnswersReply.full_name = ".SetPlotAnswersReply"
type_descriptors.SetPlotAnswersReply.nested_types = {}
type_descriptors.SetPlotAnswersReply.enum_types = {}
type_descriptors.SetPlotAnswersReply.fields = {}
type_descriptors.SetPlotAnswersReply.is_extendable = false
type_descriptors.SetPlotAnswersReply.extensions = {}
type_descriptors.JumpPlotReply.name = "JumpPlotReply"
type_descriptors.JumpPlotReply.full_name = ".JumpPlotReply"
type_descriptors.JumpPlotReply.nested_types = {}
type_descriptors.JumpPlotReply.enum_types = {}
type_descriptors.JumpPlotReply.fields = {}
type_descriptors.JumpPlotReply.is_extendable = false
type_descriptors.JumpPlotReply.extensions = {}
field_descriptors.FinishTaskRequest_id.name = "id"
field_descriptors.FinishTaskRequest_id.full_name = ".FinishTaskRequest.id"
field_descriptors.FinishTaskRequest_id.number = 1
field_descriptors.FinishTaskRequest_id.index = 0
field_descriptors.FinishTaskRequest_id.label = 3
field_descriptors.FinishTaskRequest_id.has_default_value = false
field_descriptors.FinishTaskRequest_id.default_value = {}
field_descriptors.FinishTaskRequest_id.type = 5
field_descriptors.FinishTaskRequest_id.cpp_type = 1
type_descriptors.FinishTaskRequest.name = "FinishTaskRequest"
type_descriptors.FinishTaskRequest.full_name = ".FinishTaskRequest"
type_descriptors.FinishTaskRequest.nested_types = {}
type_descriptors.FinishTaskRequest.enum_types = {}
type_descriptors.FinishTaskRequest.fields = {
	field_descriptors.FinishTaskRequest_id
}
type_descriptors.FinishTaskRequest.is_extendable = false
type_descriptors.FinishTaskRequest.extensions = {}
field_descriptors.TakeStepRewardRequest_info.name = "info"
field_descriptors.TakeStepRewardRequest_info.full_name = ".TakeStepRewardRequest.info"
field_descriptors.TakeStepRewardRequest_info.number = 1
field_descriptors.TakeStepRewardRequest_info.index = 0
field_descriptors.TakeStepRewardRequest_info.label = 2
field_descriptors.TakeStepRewardRequest_info.has_default_value = false
field_descriptors.TakeStepRewardRequest_info.default_value = nil
field_descriptors.TakeStepRewardRequest_info.message_type = type_descriptors.StepRewardInfo
field_descriptors.TakeStepRewardRequest_info.type = 11
field_descriptors.TakeStepRewardRequest_info.cpp_type = 10
type_descriptors.TakeStepRewardRequest.name = "TakeStepRewardRequest"
type_descriptors.TakeStepRewardRequest.full_name = ".TakeStepRewardRequest"
type_descriptors.TakeStepRewardRequest.nested_types = {}
type_descriptors.TakeStepRewardRequest.enum_types = {}
type_descriptors.TakeStepRewardRequest.fields = {
	field_descriptors.TakeStepRewardRequest_info
}
type_descriptors.TakeStepRewardRequest.is_extendable = false
type_descriptors.TakeStepRewardRequest.extensions = {}
field_descriptors.JumpPlotRequest_code.name = "code"
field_descriptors.JumpPlotRequest_code.full_name = ".JumpPlotRequest.code"
field_descriptors.JumpPlotRequest_code.number = 1
field_descriptors.JumpPlotRequest_code.index = 0
field_descriptors.JumpPlotRequest_code.label = 1
field_descriptors.JumpPlotRequest_code.has_default_value = false
field_descriptors.JumpPlotRequest_code.default_value = ""
field_descriptors.JumpPlotRequest_code.type = 9
field_descriptors.JumpPlotRequest_code.cpp_type = 9
field_descriptors.JumpPlotRequest_type.name = "type"
field_descriptors.JumpPlotRequest_type.full_name = ".JumpPlotRequest.type"
field_descriptors.JumpPlotRequest_type.number = 2
field_descriptors.JumpPlotRequest_type.index = 1
field_descriptors.JumpPlotRequest_type.label = 1
field_descriptors.JumpPlotRequest_type.has_default_value = false
field_descriptors.JumpPlotRequest_type.default_value = nil
field_descriptors.JumpPlotRequest_type.enum_type = type_descriptors.PlotEnum
field_descriptors.JumpPlotRequest_type.type = 14
field_descriptors.JumpPlotRequest_type.cpp_type = 8
type_descriptors.JumpPlotRequest.name = "JumpPlotRequest"
type_descriptors.JumpPlotRequest.full_name = ".JumpPlotRequest"
type_descriptors.JumpPlotRequest.nested_types = {}
type_descriptors.JumpPlotRequest.enum_types = {}
type_descriptors.JumpPlotRequest.fields = {
	field_descriptors.JumpPlotRequest_code,
	field_descriptors.JumpPlotRequest_type
}
type_descriptors.JumpPlotRequest.is_extendable = false
type_descriptors.JumpPlotRequest.extensions = {}
type_descriptors.FinishGuideReply.name = "FinishGuideReply"
type_descriptors.FinishGuideReply.full_name = ".FinishGuideReply"
type_descriptors.FinishGuideReply.nested_types = {}
type_descriptors.FinishGuideReply.enum_types = {}
type_descriptors.FinishGuideReply.fields = {}
type_descriptors.FinishGuideReply.is_extendable = false
type_descriptors.FinishGuideReply.extensions = {}
field_descriptors.FinishGuideRequest_code.name = "code"
field_descriptors.FinishGuideRequest_code.full_name = ".FinishGuideRequest.code"
field_descriptors.FinishGuideRequest_code.number = 1
field_descriptors.FinishGuideRequest_code.index = 0
field_descriptors.FinishGuideRequest_code.label = 1
field_descriptors.FinishGuideRequest_code.has_default_value = false
field_descriptors.FinishGuideRequest_code.default_value = 0
field_descriptors.FinishGuideRequest_code.type = 5
field_descriptors.FinishGuideRequest_code.cpp_type = 1
type_descriptors.FinishGuideRequest.name = "FinishGuideRequest"
type_descriptors.FinishGuideRequest.full_name = ".FinishGuideRequest"
type_descriptors.FinishGuideRequest.nested_types = {}
type_descriptors.FinishGuideRequest.enum_types = {}
type_descriptors.FinishGuideRequest.fields = {
	field_descriptors.FinishGuideRequest_code
}
type_descriptors.FinishGuideRequest.is_extendable = false
type_descriptors.FinishGuideRequest.extensions = {}
field_descriptors.FinishTaskReply_id.name = "id"
field_descriptors.FinishTaskReply_id.full_name = ".FinishTaskReply.id"
field_descriptors.FinishTaskReply_id.number = 1
field_descriptors.FinishTaskReply_id.index = 0
field_descriptors.FinishTaskReply_id.label = 3
field_descriptors.FinishTaskReply_id.has_default_value = false
field_descriptors.FinishTaskReply_id.default_value = {}
field_descriptors.FinishTaskReply_id.type = 5
field_descriptors.FinishTaskReply_id.cpp_type = 1
type_descriptors.FinishTaskReply.name = "FinishTaskReply"
type_descriptors.FinishTaskReply.full_name = ".FinishTaskReply"
type_descriptors.FinishTaskReply.nested_types = {}
type_descriptors.FinishTaskReply.enum_types = {}
type_descriptors.FinishTaskReply.fields = {
	field_descriptors.FinishTaskReply_id
}
type_descriptors.FinishTaskReply.is_extendable = false
type_descriptors.FinishTaskReply.extensions = {}
field_descriptors.GetPlotAnswersReply_answers.name = "answers"
field_descriptors.GetPlotAnswersReply_answers.full_name = ".GetPlotAnswersReply.answers"
field_descriptors.GetPlotAnswersReply_answers.number = 1
field_descriptors.GetPlotAnswersReply_answers.index = 0
field_descriptors.GetPlotAnswersReply_answers.label = 3
field_descriptors.GetPlotAnswersReply_answers.has_default_value = false
field_descriptors.GetPlotAnswersReply_answers.default_value = {}
field_descriptors.GetPlotAnswersReply_answers.message_type = type_descriptors.PlotAnswerNO
field_descriptors.GetPlotAnswersReply_answers.type = 11
field_descriptors.GetPlotAnswersReply_answers.cpp_type = 10
type_descriptors.GetPlotAnswersReply.name = "GetPlotAnswersReply"
type_descriptors.GetPlotAnswersReply.full_name = ".GetPlotAnswersReply"
type_descriptors.GetPlotAnswersReply.nested_types = {}
type_descriptors.GetPlotAnswersReply.enum_types = {}
type_descriptors.GetPlotAnswersReply.fields = {
	field_descriptors.GetPlotAnswersReply_answers
}
type_descriptors.GetPlotAnswersReply.is_extendable = false
type_descriptors.GetPlotAnswersReply.extensions = {}
type_descriptors.GetTaskListRequest.name = "GetTaskListRequest"
type_descriptors.GetTaskListRequest.full_name = ".GetTaskListRequest"
type_descriptors.GetTaskListRequest.nested_types = {}
type_descriptors.GetTaskListRequest.enum_types = {}
type_descriptors.GetTaskListRequest.fields = {}
type_descriptors.GetTaskListRequest.is_extendable = false
type_descriptors.GetTaskListRequest.extensions = {}
PlotEnum = {
	DUNGEON = 1,
	NONE = 0
}
FinishGuideReply = protobuf.Message(type_descriptors.FinishGuideReply)
FinishGuideRequest = protobuf.Message(type_descriptors.FinishGuideRequest)
FinishTaskReply = protobuf.Message(type_descriptors.FinishTaskReply)
FinishTaskRequest = protobuf.Message(type_descriptors.FinishTaskRequest)
GetGuideInfoReply = protobuf.Message(type_descriptors.GetGuideInfoReply)
GetGuideInfoRequest = protobuf.Message(type_descriptors.GetGuideInfoRequest)
GetPlotAnswersReply = protobuf.Message(type_descriptors.GetPlotAnswersReply)
GetPlotAnswersRequest = protobuf.Message(type_descriptors.GetPlotAnswersRequest)
GetTaskListReply = protobuf.Message(type_descriptors.GetTaskListReply)
GetTaskListRequest = protobuf.Message(type_descriptors.GetTaskListRequest)
JumpPlotReply = protobuf.Message(type_descriptors.JumpPlotReply)
JumpPlotRequest = protobuf.Message(type_descriptors.JumpPlotRequest)
NewbieTaskNO = protobuf.Message(type_descriptors.NewbieTaskNO)
PlotAnswerNO = protobuf.Message(type_descriptors.PlotAnswerNO)
SetPlotAnswersReply = protobuf.Message(type_descriptors.SetPlotAnswersReply)
SetPlotAnswersRequest = protobuf.Message(type_descriptors.SetPlotAnswersRequest)
StepRewardInfo = protobuf.Message(type_descriptors.StepRewardInfo)
TakeStepRewardReply = protobuf.Message(type_descriptors.TakeStepRewardReply)
TakeStepRewardRequest = protobuf.Message(type_descriptors.TakeStepRewardRequest)

return _G["logic.proto.NewbieExtension_pb"]

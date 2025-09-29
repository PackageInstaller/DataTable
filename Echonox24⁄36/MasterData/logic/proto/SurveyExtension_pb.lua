-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/SurveyExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.SurveyExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.CommitSurveyReply = protobuf.Descriptor()
field_descriptors.CommitSurveyReply_actId = protobuf.FieldDescriptor()
type_descriptors.AvailableSurveyPush = protobuf.Descriptor()
field_descriptors.AvailableSurveyPush_actId = protobuf.FieldDescriptor()
type_descriptors.AnswerNO = protobuf.Descriptor()
field_descriptors.AnswerNO_subjectId = protobuf.FieldDescriptor()
field_descriptors.AnswerNO_selection = protobuf.FieldDescriptor()
field_descriptors.AnswerNO_textContent = protobuf.FieldDescriptor()
type_descriptors.CommitSurveyRequest = protobuf.Descriptor()
field_descriptors.CommitSurveyRequest_actId = protobuf.FieldDescriptor()
field_descriptors.CommitSurveyRequest_answer = protobuf.FieldDescriptor()
field_descriptors.CommitSurveyRequest_finishSeconds = protobuf.FieldDescriptor()
field_descriptors.CommitSurveyReply_actId.name = "actId"
field_descriptors.CommitSurveyReply_actId.full_name = ".CommitSurveyReply.actId"
field_descriptors.CommitSurveyReply_actId.number = 1
field_descriptors.CommitSurveyReply_actId.index = 0
field_descriptors.CommitSurveyReply_actId.label = 2
field_descriptors.CommitSurveyReply_actId.has_default_value = false
field_descriptors.CommitSurveyReply_actId.default_value = 0
field_descriptors.CommitSurveyReply_actId.type = 5
field_descriptors.CommitSurveyReply_actId.cpp_type = 1
type_descriptors.CommitSurveyReply.name = "CommitSurveyReply"
type_descriptors.CommitSurveyReply.full_name = ".CommitSurveyReply"
type_descriptors.CommitSurveyReply.nested_types = {}
type_descriptors.CommitSurveyReply.enum_types = {}
type_descriptors.CommitSurveyReply.fields = {
	field_descriptors.CommitSurveyReply_actId
}
type_descriptors.CommitSurveyReply.is_extendable = false
type_descriptors.CommitSurveyReply.extensions = {}
field_descriptors.AvailableSurveyPush_actId.name = "actId"
field_descriptors.AvailableSurveyPush_actId.full_name = ".AvailableSurveyPush.actId"
field_descriptors.AvailableSurveyPush_actId.number = 1
field_descriptors.AvailableSurveyPush_actId.index = 0
field_descriptors.AvailableSurveyPush_actId.label = 3
field_descriptors.AvailableSurveyPush_actId.has_default_value = false
field_descriptors.AvailableSurveyPush_actId.default_value = {}
field_descriptors.AvailableSurveyPush_actId.type = 5
field_descriptors.AvailableSurveyPush_actId.cpp_type = 1
type_descriptors.AvailableSurveyPush.name = "AvailableSurveyPush"
type_descriptors.AvailableSurveyPush.full_name = ".AvailableSurveyPush"
type_descriptors.AvailableSurveyPush.nested_types = {}
type_descriptors.AvailableSurveyPush.enum_types = {}
type_descriptors.AvailableSurveyPush.fields = {
	field_descriptors.AvailableSurveyPush_actId
}
type_descriptors.AvailableSurveyPush.is_extendable = false
type_descriptors.AvailableSurveyPush.extensions = {}
field_descriptors.AnswerNO_subjectId.name = "subjectId"
field_descriptors.AnswerNO_subjectId.full_name = ".AnswerNO.subjectId"
field_descriptors.AnswerNO_subjectId.number = 1
field_descriptors.AnswerNO_subjectId.index = 0
field_descriptors.AnswerNO_subjectId.label = 2
field_descriptors.AnswerNO_subjectId.has_default_value = false
field_descriptors.AnswerNO_subjectId.default_value = 0
field_descriptors.AnswerNO_subjectId.type = 5
field_descriptors.AnswerNO_subjectId.cpp_type = 1
field_descriptors.AnswerNO_selection.name = "selection"
field_descriptors.AnswerNO_selection.full_name = ".AnswerNO.selection"
field_descriptors.AnswerNO_selection.number = 2
field_descriptors.AnswerNO_selection.index = 1
field_descriptors.AnswerNO_selection.label = 3
field_descriptors.AnswerNO_selection.has_default_value = false
field_descriptors.AnswerNO_selection.default_value = {}
field_descriptors.AnswerNO_selection.type = 5
field_descriptors.AnswerNO_selection.cpp_type = 1
field_descriptors.AnswerNO_textContent.name = "textContent"
field_descriptors.AnswerNO_textContent.full_name = ".AnswerNO.textContent"
field_descriptors.AnswerNO_textContent.number = 3
field_descriptors.AnswerNO_textContent.index = 2
field_descriptors.AnswerNO_textContent.label = 1
field_descriptors.AnswerNO_textContent.has_default_value = false
field_descriptors.AnswerNO_textContent.default_value = ""
field_descriptors.AnswerNO_textContent.type = 9
field_descriptors.AnswerNO_textContent.cpp_type = 9
type_descriptors.AnswerNO.name = "AnswerNO"
type_descriptors.AnswerNO.full_name = ".AnswerNO"
type_descriptors.AnswerNO.nested_types = {}
type_descriptors.AnswerNO.enum_types = {}
type_descriptors.AnswerNO.fields = {
	field_descriptors.AnswerNO_subjectId,
	field_descriptors.AnswerNO_selection,
	field_descriptors.AnswerNO_textContent
}
type_descriptors.AnswerNO.is_extendable = false
type_descriptors.AnswerNO.extensions = {}
field_descriptors.CommitSurveyRequest_actId.name = "actId"
field_descriptors.CommitSurveyRequest_actId.full_name = ".CommitSurveyRequest.actId"
field_descriptors.CommitSurveyRequest_actId.number = 1
field_descriptors.CommitSurveyRequest_actId.index = 0
field_descriptors.CommitSurveyRequest_actId.label = 2
field_descriptors.CommitSurveyRequest_actId.has_default_value = false
field_descriptors.CommitSurveyRequest_actId.default_value = 0
field_descriptors.CommitSurveyRequest_actId.type = 5
field_descriptors.CommitSurveyRequest_actId.cpp_type = 1
field_descriptors.CommitSurveyRequest_answer.name = "answer"
field_descriptors.CommitSurveyRequest_answer.full_name = ".CommitSurveyRequest.answer"
field_descriptors.CommitSurveyRequest_answer.number = 2
field_descriptors.CommitSurveyRequest_answer.index = 1
field_descriptors.CommitSurveyRequest_answer.label = 3
field_descriptors.CommitSurveyRequest_answer.has_default_value = false
field_descriptors.CommitSurveyRequest_answer.default_value = {}
field_descriptors.CommitSurveyRequest_answer.message_type = type_descriptors.AnswerNO
field_descriptors.CommitSurveyRequest_answer.type = 11
field_descriptors.CommitSurveyRequest_answer.cpp_type = 10
field_descriptors.CommitSurveyRequest_finishSeconds.name = "finishSeconds"
field_descriptors.CommitSurveyRequest_finishSeconds.full_name = ".CommitSurveyRequest.finishSeconds"
field_descriptors.CommitSurveyRequest_finishSeconds.number = 3
field_descriptors.CommitSurveyRequest_finishSeconds.index = 2
field_descriptors.CommitSurveyRequest_finishSeconds.label = 2
field_descriptors.CommitSurveyRequest_finishSeconds.has_default_value = false
field_descriptors.CommitSurveyRequest_finishSeconds.default_value = 0
field_descriptors.CommitSurveyRequest_finishSeconds.type = 5
field_descriptors.CommitSurveyRequest_finishSeconds.cpp_type = 1
type_descriptors.CommitSurveyRequest.name = "CommitSurveyRequest"
type_descriptors.CommitSurveyRequest.full_name = ".CommitSurveyRequest"
type_descriptors.CommitSurveyRequest.nested_types = {}
type_descriptors.CommitSurveyRequest.enum_types = {}
type_descriptors.CommitSurveyRequest.fields = {
	field_descriptors.CommitSurveyRequest_actId,
	field_descriptors.CommitSurveyRequest_answer,
	field_descriptors.CommitSurveyRequest_finishSeconds
}
type_descriptors.CommitSurveyRequest.is_extendable = false
type_descriptors.CommitSurveyRequest.extensions = {}
AnswerNO = protobuf.Message(type_descriptors.AnswerNO)
AvailableSurveyPush = protobuf.Message(type_descriptors.AvailableSurveyPush)
CommitSurveyReply = protobuf.Message(type_descriptors.CommitSurveyReply)
CommitSurveyRequest = protobuf.Message(type_descriptors.CommitSurveyRequest)

return _G["logic.proto.SurveyExtension_pb"]

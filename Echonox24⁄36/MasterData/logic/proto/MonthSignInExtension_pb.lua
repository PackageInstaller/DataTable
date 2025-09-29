-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/MonthSignInExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.MonthSignInExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.SignInRequest = protobuf.Descriptor()
type_descriptors.GetMonthSignInInfoRequest = protobuf.Descriptor()
type_descriptors.GetMonthSignInInfoReply = protobuf.Descriptor()
field_descriptors.GetMonthSignInInfoReply_signInDay = protobuf.FieldDescriptor()
field_descriptors.GetMonthSignInInfoReply_signedIn = protobuf.FieldDescriptor()
type_descriptors.SignInReply = protobuf.Descriptor()
field_descriptors.SignInReply_signInDay = protobuf.FieldDescriptor()
field_descriptors.SignInReply_signedIn = protobuf.FieldDescriptor()
type_descriptors.SignInRequest.name = "SignInRequest"
type_descriptors.SignInRequest.full_name = ".SignInRequest"
type_descriptors.SignInRequest.nested_types = {}
type_descriptors.SignInRequest.enum_types = {}
type_descriptors.SignInRequest.fields = {}
type_descriptors.SignInRequest.is_extendable = false
type_descriptors.SignInRequest.extensions = {}
type_descriptors.GetMonthSignInInfoRequest.name = "GetMonthSignInInfoRequest"
type_descriptors.GetMonthSignInInfoRequest.full_name = ".GetMonthSignInInfoRequest"
type_descriptors.GetMonthSignInInfoRequest.nested_types = {}
type_descriptors.GetMonthSignInInfoRequest.enum_types = {}
type_descriptors.GetMonthSignInInfoRequest.fields = {}
type_descriptors.GetMonthSignInInfoRequest.is_extendable = false
type_descriptors.GetMonthSignInInfoRequest.extensions = {}
field_descriptors.GetMonthSignInInfoReply_signInDay.name = "signInDay"
field_descriptors.GetMonthSignInInfoReply_signInDay.full_name = ".GetMonthSignInInfoReply.signInDay"
field_descriptors.GetMonthSignInInfoReply_signInDay.number = 1
field_descriptors.GetMonthSignInInfoReply_signInDay.index = 0
field_descriptors.GetMonthSignInInfoReply_signInDay.label = 1
field_descriptors.GetMonthSignInInfoReply_signInDay.has_default_value = false
field_descriptors.GetMonthSignInInfoReply_signInDay.default_value = 0
field_descriptors.GetMonthSignInInfoReply_signInDay.type = 5
field_descriptors.GetMonthSignInInfoReply_signInDay.cpp_type = 1
field_descriptors.GetMonthSignInInfoReply_signedIn.name = "signedIn"
field_descriptors.GetMonthSignInInfoReply_signedIn.full_name = ".GetMonthSignInInfoReply.signedIn"
field_descriptors.GetMonthSignInInfoReply_signedIn.number = 2
field_descriptors.GetMonthSignInInfoReply_signedIn.index = 1
field_descriptors.GetMonthSignInInfoReply_signedIn.label = 1
field_descriptors.GetMonthSignInInfoReply_signedIn.has_default_value = false
field_descriptors.GetMonthSignInInfoReply_signedIn.default_value = false
field_descriptors.GetMonthSignInInfoReply_signedIn.type = 8
field_descriptors.GetMonthSignInInfoReply_signedIn.cpp_type = 7
type_descriptors.GetMonthSignInInfoReply.name = "GetMonthSignInInfoReply"
type_descriptors.GetMonthSignInInfoReply.full_name = ".GetMonthSignInInfoReply"
type_descriptors.GetMonthSignInInfoReply.nested_types = {}
type_descriptors.GetMonthSignInInfoReply.enum_types = {}
type_descriptors.GetMonthSignInInfoReply.fields = {
	field_descriptors.GetMonthSignInInfoReply_signInDay,
	field_descriptors.GetMonthSignInInfoReply_signedIn
}
type_descriptors.GetMonthSignInInfoReply.is_extendable = false
type_descriptors.GetMonthSignInInfoReply.extensions = {}
field_descriptors.SignInReply_signInDay.name = "signInDay"
field_descriptors.SignInReply_signInDay.full_name = ".SignInReply.signInDay"
field_descriptors.SignInReply_signInDay.number = 1
field_descriptors.SignInReply_signInDay.index = 0
field_descriptors.SignInReply_signInDay.label = 1
field_descriptors.SignInReply_signInDay.has_default_value = false
field_descriptors.SignInReply_signInDay.default_value = 0
field_descriptors.SignInReply_signInDay.type = 5
field_descriptors.SignInReply_signInDay.cpp_type = 1
field_descriptors.SignInReply_signedIn.name = "signedIn"
field_descriptors.SignInReply_signedIn.full_name = ".SignInReply.signedIn"
field_descriptors.SignInReply_signedIn.number = 2
field_descriptors.SignInReply_signedIn.index = 1
field_descriptors.SignInReply_signedIn.label = 1
field_descriptors.SignInReply_signedIn.has_default_value = false
field_descriptors.SignInReply_signedIn.default_value = false
field_descriptors.SignInReply_signedIn.type = 8
field_descriptors.SignInReply_signedIn.cpp_type = 7
type_descriptors.SignInReply.name = "SignInReply"
type_descriptors.SignInReply.full_name = ".SignInReply"
type_descriptors.SignInReply.nested_types = {}
type_descriptors.SignInReply.enum_types = {}
type_descriptors.SignInReply.fields = {
	field_descriptors.SignInReply_signInDay,
	field_descriptors.SignInReply_signedIn
}
type_descriptors.SignInReply.is_extendable = false
type_descriptors.SignInReply.extensions = {}
GetMonthSignInInfoReply = protobuf.Message(type_descriptors.GetMonthSignInInfoReply)
GetMonthSignInInfoRequest = protobuf.Message(type_descriptors.GetMonthSignInInfoRequest)
SignInReply = protobuf.Message(type_descriptors.SignInReply)
SignInRequest = protobuf.Message(type_descriptors.SignInRequest)

return _G["logic.proto.MonthSignInExtension_pb"]

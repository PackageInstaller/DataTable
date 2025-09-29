-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/ChatExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.ChatExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.NotifyType = protobuf.EnumDescriptor()
enum_item_descriptors.NotifyType_ForceUpdate = protobuf.EnumValueDescriptor()
type_descriptors.MessageRequestNO = protobuf.Descriptor()
field_descriptors.MessageRequestNO_messageType = protobuf.FieldDescriptor()
field_descriptors.MessageRequestNO_channelType = protobuf.FieldDescriptor()
field_descriptors.MessageRequestNO_content = protobuf.FieldDescriptor()
field_descriptors.MessageRequestNO_targetId = protobuf.FieldDescriptor()
type_descriptors.SendMessageReply = protobuf.Descriptor()
type_descriptors.NewMessagePush = protobuf.Descriptor()
field_descriptors.NewMessagePush_result = protobuf.FieldDescriptor()
field_descriptors.NewMessagePush_message = protobuf.FieldDescriptor()
type_descriptors.BroadcastPush = protobuf.Descriptor()
field_descriptors.BroadcastPush_displayMode = protobuf.FieldDescriptor()
field_descriptors.BroadcastPush_content = protobuf.FieldDescriptor()
type_descriptors.MessageReplyNO = protobuf.Descriptor()
field_descriptors.MessageReplyNO_messageType = protobuf.FieldDescriptor()
field_descriptors.MessageReplyNO_channelType = protobuf.FieldDescriptor()
field_descriptors.MessageReplyNO_content = protobuf.FieldDescriptor()
field_descriptors.MessageReplyNO_time = protobuf.FieldDescriptor()
field_descriptors.MessageReplyNO_senderId = protobuf.FieldDescriptor()
field_descriptors.MessageReplyNO_targetId = protobuf.FieldDescriptor()
type_descriptors.SendMessageRequest = protobuf.Descriptor()
field_descriptors.SendMessageRequest_message = protobuf.FieldDescriptor()
enum_item_descriptors.NotifyType_ForceUpdate.name = "ForceUpdate"
enum_item_descriptors.NotifyType_ForceUpdate.index = 0
enum_item_descriptors.NotifyType_ForceUpdate.number = 1
type_descriptors.NotifyType.name = "NotifyType"
type_descriptors.NotifyType.full_name = ".NotifyType"
type_descriptors.NotifyType.values = {
	enum_item_descriptors.NotifyType_ForceUpdate
}
field_descriptors.MessageRequestNO_messageType.name = "messageType"
field_descriptors.MessageRequestNO_messageType.full_name = ".MessageRequestNO.messageType"
field_descriptors.MessageRequestNO_messageType.number = 1
field_descriptors.MessageRequestNO_messageType.index = 0
field_descriptors.MessageRequestNO_messageType.label = 2
field_descriptors.MessageRequestNO_messageType.has_default_value = false
field_descriptors.MessageRequestNO_messageType.default_value = 0
field_descriptors.MessageRequestNO_messageType.type = 5
field_descriptors.MessageRequestNO_messageType.cpp_type = 1
field_descriptors.MessageRequestNO_channelType.name = "channelType"
field_descriptors.MessageRequestNO_channelType.full_name = ".MessageRequestNO.channelType"
field_descriptors.MessageRequestNO_channelType.number = 2
field_descriptors.MessageRequestNO_channelType.index = 1
field_descriptors.MessageRequestNO_channelType.label = 2
field_descriptors.MessageRequestNO_channelType.has_default_value = false
field_descriptors.MessageRequestNO_channelType.default_value = 0
field_descriptors.MessageRequestNO_channelType.type = 5
field_descriptors.MessageRequestNO_channelType.cpp_type = 1
field_descriptors.MessageRequestNO_content.name = "content"
field_descriptors.MessageRequestNO_content.full_name = ".MessageRequestNO.content"
field_descriptors.MessageRequestNO_content.number = 3
field_descriptors.MessageRequestNO_content.index = 2
field_descriptors.MessageRequestNO_content.label = 2
field_descriptors.MessageRequestNO_content.has_default_value = false
field_descriptors.MessageRequestNO_content.default_value = ""
field_descriptors.MessageRequestNO_content.type = 9
field_descriptors.MessageRequestNO_content.cpp_type = 9
field_descriptors.MessageRequestNO_targetId.name = "targetId"
field_descriptors.MessageRequestNO_targetId.full_name = ".MessageRequestNO.targetId"
field_descriptors.MessageRequestNO_targetId.number = 4
field_descriptors.MessageRequestNO_targetId.index = 3
field_descriptors.MessageRequestNO_targetId.label = 1
field_descriptors.MessageRequestNO_targetId.has_default_value = false
field_descriptors.MessageRequestNO_targetId.default_value = 0
field_descriptors.MessageRequestNO_targetId.type = 3
field_descriptors.MessageRequestNO_targetId.cpp_type = 2
type_descriptors.MessageRequestNO.name = "MessageRequestNO"
type_descriptors.MessageRequestNO.full_name = ".MessageRequestNO"
type_descriptors.MessageRequestNO.nested_types = {}
type_descriptors.MessageRequestNO.enum_types = {}
type_descriptors.MessageRequestNO.fields = {
	field_descriptors.MessageRequestNO_messageType,
	field_descriptors.MessageRequestNO_channelType,
	field_descriptors.MessageRequestNO_content,
	field_descriptors.MessageRequestNO_targetId
}
type_descriptors.MessageRequestNO.is_extendable = false
type_descriptors.MessageRequestNO.extensions = {}
type_descriptors.SendMessageReply.name = "SendMessageReply"
type_descriptors.SendMessageReply.full_name = ".SendMessageReply"
type_descriptors.SendMessageReply.nested_types = {}
type_descriptors.SendMessageReply.enum_types = {}
type_descriptors.SendMessageReply.fields = {}
type_descriptors.SendMessageReply.is_extendable = false
type_descriptors.SendMessageReply.extensions = {}
field_descriptors.NewMessagePush_result.name = "result"
field_descriptors.NewMessagePush_result.full_name = ".NewMessagePush.result"
field_descriptors.NewMessagePush_result.number = 1
field_descriptors.NewMessagePush_result.index = 0
field_descriptors.NewMessagePush_result.label = 1
field_descriptors.NewMessagePush_result.has_default_value = false
field_descriptors.NewMessagePush_result.default_value = 0
field_descriptors.NewMessagePush_result.type = 5
field_descriptors.NewMessagePush_result.cpp_type = 1
field_descriptors.NewMessagePush_message.name = "message"
field_descriptors.NewMessagePush_message.full_name = ".NewMessagePush.message"
field_descriptors.NewMessagePush_message.number = 2
field_descriptors.NewMessagePush_message.index = 1
field_descriptors.NewMessagePush_message.label = 3
field_descriptors.NewMessagePush_message.has_default_value = false
field_descriptors.NewMessagePush_message.default_value = {}
field_descriptors.NewMessagePush_message.message_type = type_descriptors.MessageReplyNO
field_descriptors.NewMessagePush_message.type = 11
field_descriptors.NewMessagePush_message.cpp_type = 10
type_descriptors.NewMessagePush.name = "NewMessagePush"
type_descriptors.NewMessagePush.full_name = ".NewMessagePush"
type_descriptors.NewMessagePush.nested_types = {}
type_descriptors.NewMessagePush.enum_types = {}
type_descriptors.NewMessagePush.fields = {
	field_descriptors.NewMessagePush_result,
	field_descriptors.NewMessagePush_message
}
type_descriptors.NewMessagePush.is_extendable = false
type_descriptors.NewMessagePush.extensions = {}
field_descriptors.BroadcastPush_displayMode.name = "displayMode"
field_descriptors.BroadcastPush_displayMode.full_name = ".BroadcastPush.displayMode"
field_descriptors.BroadcastPush_displayMode.number = 1
field_descriptors.BroadcastPush_displayMode.index = 0
field_descriptors.BroadcastPush_displayMode.label = 3
field_descriptors.BroadcastPush_displayMode.has_default_value = false
field_descriptors.BroadcastPush_displayMode.default_value = {}
field_descriptors.BroadcastPush_displayMode.type = 5
field_descriptors.BroadcastPush_displayMode.cpp_type = 1
field_descriptors.BroadcastPush_content.name = "content"
field_descriptors.BroadcastPush_content.full_name = ".BroadcastPush.content"
field_descriptors.BroadcastPush_content.number = 2
field_descriptors.BroadcastPush_content.index = 1
field_descriptors.BroadcastPush_content.label = 2
field_descriptors.BroadcastPush_content.has_default_value = false
field_descriptors.BroadcastPush_content.default_value = ""
field_descriptors.BroadcastPush_content.type = 9
field_descriptors.BroadcastPush_content.cpp_type = 9
type_descriptors.BroadcastPush.name = "BroadcastPush"
type_descriptors.BroadcastPush.full_name = ".BroadcastPush"
type_descriptors.BroadcastPush.nested_types = {}
type_descriptors.BroadcastPush.enum_types = {}
type_descriptors.BroadcastPush.fields = {
	field_descriptors.BroadcastPush_displayMode,
	field_descriptors.BroadcastPush_content
}
type_descriptors.BroadcastPush.is_extendable = false
type_descriptors.BroadcastPush.extensions = {}
field_descriptors.MessageReplyNO_messageType.name = "messageType"
field_descriptors.MessageReplyNO_messageType.full_name = ".MessageReplyNO.messageType"
field_descriptors.MessageReplyNO_messageType.number = 1
field_descriptors.MessageReplyNO_messageType.index = 0
field_descriptors.MessageReplyNO_messageType.label = 2
field_descriptors.MessageReplyNO_messageType.has_default_value = false
field_descriptors.MessageReplyNO_messageType.default_value = 0
field_descriptors.MessageReplyNO_messageType.type = 5
field_descriptors.MessageReplyNO_messageType.cpp_type = 1
field_descriptors.MessageReplyNO_channelType.name = "channelType"
field_descriptors.MessageReplyNO_channelType.full_name = ".MessageReplyNO.channelType"
field_descriptors.MessageReplyNO_channelType.number = 2
field_descriptors.MessageReplyNO_channelType.index = 1
field_descriptors.MessageReplyNO_channelType.label = 2
field_descriptors.MessageReplyNO_channelType.has_default_value = false
field_descriptors.MessageReplyNO_channelType.default_value = 0
field_descriptors.MessageReplyNO_channelType.type = 5
field_descriptors.MessageReplyNO_channelType.cpp_type = 1
field_descriptors.MessageReplyNO_content.name = "content"
field_descriptors.MessageReplyNO_content.full_name = ".MessageReplyNO.content"
field_descriptors.MessageReplyNO_content.number = 3
field_descriptors.MessageReplyNO_content.index = 2
field_descriptors.MessageReplyNO_content.label = 2
field_descriptors.MessageReplyNO_content.has_default_value = false
field_descriptors.MessageReplyNO_content.default_value = ""
field_descriptors.MessageReplyNO_content.type = 9
field_descriptors.MessageReplyNO_content.cpp_type = 9
field_descriptors.MessageReplyNO_time.name = "time"
field_descriptors.MessageReplyNO_time.full_name = ".MessageReplyNO.time"
field_descriptors.MessageReplyNO_time.number = 4
field_descriptors.MessageReplyNO_time.index = 3
field_descriptors.MessageReplyNO_time.label = 2
field_descriptors.MessageReplyNO_time.has_default_value = false
field_descriptors.MessageReplyNO_time.default_value = 0
field_descriptors.MessageReplyNO_time.type = 3
field_descriptors.MessageReplyNO_time.cpp_type = 2
field_descriptors.MessageReplyNO_senderId.name = "senderId"
field_descriptors.MessageReplyNO_senderId.full_name = ".MessageReplyNO.senderId"
field_descriptors.MessageReplyNO_senderId.number = 5
field_descriptors.MessageReplyNO_senderId.index = 4
field_descriptors.MessageReplyNO_senderId.label = 2
field_descriptors.MessageReplyNO_senderId.has_default_value = false
field_descriptors.MessageReplyNO_senderId.default_value = 0
field_descriptors.MessageReplyNO_senderId.type = 3
field_descriptors.MessageReplyNO_senderId.cpp_type = 2
field_descriptors.MessageReplyNO_targetId.name = "targetId"
field_descriptors.MessageReplyNO_targetId.full_name = ".MessageReplyNO.targetId"
field_descriptors.MessageReplyNO_targetId.number = 6
field_descriptors.MessageReplyNO_targetId.index = 5
field_descriptors.MessageReplyNO_targetId.label = 1
field_descriptors.MessageReplyNO_targetId.has_default_value = false
field_descriptors.MessageReplyNO_targetId.default_value = 0
field_descriptors.MessageReplyNO_targetId.type = 3
field_descriptors.MessageReplyNO_targetId.cpp_type = 2
type_descriptors.MessageReplyNO.name = "MessageReplyNO"
type_descriptors.MessageReplyNO.full_name = ".MessageReplyNO"
type_descriptors.MessageReplyNO.nested_types = {}
type_descriptors.MessageReplyNO.enum_types = {}
type_descriptors.MessageReplyNO.fields = {
	field_descriptors.MessageReplyNO_messageType,
	field_descriptors.MessageReplyNO_channelType,
	field_descriptors.MessageReplyNO_content,
	field_descriptors.MessageReplyNO_time,
	field_descriptors.MessageReplyNO_senderId,
	field_descriptors.MessageReplyNO_targetId
}
type_descriptors.MessageReplyNO.is_extendable = false
type_descriptors.MessageReplyNO.extensions = {}
field_descriptors.SendMessageRequest_message.name = "message"
field_descriptors.SendMessageRequest_message.full_name = ".SendMessageRequest.message"
field_descriptors.SendMessageRequest_message.number = 1
field_descriptors.SendMessageRequest_message.index = 0
field_descriptors.SendMessageRequest_message.label = 2
field_descriptors.SendMessageRequest_message.has_default_value = false
field_descriptors.SendMessageRequest_message.default_value = nil
field_descriptors.SendMessageRequest_message.message_type = type_descriptors.MessageRequestNO
field_descriptors.SendMessageRequest_message.type = 11
field_descriptors.SendMessageRequest_message.cpp_type = 10
type_descriptors.SendMessageRequest.name = "SendMessageRequest"
type_descriptors.SendMessageRequest.full_name = ".SendMessageRequest"
type_descriptors.SendMessageRequest.nested_types = {}
type_descriptors.SendMessageRequest.enum_types = {}
type_descriptors.SendMessageRequest.fields = {
	field_descriptors.SendMessageRequest_message
}
type_descriptors.SendMessageRequest.is_extendable = false
type_descriptors.SendMessageRequest.extensions = {}
NotifyType = {
	ForceUpdate = 1
}
BroadcastPush = protobuf.Message(type_descriptors.BroadcastPush)
MessageReplyNO = protobuf.Message(type_descriptors.MessageReplyNO)
MessageRequestNO = protobuf.Message(type_descriptors.MessageRequestNO)
NewMessagePush = protobuf.Message(type_descriptors.NewMessagePush)
SendMessageReply = protobuf.Message(type_descriptors.SendMessageReply)
SendMessageRequest = protobuf.Message(type_descriptors.SendMessageRequest)

return _G["logic.proto.ChatExtension_pb"]

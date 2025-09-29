-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/MailExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.BackpackExtension = require("logic.proto.BackpackExtension_pb")

module("logic.proto.MailExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.UnlockSecretMailReply = protobuf.Descriptor()
type_descriptors.TakeMailAttachmentReply = protobuf.Descriptor()
field_descriptors.TakeMailAttachmentReply_fullBackpacks = protobuf.FieldDescriptor()
type_descriptors.GetHistoryMailInfoReply = protobuf.Descriptor()
field_descriptors.GetHistoryMailInfoReply_mails = protobuf.FieldDescriptor()
type_descriptors.UnlockSecretMailRequest = protobuf.Descriptor()
field_descriptors.UnlockSecretMailRequest_id = protobuf.FieldDescriptor()
type_descriptors.TakeMailAttachmentRequest = protobuf.Descriptor()
field_descriptors.TakeMailAttachmentRequest_id = protobuf.FieldDescriptor()
type_descriptors.GetMailInfoRequest = protobuf.Descriptor()
type_descriptors.GetMailInfoReply = protobuf.Descriptor()
field_descriptors.GetMailInfoReply_mails = protobuf.FieldDescriptor()
type_descriptors.NotifyNewMailPush = protobuf.Descriptor()
field_descriptors.NotifyNewMailPush_ids = protobuf.FieldDescriptor()
type_descriptors.GetHistoryMailInfoRequest = protobuf.Descriptor()
type_descriptors.MarkMailReadReply = protobuf.Descriptor()
type_descriptors.RemoveAllReadMailRequest = protobuf.Descriptor()
type_descriptors.MailNO = protobuf.Descriptor()
field_descriptors.MailNO_id = protobuf.FieldDescriptor()
field_descriptors.MailNO_flags = protobuf.FieldDescriptor()
field_descriptors.MailNO_receivedTime = protobuf.FieldDescriptor()
field_descriptors.MailNO_expiredTime = protobuf.FieldDescriptor()
field_descriptors.MailNO_mailCode = protobuf.FieldDescriptor()
field_descriptors.MailNO_senderName = protobuf.FieldDescriptor()
field_descriptors.MailNO_senderLocation = protobuf.FieldDescriptor()
field_descriptors.MailNO_title = protobuf.FieldDescriptor()
field_descriptors.MailNO_content = protobuf.FieldDescriptor()
field_descriptors.MailNO_attachments = protobuf.FieldDescriptor()
field_descriptors.MailNO_bgmId = protobuf.FieldDescriptor()
field_descriptors.MailNO_surveyRank = protobuf.FieldDescriptor()
field_descriptors.MailNO_surveyUrl = protobuf.FieldDescriptor()
type_descriptors.MarkMailReadRequest = protobuf.Descriptor()
field_descriptors.MarkMailReadRequest_id = protobuf.FieldDescriptor()
type_descriptors.TakeAllMailAttachmentRequest = protobuf.Descriptor()
type_descriptors.TakeAllMailAttachmentReply = protobuf.Descriptor()
field_descriptors.TakeAllMailAttachmentReply_ids = protobuf.FieldDescriptor()
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks = protobuf.FieldDescriptor()
type_descriptors.RemoveAllReadMailReply = protobuf.Descriptor()
field_descriptors.RemoveAllReadMailReply_ids = protobuf.FieldDescriptor()
type_descriptors.UnlockSecretMailReply.name = "UnlockSecretMailReply"
type_descriptors.UnlockSecretMailReply.full_name = ".UnlockSecretMailReply"
type_descriptors.UnlockSecretMailReply.nested_types = {}
type_descriptors.UnlockSecretMailReply.enum_types = {}
type_descriptors.UnlockSecretMailReply.fields = {}
type_descriptors.UnlockSecretMailReply.is_extendable = false
type_descriptors.UnlockSecretMailReply.extensions = {}
field_descriptors.TakeMailAttachmentReply_fullBackpacks.name = "fullBackpacks"
field_descriptors.TakeMailAttachmentReply_fullBackpacks.full_name = ".TakeMailAttachmentReply.fullBackpacks"
field_descriptors.TakeMailAttachmentReply_fullBackpacks.number = 1
field_descriptors.TakeMailAttachmentReply_fullBackpacks.index = 0
field_descriptors.TakeMailAttachmentReply_fullBackpacks.label = 3
field_descriptors.TakeMailAttachmentReply_fullBackpacks.has_default_value = false
field_descriptors.TakeMailAttachmentReply_fullBackpacks.default_value = {}
field_descriptors.TakeMailAttachmentReply_fullBackpacks.type = 5
field_descriptors.TakeMailAttachmentReply_fullBackpacks.cpp_type = 1
type_descriptors.TakeMailAttachmentReply.name = "TakeMailAttachmentReply"
type_descriptors.TakeMailAttachmentReply.full_name = ".TakeMailAttachmentReply"
type_descriptors.TakeMailAttachmentReply.nested_types = {}
type_descriptors.TakeMailAttachmentReply.enum_types = {}
type_descriptors.TakeMailAttachmentReply.fields = {
	field_descriptors.TakeMailAttachmentReply_fullBackpacks
}
type_descriptors.TakeMailAttachmentReply.is_extendable = false
type_descriptors.TakeMailAttachmentReply.extensions = {}
field_descriptors.GetHistoryMailInfoReply_mails.name = "mails"
field_descriptors.GetHistoryMailInfoReply_mails.full_name = ".GetHistoryMailInfoReply.mails"
field_descriptors.GetHistoryMailInfoReply_mails.number = 1
field_descriptors.GetHistoryMailInfoReply_mails.index = 0
field_descriptors.GetHistoryMailInfoReply_mails.label = 3
field_descriptors.GetHistoryMailInfoReply_mails.has_default_value = false
field_descriptors.GetHistoryMailInfoReply_mails.default_value = {}
field_descriptors.GetHistoryMailInfoReply_mails.message_type = type_descriptors.MailNO
field_descriptors.GetHistoryMailInfoReply_mails.type = 11
field_descriptors.GetHistoryMailInfoReply_mails.cpp_type = 10
type_descriptors.GetHistoryMailInfoReply.name = "GetHistoryMailInfoReply"
type_descriptors.GetHistoryMailInfoReply.full_name = ".GetHistoryMailInfoReply"
type_descriptors.GetHistoryMailInfoReply.nested_types = {}
type_descriptors.GetHistoryMailInfoReply.enum_types = {}
type_descriptors.GetHistoryMailInfoReply.fields = {
	field_descriptors.GetHistoryMailInfoReply_mails
}
type_descriptors.GetHistoryMailInfoReply.is_extendable = false
type_descriptors.GetHistoryMailInfoReply.extensions = {}
field_descriptors.UnlockSecretMailRequest_id.name = "id"
field_descriptors.UnlockSecretMailRequest_id.full_name = ".UnlockSecretMailRequest.id"
field_descriptors.UnlockSecretMailRequest_id.number = 1
field_descriptors.UnlockSecretMailRequest_id.index = 0
field_descriptors.UnlockSecretMailRequest_id.label = 1
field_descriptors.UnlockSecretMailRequest_id.has_default_value = false
field_descriptors.UnlockSecretMailRequest_id.default_value = 0
field_descriptors.UnlockSecretMailRequest_id.type = 3
field_descriptors.UnlockSecretMailRequest_id.cpp_type = 2
type_descriptors.UnlockSecretMailRequest.name = "UnlockSecretMailRequest"
type_descriptors.UnlockSecretMailRequest.full_name = ".UnlockSecretMailRequest"
type_descriptors.UnlockSecretMailRequest.nested_types = {}
type_descriptors.UnlockSecretMailRequest.enum_types = {}
type_descriptors.UnlockSecretMailRequest.fields = {
	field_descriptors.UnlockSecretMailRequest_id
}
type_descriptors.UnlockSecretMailRequest.is_extendable = false
type_descriptors.UnlockSecretMailRequest.extensions = {}
field_descriptors.TakeMailAttachmentRequest_id.name = "id"
field_descriptors.TakeMailAttachmentRequest_id.full_name = ".TakeMailAttachmentRequest.id"
field_descriptors.TakeMailAttachmentRequest_id.number = 1
field_descriptors.TakeMailAttachmentRequest_id.index = 0
field_descriptors.TakeMailAttachmentRequest_id.label = 1
field_descriptors.TakeMailAttachmentRequest_id.has_default_value = false
field_descriptors.TakeMailAttachmentRequest_id.default_value = 0
field_descriptors.TakeMailAttachmentRequest_id.type = 3
field_descriptors.TakeMailAttachmentRequest_id.cpp_type = 2
type_descriptors.TakeMailAttachmentRequest.name = "TakeMailAttachmentRequest"
type_descriptors.TakeMailAttachmentRequest.full_name = ".TakeMailAttachmentRequest"
type_descriptors.TakeMailAttachmentRequest.nested_types = {}
type_descriptors.TakeMailAttachmentRequest.enum_types = {}
type_descriptors.TakeMailAttachmentRequest.fields = {
	field_descriptors.TakeMailAttachmentRequest_id
}
type_descriptors.TakeMailAttachmentRequest.is_extendable = false
type_descriptors.TakeMailAttachmentRequest.extensions = {}
type_descriptors.GetMailInfoRequest.name = "GetMailInfoRequest"
type_descriptors.GetMailInfoRequest.full_name = ".GetMailInfoRequest"
type_descriptors.GetMailInfoRequest.nested_types = {}
type_descriptors.GetMailInfoRequest.enum_types = {}
type_descriptors.GetMailInfoRequest.fields = {}
type_descriptors.GetMailInfoRequest.is_extendable = false
type_descriptors.GetMailInfoRequest.extensions = {}
field_descriptors.GetMailInfoReply_mails.name = "mails"
field_descriptors.GetMailInfoReply_mails.full_name = ".GetMailInfoReply.mails"
field_descriptors.GetMailInfoReply_mails.number = 1
field_descriptors.GetMailInfoReply_mails.index = 0
field_descriptors.GetMailInfoReply_mails.label = 3
field_descriptors.GetMailInfoReply_mails.has_default_value = false
field_descriptors.GetMailInfoReply_mails.default_value = {}
field_descriptors.GetMailInfoReply_mails.message_type = type_descriptors.MailNO
field_descriptors.GetMailInfoReply_mails.type = 11
field_descriptors.GetMailInfoReply_mails.cpp_type = 10
type_descriptors.GetMailInfoReply.name = "GetMailInfoReply"
type_descriptors.GetMailInfoReply.full_name = ".GetMailInfoReply"
type_descriptors.GetMailInfoReply.nested_types = {}
type_descriptors.GetMailInfoReply.enum_types = {}
type_descriptors.GetMailInfoReply.fields = {
	field_descriptors.GetMailInfoReply_mails
}
type_descriptors.GetMailInfoReply.is_extendable = false
type_descriptors.GetMailInfoReply.extensions = {}
field_descriptors.NotifyNewMailPush_ids.name = "ids"
field_descriptors.NotifyNewMailPush_ids.full_name = ".NotifyNewMailPush.ids"
field_descriptors.NotifyNewMailPush_ids.number = 1
field_descriptors.NotifyNewMailPush_ids.index = 0
field_descriptors.NotifyNewMailPush_ids.label = 3
field_descriptors.NotifyNewMailPush_ids.has_default_value = false
field_descriptors.NotifyNewMailPush_ids.default_value = {}
field_descriptors.NotifyNewMailPush_ids.type = 3
field_descriptors.NotifyNewMailPush_ids.cpp_type = 2
type_descriptors.NotifyNewMailPush.name = "NotifyNewMailPush"
type_descriptors.NotifyNewMailPush.full_name = ".NotifyNewMailPush"
type_descriptors.NotifyNewMailPush.nested_types = {}
type_descriptors.NotifyNewMailPush.enum_types = {}
type_descriptors.NotifyNewMailPush.fields = {
	field_descriptors.NotifyNewMailPush_ids
}
type_descriptors.NotifyNewMailPush.is_extendable = false
type_descriptors.NotifyNewMailPush.extensions = {}
type_descriptors.GetHistoryMailInfoRequest.name = "GetHistoryMailInfoRequest"
type_descriptors.GetHistoryMailInfoRequest.full_name = ".GetHistoryMailInfoRequest"
type_descriptors.GetHistoryMailInfoRequest.nested_types = {}
type_descriptors.GetHistoryMailInfoRequest.enum_types = {}
type_descriptors.GetHistoryMailInfoRequest.fields = {}
type_descriptors.GetHistoryMailInfoRequest.is_extendable = false
type_descriptors.GetHistoryMailInfoRequest.extensions = {}
type_descriptors.MarkMailReadReply.name = "MarkMailReadReply"
type_descriptors.MarkMailReadReply.full_name = ".MarkMailReadReply"
type_descriptors.MarkMailReadReply.nested_types = {}
type_descriptors.MarkMailReadReply.enum_types = {}
type_descriptors.MarkMailReadReply.fields = {}
type_descriptors.MarkMailReadReply.is_extendable = false
type_descriptors.MarkMailReadReply.extensions = {}
type_descriptors.RemoveAllReadMailRequest.name = "RemoveAllReadMailRequest"
type_descriptors.RemoveAllReadMailRequest.full_name = ".RemoveAllReadMailRequest"
type_descriptors.RemoveAllReadMailRequest.nested_types = {}
type_descriptors.RemoveAllReadMailRequest.enum_types = {}
type_descriptors.RemoveAllReadMailRequest.fields = {}
type_descriptors.RemoveAllReadMailRequest.is_extendable = false
type_descriptors.RemoveAllReadMailRequest.extensions = {}
field_descriptors.MailNO_id.name = "id"
field_descriptors.MailNO_id.full_name = ".MailNO.id"
field_descriptors.MailNO_id.number = 1
field_descriptors.MailNO_id.index = 0
field_descriptors.MailNO_id.label = 1
field_descriptors.MailNO_id.has_default_value = false
field_descriptors.MailNO_id.default_value = 0
field_descriptors.MailNO_id.type = 3
field_descriptors.MailNO_id.cpp_type = 2
field_descriptors.MailNO_flags.name = "flags"
field_descriptors.MailNO_flags.full_name = ".MailNO.flags"
field_descriptors.MailNO_flags.number = 2
field_descriptors.MailNO_flags.index = 1
field_descriptors.MailNO_flags.label = 1
field_descriptors.MailNO_flags.has_default_value = false
field_descriptors.MailNO_flags.default_value = 0
field_descriptors.MailNO_flags.type = 5
field_descriptors.MailNO_flags.cpp_type = 1
field_descriptors.MailNO_receivedTime.name = "receivedTime"
field_descriptors.MailNO_receivedTime.full_name = ".MailNO.receivedTime"
field_descriptors.MailNO_receivedTime.number = 3
field_descriptors.MailNO_receivedTime.index = 2
field_descriptors.MailNO_receivedTime.label = 1
field_descriptors.MailNO_receivedTime.has_default_value = false
field_descriptors.MailNO_receivedTime.default_value = 0
field_descriptors.MailNO_receivedTime.type = 3
field_descriptors.MailNO_receivedTime.cpp_type = 2
field_descriptors.MailNO_expiredTime.name = "expiredTime"
field_descriptors.MailNO_expiredTime.full_name = ".MailNO.expiredTime"
field_descriptors.MailNO_expiredTime.number = 4
field_descriptors.MailNO_expiredTime.index = 3
field_descriptors.MailNO_expiredTime.label = 1
field_descriptors.MailNO_expiredTime.has_default_value = false
field_descriptors.MailNO_expiredTime.default_value = 0
field_descriptors.MailNO_expiredTime.type = 3
field_descriptors.MailNO_expiredTime.cpp_type = 2
field_descriptors.MailNO_mailCode.name = "mailCode"
field_descriptors.MailNO_mailCode.full_name = ".MailNO.mailCode"
field_descriptors.MailNO_mailCode.number = 5
field_descriptors.MailNO_mailCode.index = 4
field_descriptors.MailNO_mailCode.label = 1
field_descriptors.MailNO_mailCode.has_default_value = false
field_descriptors.MailNO_mailCode.default_value = 0
field_descriptors.MailNO_mailCode.type = 5
field_descriptors.MailNO_mailCode.cpp_type = 1
field_descriptors.MailNO_senderName.name = "senderName"
field_descriptors.MailNO_senderName.full_name = ".MailNO.senderName"
field_descriptors.MailNO_senderName.number = 6
field_descriptors.MailNO_senderName.index = 5
field_descriptors.MailNO_senderName.label = 1
field_descriptors.MailNO_senderName.has_default_value = false
field_descriptors.MailNO_senderName.default_value = ""
field_descriptors.MailNO_senderName.type = 9
field_descriptors.MailNO_senderName.cpp_type = 9
field_descriptors.MailNO_senderLocation.name = "senderLocation"
field_descriptors.MailNO_senderLocation.full_name = ".MailNO.senderLocation"
field_descriptors.MailNO_senderLocation.number = 7
field_descriptors.MailNO_senderLocation.index = 6
field_descriptors.MailNO_senderLocation.label = 1
field_descriptors.MailNO_senderLocation.has_default_value = false
field_descriptors.MailNO_senderLocation.default_value = ""
field_descriptors.MailNO_senderLocation.type = 9
field_descriptors.MailNO_senderLocation.cpp_type = 9
field_descriptors.MailNO_title.name = "title"
field_descriptors.MailNO_title.full_name = ".MailNO.title"
field_descriptors.MailNO_title.number = 8
field_descriptors.MailNO_title.index = 7
field_descriptors.MailNO_title.label = 1
field_descriptors.MailNO_title.has_default_value = false
field_descriptors.MailNO_title.default_value = ""
field_descriptors.MailNO_title.type = 9
field_descriptors.MailNO_title.cpp_type = 9
field_descriptors.MailNO_content.name = "content"
field_descriptors.MailNO_content.full_name = ".MailNO.content"
field_descriptors.MailNO_content.number = 9
field_descriptors.MailNO_content.index = 8
field_descriptors.MailNO_content.label = 1
field_descriptors.MailNO_content.has_default_value = false
field_descriptors.MailNO_content.default_value = ""
field_descriptors.MailNO_content.type = 9
field_descriptors.MailNO_content.cpp_type = 9
field_descriptors.MailNO_attachments.name = "attachments"
field_descriptors.MailNO_attachments.full_name = ".MailNO.attachments"
field_descriptors.MailNO_attachments.number = 10
field_descriptors.MailNO_attachments.index = 9
field_descriptors.MailNO_attachments.label = 3
field_descriptors.MailNO_attachments.has_default_value = false
field_descriptors.MailNO_attachments.default_value = {}
field_descriptors.MailNO_attachments.message_type = dependencies.BackpackExtension.type_descriptors.ItemNO
field_descriptors.MailNO_attachments.type = 11
field_descriptors.MailNO_attachments.cpp_type = 10
field_descriptors.MailNO_bgmId.name = "bgmId"
field_descriptors.MailNO_bgmId.full_name = ".MailNO.bgmId"
field_descriptors.MailNO_bgmId.number = 11
field_descriptors.MailNO_bgmId.index = 10
field_descriptors.MailNO_bgmId.label = 1
field_descriptors.MailNO_bgmId.has_default_value = false
field_descriptors.MailNO_bgmId.default_value = 0
field_descriptors.MailNO_bgmId.type = 5
field_descriptors.MailNO_bgmId.cpp_type = 1
field_descriptors.MailNO_surveyRank.name = "surveyRank"
field_descriptors.MailNO_surveyRank.full_name = ".MailNO.surveyRank"
field_descriptors.MailNO_surveyRank.number = 12
field_descriptors.MailNO_surveyRank.index = 11
field_descriptors.MailNO_surveyRank.label = 1
field_descriptors.MailNO_surveyRank.has_default_value = false
field_descriptors.MailNO_surveyRank.default_value = 0
field_descriptors.MailNO_surveyRank.type = 5
field_descriptors.MailNO_surveyRank.cpp_type = 1
field_descriptors.MailNO_surveyUrl.name = "surveyUrl"
field_descriptors.MailNO_surveyUrl.full_name = ".MailNO.surveyUrl"
field_descriptors.MailNO_surveyUrl.number = 13
field_descriptors.MailNO_surveyUrl.index = 12
field_descriptors.MailNO_surveyUrl.label = 1
field_descriptors.MailNO_surveyUrl.has_default_value = false
field_descriptors.MailNO_surveyUrl.default_value = ""
field_descriptors.MailNO_surveyUrl.type = 9
field_descriptors.MailNO_surveyUrl.cpp_type = 9
type_descriptors.MailNO.name = "MailNO"
type_descriptors.MailNO.full_name = ".MailNO"
type_descriptors.MailNO.nested_types = {}
type_descriptors.MailNO.enum_types = {}
type_descriptors.MailNO.fields = {
	field_descriptors.MailNO_id,
	field_descriptors.MailNO_flags,
	field_descriptors.MailNO_receivedTime,
	field_descriptors.MailNO_expiredTime,
	field_descriptors.MailNO_mailCode,
	field_descriptors.MailNO_senderName,
	field_descriptors.MailNO_senderLocation,
	field_descriptors.MailNO_title,
	field_descriptors.MailNO_content,
	field_descriptors.MailNO_attachments,
	field_descriptors.MailNO_bgmId,
	field_descriptors.MailNO_surveyRank,
	field_descriptors.MailNO_surveyUrl
}
type_descriptors.MailNO.is_extendable = false
type_descriptors.MailNO.extensions = {}
field_descriptors.MarkMailReadRequest_id.name = "id"
field_descriptors.MarkMailReadRequest_id.full_name = ".MarkMailReadRequest.id"
field_descriptors.MarkMailReadRequest_id.number = 1
field_descriptors.MarkMailReadRequest_id.index = 0
field_descriptors.MarkMailReadRequest_id.label = 1
field_descriptors.MarkMailReadRequest_id.has_default_value = false
field_descriptors.MarkMailReadRequest_id.default_value = 0
field_descriptors.MarkMailReadRequest_id.type = 3
field_descriptors.MarkMailReadRequest_id.cpp_type = 2
type_descriptors.MarkMailReadRequest.name = "MarkMailReadRequest"
type_descriptors.MarkMailReadRequest.full_name = ".MarkMailReadRequest"
type_descriptors.MarkMailReadRequest.nested_types = {}
type_descriptors.MarkMailReadRequest.enum_types = {}
type_descriptors.MarkMailReadRequest.fields = {
	field_descriptors.MarkMailReadRequest_id
}
type_descriptors.MarkMailReadRequest.is_extendable = false
type_descriptors.MarkMailReadRequest.extensions = {}
type_descriptors.TakeAllMailAttachmentRequest.name = "TakeAllMailAttachmentRequest"
type_descriptors.TakeAllMailAttachmentRequest.full_name = ".TakeAllMailAttachmentRequest"
type_descriptors.TakeAllMailAttachmentRequest.nested_types = {}
type_descriptors.TakeAllMailAttachmentRequest.enum_types = {}
type_descriptors.TakeAllMailAttachmentRequest.fields = {}
type_descriptors.TakeAllMailAttachmentRequest.is_extendable = false
type_descriptors.TakeAllMailAttachmentRequest.extensions = {}
field_descriptors.TakeAllMailAttachmentReply_ids.name = "ids"
field_descriptors.TakeAllMailAttachmentReply_ids.full_name = ".TakeAllMailAttachmentReply.ids"
field_descriptors.TakeAllMailAttachmentReply_ids.number = 1
field_descriptors.TakeAllMailAttachmentReply_ids.index = 0
field_descriptors.TakeAllMailAttachmentReply_ids.label = 3
field_descriptors.TakeAllMailAttachmentReply_ids.has_default_value = false
field_descriptors.TakeAllMailAttachmentReply_ids.default_value = {}
field_descriptors.TakeAllMailAttachmentReply_ids.type = 3
field_descriptors.TakeAllMailAttachmentReply_ids.cpp_type = 2
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.name = "fullBackpacks"
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.full_name = ".TakeAllMailAttachmentReply.fullBackpacks"
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.number = 2
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.index = 1
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.label = 3
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.has_default_value = false
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.default_value = {}
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.type = 5
field_descriptors.TakeAllMailAttachmentReply_fullBackpacks.cpp_type = 1
type_descriptors.TakeAllMailAttachmentReply.name = "TakeAllMailAttachmentReply"
type_descriptors.TakeAllMailAttachmentReply.full_name = ".TakeAllMailAttachmentReply"
type_descriptors.TakeAllMailAttachmentReply.nested_types = {}
type_descriptors.TakeAllMailAttachmentReply.enum_types = {}
type_descriptors.TakeAllMailAttachmentReply.fields = {
	field_descriptors.TakeAllMailAttachmentReply_ids,
	field_descriptors.TakeAllMailAttachmentReply_fullBackpacks
}
type_descriptors.TakeAllMailAttachmentReply.is_extendable = false
type_descriptors.TakeAllMailAttachmentReply.extensions = {}
field_descriptors.RemoveAllReadMailReply_ids.name = "ids"
field_descriptors.RemoveAllReadMailReply_ids.full_name = ".RemoveAllReadMailReply.ids"
field_descriptors.RemoveAllReadMailReply_ids.number = 2
field_descriptors.RemoveAllReadMailReply_ids.index = 0
field_descriptors.RemoveAllReadMailReply_ids.label = 3
field_descriptors.RemoveAllReadMailReply_ids.has_default_value = false
field_descriptors.RemoveAllReadMailReply_ids.default_value = {}
field_descriptors.RemoveAllReadMailReply_ids.type = 3
field_descriptors.RemoveAllReadMailReply_ids.cpp_type = 2
type_descriptors.RemoveAllReadMailReply.name = "RemoveAllReadMailReply"
type_descriptors.RemoveAllReadMailReply.full_name = ".RemoveAllReadMailReply"
type_descriptors.RemoveAllReadMailReply.nested_types = {}
type_descriptors.RemoveAllReadMailReply.enum_types = {}
type_descriptors.RemoveAllReadMailReply.fields = {
	field_descriptors.RemoveAllReadMailReply_ids
}
type_descriptors.RemoveAllReadMailReply.is_extendable = false
type_descriptors.RemoveAllReadMailReply.extensions = {}
GetHistoryMailInfoReply = protobuf.Message(type_descriptors.GetHistoryMailInfoReply)
GetHistoryMailInfoRequest = protobuf.Message(type_descriptors.GetHistoryMailInfoRequest)
GetMailInfoReply = protobuf.Message(type_descriptors.GetMailInfoReply)
GetMailInfoRequest = protobuf.Message(type_descriptors.GetMailInfoRequest)
MailNO = protobuf.Message(type_descriptors.MailNO)
MarkMailReadReply = protobuf.Message(type_descriptors.MarkMailReadReply)
MarkMailReadRequest = protobuf.Message(type_descriptors.MarkMailReadRequest)
NotifyNewMailPush = protobuf.Message(type_descriptors.NotifyNewMailPush)
RemoveAllReadMailReply = protobuf.Message(type_descriptors.RemoveAllReadMailReply)
RemoveAllReadMailRequest = protobuf.Message(type_descriptors.RemoveAllReadMailRequest)
TakeAllMailAttachmentReply = protobuf.Message(type_descriptors.TakeAllMailAttachmentReply)
TakeAllMailAttachmentRequest = protobuf.Message(type_descriptors.TakeAllMailAttachmentRequest)
TakeMailAttachmentReply = protobuf.Message(type_descriptors.TakeMailAttachmentReply)
TakeMailAttachmentRequest = protobuf.Message(type_descriptors.TakeMailAttachmentRequest)
UnlockSecretMailReply = protobuf.Message(type_descriptors.UnlockSecretMailReply)
UnlockSecretMailRequest = protobuf.Message(type_descriptors.UnlockSecretMailRequest)

return _G["logic.proto.MailExtension_pb"]

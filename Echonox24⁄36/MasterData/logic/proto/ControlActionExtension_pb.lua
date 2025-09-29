-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/ControlActionExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

dependencies.TaskExtension = require("logic.proto.TaskExtension_pb")

module("logic.proto.ControlActionExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.ControlActionNO = protobuf.Descriptor()
field_descriptors.ControlActionNO_area = protobuf.FieldDescriptor()
field_descriptors.ControlActionNO_level = protobuf.FieldDescriptor()
field_descriptors.ControlActionNO_postCode = protobuf.FieldDescriptor()
type_descriptors.PostReplyNO = protobuf.Descriptor()
field_descriptors.PostReplyNO_floor = protobuf.FieldDescriptor()
field_descriptors.PostReplyNO_time = protobuf.FieldDescriptor()
field_descriptors.PostReplyNO_author = protobuf.FieldDescriptor()
field_descriptors.PostReplyNO_contentCode = protobuf.FieldDescriptor()
field_descriptors.PostReplyNO_likesCount = protobuf.FieldDescriptor()
field_descriptors.PostReplyNO_like = protobuf.FieldDescriptor()
type_descriptors.GetPostListRequest = protobuf.Descriptor()
type_descriptors.CancelLikePostRequest = protobuf.Descriptor()
field_descriptors.CancelLikePostRequest_id = protobuf.FieldDescriptor()
field_descriptors.CancelLikePostRequest_floor = protobuf.FieldDescriptor()
type_descriptors.GetTaskRewardRequest = protobuf.Descriptor()
field_descriptors.GetTaskRewardRequest_id = protobuf.FieldDescriptor()
type_descriptors.GetUnlockedProtomersRequest = protobuf.Descriptor()
type_descriptors.GetPostRequest = protobuf.Descriptor()
field_descriptors.GetPostRequest_id = protobuf.FieldDescriptor()
type_descriptors.ProtomerNO = protobuf.Descriptor()
field_descriptors.ProtomerNO_id = protobuf.FieldDescriptor()
field_descriptors.ProtomerNO_tasks = protobuf.FieldDescriptor()
field_descriptors.ProtomerNO_canHold = protobuf.FieldDescriptor()
field_descriptors.ProtomerNO_isHold = protobuf.FieldDescriptor()
type_descriptors.GetPostListReply = protobuf.Descriptor()
field_descriptors.GetPostListReply_posts = protobuf.FieldDescriptor()
type_descriptors.GetPostReply = protobuf.Descriptor()
field_descriptors.GetPostReply_id = protobuf.FieldDescriptor()
field_descriptors.GetPostReply_posts = protobuf.FieldDescriptor()
type_descriptors.CancelLikePostReply = protobuf.Descriptor()
field_descriptors.CancelLikePostReply_id = protobuf.FieldDescriptor()
field_descriptors.CancelLikePostReply_floor = protobuf.FieldDescriptor()
type_descriptors.LikePostRequest = protobuf.Descriptor()
field_descriptors.LikePostRequest_id = protobuf.FieldDescriptor()
field_descriptors.LikePostRequest_floor = protobuf.FieldDescriptor()
type_descriptors.GetUnlockedProtomersReply = protobuf.Descriptor()
field_descriptors.GetUnlockedProtomersReply_protomers = protobuf.FieldDescriptor()
type_descriptors.GetControlActionsReply = protobuf.Descriptor()
field_descriptors.GetControlActionsReply_actions = protobuf.FieldDescriptor()
field_descriptors.GetControlActionsReply_passTime = protobuf.FieldDescriptor()
type_descriptors.HoldProtomerReply = protobuf.Descriptor()
field_descriptors.HoldProtomerReply_id = protobuf.FieldDescriptor()
type_descriptors.HoldProtomerRequest = protobuf.Descriptor()
field_descriptors.HoldProtomerRequest_id = protobuf.FieldDescriptor()
type_descriptors.GetControlActionsRequest = protobuf.Descriptor()
type_descriptors.GetTaskRewardReply = protobuf.Descriptor()
field_descriptors.GetTaskRewardReply_id = protobuf.FieldDescriptor()
type_descriptors.PostNO = protobuf.Descriptor()
field_descriptors.PostNO_id = protobuf.FieldDescriptor()
field_descriptors.PostNO_contentCode = protobuf.FieldDescriptor()
field_descriptors.PostNO_author = protobuf.FieldDescriptor()
field_descriptors.PostNO_time = protobuf.FieldDescriptor()
field_descriptors.PostNO_likesCount = protobuf.FieldDescriptor()
field_descriptors.PostNO_isTop = protobuf.FieldDescriptor()
type_descriptors.LikePostReply = protobuf.Descriptor()
field_descriptors.LikePostReply_id = protobuf.FieldDescriptor()
field_descriptors.LikePostReply_floor = protobuf.FieldDescriptor()
field_descriptors.ControlActionNO_area.name = "area"
field_descriptors.ControlActionNO_area.full_name = ".ControlActionNO.area"
field_descriptors.ControlActionNO_area.number = 1
field_descriptors.ControlActionNO_area.index = 0
field_descriptors.ControlActionNO_area.label = 2
field_descriptors.ControlActionNO_area.has_default_value = false
field_descriptors.ControlActionNO_area.default_value = 0
field_descriptors.ControlActionNO_area.type = 5
field_descriptors.ControlActionNO_area.cpp_type = 1
field_descriptors.ControlActionNO_level.name = "level"
field_descriptors.ControlActionNO_level.full_name = ".ControlActionNO.level"
field_descriptors.ControlActionNO_level.number = 2
field_descriptors.ControlActionNO_level.index = 1
field_descriptors.ControlActionNO_level.label = 2
field_descriptors.ControlActionNO_level.has_default_value = false
field_descriptors.ControlActionNO_level.default_value = 0
field_descriptors.ControlActionNO_level.type = 5
field_descriptors.ControlActionNO_level.cpp_type = 1
field_descriptors.ControlActionNO_postCode.name = "postCode"
field_descriptors.ControlActionNO_postCode.full_name = ".ControlActionNO.postCode"
field_descriptors.ControlActionNO_postCode.number = 3
field_descriptors.ControlActionNO_postCode.index = 2
field_descriptors.ControlActionNO_postCode.label = 2
field_descriptors.ControlActionNO_postCode.has_default_value = false
field_descriptors.ControlActionNO_postCode.default_value = 0
field_descriptors.ControlActionNO_postCode.type = 5
field_descriptors.ControlActionNO_postCode.cpp_type = 1
type_descriptors.ControlActionNO.name = "ControlActionNO"
type_descriptors.ControlActionNO.full_name = ".ControlActionNO"
type_descriptors.ControlActionNO.nested_types = {}
type_descriptors.ControlActionNO.enum_types = {}
type_descriptors.ControlActionNO.fields = {
	field_descriptors.ControlActionNO_area,
	field_descriptors.ControlActionNO_level,
	field_descriptors.ControlActionNO_postCode
}
type_descriptors.ControlActionNO.is_extendable = false
type_descriptors.ControlActionNO.extensions = {}
field_descriptors.PostReplyNO_floor.name = "floor"
field_descriptors.PostReplyNO_floor.full_name = ".PostReplyNO.floor"
field_descriptors.PostReplyNO_floor.number = 1
field_descriptors.PostReplyNO_floor.index = 0
field_descriptors.PostReplyNO_floor.label = 2
field_descriptors.PostReplyNO_floor.has_default_value = false
field_descriptors.PostReplyNO_floor.default_value = 0
field_descriptors.PostReplyNO_floor.type = 5
field_descriptors.PostReplyNO_floor.cpp_type = 1
field_descriptors.PostReplyNO_time.name = "time"
field_descriptors.PostReplyNO_time.full_name = ".PostReplyNO.time"
field_descriptors.PostReplyNO_time.number = 2
field_descriptors.PostReplyNO_time.index = 1
field_descriptors.PostReplyNO_time.label = 2
field_descriptors.PostReplyNO_time.has_default_value = false
field_descriptors.PostReplyNO_time.default_value = 0
field_descriptors.PostReplyNO_time.type = 3
field_descriptors.PostReplyNO_time.cpp_type = 2
field_descriptors.PostReplyNO_author.name = "author"
field_descriptors.PostReplyNO_author.full_name = ".PostReplyNO.author"
field_descriptors.PostReplyNO_author.number = 3
field_descriptors.PostReplyNO_author.index = 2
field_descriptors.PostReplyNO_author.label = 2
field_descriptors.PostReplyNO_author.has_default_value = false
field_descriptors.PostReplyNO_author.default_value = 0
field_descriptors.PostReplyNO_author.type = 5
field_descriptors.PostReplyNO_author.cpp_type = 1
field_descriptors.PostReplyNO_contentCode.name = "contentCode"
field_descriptors.PostReplyNO_contentCode.full_name = ".PostReplyNO.contentCode"
field_descriptors.PostReplyNO_contentCode.number = 4
field_descriptors.PostReplyNO_contentCode.index = 3
field_descriptors.PostReplyNO_contentCode.label = 2
field_descriptors.PostReplyNO_contentCode.has_default_value = false
field_descriptors.PostReplyNO_contentCode.default_value = 0
field_descriptors.PostReplyNO_contentCode.type = 5
field_descriptors.PostReplyNO_contentCode.cpp_type = 1
field_descriptors.PostReplyNO_likesCount.name = "likesCount"
field_descriptors.PostReplyNO_likesCount.full_name = ".PostReplyNO.likesCount"
field_descriptors.PostReplyNO_likesCount.number = 5
field_descriptors.PostReplyNO_likesCount.index = 4
field_descriptors.PostReplyNO_likesCount.label = 2
field_descriptors.PostReplyNO_likesCount.has_default_value = false
field_descriptors.PostReplyNO_likesCount.default_value = 0
field_descriptors.PostReplyNO_likesCount.type = 5
field_descriptors.PostReplyNO_likesCount.cpp_type = 1
field_descriptors.PostReplyNO_like.name = "like"
field_descriptors.PostReplyNO_like.full_name = ".PostReplyNO.like"
field_descriptors.PostReplyNO_like.number = 6
field_descriptors.PostReplyNO_like.index = 5
field_descriptors.PostReplyNO_like.label = 2
field_descriptors.PostReplyNO_like.has_default_value = false
field_descriptors.PostReplyNO_like.default_value = false
field_descriptors.PostReplyNO_like.type = 8
field_descriptors.PostReplyNO_like.cpp_type = 7
type_descriptors.PostReplyNO.name = "PostReplyNO"
type_descriptors.PostReplyNO.full_name = ".PostReplyNO"
type_descriptors.PostReplyNO.nested_types = {}
type_descriptors.PostReplyNO.enum_types = {}
type_descriptors.PostReplyNO.fields = {
	field_descriptors.PostReplyNO_floor,
	field_descriptors.PostReplyNO_time,
	field_descriptors.PostReplyNO_author,
	field_descriptors.PostReplyNO_contentCode,
	field_descriptors.PostReplyNO_likesCount,
	field_descriptors.PostReplyNO_like
}
type_descriptors.PostReplyNO.is_extendable = false
type_descriptors.PostReplyNO.extensions = {}
type_descriptors.GetPostListRequest.name = "GetPostListRequest"
type_descriptors.GetPostListRequest.full_name = ".GetPostListRequest"
type_descriptors.GetPostListRequest.nested_types = {}
type_descriptors.GetPostListRequest.enum_types = {}
type_descriptors.GetPostListRequest.fields = {}
type_descriptors.GetPostListRequest.is_extendable = false
type_descriptors.GetPostListRequest.extensions = {}
field_descriptors.CancelLikePostRequest_id.name = "id"
field_descriptors.CancelLikePostRequest_id.full_name = ".CancelLikePostRequest.id"
field_descriptors.CancelLikePostRequest_id.number = 1
field_descriptors.CancelLikePostRequest_id.index = 0
field_descriptors.CancelLikePostRequest_id.label = 2
field_descriptors.CancelLikePostRequest_id.has_default_value = false
field_descriptors.CancelLikePostRequest_id.default_value = 0
field_descriptors.CancelLikePostRequest_id.type = 5
field_descriptors.CancelLikePostRequest_id.cpp_type = 1
field_descriptors.CancelLikePostRequest_floor.name = "floor"
field_descriptors.CancelLikePostRequest_floor.full_name = ".CancelLikePostRequest.floor"
field_descriptors.CancelLikePostRequest_floor.number = 2
field_descriptors.CancelLikePostRequest_floor.index = 1
field_descriptors.CancelLikePostRequest_floor.label = 2
field_descriptors.CancelLikePostRequest_floor.has_default_value = false
field_descriptors.CancelLikePostRequest_floor.default_value = 0
field_descriptors.CancelLikePostRequest_floor.type = 5
field_descriptors.CancelLikePostRequest_floor.cpp_type = 1
type_descriptors.CancelLikePostRequest.name = "CancelLikePostRequest"
type_descriptors.CancelLikePostRequest.full_name = ".CancelLikePostRequest"
type_descriptors.CancelLikePostRequest.nested_types = {}
type_descriptors.CancelLikePostRequest.enum_types = {}
type_descriptors.CancelLikePostRequest.fields = {
	field_descriptors.CancelLikePostRequest_id,
	field_descriptors.CancelLikePostRequest_floor
}
type_descriptors.CancelLikePostRequest.is_extendable = false
type_descriptors.CancelLikePostRequest.extensions = {}
field_descriptors.GetTaskRewardRequest_id.name = "id"
field_descriptors.GetTaskRewardRequest_id.full_name = ".GetTaskRewardRequest.id"
field_descriptors.GetTaskRewardRequest_id.number = 1
field_descriptors.GetTaskRewardRequest_id.index = 0
field_descriptors.GetTaskRewardRequest_id.label = 2
field_descriptors.GetTaskRewardRequest_id.has_default_value = false
field_descriptors.GetTaskRewardRequest_id.default_value = 0
field_descriptors.GetTaskRewardRequest_id.type = 5
field_descriptors.GetTaskRewardRequest_id.cpp_type = 1
type_descriptors.GetTaskRewardRequest.name = "GetTaskRewardRequest"
type_descriptors.GetTaskRewardRequest.full_name = ".GetTaskRewardRequest"
type_descriptors.GetTaskRewardRequest.nested_types = {}
type_descriptors.GetTaskRewardRequest.enum_types = {}
type_descriptors.GetTaskRewardRequest.fields = {
	field_descriptors.GetTaskRewardRequest_id
}
type_descriptors.GetTaskRewardRequest.is_extendable = false
type_descriptors.GetTaskRewardRequest.extensions = {}
type_descriptors.GetUnlockedProtomersRequest.name = "GetUnlockedProtomersRequest"
type_descriptors.GetUnlockedProtomersRequest.full_name = ".GetUnlockedProtomersRequest"
type_descriptors.GetUnlockedProtomersRequest.nested_types = {}
type_descriptors.GetUnlockedProtomersRequest.enum_types = {}
type_descriptors.GetUnlockedProtomersRequest.fields = {}
type_descriptors.GetUnlockedProtomersRequest.is_extendable = false
type_descriptors.GetUnlockedProtomersRequest.extensions = {}
field_descriptors.GetPostRequest_id.name = "id"
field_descriptors.GetPostRequest_id.full_name = ".GetPostRequest.id"
field_descriptors.GetPostRequest_id.number = 1
field_descriptors.GetPostRequest_id.index = 0
field_descriptors.GetPostRequest_id.label = 2
field_descriptors.GetPostRequest_id.has_default_value = false
field_descriptors.GetPostRequest_id.default_value = 0
field_descriptors.GetPostRequest_id.type = 5
field_descriptors.GetPostRequest_id.cpp_type = 1
type_descriptors.GetPostRequest.name = "GetPostRequest"
type_descriptors.GetPostRequest.full_name = ".GetPostRequest"
type_descriptors.GetPostRequest.nested_types = {}
type_descriptors.GetPostRequest.enum_types = {}
type_descriptors.GetPostRequest.fields = {
	field_descriptors.GetPostRequest_id
}
type_descriptors.GetPostRequest.is_extendable = false
type_descriptors.GetPostRequest.extensions = {}
field_descriptors.ProtomerNO_id.name = "id"
field_descriptors.ProtomerNO_id.full_name = ".ProtomerNO.id"
field_descriptors.ProtomerNO_id.number = 1
field_descriptors.ProtomerNO_id.index = 0
field_descriptors.ProtomerNO_id.label = 2
field_descriptors.ProtomerNO_id.has_default_value = false
field_descriptors.ProtomerNO_id.default_value = 0
field_descriptors.ProtomerNO_id.type = 5
field_descriptors.ProtomerNO_id.cpp_type = 1
field_descriptors.ProtomerNO_tasks.name = "tasks"
field_descriptors.ProtomerNO_tasks.full_name = ".ProtomerNO.tasks"
field_descriptors.ProtomerNO_tasks.number = 2
field_descriptors.ProtomerNO_tasks.index = 1
field_descriptors.ProtomerNO_tasks.label = 3
field_descriptors.ProtomerNO_tasks.has_default_value = false
field_descriptors.ProtomerNO_tasks.default_value = {}
field_descriptors.ProtomerNO_tasks.message_type = dependencies.TaskExtension.type_descriptors.TaskNO
field_descriptors.ProtomerNO_tasks.type = 11
field_descriptors.ProtomerNO_tasks.cpp_type = 10
field_descriptors.ProtomerNO_canHold.name = "canHold"
field_descriptors.ProtomerNO_canHold.full_name = ".ProtomerNO.canHold"
field_descriptors.ProtomerNO_canHold.number = 3
field_descriptors.ProtomerNO_canHold.index = 2
field_descriptors.ProtomerNO_canHold.label = 1
field_descriptors.ProtomerNO_canHold.has_default_value = false
field_descriptors.ProtomerNO_canHold.default_value = false
field_descriptors.ProtomerNO_canHold.type = 8
field_descriptors.ProtomerNO_canHold.cpp_type = 7
field_descriptors.ProtomerNO_isHold.name = "isHold"
field_descriptors.ProtomerNO_isHold.full_name = ".ProtomerNO.isHold"
field_descriptors.ProtomerNO_isHold.number = 4
field_descriptors.ProtomerNO_isHold.index = 3
field_descriptors.ProtomerNO_isHold.label = 1
field_descriptors.ProtomerNO_isHold.has_default_value = false
field_descriptors.ProtomerNO_isHold.default_value = false
field_descriptors.ProtomerNO_isHold.type = 8
field_descriptors.ProtomerNO_isHold.cpp_type = 7
type_descriptors.ProtomerNO.name = "ProtomerNO"
type_descriptors.ProtomerNO.full_name = ".ProtomerNO"
type_descriptors.ProtomerNO.nested_types = {}
type_descriptors.ProtomerNO.enum_types = {}
type_descriptors.ProtomerNO.fields = {
	field_descriptors.ProtomerNO_id,
	field_descriptors.ProtomerNO_tasks,
	field_descriptors.ProtomerNO_canHold,
	field_descriptors.ProtomerNO_isHold
}
type_descriptors.ProtomerNO.is_extendable = false
type_descriptors.ProtomerNO.extensions = {}
field_descriptors.GetPostListReply_posts.name = "posts"
field_descriptors.GetPostListReply_posts.full_name = ".GetPostListReply.posts"
field_descriptors.GetPostListReply_posts.number = 1
field_descriptors.GetPostListReply_posts.index = 0
field_descriptors.GetPostListReply_posts.label = 3
field_descriptors.GetPostListReply_posts.has_default_value = false
field_descriptors.GetPostListReply_posts.default_value = {}
field_descriptors.GetPostListReply_posts.message_type = type_descriptors.PostNO
field_descriptors.GetPostListReply_posts.type = 11
field_descriptors.GetPostListReply_posts.cpp_type = 10
type_descriptors.GetPostListReply.name = "GetPostListReply"
type_descriptors.GetPostListReply.full_name = ".GetPostListReply"
type_descriptors.GetPostListReply.nested_types = {}
type_descriptors.GetPostListReply.enum_types = {}
type_descriptors.GetPostListReply.fields = {
	field_descriptors.GetPostListReply_posts
}
type_descriptors.GetPostListReply.is_extendable = false
type_descriptors.GetPostListReply.extensions = {}
field_descriptors.GetPostReply_id.name = "id"
field_descriptors.GetPostReply_id.full_name = ".GetPostReply.id"
field_descriptors.GetPostReply_id.number = 1
field_descriptors.GetPostReply_id.index = 0
field_descriptors.GetPostReply_id.label = 2
field_descriptors.GetPostReply_id.has_default_value = false
field_descriptors.GetPostReply_id.default_value = 0
field_descriptors.GetPostReply_id.type = 5
field_descriptors.GetPostReply_id.cpp_type = 1
field_descriptors.GetPostReply_posts.name = "posts"
field_descriptors.GetPostReply_posts.full_name = ".GetPostReply.posts"
field_descriptors.GetPostReply_posts.number = 2
field_descriptors.GetPostReply_posts.index = 1
field_descriptors.GetPostReply_posts.label = 3
field_descriptors.GetPostReply_posts.has_default_value = false
field_descriptors.GetPostReply_posts.default_value = {}
field_descriptors.GetPostReply_posts.message_type = type_descriptors.PostReplyNO
field_descriptors.GetPostReply_posts.type = 11
field_descriptors.GetPostReply_posts.cpp_type = 10
type_descriptors.GetPostReply.name = "GetPostReply"
type_descriptors.GetPostReply.full_name = ".GetPostReply"
type_descriptors.GetPostReply.nested_types = {}
type_descriptors.GetPostReply.enum_types = {}
type_descriptors.GetPostReply.fields = {
	field_descriptors.GetPostReply_id,
	field_descriptors.GetPostReply_posts
}
type_descriptors.GetPostReply.is_extendable = false
type_descriptors.GetPostReply.extensions = {}
field_descriptors.CancelLikePostReply_id.name = "id"
field_descriptors.CancelLikePostReply_id.full_name = ".CancelLikePostReply.id"
field_descriptors.CancelLikePostReply_id.number = 1
field_descriptors.CancelLikePostReply_id.index = 0
field_descriptors.CancelLikePostReply_id.label = 2
field_descriptors.CancelLikePostReply_id.has_default_value = false
field_descriptors.CancelLikePostReply_id.default_value = 0
field_descriptors.CancelLikePostReply_id.type = 5
field_descriptors.CancelLikePostReply_id.cpp_type = 1
field_descriptors.CancelLikePostReply_floor.name = "floor"
field_descriptors.CancelLikePostReply_floor.full_name = ".CancelLikePostReply.floor"
field_descriptors.CancelLikePostReply_floor.number = 2
field_descriptors.CancelLikePostReply_floor.index = 1
field_descriptors.CancelLikePostReply_floor.label = 2
field_descriptors.CancelLikePostReply_floor.has_default_value = false
field_descriptors.CancelLikePostReply_floor.default_value = 0
field_descriptors.CancelLikePostReply_floor.type = 5
field_descriptors.CancelLikePostReply_floor.cpp_type = 1
type_descriptors.CancelLikePostReply.name = "CancelLikePostReply"
type_descriptors.CancelLikePostReply.full_name = ".CancelLikePostReply"
type_descriptors.CancelLikePostReply.nested_types = {}
type_descriptors.CancelLikePostReply.enum_types = {}
type_descriptors.CancelLikePostReply.fields = {
	field_descriptors.CancelLikePostReply_id,
	field_descriptors.CancelLikePostReply_floor
}
type_descriptors.CancelLikePostReply.is_extendable = false
type_descriptors.CancelLikePostReply.extensions = {}
field_descriptors.LikePostRequest_id.name = "id"
field_descriptors.LikePostRequest_id.full_name = ".LikePostRequest.id"
field_descriptors.LikePostRequest_id.number = 1
field_descriptors.LikePostRequest_id.index = 0
field_descriptors.LikePostRequest_id.label = 2
field_descriptors.LikePostRequest_id.has_default_value = false
field_descriptors.LikePostRequest_id.default_value = 0
field_descriptors.LikePostRequest_id.type = 5
field_descriptors.LikePostRequest_id.cpp_type = 1
field_descriptors.LikePostRequest_floor.name = "floor"
field_descriptors.LikePostRequest_floor.full_name = ".LikePostRequest.floor"
field_descriptors.LikePostRequest_floor.number = 2
field_descriptors.LikePostRequest_floor.index = 1
field_descriptors.LikePostRequest_floor.label = 2
field_descriptors.LikePostRequest_floor.has_default_value = false
field_descriptors.LikePostRequest_floor.default_value = 0
field_descriptors.LikePostRequest_floor.type = 5
field_descriptors.LikePostRequest_floor.cpp_type = 1
type_descriptors.LikePostRequest.name = "LikePostRequest"
type_descriptors.LikePostRequest.full_name = ".LikePostRequest"
type_descriptors.LikePostRequest.nested_types = {}
type_descriptors.LikePostRequest.enum_types = {}
type_descriptors.LikePostRequest.fields = {
	field_descriptors.LikePostRequest_id,
	field_descriptors.LikePostRequest_floor
}
type_descriptors.LikePostRequest.is_extendable = false
type_descriptors.LikePostRequest.extensions = {}
field_descriptors.GetUnlockedProtomersReply_protomers.name = "protomers"
field_descriptors.GetUnlockedProtomersReply_protomers.full_name = ".GetUnlockedProtomersReply.protomers"
field_descriptors.GetUnlockedProtomersReply_protomers.number = 1
field_descriptors.GetUnlockedProtomersReply_protomers.index = 0
field_descriptors.GetUnlockedProtomersReply_protomers.label = 3
field_descriptors.GetUnlockedProtomersReply_protomers.has_default_value = false
field_descriptors.GetUnlockedProtomersReply_protomers.default_value = {}
field_descriptors.GetUnlockedProtomersReply_protomers.message_type = type_descriptors.ProtomerNO
field_descriptors.GetUnlockedProtomersReply_protomers.type = 11
field_descriptors.GetUnlockedProtomersReply_protomers.cpp_type = 10
type_descriptors.GetUnlockedProtomersReply.name = "GetUnlockedProtomersReply"
type_descriptors.GetUnlockedProtomersReply.full_name = ".GetUnlockedProtomersReply"
type_descriptors.GetUnlockedProtomersReply.nested_types = {}
type_descriptors.GetUnlockedProtomersReply.enum_types = {}
type_descriptors.GetUnlockedProtomersReply.fields = {
	field_descriptors.GetUnlockedProtomersReply_protomers
}
type_descriptors.GetUnlockedProtomersReply.is_extendable = false
type_descriptors.GetUnlockedProtomersReply.extensions = {}
field_descriptors.GetControlActionsReply_actions.name = "actions"
field_descriptors.GetControlActionsReply_actions.full_name = ".GetControlActionsReply.actions"
field_descriptors.GetControlActionsReply_actions.number = 1
field_descriptors.GetControlActionsReply_actions.index = 0
field_descriptors.GetControlActionsReply_actions.label = 3
field_descriptors.GetControlActionsReply_actions.has_default_value = false
field_descriptors.GetControlActionsReply_actions.default_value = {}
field_descriptors.GetControlActionsReply_actions.message_type = type_descriptors.ControlActionNO
field_descriptors.GetControlActionsReply_actions.type = 11
field_descriptors.GetControlActionsReply_actions.cpp_type = 10
field_descriptors.GetControlActionsReply_passTime.name = "passTime"
field_descriptors.GetControlActionsReply_passTime.full_name = ".GetControlActionsReply.passTime"
field_descriptors.GetControlActionsReply_passTime.number = 2
field_descriptors.GetControlActionsReply_passTime.index = 1
field_descriptors.GetControlActionsReply_passTime.label = 2
field_descriptors.GetControlActionsReply_passTime.has_default_value = false
field_descriptors.GetControlActionsReply_passTime.default_value = 0
field_descriptors.GetControlActionsReply_passTime.type = 5
field_descriptors.GetControlActionsReply_passTime.cpp_type = 1
type_descriptors.GetControlActionsReply.name = "GetControlActionsReply"
type_descriptors.GetControlActionsReply.full_name = ".GetControlActionsReply"
type_descriptors.GetControlActionsReply.nested_types = {}
type_descriptors.GetControlActionsReply.enum_types = {}
type_descriptors.GetControlActionsReply.fields = {
	field_descriptors.GetControlActionsReply_actions,
	field_descriptors.GetControlActionsReply_passTime
}
type_descriptors.GetControlActionsReply.is_extendable = false
type_descriptors.GetControlActionsReply.extensions = {}
field_descriptors.HoldProtomerReply_id.name = "id"
field_descriptors.HoldProtomerReply_id.full_name = ".HoldProtomerReply.id"
field_descriptors.HoldProtomerReply_id.number = 1
field_descriptors.HoldProtomerReply_id.index = 0
field_descriptors.HoldProtomerReply_id.label = 2
field_descriptors.HoldProtomerReply_id.has_default_value = false
field_descriptors.HoldProtomerReply_id.default_value = 0
field_descriptors.HoldProtomerReply_id.type = 5
field_descriptors.HoldProtomerReply_id.cpp_type = 1
type_descriptors.HoldProtomerReply.name = "HoldProtomerReply"
type_descriptors.HoldProtomerReply.full_name = ".HoldProtomerReply"
type_descriptors.HoldProtomerReply.nested_types = {}
type_descriptors.HoldProtomerReply.enum_types = {}
type_descriptors.HoldProtomerReply.fields = {
	field_descriptors.HoldProtomerReply_id
}
type_descriptors.HoldProtomerReply.is_extendable = false
type_descriptors.HoldProtomerReply.extensions = {}
field_descriptors.HoldProtomerRequest_id.name = "id"
field_descriptors.HoldProtomerRequest_id.full_name = ".HoldProtomerRequest.id"
field_descriptors.HoldProtomerRequest_id.number = 1
field_descriptors.HoldProtomerRequest_id.index = 0
field_descriptors.HoldProtomerRequest_id.label = 2
field_descriptors.HoldProtomerRequest_id.has_default_value = false
field_descriptors.HoldProtomerRequest_id.default_value = 0
field_descriptors.HoldProtomerRequest_id.type = 5
field_descriptors.HoldProtomerRequest_id.cpp_type = 1
type_descriptors.HoldProtomerRequest.name = "HoldProtomerRequest"
type_descriptors.HoldProtomerRequest.full_name = ".HoldProtomerRequest"
type_descriptors.HoldProtomerRequest.nested_types = {}
type_descriptors.HoldProtomerRequest.enum_types = {}
type_descriptors.HoldProtomerRequest.fields = {
	field_descriptors.HoldProtomerRequest_id
}
type_descriptors.HoldProtomerRequest.is_extendable = false
type_descriptors.HoldProtomerRequest.extensions = {}
type_descriptors.GetControlActionsRequest.name = "GetControlActionsRequest"
type_descriptors.GetControlActionsRequest.full_name = ".GetControlActionsRequest"
type_descriptors.GetControlActionsRequest.nested_types = {}
type_descriptors.GetControlActionsRequest.enum_types = {}
type_descriptors.GetControlActionsRequest.fields = {}
type_descriptors.GetControlActionsRequest.is_extendable = false
type_descriptors.GetControlActionsRequest.extensions = {}
field_descriptors.GetTaskRewardReply_id.name = "id"
field_descriptors.GetTaskRewardReply_id.full_name = ".GetTaskRewardReply.id"
field_descriptors.GetTaskRewardReply_id.number = 1
field_descriptors.GetTaskRewardReply_id.index = 0
field_descriptors.GetTaskRewardReply_id.label = 2
field_descriptors.GetTaskRewardReply_id.has_default_value = false
field_descriptors.GetTaskRewardReply_id.default_value = 0
field_descriptors.GetTaskRewardReply_id.type = 5
field_descriptors.GetTaskRewardReply_id.cpp_type = 1
type_descriptors.GetTaskRewardReply.name = "GetTaskRewardReply"
type_descriptors.GetTaskRewardReply.full_name = ".GetTaskRewardReply"
type_descriptors.GetTaskRewardReply.nested_types = {}
type_descriptors.GetTaskRewardReply.enum_types = {}
type_descriptors.GetTaskRewardReply.fields = {
	field_descriptors.GetTaskRewardReply_id
}
type_descriptors.GetTaskRewardReply.is_extendable = false
type_descriptors.GetTaskRewardReply.extensions = {}
field_descriptors.PostNO_id.name = "id"
field_descriptors.PostNO_id.full_name = ".PostNO.id"
field_descriptors.PostNO_id.number = 1
field_descriptors.PostNO_id.index = 0
field_descriptors.PostNO_id.label = 2
field_descriptors.PostNO_id.has_default_value = false
field_descriptors.PostNO_id.default_value = 0
field_descriptors.PostNO_id.type = 5
field_descriptors.PostNO_id.cpp_type = 1
field_descriptors.PostNO_contentCode.name = "contentCode"
field_descriptors.PostNO_contentCode.full_name = ".PostNO.contentCode"
field_descriptors.PostNO_contentCode.number = 2
field_descriptors.PostNO_contentCode.index = 1
field_descriptors.PostNO_contentCode.label = 2
field_descriptors.PostNO_contentCode.has_default_value = false
field_descriptors.PostNO_contentCode.default_value = 0
field_descriptors.PostNO_contentCode.type = 5
field_descriptors.PostNO_contentCode.cpp_type = 1
field_descriptors.PostNO_author.name = "author"
field_descriptors.PostNO_author.full_name = ".PostNO.author"
field_descriptors.PostNO_author.number = 3
field_descriptors.PostNO_author.index = 2
field_descriptors.PostNO_author.label = 2
field_descriptors.PostNO_author.has_default_value = false
field_descriptors.PostNO_author.default_value = 0
field_descriptors.PostNO_author.type = 5
field_descriptors.PostNO_author.cpp_type = 1
field_descriptors.PostNO_time.name = "time"
field_descriptors.PostNO_time.full_name = ".PostNO.time"
field_descriptors.PostNO_time.number = 4
field_descriptors.PostNO_time.index = 3
field_descriptors.PostNO_time.label = 2
field_descriptors.PostNO_time.has_default_value = false
field_descriptors.PostNO_time.default_value = 0
field_descriptors.PostNO_time.type = 3
field_descriptors.PostNO_time.cpp_type = 2
field_descriptors.PostNO_likesCount.name = "likesCount"
field_descriptors.PostNO_likesCount.full_name = ".PostNO.likesCount"
field_descriptors.PostNO_likesCount.number = 5
field_descriptors.PostNO_likesCount.index = 4
field_descriptors.PostNO_likesCount.label = 2
field_descriptors.PostNO_likesCount.has_default_value = false
field_descriptors.PostNO_likesCount.default_value = 0
field_descriptors.PostNO_likesCount.type = 5
field_descriptors.PostNO_likesCount.cpp_type = 1
field_descriptors.PostNO_isTop.name = "isTop"
field_descriptors.PostNO_isTop.full_name = ".PostNO.isTop"
field_descriptors.PostNO_isTop.number = 6
field_descriptors.PostNO_isTop.index = 5
field_descriptors.PostNO_isTop.label = 2
field_descriptors.PostNO_isTop.has_default_value = false
field_descriptors.PostNO_isTop.default_value = false
field_descriptors.PostNO_isTop.type = 8
field_descriptors.PostNO_isTop.cpp_type = 7
type_descriptors.PostNO.name = "PostNO"
type_descriptors.PostNO.full_name = ".PostNO"
type_descriptors.PostNO.nested_types = {}
type_descriptors.PostNO.enum_types = {}
type_descriptors.PostNO.fields = {
	field_descriptors.PostNO_id,
	field_descriptors.PostNO_contentCode,
	field_descriptors.PostNO_author,
	field_descriptors.PostNO_time,
	field_descriptors.PostNO_likesCount,
	field_descriptors.PostNO_isTop
}
type_descriptors.PostNO.is_extendable = false
type_descriptors.PostNO.extensions = {}
field_descriptors.LikePostReply_id.name = "id"
field_descriptors.LikePostReply_id.full_name = ".LikePostReply.id"
field_descriptors.LikePostReply_id.number = 1
field_descriptors.LikePostReply_id.index = 0
field_descriptors.LikePostReply_id.label = 2
field_descriptors.LikePostReply_id.has_default_value = false
field_descriptors.LikePostReply_id.default_value = 0
field_descriptors.LikePostReply_id.type = 5
field_descriptors.LikePostReply_id.cpp_type = 1
field_descriptors.LikePostReply_floor.name = "floor"
field_descriptors.LikePostReply_floor.full_name = ".LikePostReply.floor"
field_descriptors.LikePostReply_floor.number = 2
field_descriptors.LikePostReply_floor.index = 1
field_descriptors.LikePostReply_floor.label = 2
field_descriptors.LikePostReply_floor.has_default_value = false
field_descriptors.LikePostReply_floor.default_value = 0
field_descriptors.LikePostReply_floor.type = 5
field_descriptors.LikePostReply_floor.cpp_type = 1
type_descriptors.LikePostReply.name = "LikePostReply"
type_descriptors.LikePostReply.full_name = ".LikePostReply"
type_descriptors.LikePostReply.nested_types = {}
type_descriptors.LikePostReply.enum_types = {}
type_descriptors.LikePostReply.fields = {
	field_descriptors.LikePostReply_id,
	field_descriptors.LikePostReply_floor
}
type_descriptors.LikePostReply.is_extendable = false
type_descriptors.LikePostReply.extensions = {}
CancelLikePostReply = protobuf.Message(type_descriptors.CancelLikePostReply)
CancelLikePostRequest = protobuf.Message(type_descriptors.CancelLikePostRequest)
ControlActionNO = protobuf.Message(type_descriptors.ControlActionNO)
GetControlActionsReply = protobuf.Message(type_descriptors.GetControlActionsReply)
GetControlActionsRequest = protobuf.Message(type_descriptors.GetControlActionsRequest)
GetPostListReply = protobuf.Message(type_descriptors.GetPostListReply)
GetPostListRequest = protobuf.Message(type_descriptors.GetPostListRequest)
GetPostReply = protobuf.Message(type_descriptors.GetPostReply)
GetPostRequest = protobuf.Message(type_descriptors.GetPostRequest)
GetTaskRewardReply = protobuf.Message(type_descriptors.GetTaskRewardReply)
GetTaskRewardRequest = protobuf.Message(type_descriptors.GetTaskRewardRequest)
GetUnlockedProtomersReply = protobuf.Message(type_descriptors.GetUnlockedProtomersReply)
GetUnlockedProtomersRequest = protobuf.Message(type_descriptors.GetUnlockedProtomersRequest)
HoldProtomerReply = protobuf.Message(type_descriptors.HoldProtomerReply)
HoldProtomerRequest = protobuf.Message(type_descriptors.HoldProtomerRequest)
LikePostReply = protobuf.Message(type_descriptors.LikePostReply)
LikePostRequest = protobuf.Message(type_descriptors.LikePostRequest)
PostNO = protobuf.Message(type_descriptors.PostNO)
PostReplyNO = protobuf.Message(type_descriptors.PostReplyNO)
ProtomerNO = protobuf.Message(type_descriptors.ProtomerNO)

return _G["logic.proto.ControlActionExtension_pb"]

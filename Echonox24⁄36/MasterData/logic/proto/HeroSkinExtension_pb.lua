-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/proto/HeroSkinExtension_pb.lua

local protobuf = require("protobuf.protobuf")
local dependencies = {}

module("logic.proto.HeroSkinExtension_pb", package.seeall)

local enum_item_descriptors = {}
local field_descriptors = {}

type_descriptors = {}
type_descriptors.HeroSkinInfoRequest = protobuf.Descriptor()
field_descriptors.HeroSkinInfoRequest_heroId = protobuf.FieldDescriptor()
type_descriptors.HeroSkinInfoReply = protobuf.Descriptor()
field_descriptors.HeroSkinInfoReply_info = protobuf.FieldDescriptor()
type_descriptors.HeroSkinSetReply = protobuf.Descriptor()
field_descriptors.HeroSkinSetReply_info = protobuf.FieldDescriptor()
type_descriptors.GetAllHeroSkinInfoReply = protobuf.Descriptor()
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds = protobuf.FieldDescriptor()
type_descriptors.HeroSkinSetRequest = protobuf.Descriptor()
field_descriptors.HeroSkinSetRequest_skinId = protobuf.FieldDescriptor()
field_descriptors.HeroSkinSetRequest_heroId = protobuf.FieldDescriptor()
type_descriptors.GetAllHeroSkinInfoRequest = protobuf.Descriptor()
type_descriptors.HeroSkinInfo = protobuf.Descriptor()
field_descriptors.HeroSkinInfo_heroId = protobuf.FieldDescriptor()
field_descriptors.HeroSkinInfo_skinId = protobuf.FieldDescriptor()
field_descriptors.HeroSkinInfo_hasbuy = protobuf.FieldDescriptor()
field_descriptors.HeroSkinInfoRequest_heroId.name = "heroId"
field_descriptors.HeroSkinInfoRequest_heroId.full_name = ".HeroSkinInfoRequest.heroId"
field_descriptors.HeroSkinInfoRequest_heroId.number = 1
field_descriptors.HeroSkinInfoRequest_heroId.index = 0
field_descriptors.HeroSkinInfoRequest_heroId.label = 1
field_descriptors.HeroSkinInfoRequest_heroId.has_default_value = false
field_descriptors.HeroSkinInfoRequest_heroId.default_value = 0
field_descriptors.HeroSkinInfoRequest_heroId.type = 5
field_descriptors.HeroSkinInfoRequest_heroId.cpp_type = 1
type_descriptors.HeroSkinInfoRequest.name = "HeroSkinInfoRequest"
type_descriptors.HeroSkinInfoRequest.full_name = ".HeroSkinInfoRequest"
type_descriptors.HeroSkinInfoRequest.nested_types = {}
type_descriptors.HeroSkinInfoRequest.enum_types = {}
type_descriptors.HeroSkinInfoRequest.fields = {
	field_descriptors.HeroSkinInfoRequest_heroId
}
type_descriptors.HeroSkinInfoRequest.is_extendable = false
type_descriptors.HeroSkinInfoRequest.extensions = {}
field_descriptors.HeroSkinInfoReply_info.name = "info"
field_descriptors.HeroSkinInfoReply_info.full_name = ".HeroSkinInfoReply.info"
field_descriptors.HeroSkinInfoReply_info.number = 1
field_descriptors.HeroSkinInfoReply_info.index = 0
field_descriptors.HeroSkinInfoReply_info.label = 1
field_descriptors.HeroSkinInfoReply_info.has_default_value = false
field_descriptors.HeroSkinInfoReply_info.default_value = nil
field_descriptors.HeroSkinInfoReply_info.message_type = type_descriptors.HeroSkinInfo
field_descriptors.HeroSkinInfoReply_info.type = 11
field_descriptors.HeroSkinInfoReply_info.cpp_type = 10
type_descriptors.HeroSkinInfoReply.name = "HeroSkinInfoReply"
type_descriptors.HeroSkinInfoReply.full_name = ".HeroSkinInfoReply"
type_descriptors.HeroSkinInfoReply.nested_types = {}
type_descriptors.HeroSkinInfoReply.enum_types = {}
type_descriptors.HeroSkinInfoReply.fields = {
	field_descriptors.HeroSkinInfoReply_info
}
type_descriptors.HeroSkinInfoReply.is_extendable = false
type_descriptors.HeroSkinInfoReply.extensions = {}
field_descriptors.HeroSkinSetReply_info.name = "info"
field_descriptors.HeroSkinSetReply_info.full_name = ".HeroSkinSetReply.info"
field_descriptors.HeroSkinSetReply_info.number = 1
field_descriptors.HeroSkinSetReply_info.index = 0
field_descriptors.HeroSkinSetReply_info.label = 1
field_descriptors.HeroSkinSetReply_info.has_default_value = false
field_descriptors.HeroSkinSetReply_info.default_value = nil
field_descriptors.HeroSkinSetReply_info.message_type = type_descriptors.HeroSkinInfo
field_descriptors.HeroSkinSetReply_info.type = 11
field_descriptors.HeroSkinSetReply_info.cpp_type = 10
type_descriptors.HeroSkinSetReply.name = "HeroSkinSetReply"
type_descriptors.HeroSkinSetReply.full_name = ".HeroSkinSetReply"
type_descriptors.HeroSkinSetReply.nested_types = {}
type_descriptors.HeroSkinSetReply.enum_types = {}
type_descriptors.HeroSkinSetReply.fields = {
	field_descriptors.HeroSkinSetReply_info
}
type_descriptors.HeroSkinSetReply.is_extendable = false
type_descriptors.HeroSkinSetReply.extensions = {}
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.name = "ownedSkinIds"
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.full_name = ".GetAllHeroSkinInfoReply.ownedSkinIds"
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.number = 1
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.index = 0
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.label = 3
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.has_default_value = false
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.default_value = {}
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.type = 5
field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds.cpp_type = 1
type_descriptors.GetAllHeroSkinInfoReply.name = "GetAllHeroSkinInfoReply"
type_descriptors.GetAllHeroSkinInfoReply.full_name = ".GetAllHeroSkinInfoReply"
type_descriptors.GetAllHeroSkinInfoReply.nested_types = {}
type_descriptors.GetAllHeroSkinInfoReply.enum_types = {}
type_descriptors.GetAllHeroSkinInfoReply.fields = {
	field_descriptors.GetAllHeroSkinInfoReply_ownedSkinIds
}
type_descriptors.GetAllHeroSkinInfoReply.is_extendable = false
type_descriptors.GetAllHeroSkinInfoReply.extensions = {}
field_descriptors.HeroSkinSetRequest_skinId.name = "skinId"
field_descriptors.HeroSkinSetRequest_skinId.full_name = ".HeroSkinSetRequest.skinId"
field_descriptors.HeroSkinSetRequest_skinId.number = 1
field_descriptors.HeroSkinSetRequest_skinId.index = 0
field_descriptors.HeroSkinSetRequest_skinId.label = 1
field_descriptors.HeroSkinSetRequest_skinId.has_default_value = false
field_descriptors.HeroSkinSetRequest_skinId.default_value = 0
field_descriptors.HeroSkinSetRequest_skinId.type = 5
field_descriptors.HeroSkinSetRequest_skinId.cpp_type = 1
field_descriptors.HeroSkinSetRequest_heroId.name = "heroId"
field_descriptors.HeroSkinSetRequest_heroId.full_name = ".HeroSkinSetRequest.heroId"
field_descriptors.HeroSkinSetRequest_heroId.number = 2
field_descriptors.HeroSkinSetRequest_heroId.index = 1
field_descriptors.HeroSkinSetRequest_heroId.label = 1
field_descriptors.HeroSkinSetRequest_heroId.has_default_value = false
field_descriptors.HeroSkinSetRequest_heroId.default_value = 0
field_descriptors.HeroSkinSetRequest_heroId.type = 5
field_descriptors.HeroSkinSetRequest_heroId.cpp_type = 1
type_descriptors.HeroSkinSetRequest.name = "HeroSkinSetRequest"
type_descriptors.HeroSkinSetRequest.full_name = ".HeroSkinSetRequest"
type_descriptors.HeroSkinSetRequest.nested_types = {}
type_descriptors.HeroSkinSetRequest.enum_types = {}
type_descriptors.HeroSkinSetRequest.fields = {
	field_descriptors.HeroSkinSetRequest_skinId,
	field_descriptors.HeroSkinSetRequest_heroId
}
type_descriptors.HeroSkinSetRequest.is_extendable = false
type_descriptors.HeroSkinSetRequest.extensions = {}
type_descriptors.GetAllHeroSkinInfoRequest.name = "GetAllHeroSkinInfoRequest"
type_descriptors.GetAllHeroSkinInfoRequest.full_name = ".GetAllHeroSkinInfoRequest"
type_descriptors.GetAllHeroSkinInfoRequest.nested_types = {}
type_descriptors.GetAllHeroSkinInfoRequest.enum_types = {}
type_descriptors.GetAllHeroSkinInfoRequest.fields = {}
type_descriptors.GetAllHeroSkinInfoRequest.is_extendable = false
type_descriptors.GetAllHeroSkinInfoRequest.extensions = {}
field_descriptors.HeroSkinInfo_heroId.name = "heroId"
field_descriptors.HeroSkinInfo_heroId.full_name = ".HeroSkinInfo.heroId"
field_descriptors.HeroSkinInfo_heroId.number = 1
field_descriptors.HeroSkinInfo_heroId.index = 0
field_descriptors.HeroSkinInfo_heroId.label = 1
field_descriptors.HeroSkinInfo_heroId.has_default_value = false
field_descriptors.HeroSkinInfo_heroId.default_value = 0
field_descriptors.HeroSkinInfo_heroId.type = 5
field_descriptors.HeroSkinInfo_heroId.cpp_type = 1
field_descriptors.HeroSkinInfo_skinId.name = "skinId"
field_descriptors.HeroSkinInfo_skinId.full_name = ".HeroSkinInfo.skinId"
field_descriptors.HeroSkinInfo_skinId.number = 2
field_descriptors.HeroSkinInfo_skinId.index = 1
field_descriptors.HeroSkinInfo_skinId.label = 1
field_descriptors.HeroSkinInfo_skinId.has_default_value = false
field_descriptors.HeroSkinInfo_skinId.default_value = 0
field_descriptors.HeroSkinInfo_skinId.type = 5
field_descriptors.HeroSkinInfo_skinId.cpp_type = 1
field_descriptors.HeroSkinInfo_hasbuy.name = "hasbuy"
field_descriptors.HeroSkinInfo_hasbuy.full_name = ".HeroSkinInfo.hasbuy"
field_descriptors.HeroSkinInfo_hasbuy.number = 3
field_descriptors.HeroSkinInfo_hasbuy.index = 2
field_descriptors.HeroSkinInfo_hasbuy.label = 3
field_descriptors.HeroSkinInfo_hasbuy.has_default_value = false
field_descriptors.HeroSkinInfo_hasbuy.default_value = {}
field_descriptors.HeroSkinInfo_hasbuy.type = 5
field_descriptors.HeroSkinInfo_hasbuy.cpp_type = 1
type_descriptors.HeroSkinInfo.name = "HeroSkinInfo"
type_descriptors.HeroSkinInfo.full_name = ".HeroSkinInfo"
type_descriptors.HeroSkinInfo.nested_types = {}
type_descriptors.HeroSkinInfo.enum_types = {}
type_descriptors.HeroSkinInfo.fields = {
	field_descriptors.HeroSkinInfo_heroId,
	field_descriptors.HeroSkinInfo_skinId,
	field_descriptors.HeroSkinInfo_hasbuy
}
type_descriptors.HeroSkinInfo.is_extendable = false
type_descriptors.HeroSkinInfo.extensions = {}
GetAllHeroSkinInfoReply = protobuf.Message(type_descriptors.GetAllHeroSkinInfoReply)
GetAllHeroSkinInfoRequest = protobuf.Message(type_descriptors.GetAllHeroSkinInfoRequest)
HeroSkinInfo = protobuf.Message(type_descriptors.HeroSkinInfo)
HeroSkinInfoReply = protobuf.Message(type_descriptors.HeroSkinInfoReply)
HeroSkinInfoRequest = protobuf.Message(type_descriptors.HeroSkinInfoRequest)
HeroSkinSetReply = protobuf.Message(type_descriptors.HeroSkinSetReply)
HeroSkinSetRequest = protobuf.Message(type_descriptors.HeroSkinSetRequest)

return _G["logic.proto.HeroSkinExtension_pb"]

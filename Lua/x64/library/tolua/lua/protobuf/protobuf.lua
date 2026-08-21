local var_0_0 = setmetatable
local var_0_1 = rawset
local var_0_2 = rawget
local var_0_3 = error
local var_0_4 = ipairs
local var_0_5 = pairs
local var_0_6 = print
local var_0_7 = table
local var_0_8 = string
local var_0_9 = tostring
local var_0_10 = type
local var_0_11 = require("pb")
local var_0_12 = require("wire_format")
local var_0_13 = require("type_checkers")
local var_0_14 = require("encoder")
local var_0_15 = require("decoder")
local var_0_16 = require("listener")
local var_0_17 = require("containers")
local var_0_18 = require("descriptor").FieldDescriptor
local var_0_19 = require("text_format")

module("protobuf")

local function var_0_20(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		__newindex = function(arg_2_0, arg_2_1, arg_2_2)
			if arg_1_2[arg_2_1] then
				var_0_1(arg_2_0, arg_2_1, arg_2_2)
			else
				var_0_3("error key: " .. arg_2_1)
			end
		end
	}

	var_1_0.__index = var_1_0

	function var_1_0.__call()
		return var_0_0({}, var_1_0)
	end

	_M[arg_1_0] = var_0_0(arg_1_1, var_1_0)
end

var_0_20("Descriptor", {}, {
	full_name = true,
	name = true,
	containing_type = true,
	is_extendable = true,
	extensions = true,
	fields = true,
	extension_ranges = true,
	nested_types = true,
	options = true,
	enum_types = true,
	filename = true
})
var_0_20("FieldDescriptor", var_0_18, {
	full_name = true,
	name = true,
	containing_type = true,
	type = true,
	index = true,
	label = true,
	default_value = true,
	number = true,
	extension_scope = true,
	is_extension = true,
	enum_type = true,
	has_default_value = true,
	message_type = true,
	cpp_type = true
})
var_0_20("EnumDescriptor", {}, {
	full_name = true,
	values = true,
	containing_type = true,
	name = true,
	options = true
})
var_0_20("EnumValueDescriptor", {}, {
	options = true,
	name = true,
	type = true,
	index = true,
	number = true
})

local var_0_21 = {
	[var_0_18.TYPE_DOUBLE] = var_0_12.WIRETYPE_FIXED64,
	[var_0_18.TYPE_FLOAT] = var_0_12.WIRETYPE_FIXED32,
	[var_0_18.TYPE_INT64] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_UINT64] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_INT32] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_FIXED64] = var_0_12.WIRETYPE_FIXED64,
	[var_0_18.TYPE_FIXED32] = var_0_12.WIRETYPE_FIXED32,
	[var_0_18.TYPE_BOOL] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_STRING] = var_0_12.WIRETYPE_LENGTH_DELIMITED,
	[var_0_18.TYPE_GROUP] = var_0_12.WIRETYPE_START_GROUP,
	[var_0_18.TYPE_MESSAGE] = var_0_12.WIRETYPE_LENGTH_DELIMITED,
	[var_0_18.TYPE_BYTES] = var_0_12.WIRETYPE_LENGTH_DELIMITED,
	[var_0_18.TYPE_UINT32] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_ENUM] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_SFIXED32] = var_0_12.WIRETYPE_FIXED32,
	[var_0_18.TYPE_SFIXED64] = var_0_12.WIRETYPE_FIXED64,
	[var_0_18.TYPE_SINT32] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_SINT64] = var_0_12.WIRETYPE_VARINT
}
local var_0_22 = {
	[var_0_18.TYPE_STRING] = true,
	[var_0_18.TYPE_GROUP] = true,
	[var_0_18.TYPE_MESSAGE] = true,
	[var_0_18.TYPE_BYTES] = true
}
local var_0_23 = {
	[var_0_18.CPPTYPE_INT32] = var_0_13.Int32ValueChecker(),
	[var_0_18.CPPTYPE_INT64] = var_0_13.TypeChecker({
		string = true,
		number = true
	}),
	[var_0_18.CPPTYPE_UINT32] = var_0_13.Uint32ValueChecker(),
	[var_0_18.CPPTYPE_UINT64] = var_0_13.TypeChecker({
		string = true,
		number = true
	}),
	[var_0_18.CPPTYPE_DOUBLE] = var_0_13.TypeChecker({
		number = true
	}),
	[var_0_18.CPPTYPE_FLOAT] = var_0_13.TypeChecker({
		number = true
	}),
	[var_0_18.CPPTYPE_BOOL] = var_0_13.TypeChecker({
		boolean = true,
		int = true,
		bool = true
	}),
	[var_0_18.CPPTYPE_ENUM] = var_0_13.Int32ValueChecker(),
	[var_0_18.CPPTYPE_STRING] = var_0_13.TypeChecker({
		string = true
	})
}
local var_0_24 = {
	[var_0_18.TYPE_DOUBLE] = var_0_12.DoubleByteSize,
	[var_0_18.TYPE_FLOAT] = var_0_12.FloatByteSize,
	[var_0_18.TYPE_INT64] = var_0_12.Int64ByteSize,
	[var_0_18.TYPE_UINT64] = var_0_12.UInt64ByteSize,
	[var_0_18.TYPE_INT32] = var_0_12.Int32ByteSize,
	[var_0_18.TYPE_FIXED64] = var_0_12.Fixed64ByteSize,
	[var_0_18.TYPE_FIXED32] = var_0_12.Fixed32ByteSize,
	[var_0_18.TYPE_BOOL] = var_0_12.BoolByteSize,
	[var_0_18.TYPE_STRING] = var_0_12.StringByteSize,
	[var_0_18.TYPE_GROUP] = var_0_12.GroupByteSize,
	[var_0_18.TYPE_MESSAGE] = var_0_12.MessageByteSize,
	[var_0_18.TYPE_BYTES] = var_0_12.BytesByteSize,
	[var_0_18.TYPE_UINT32] = var_0_12.UInt32ByteSize,
	[var_0_18.TYPE_ENUM] = var_0_12.EnumByteSize,
	[var_0_18.TYPE_SFIXED32] = var_0_12.SFixed32ByteSize,
	[var_0_18.TYPE_SFIXED64] = var_0_12.SFixed64ByteSize,
	[var_0_18.TYPE_SINT32] = var_0_12.SInt32ByteSize,
	[var_0_18.TYPE_SINT64] = var_0_12.SInt64ByteSize
}
local var_0_25 = {
	[var_0_18.TYPE_DOUBLE] = var_0_14.DoubleEncoder,
	[var_0_18.TYPE_FLOAT] = var_0_14.FloatEncoder,
	[var_0_18.TYPE_INT64] = var_0_14.Int64Encoder,
	[var_0_18.TYPE_UINT64] = var_0_14.UInt64Encoder,
	[var_0_18.TYPE_INT32] = var_0_14.Int32Encoder,
	[var_0_18.TYPE_FIXED64] = var_0_14.Fixed64Encoder,
	[var_0_18.TYPE_FIXED32] = var_0_14.Fixed32Encoder,
	[var_0_18.TYPE_BOOL] = var_0_14.BoolEncoder,
	[var_0_18.TYPE_STRING] = var_0_14.StringEncoder,
	[var_0_18.TYPE_GROUP] = var_0_14.GroupEncoder,
	[var_0_18.TYPE_MESSAGE] = var_0_14.MessageEncoder,
	[var_0_18.TYPE_BYTES] = var_0_14.BytesEncoder,
	[var_0_18.TYPE_UINT32] = var_0_14.UInt32Encoder,
	[var_0_18.TYPE_ENUM] = var_0_14.EnumEncoder,
	[var_0_18.TYPE_SFIXED32] = var_0_14.SFixed32Encoder,
	[var_0_18.TYPE_SFIXED64] = var_0_14.SFixed64Encoder,
	[var_0_18.TYPE_SINT32] = var_0_14.SInt32Encoder,
	[var_0_18.TYPE_SINT64] = var_0_14.SInt64Encoder
}
local var_0_26 = {
	[var_0_18.TYPE_DOUBLE] = var_0_14.DoubleSizer,
	[var_0_18.TYPE_FLOAT] = var_0_14.FloatSizer,
	[var_0_18.TYPE_INT64] = var_0_14.Int64Sizer,
	[var_0_18.TYPE_UINT64] = var_0_14.UInt64Sizer,
	[var_0_18.TYPE_INT32] = var_0_14.Int32Sizer,
	[var_0_18.TYPE_FIXED64] = var_0_14.Fixed64Sizer,
	[var_0_18.TYPE_FIXED32] = var_0_14.Fixed32Sizer,
	[var_0_18.TYPE_BOOL] = var_0_14.BoolSizer,
	[var_0_18.TYPE_STRING] = var_0_14.StringSizer,
	[var_0_18.TYPE_GROUP] = var_0_14.GroupSizer,
	[var_0_18.TYPE_MESSAGE] = var_0_14.MessageSizer,
	[var_0_18.TYPE_BYTES] = var_0_14.BytesSizer,
	[var_0_18.TYPE_UINT32] = var_0_14.UInt32Sizer,
	[var_0_18.TYPE_ENUM] = var_0_14.EnumSizer,
	[var_0_18.TYPE_SFIXED32] = var_0_14.SFixed32Sizer,
	[var_0_18.TYPE_SFIXED64] = var_0_14.SFixed64Sizer,
	[var_0_18.TYPE_SINT32] = var_0_14.SInt32Sizer,
	[var_0_18.TYPE_SINT64] = var_0_14.SInt64Sizer
}
local var_0_27 = {
	[var_0_18.TYPE_DOUBLE] = var_0_15.DoubleDecoder,
	[var_0_18.TYPE_FLOAT] = var_0_15.FloatDecoder,
	[var_0_18.TYPE_INT64] = var_0_15.Int64Decoder,
	[var_0_18.TYPE_UINT64] = var_0_15.UInt64Decoder,
	[var_0_18.TYPE_INT32] = var_0_15.Int32Decoder,
	[var_0_18.TYPE_FIXED64] = var_0_15.Fixed64Decoder,
	[var_0_18.TYPE_FIXED32] = var_0_15.Fixed32Decoder,
	[var_0_18.TYPE_BOOL] = var_0_15.BoolDecoder,
	[var_0_18.TYPE_STRING] = var_0_15.StringDecoder,
	[var_0_18.TYPE_GROUP] = var_0_15.GroupDecoder,
	[var_0_18.TYPE_MESSAGE] = var_0_15.MessageDecoder,
	[var_0_18.TYPE_BYTES] = var_0_15.BytesDecoder,
	[var_0_18.TYPE_UINT32] = var_0_15.UInt32Decoder,
	[var_0_18.TYPE_ENUM] = var_0_15.EnumDecoder,
	[var_0_18.TYPE_SFIXED32] = var_0_15.SFixed32Decoder,
	[var_0_18.TYPE_SFIXED64] = var_0_15.SFixed64Decoder,
	[var_0_18.TYPE_SINT32] = var_0_15.SInt32Decoder,
	[var_0_18.TYPE_SINT64] = var_0_15.SInt64Decoder
}
local var_0_28 = {
	[var_0_18.TYPE_DOUBLE] = var_0_12.WIRETYPE_FIXED64,
	[var_0_18.TYPE_FLOAT] = var_0_12.WIRETYPE_FIXED32,
	[var_0_18.TYPE_INT64] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_UINT64] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_INT32] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_FIXED64] = var_0_12.WIRETYPE_FIXED64,
	[var_0_18.TYPE_FIXED32] = var_0_12.WIRETYPE_FIXED32,
	[var_0_18.TYPE_BOOL] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_STRING] = var_0_12.WIRETYPE_LENGTH_DELIMITED,
	[var_0_18.TYPE_GROUP] = var_0_12.WIRETYPE_START_GROUP,
	[var_0_18.TYPE_MESSAGE] = var_0_12.WIRETYPE_LENGTH_DELIMITED,
	[var_0_18.TYPE_BYTES] = var_0_12.WIRETYPE_LENGTH_DELIMITED,
	[var_0_18.TYPE_UINT32] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_ENUM] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_SFIXED32] = var_0_12.WIRETYPE_FIXED32,
	[var_0_18.TYPE_SFIXED64] = var_0_12.WIRETYPE_FIXED64,
	[var_0_18.TYPE_SINT32] = var_0_12.WIRETYPE_VARINT,
	[var_0_18.TYPE_SINT64] = var_0_12.WIRETYPE_VARINT
}

local function var_0_29(arg_4_0)
	return var_0_22[arg_4_0] == nil
end

local function var_0_30(arg_5_0, arg_5_1)
	if arg_5_0 == var_0_18.CPPTYPE_STRING and arg_5_1 == var_0_18.TYPE_STRING then
		return var_0_13.UnicodeValueChecker()
	end

	return var_0_23[arg_5_0]
end

local function var_0_31(arg_6_0)
	if arg_6_0.label == var_0_18.LABEL_REPEATED then
		if var_0_10(arg_6_0.default_value) ~= "table" or #arg_6_0.default_value ~= 0 then
			var_0_3("Repeated field default value not empty list:" .. var_0_9(arg_6_0.default_value))
		end

		if arg_6_0.cpp_type == var_0_18.CPPTYPE_MESSAGE then
			local var_6_0 = arg_6_0.message_type

			return function(arg_7_0)
				return var_0_17.RepeatedCompositeFieldContainer(arg_7_0._listener_for_children, var_6_0)
			end
		else
			local var_6_1 = var_0_30(arg_6_0.cpp_type, arg_6_0.type)

			return function(arg_8_0)
				return var_0_17.RepeatedScalarFieldContainer(arg_8_0._listener_for_children, var_6_1)
			end
		end
	end

	if arg_6_0.cpp_type == var_0_18.CPPTYPE_MESSAGE then
		local var_6_2 = arg_6_0.message_type

		return function(arg_9_0)
			result = var_6_2._concrete_class()

			result._SetListener(arg_9_0._listener_for_children)

			return result
		end
	end

	return function(arg_10_0)
		return arg_6_0.default_value
	end
end

local function var_0_32(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.label == var_0_18.LABEL_REPEATED
	local var_11_1 = arg_11_1.has_options and arg_11_1.GetOptions().packed

	var_0_1(arg_11_1, "_encoder", var_0_25[arg_11_1.type](arg_11_1.number, var_11_0, var_11_1))
	var_0_1(arg_11_1, "_sizer", var_0_26[arg_11_1.type](arg_11_1.number, var_11_0, var_11_1))
	var_0_1(arg_11_1, "_default_constructor", var_0_31(arg_11_1))

	local function var_11_2(arg_12_0, arg_12_1)
		local var_12_0 = var_0_14.TagBytes(arg_11_1.number, arg_12_0)

		arg_11_0._decoders_by_tag[var_12_0] = var_0_27[arg_11_1.type](arg_11_1.number, var_11_0, arg_12_1, arg_11_1, arg_11_1._default_constructor)
	end

	var_11_2(var_0_28[arg_11_1.type], False)

	if var_11_0 and var_0_29(arg_11_1.type) then
		var_11_2(var_0_12.WIRETYPE_LENGTH_DELIMITED, True)
	end
end

local function var_0_33(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in var_0_4(arg_13_0.enum_types) do
		for iter_13_2, iter_13_3 in var_0_4(iter_13_1.values) do
			arg_13_1._member[iter_13_3.name] = iter_13_3.number
		end
	end
end

local function var_0_34(arg_14_0)
	return function()
		local var_15_0 = {}

		var_15_0._cached_byte_size = 0
		var_15_0._cached_byte_size_dirty = false
		var_15_0._fields = {}
		var_15_0._is_present_in_parent = false
		var_15_0._listener = var_0_16.NullMessageListener()
		var_15_0._listener_for_children = var_0_16.Listener(var_15_0)

		return var_0_0(var_15_0, arg_14_0)
	end
end

local function var_0_35(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.name

	arg_16_1._getter[var_16_0] = function(arg_17_0)
		local var_17_0 = arg_17_0._fields[arg_16_0]

		if var_17_0 == nil then
			var_17_0 = arg_16_0._default_constructor(arg_17_0)
			arg_17_0._fields[arg_16_0] = var_17_0

			if not arg_17_0._cached_byte_size_dirty then
				arg_16_1._member._Modified(arg_17_0)
			end
		end

		return var_17_0
	end
	arg_16_1._setter[var_16_0] = function(arg_18_0)
		var_0_3("Assignment not allowed to repeated field \"" .. var_16_0 .. "\" in protocol message object.")
	end
end

local function var_0_36(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.name
	local var_19_1 = arg_19_0.message_type

	arg_19_1._getter[var_19_0] = function(arg_20_0)
		local var_20_0 = arg_20_0._fields[arg_19_0]

		if var_20_0 == nil then
			var_20_0 = var_19_1._concrete_class()

			var_20_0:_SetListener(arg_20_0._listener_for_children)

			arg_20_0._fields[arg_19_0] = var_20_0

			if not arg_20_0._cached_byte_size_dirty then
				arg_19_1._member._Modified(arg_20_0)
			end
		end

		return var_20_0
	end
	arg_19_1._setter[var_19_0] = function(arg_21_0, arg_21_1)
		var_0_3("Assignment not allowed to composite field" .. var_19_0 .. "in protocol message object.")
	end
end

local function var_0_37(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.name
	local var_22_1 = var_0_30(arg_22_0.cpp_type, arg_22_0.type)
	local var_22_2 = arg_22_0.default_value

	arg_22_1._getter[var_22_0] = function(arg_23_0)
		if arg_23_0._fields[arg_22_0] ~= nil then
			return arg_23_0._fields[arg_22_0]
		else
			return var_22_2
		end
	end
	arg_22_1._setter[var_22_0] = function(arg_24_0, arg_24_1)
		var_22_1(arg_24_1)

		arg_24_0._fields[arg_22_0] = arg_24_1

		if not arg_24_0._cached_byte_size_dirty then
			arg_22_1._member._Modified(arg_24_0)
		end
	end
end

local function var_0_38(arg_25_0, arg_25_1)
	constant_name = arg_25_0.name:upper() .. "_FIELD_NUMBER"
	arg_25_1._member[constant_name] = arg_25_0.number

	if arg_25_0.label == var_0_18.LABEL_REPEATED then
		var_0_35(arg_25_0, arg_25_1)
	elseif arg_25_0.cpp_type == var_0_18.CPPTYPE_MESSAGE then
		var_0_36(arg_25_0, arg_25_1)
	else
		var_0_37(arg_25_0, arg_25_1)
	end
end

local var_0_39 = {
	__index = function(arg_26_0, arg_26_1)
		local var_26_0 = var_0_2(arg_26_0, "_extended_message")
		local var_26_1 = var_26_0._fields[arg_26_1]

		if var_26_1 ~= nil then
			return var_26_1
		end

		if arg_26_1.label == var_0_18.LABEL_REPEATED then
			var_26_1 = arg_26_1._default_constructor(arg_26_0._extended_message)
		elseif arg_26_1.cpp_type == var_0_18.CPPTYPE_MESSAGE then
			var_26_1 = arg_26_1.message_type._concrete_class()

			var_26_1:_SetListener(var_26_0._listener_for_children)
		else
			return arg_26_1.default_value
		end

		var_26_0._fields[arg_26_1] = var_26_1

		return var_26_1
	end,
	__newindex = function(arg_27_0, arg_27_1, arg_27_2)
		local var_27_0 = var_0_2(arg_27_0, "_extended_message")

		if arg_27_1.label == var_0_18.LABEL_REPEATED or arg_27_1.cpp_type == var_0_18.CPPTYPE_MESSAGE then
			var_0_3("Cannot assign to extension \"" .. arg_27_1.full_name .. "\" because it is a repeated or composite type.")
		end

		var_0_30(arg_27_1.cpp_type, arg_27_1.type).CheckValue(arg_27_2)

		var_27_0._fields[arg_27_1] = arg_27_2

		var_27_0._Modified()
	end
}

local function var_0_40(arg_28_0)
	local var_28_0 = {
		_extended_message = arg_28_0
	}

	return var_0_0(var_28_0, var_0_39)
end

local function var_0_41(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in var_0_4(arg_29_0.fields) do
		var_0_38(iter_29_1, arg_29_1)
	end

	if arg_29_0.is_extendable then
		function arg_29_1._getter.Extensions(arg_30_0)
			return var_0_40(arg_30_0)
		end
	end
end

local function var_0_42(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0._extensions_by_name

	for iter_31_0, iter_31_1 in var_0_5(var_31_0) do
		local var_31_1 = var_0_8.upper(iter_31_0) .. "_FIELD_NUMBER"

		arg_31_1._member[var_31_1] = iter_31_1.number
	end
end

local function var_0_43(arg_32_0)
	function arg_32_0._member.RegisterExtension(arg_33_0)
		arg_33_0.containing_type = arg_32_0._descriptor

		var_0_32(arg_32_0, arg_33_0)

		if arg_32_0._extensions_by_number[arg_33_0.number] == nil then
			arg_32_0._extensions_by_number[arg_33_0.number] = arg_33_0
		else
			var_0_3(var_0_8.format("Extensions \"%s\" and \"%s\" both try to extend message type \"%s\" with field number %d.", arg_33_0.full_name, actual_handle.full_name, arg_32_0._descriptor.full_name, arg_33_0.number))
		end

		arg_32_0._extensions_by_name[arg_33_0.full_name] = arg_33_0
	end

	function arg_32_0._member.FromString(arg_34_0)
		local var_34_0 = arg_32_0._member.__call()

		var_34_0.MergeFromString(arg_34_0)

		return var_34_0
	end
end

local function var_0_44(arg_35_0, arg_35_1)
	if arg_35_0.label == var_0_18.LABEL_REPEATED then
		return arg_35_1
	elseif arg_35_0.cpp_type == var_0_18.CPPTYPE_MESSAGE then
		return arg_35_1._is_present_in_parent
	else
		return true
	end
end

function sortFunc(arg_36_0, arg_36_1)
	return arg_36_0.index < arg_36_1.index
end

function pairsByKeys(arg_37_0, arg_37_1)
	local var_37_0 = {}

	for iter_37_0 in var_0_5(arg_37_0) do
		var_0_7.insert(var_37_0, iter_37_0)
	end

	var_0_7.sort(var_37_0, arg_37_1)

	local var_37_1 = 0

	return function()
		var_37_1 = var_37_1 + 1

		if var_37_0[var_37_1] == nil then
			return nil
		else
			return var_37_0[var_37_1], arg_37_0[var_37_0[var_37_1]]
		end
	end
end

local function var_0_45(arg_39_0, arg_39_1)
	function arg_39_1._member.ListFields(arg_40_0)
		return (function(arg_41_0)
			local var_41_0, var_41_1, var_41_2 = pairsByKeys(arg_40_0._fields, sortFunc)

			return function(arg_42_0, arg_42_1)
				while true do
					local var_42_0, var_42_1 = var_41_0(arg_42_0, arg_42_1)

					if var_42_0 == nil then
						return
					elseif var_0_44(var_42_0, var_42_1) then
						return var_42_0, var_42_1
					end
				end
			end, var_41_1, var_41_2
		end)(arg_40_0._fields)
	end
end

local function var_0_46(arg_43_0, arg_43_1)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in var_0_4(arg_43_0.fields) do
		if iter_43_1.label ~= var_0_18.LABEL_REPEATED then
			var_43_0[iter_43_1.name] = iter_43_1
		end
	end

	function arg_43_1._member.HasField(arg_44_0, arg_44_1)
		field = var_43_0[arg_44_1]

		if field == nil then
			var_0_3("Protocol message has no singular \"" .. arg_44_1 .. "\" field.")
		end

		if field.cpp_type == var_0_18.CPPTYPE_MESSAGE then
			value = arg_44_0._fields[field]

			return value ~= nil and value._is_present_in_parent
		else
			return arg_44_0._fields[field] ~= nil
		end
	end
end

local function var_0_47(arg_45_0, arg_45_1)
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in var_0_4(arg_45_0.fields) do
		if iter_45_1.label ~= var_0_18.LABEL_REPEATED then
			var_45_0[iter_45_1.name] = iter_45_1
		end
	end

	function arg_45_1._member.ClearField(arg_46_0, arg_46_1)
		field = var_45_0[arg_46_1]

		if field == nil then
			var_0_3("Protocol message has no singular \"" .. arg_46_1 .. "\" field.")
		end

		if arg_46_0._fields[field] then
			arg_46_0._fields[field] = nil
		end

		arg_45_1._member._Modified(arg_46_0)
	end
end

local function var_0_48(arg_47_0)
	function arg_47_0._member.ClearExtension(arg_48_0, arg_48_1)
		if arg_48_0._fields[arg_48_1] == nil then
			arg_48_0._fields[arg_48_1] = nil
		end

		arg_47_0._member._Modified(arg_48_0)
	end
end

local function var_0_49(arg_49_0, arg_49_1)
	function arg_49_1._member.Clear(arg_50_0)
		arg_50_0._fields = {}

		arg_49_1._member._Modified(arg_50_0)
	end
end

local function var_0_50(arg_51_0)
	local var_51_0 = var_0_19.msg_format

	function arg_51_0.__tostring(arg_52_0)
		return var_51_0(arg_52_0)
	end
end

local function var_0_51(arg_53_0)
	function arg_53_0._member.HasExtension(arg_54_0, arg_54_1)
		if arg_54_1.label == var_0_18.LABEL_REPEATED then
			var_0_3(arg_54_1.full_name .. " is repeated.")
		end

		if arg_54_1.cpp_type == var_0_18.CPPTYPE_MESSAGE then
			value = arg_54_0._fields[arg_54_1]

			return value ~= nil and value._is_present_in_parent
		else
			return arg_54_0._fields[arg_54_1]
		end
	end
end

local function var_0_52(arg_55_0)
	function arg_55_0._member._SetListener(arg_56_0, arg_56_1)
		if arg_56_1 ~= nil then
			arg_56_0._listener = var_0_16.NullMessageListener()
		else
			arg_56_0._listener = arg_56_1
		end
	end
end

local function var_0_53(arg_57_0, arg_57_1)
	function arg_57_1._member.ByteSize(arg_58_0)
		if not arg_58_0._cached_byte_size_dirty and arg_58_0._cached_byte_size > 0 then
			return arg_58_0._cached_byte_size
		end

		local var_58_0 = 0

		for iter_58_0, iter_58_1 in arg_57_1._member.ListFields(arg_58_0) do
			var_58_0 = iter_58_0._sizer(iter_58_1) + var_58_0
		end

		arg_58_0._cached_byte_size = var_58_0
		arg_58_0._cached_byte_size_dirty = false
		arg_58_0._listener_for_children.dirty = false

		return var_58_0
	end
end

local function var_0_54(arg_59_0, arg_59_1)
	function arg_59_1._member.SerializeToString(arg_60_0)
		if not arg_59_1._member.IsInitialized(arg_60_0) then
			var_0_3("Message is missing required fields: " .. var_0_7.concat(arg_59_1._member.FindInitializationErrors(arg_60_0), ","))
		end

		return arg_59_1._member.SerializePartialToString(arg_60_0)
	end

	function arg_59_1._member.SerializeToIOString(arg_61_0, arg_61_1)
		if not arg_59_1._member.IsInitialized(arg_61_0) then
			var_0_3("Message is missing required fields: " .. var_0_7.concat(arg_59_1._member.FindInitializationErrors(arg_61_0), ","))
		end

		return arg_59_1._member.SerializePartialToIOString(arg_61_0, arg_61_1)
	end
end

local function var_0_55(arg_62_0, arg_62_1)
	local var_62_0 = var_0_7.concat

	local function var_62_1(arg_63_0, arg_63_1)
		for iter_63_0, iter_63_1 in arg_62_1._member.ListFields(arg_63_0) do
			iter_63_0._encoder(arg_63_1, iter_63_1)
		end
	end

	local function var_62_2(arg_64_0, arg_64_1)
		local var_64_0 = arg_64_1.write

		local function var_64_1(arg_65_0)
			var_64_0(arg_64_1, arg_65_0)
		end

		var_62_1(arg_64_0, var_64_1)
	end

	local function var_62_3(arg_66_0)
		local var_66_0 = {}

		local function var_66_1(arg_67_0)
			var_66_0[#var_66_0 + 1] = arg_67_0
		end

		var_62_1(arg_66_0, var_66_1)

		return var_62_0(var_66_0)
	end

	arg_62_1._member._InternalSerialize = var_62_1
	arg_62_1._member.SerializePartialToIOString = var_62_2
	arg_62_1._member.SerializePartialToString = var_62_3
end

local function var_0_56(arg_68_0, arg_68_1)
	local var_68_0 = var_0_15.ReadTag
	local var_68_1 = var_0_15.SkipField
	local var_68_2 = arg_68_1._decoders_by_tag

	local function var_68_3(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
		arg_68_1._member._Modified(arg_69_0)

		local var_69_0 = arg_69_0._fields
		local var_69_1
		local var_69_2
		local var_69_3

		while arg_69_2 ~= arg_69_3 do
			local var_69_4, var_69_5 = var_68_0(arg_69_1, arg_69_2)
			local var_69_6 = var_68_2[var_69_4]

			if var_69_6 == nil then
				var_69_5 = var_68_1(arg_69_1, var_69_5, arg_69_3, var_69_4)

				if var_69_5 == -1 then
					return arg_69_2
				end

				arg_69_2 = var_69_5
			else
				arg_69_2 = var_69_6(arg_69_1, var_69_5, arg_69_3, arg_69_0, var_69_0)
			end
		end

		return arg_69_2
	end

	arg_68_1._member._InternalParse = var_68_3

	local function var_68_4(arg_70_0, arg_70_1)
		local var_70_0 = #arg_70_1

		if var_68_3(arg_70_0, arg_70_1, 0, var_70_0) ~= var_70_0 then
			var_0_3("Unexpected end-group tag.")
		end

		return var_70_0
	end

	arg_68_1._member.MergeFromString = var_68_4

	function arg_68_1._member.ParseFromString(arg_71_0, arg_71_1)
		arg_68_1._member.Clear(arg_71_0)
		var_68_4(arg_71_0, arg_71_1)
	end
end

local function var_0_57(arg_72_0, arg_72_1)
	local var_72_0 = {}

	for iter_72_0, iter_72_1 in var_0_4(arg_72_0.fields) do
		if iter_72_1.label == var_0_18.LABEL_REQUIRED then
			var_72_0[#var_72_0 + 1] = iter_72_1
		end
	end

	function arg_72_1._member.IsInitialized(arg_73_0, arg_73_1)
		for iter_73_0, iter_73_1 in var_0_4(var_72_0) do
			if arg_73_0._fields[iter_73_1] == nil or iter_73_1.cpp_type == var_0_18.CPPTYPE_MESSAGE and not arg_73_0._fields[iter_73_1]._is_present_in_parent then
				if arg_73_1 ~= nil then
					arg_73_1[#arg_73_1 + 1] = arg_72_1._member.FindInitializationErrors(arg_73_0)
				end

				return false
			end
		end

		for iter_73_2, iter_73_3 in var_0_5(arg_73_0._fields) do
			if iter_73_2.cpp_type == var_0_18.CPPTYPE_MESSAGE then
				if iter_73_2.label == var_0_18.LABEL_REPEATED then
					for iter_73_4, iter_73_5 in var_0_4(iter_73_3) do
						if not iter_73_5:IsInitialized() then
							if arg_73_1 ~= nil then
								arg_73_1[#arg_73_1 + 1] = arg_72_1._member.FindInitializationErrors(arg_73_0)
							end

							return false
						end
					end
				elseif iter_73_3._is_present_in_parent and not iter_73_3:IsInitialized() then
					if arg_73_1 ~= nil then
						arg_73_1[#arg_73_1 + 1] = arg_72_1._member.FindInitializationErrors(arg_73_0)
					end

					return false
				end
			end
		end

		return true
	end

	function arg_72_1._member.FindInitializationErrors(arg_74_0)
		local var_74_0 = {}

		for iter_74_0, iter_74_1 in var_0_4(var_72_0) do
			if not arg_72_1._member.HasField(arg_74_0, iter_74_1.name) then
				var_0_7.insert(var_74_0, iter_74_1.name)
			end
		end

		for iter_74_2, iter_74_3 in arg_72_1._member.ListFields(arg_74_0) do
			if iter_74_2.cpp_type == var_0_18.CPPTYPE_MESSAGE then
				if iter_74_2.is_extension then
					name = var_0_8.format("(%s)", iter_74_2.full_name)
				else
					name = iter_74_2.name
				end

				if iter_74_2.label == var_0_18.LABEL_REPEATED then
					for iter_74_4, iter_74_5 in var_0_4(iter_74_3) do
						prefix = var_0_8.format("%s[%d].", name, iter_74_4)
						sub_errors = iter_74_5:FindInitializationErrors()

						for iter_74_6, iter_74_7 in var_0_4(sub_errors) do
							var_74_0[#var_74_0 + 1] = prefix .. iter_74_7
						end
					end
				else
					prefix = name .. "."
					sub_errors = iter_74_3:FindInitializationErrors()

					for iter_74_8, iter_74_9 in var_0_4(sub_errors) do
						var_74_0[#var_74_0 + 1] = prefix .. iter_74_9
					end
				end
			end
		end

		return var_74_0
	end
end

local function var_0_58(arg_75_0)
	local var_75_0 = var_0_18.LABEL_REPEATED
	local var_75_1 = var_0_18.CPPTYPE_MESSAGE

	function arg_75_0._member.MergeFrom(arg_76_0, arg_76_1)
		arg_75_0._member._Modified(arg_76_0)

		local var_76_0 = arg_76_0._fields

		for iter_76_0, iter_76_1 in var_0_5(arg_76_1._fields) do
			if iter_76_0.label == var_75_0 or iter_76_0.cpp_type == var_75_1 then
				field_value = var_76_0[iter_76_0]

				if field_value == nil then
					field_value = iter_76_0._default_constructor(arg_76_0)
					var_76_0[iter_76_0] = field_value
				end

				field_value:MergeFrom(iter_76_1)
			else
				arg_76_0._fields[iter_76_0] = iter_76_1
			end
		end
	end
end

local function var_0_59(arg_77_0, arg_77_1)
	var_0_45(arg_77_0, arg_77_1)
	var_0_46(arg_77_0, arg_77_1)
	var_0_47(arg_77_0, arg_77_1)

	if arg_77_0.is_extendable then
		var_0_48(arg_77_1)
		var_0_51(arg_77_1)
	end

	var_0_49(arg_77_0, arg_77_1)
	var_0_50(arg_77_1)
	var_0_52(arg_77_1)
	var_0_53(arg_77_0, arg_77_1)
	var_0_54(arg_77_0, arg_77_1)
	var_0_55(arg_77_0, arg_77_1)
	var_0_56(arg_77_0, arg_77_1)
	var_0_57(arg_77_0, arg_77_1)
	var_0_58(arg_77_1)
end

local function var_0_60(arg_78_0)
	local function var_78_0(arg_79_0)
		if not arg_79_0._cached_byte_size_dirty then
			arg_79_0._cached_byte_size_dirty = true
			arg_79_0._listener_for_children.dirty = true
			arg_79_0._is_present_in_parent = true

			arg_79_0._listener:Modified()
		end
	end

	arg_78_0._member._Modified = var_78_0
	arg_78_0._member.SetInParent = var_78_0
end

local function var_0_61(arg_80_0)
	local var_80_0 = arg_80_0._getter
	local var_80_1 = arg_80_0._member

	return function(arg_81_0, arg_81_1)
		local var_81_0 = var_80_0[arg_81_1]

		if var_81_0 then
			return var_81_0(arg_81_0)
		else
			return var_80_1[arg_81_1]
		end
	end
end

local function var_0_62(arg_82_0)
	local var_82_0 = arg_82_0._setter

	return function(arg_83_0, arg_83_1, arg_83_2)
		local var_83_0 = var_82_0[arg_83_1]

		if var_83_0 then
			var_83_0(arg_83_0, arg_83_2)
		else
			var_0_3(arg_83_1 .. " not found")
		end
	end
end

function _AddClassAttributesForNestedExtensions(arg_84_0, arg_84_1)
	local var_84_0 = arg_84_0._extensions_by_name

	for iter_84_0, iter_84_1 in var_0_5(var_84_0) do
		arg_84_1._member[iter_84_0] = iter_84_1
	end
end

local function var_0_63(arg_85_0)
	local var_85_0 = {
		_decoders_by_tag = {}
	}

	var_0_1(arg_85_0, "_extensions_by_name", {})

	for iter_85_0, iter_85_1 in var_0_4(arg_85_0.extensions) do
		arg_85_0._extensions_by_name[iter_85_1.name] = iter_85_1
	end

	var_0_1(arg_85_0, "_extensions_by_number", {})

	for iter_85_2, iter_85_3 in var_0_4(arg_85_0.extensions) do
		arg_85_0._extensions_by_number[iter_85_3.number] = iter_85_3
	end

	var_85_0._descriptor = arg_85_0
	var_85_0._extensions_by_name = {}
	var_85_0._extensions_by_number = {}
	var_85_0._getter = {}
	var_85_0._setter = {}
	var_85_0._member = {}

	local var_85_1 = var_0_0({}, var_85_0._member)

	var_85_0._member.__call = var_0_34(var_85_0)
	var_85_0._member.__index = var_85_0._member
	var_85_0._member.type = var_85_1

	if var_0_2(arg_85_0, "_concrete_class") == nil then
		var_0_1(arg_85_0, "_concrete_class", var_85_1)

		for iter_85_4, iter_85_5 in var_0_4(arg_85_0.fields) do
			var_0_32(var_85_0, iter_85_5)
		end
	end

	var_0_33(arg_85_0, var_85_0)
	_AddClassAttributesForNestedExtensions(arg_85_0, var_85_0)
	var_0_41(arg_85_0, var_85_0)
	var_0_42(arg_85_0, var_85_0)
	var_0_43(var_85_0)
	var_0_59(arg_85_0, var_85_0)
	var_0_60(var_85_0)

	var_85_0.__index = var_0_61(var_85_0)
	var_85_0.__newindex = var_0_62(var_85_0)

	return var_85_1
end

_M.Message = var_0_63

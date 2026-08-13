require = var_0_10000

local var_0_0 = var_0_10000("pb")

module = var_1

var_1("protobuf.wire_format")

local var_0_1 = 0
local var_0_2 = WIRETYPE_VARINT
local var_0_3 = 1
local var_0_4 = WIRETYPE_FIXED64
local var_0_5 = 2
local var_0_6 = WIRETYPE_LENGTH_DELIMITED
local var_0_7 = 3
local var_0_8 = WIRETYPE_START_GROUP
local var_0_9 = 4
local var_0_10 = WIRETYPE_END_GROUP
local var_0_11 = 5
local var_0_12 = WIRETYPE_FIXED32
local var_0_13 = 5
local var_0_14 = _WIRETYPE_MAX

local function var_0_15(arg_1_0)
	if arg_1_0 <= 127 then
		return 1
	end

	if arg_1_0 <= 16383 then
		return 2
	end

	if arg_1_0 <= 2097151 then
		return 3
	end

	if arg_1_0 <= 268435455 then
		return 4
	end

	return 5
end

local function var_0_16(arg_2_0, arg_2_1)
	return arg_2_0 * 8 + arg_2_1
end

local var_0_17 = PackTag

local function var_0_18(arg_3_0)
	return (arg_3_0 - arg_3_0 % 8) / 8, var_1
end

local var_0_19 = UnpackTag
local var_0_20 = var_0_0.zig_zag_encode32
local var_0_21 = ZigZagEncode32
local var_0_22 = var_0_0.zig_zag_decode32
local var_0_23 = ZigZagDecode32
local var_0_24 = var_0_0.zig_zag_encode64
local var_0_25 = ZigZagEncode64
local var_0_26 = var_0_0.zig_zag_decode64
local var_0_27 = ZigZagDecode64

local function var_0_28(arg_4_0, arg_4_1)
	Int64ByteSize = var_1_10002

	return var_1_10002(arg_4_0, arg_4_1)
end

local var_0_29 = Int32ByteSize

local function var_0_30(arg_5_0)
	return var_0_15(arg_5_0)
end

local var_0_31 = Int32ByteSizeNoTag

local function var_0_32(arg_6_0, arg_6_1)
	UInt64ByteSize = var_1_10002

	return var_1_10002(arg_6_0, arg_6_1)
end

local var_0_33 = Int64ByteSize

local function var_0_34(arg_7_0, arg_7_1)
	UInt64ByteSize = var_1_10002

	return var_1_10002(arg_7_0, arg_7_1)
end

local var_0_35 = UInt32ByteSize

local function var_0_36(arg_8_0, arg_8_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_8_0) + var_0_15(arg_8_1)
end

local var_0_37 = UInt64ByteSize

local function var_0_38(arg_9_0, arg_9_1)
	UInt32ByteSize = var_1_10002

	local var_9_0 = arg_9_0

	ZigZagEncode = var_1_10004

	return var_1_10002(var_9_0, var_1_10004(arg_9_1))
end

local var_0_39 = SInt32ByteSize

local function var_0_40(arg_10_0, arg_10_1)
	UInt64ByteSize = var_1_10002

	local var_10_0 = arg_10_0

	ZigZagEncode = var_1_10004

	return var_1_10002(var_10_0, var_1_10004(arg_10_1))
end

local var_0_41 = SInt64ByteSize

local function var_0_42(arg_11_0, arg_11_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_11_0) + 4
end

local var_0_43 = Fixed32ByteSize

local function var_0_44(arg_12_0, arg_12_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_12_0) + 8
end

local var_0_45 = Fixed64ByteSize

local function var_0_46(arg_13_0, arg_13_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_13_0) + 4
end

local var_0_47 = SFixed32ByteSize

local function var_0_48(arg_14_0, arg_14_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_14_0) + 8
end

local var_0_49 = SFixed64ByteSize

local function var_0_50(arg_15_0, arg_15_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_15_0) + 4
end

local var_0_51 = FloatByteSize

local function var_0_52(arg_16_0, arg_16_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_16_0) + 8
end

local var_0_53 = DoubleByteSize

local function var_0_54(arg_17_0, arg_17_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_17_0) + 1
end

local var_0_55 = BoolByteSize

local function var_0_56(arg_18_0, arg_18_1)
	UInt32ByteSize = var_1_10002

	return var_1_10002(arg_18_0, arg_18_1)
end

local var_0_57 = EnumByteSize

local function var_0_58(arg_19_0, arg_19_1)
	BytesByteSize = var_1_10002

	return var_1_10002(arg_19_0, arg_19_1)
end

local var_0_59 = StringByteSize

local function var_0_60(arg_20_0, arg_20_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_20_0) + var_0_15(#arg_20_1) + #arg_20_1
end

local var_0_61 = BytesByteSize

local function var_0_62(arg_21_0, arg_21_1)
	TagByteSize = var_1_10002

	return var_1_10002(arg_21_0) + var_0_15(arg_21_1.ByteSize()) + arg_21_1.ByteSize()
end

local var_0_63 = MessageByteSize

local function var_0_64(arg_22_0, arg_22_1)
	TagByteSize = var_1_10002

	local var_22_0 = 2 * var_1_10002(1)

	TagByteSize = var_3

	local var_22_1 = var_22_0 + var_3(2)

	TagByteSize = var_3

	local var_22_2 = var_22_1 + var_3(3) + var_0_15(arg_22_0)
	local var_22_3 = arg_22_1.ByteSize()

	return var_22_2 + var_0_15(var_22_3) + var_22_3
end

local var_0_65 = MessageSetItemByteSize

local function var_0_66(arg_23_0)
	local var_23_0 = var_0_15

	PackTag = var_1_10002

	return var_23_0(var_1_10002(arg_23_0, 0))
end

local var_0_67 = TagByteSize

return

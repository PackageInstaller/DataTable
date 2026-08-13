string = var_0_10000
table = var_0_10001
ipairs = var_0_10002
assert = var_0_10003
uint64 = var_0_10004
type = var_0_10005
require = var_0_10006

local var_0_0 = var_0_10006("pb")

require = var_7

local var_0_1 = var_7("wire_format")

module = var_8

var_8("encoder")

local function var_0_2(arg_1_0)
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

local var_0_3 = _VarintSize

local function var_0_4(arg_2_0)
	if arg_2_0 < 0 then
		return 10
	end

	if arg_2_0 <= 127 then
		return 1
	end

	if arg_2_0 <= 16383 then
		return 2
	end

	if arg_2_0 <= 2097151 then
		return 3
	end

	if arg_2_0 <= 268435455 then
		return 4
	end

	return 5
end

local var_0_5 = _SignedVarintSize

local function var_0_6(arg_3_0)
	local var_3_0 = 0
	local var_3_1 = 0

	if var_0_10005(arg_3_0) == "number" then
		var_3_1 = arg_3_0
	else
		local var_3_2 = var_0_10004.new(arg_3_0)

		var_3_1, var_3_0 = var_3.tonum2(var_3_2)
	end

	if var_3_0 == 0 then
		if var_3_1 <= 127 then
			return 1
		end

		if var_3_1 <= 16383 then
			return 2
		end

		if var_3_1 <= 2097151 then
			return 3
		end

		if var_3_1 <= 268435455 then
			return 4
		end

		return 5
	else
		if var_3_0 <= 7 then
			return 5
		end

		if var_3_0 <= 1023 then
			return 6
		end

		if var_3_0 <= 131071 then
			return 7
		end

		if var_3_0 <= 16777215 then
			return 8
		end

		if var_3_0 <= 2147483647 then
			return 9
		end

		return 10
	end

	return
end

local var_0_7 = _VarintSize64

local function var_0_8(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 0

	if var_0_10005(arg_4_0) == "number" then
		var_4_2 = arg_4_0
		var_4_0 = arg_4_0 < 0 and 1 or 0
	else
		int64 = var_4

		local var_4_3 = var_4.new(arg_4_0)

		var_4_2, var_4_1 = var_4.tonum2(var_4_3)
		var_4_0 = var_4_1 > 2147483647 and 1 or 0
	end

	if var_4_0 == 1 then
		return 10
	end

	if var_4_1 == 0 then
		if var_4_2 <= 127 then
			return 1
		end

		if var_4_2 <= 16383 then
			return 2
		end

		if var_4_2 <= 2097151 then
			return 3
		end

		if var_4_2 <= 268435455 then
			return 4
		end

		return 5
	else
		if var_4_1 <= 7 then
			return 5
		end

		if var_4_1 <= 1023 then
			return 6
		end

		if var_4_1 <= 131071 then
			return 7
		end

		if var_4_1 <= 16777215 then
			return 8
		end

		if var_4_1 <= 2147483647 then
			return 9
		end

		return 10
	end

	return
end

local var_0_9 = _SignedVarintSize64

local function var_0_10(arg_5_0)
	_VarintSize = var_1_10001

	return var_1_10001(var_0_1.PackTag(arg_5_0, 0))
end

local var_0_11 = _TagSize

local function var_0_12(arg_6_0)
	return function(arg_7_0, arg_7_1, arg_7_2)
		_TagSize = var_2_10003

		local var_7_0 = var_2_10003(arg_7_0)

		if arg_7_2 then
			_VarintSize = var_4

			return function(arg_8_0)
				local var_8_0 = 0

				for iter_8_0, iter_8_1 in var_0_10002(arg_8_0) do
					var_8_0 = var_8_0 + arg_6_0(iter_8_1)
				end

				return var_8_0 + var_0(var_8_0) + var_7_0
			end
		elseif arg_7_1 then
			return function(arg_9_0)
				local var_9_0 = var_7_0 * #arg_9_0

				for iter_9_0, iter_9_1 in var_0_10002(arg_9_0) do
					var_9_0 = var_9_0 + arg_6_0(iter_9_1)
				end

				return var_9_0
			end
		else
			return function(arg_10_0)
				return var_7_0 + arg_6_0(arg_10_0)
			end
		end

		return
	end
end

local var_0_13 = _SimpleSizer

local function var_0_14(arg_11_0, arg_11_1)
	return function(arg_12_0, arg_12_1, arg_12_2)
		_TagSize = var_2_10003

		local var_12_0 = var_2_10003(arg_12_0)

		if arg_12_2 then
			_VarintSize = var_4

			return function(arg_13_0)
				local var_13_0 = 0

				for iter_13_0, iter_13_1 in var_0_10002(arg_13_0) do
					var_13_0 = var_13_0 + arg_11_0(arg_11_1(iter_13_1))
				end

				return var_13_0 + var_0(var_13_0) + var_12_0
			end
		elseif arg_12_1 then
			return function(arg_14_0)
				local var_14_0 = var_12_0 * #arg_14_0

				for iter_14_0, iter_14_1 in var_0_10002(arg_14_0) do
					var_14_0 = var_14_0 + arg_11_0(arg_11_1(iter_14_1))
				end

				return var_14_0
			end
		else
			return function(arg_15_0)
				return var_12_0 + arg_11_0(arg_11_1(arg_15_0))
			end
		end

		return
	end
end

local var_0_15 = _ModifiedSizer

local function var_0_16(arg_16_0)
	return function(arg_17_0, arg_17_1, arg_17_2)
		_TagSize = var_2_10003

		local var_17_0 = var_2_10003(arg_17_0)

		if arg_17_2 then
			_VarintSize = var_4

			return function(arg_18_0)
				return #arg_18_0 * arg_16_0 + var_0(var_1) + var_17_0
			end
		elseif arg_17_1 then
			local var_17_1 = arg_16_0 + var_17_0

			return function(arg_19_0)
				return #arg_19_0 * var_17_1
			end
		else
			local var_17_2 = arg_16_0 + var_17_0

			return function(arg_20_0)
				return var_17_2
			end
		end

		return
	end
end

_SimpleSizer = _FixedSizer
_SignedVarintSize = var_9

local var_0_17 = var_8(var_9)

_SimpleSizer = Int32Sizer
_SignedVarintSize64 = var_9

local var_0_18 = var_8(var_9)

Int32Sizer = Int64Sizer
_SimpleSizer = EnumSizer
_VarintSize = var_9

local var_0_19 = var_8(var_9)

_SimpleSizer = UInt32Sizer
_VarintSize64 = var_9

local var_0_20 = var_8(var_9)

_ModifiedSizer = UInt64Sizer
_VarintSize = var_9

local var_0_21 = var_8(var_9, var_0_1.ZigZagEncode32)

_ModifiedSizer = SInt32Sizer
_VarintSize64 = var_9

local var_0_22 = var_8(var_9, var_0_1.ZigZagEncode32)

_FixedSizer = SInt64Sizer

local var_0_23 = var_8(4)

Fixed32Sizer = Fixed32Sizer
Fixed32Sizer = SFixed32Sizer
_FixedSizer = FloatSizer

local var_0_24 = var_8(8)

Fixed64Sizer = Fixed64Sizer
Fixed64Sizer = SFixed64Sizer
_FixedSizer = DoubleSizer

local var_0_25 = var_8(1)
local var_0_26 = BoolSizer

local function var_0_27(arg_21_0, arg_21_1, arg_21_2)
	_TagSize = var_1_10003

	local var_21_0 = var_1_10003(arg_21_0)

	_VarintSize = var_4

	var_0_10003(not arg_21_2)

	if arg_21_1 then
		return function(arg_22_0)
			local var_22_0 = var_21_0 * #arg_22_0

			for iter_22_0, iter_22_1 in var_0_10002(arg_22_0) do
				local var_22_1 = #iter_22_1

				var_22_0 = var_22_0 + var_0(var_22_1) + var_22_1
			end

			return var_22_0
		end
	else
		return function(arg_23_0)
			local var_23_0 = #arg_23_0

			return var_21_0 + var_0(var_23_0) + var_23_0
		end
	end

	return
end

local var_0_28 = StringSizer

local function var_0_29(arg_24_0, arg_24_1, arg_24_2)
	_TagSize = var_1_10003

	local var_24_0 = var_1_10003(arg_24_0)

	_VarintSize = var_4

	var_0_10003(not arg_24_2)

	if arg_24_1 then
		return function(arg_25_0)
			local var_25_0 = var_24_0 * #arg_25_0

			for iter_25_0, iter_25_1 in var_0_10002(arg_25_0) do
				local var_25_1 = #iter_25_1

				var_25_0 = var_25_0 + var_0(var_25_1) + var_25_1
			end

			return var_25_0
		end
	else
		return function(arg_26_0)
			local var_26_0 = #arg_26_0

			return var_24_0 + var_0(var_26_0) + var_26_0
		end
	end

	return
end

local var_0_30 = BytesSizer

local function var_0_31(arg_27_0, arg_27_1, arg_27_2)
	_TagSize = var_1_10003

	local var_27_0 = var_1_10003(arg_27_0)

	_VarintSize = var_4

	var_0_10003(not arg_27_2)

	if arg_27_1 then
		return function(arg_28_0)
			local var_28_0 = var_27_0 * #arg_28_0

			for iter_28_0, iter_28_1 in var_0_10002(arg_28_0) do
				local var_28_1 = iter_28_1:ByteSize()

				var_28_0 = var_28_0 + var_0(var_28_1) + var_28_1
			end

			return var_28_0
		end
	else
		return function(arg_29_0)
			local var_29_0 = arg_29_0:ByteSize()

			return var_27_0 + var_0(var_29_0) + var_29_0
		end
	end

	return
end

local var_0_32 = MessageSizer
local var_0_33 = var_0_0.varint_encoder
local var_0_34 = var_0_0.signed_varint_encoder
local var_0_35 = var_0_0.varint_encoder64
local var_0_36 = var_0_0.signed_varint_encoder64

local function var_0_37(arg_30_0)
	local var_30_0 = {}

	local function var_30_1(arg_31_0)
		var_30_0[#var_30_0 + 1] = arg_31_0

		return
	end

	var_0_34(var_30_1, arg_30_0)

	return var_0_10001.concat(var_30_0)
end

local var_0_38 = _VarintBytes

local function var_0_39(arg_32_0, arg_32_1)
	_VarintBytes = var_1_10002

	return var_1_10002(var_0_1.PackTag(arg_32_0, arg_32_1))
end

local var_0_40 = TagBytes

local function var_0_41(arg_33_0, arg_33_1, arg_33_2)
	return function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_2 then
			TagBytes = var_2_10003
			var_2_10003 = var_2_10003(arg_34_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)

			local var_34_0 = var_0_33

			return function(arg_35_0, arg_35_1)
				arg_35_0(var_2_10003)

				local var_35_0 = 0

				for iter_35_0, iter_35_1 in var_0_10002(arg_35_1) do
					var_35_0 = var_35_0 + arg_33_2(iter_35_1)
				end

				var_34_0(arg_35_0, var_35_0)

				for iter_35_2 in arg_35_1 do
					arg_33_1(arg_35_0, iter_35_2)
				end

				return
			end
		elseif arg_34_1 then
			TagBytes = var_2_10003
			var_2_10003 = var_2_10003(arg_34_0, arg_33_0)

			return function(arg_36_0, arg_36_1)
				for iter_36_0, iter_36_1 in var_0_10002(arg_36_1) do
					arg_36_0(var_2_10003)
					arg_33_1(arg_36_0, iter_36_1)
				end

				return
			end
		else
			TagBytes = var_2_10003

			local var_34_1 = var_2_10003(arg_34_0, arg_33_0)

			return function(arg_37_0, arg_37_1)
				arg_37_0(var_34_1)
				arg_33_1(arg_37_0, arg_37_1)

				return
			end
		end

		return
	end
end

local var_0_42 = _SimpleEncoder

local function var_0_43(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	return function(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_2 then
			TagBytes = var_2_10003
			var_2_10003 = var_2_10003(arg_39_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)

			local var_39_0 = var_0_33

			return function(arg_40_0, arg_40_1)
				arg_40_0(var_2_10003)

				local var_40_0 = 0

				for iter_40_0, iter_40_1 in var_0_10002(arg_40_1) do
					var_40_0 = var_40_0 + arg_38_2(arg_38_3(iter_40_1))
				end

				var_39_0(arg_40_0, var_40_0)

				for iter_40_2, iter_40_3 in var_0_10002(arg_40_1) do
					arg_38_1(arg_40_0, arg_38_3(iter_40_3))
				end

				return
			end
		elseif arg_39_1 then
			TagBytes = var_2_10003
			var_2_10003 = var_2_10003(arg_39_0, arg_38_0)

			return function(arg_41_0, arg_41_1)
				for iter_41_0, iter_41_1 in var_0_10002(arg_41_1) do
					arg_41_0(var_2_10003)
					arg_38_1(arg_41_0, arg_38_3(iter_41_1))
				end

				return
			end
		else
			TagBytes = var_2_10003

			local var_39_1 = var_2_10003(arg_39_0, arg_38_0)

			return function(arg_42_0, arg_42_1)
				arg_42_0(var_39_1)
				arg_38_1(arg_42_0, arg_38_3(arg_42_1))

				return
			end
		end

		return
	end
end

local var_0_44 = _ModifiedEncoder

local function var_0_45(arg_43_0, arg_43_1, arg_43_2)
	return function(arg_44_0, arg_44_1, arg_44_2)
		local var_44_0 = var_0_0.struct_pack

		if arg_44_2 then
			TagBytes = var_2_10004
			var_2_10004 = var_2_10004(arg_44_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)

			local var_44_1 = var_0_33

			return function(arg_45_0, arg_45_1)
				arg_45_0(var_2_10004)
				var_44_1(arg_45_0, #arg_45_1 * arg_43_1)

				for iter_45_0, iter_45_1 in var_0_10002(arg_45_1) do
					var_44_0(arg_45_0, arg_43_2, iter_45_1)
				end

				return
			end
		elseif arg_44_1 then
			TagBytes = var_2_10004
			var_2_10004 = var_2_10004(arg_44_0, arg_43_0)

			return function(arg_46_0, arg_46_1)
				for iter_46_0, iter_46_1 in var_0_10002(arg_46_1) do
					arg_46_0(var_2_10004)
					var_44_0(arg_46_0, arg_43_2, iter_46_1)
				end

				return
			end
		else
			TagBytes = var_2_10004

			local var_44_2 = var_2_10004(arg_44_0, arg_43_0)

			return function(arg_47_0, arg_47_1)
				arg_47_0(var_44_2)
				var_44_0(arg_47_0, arg_43_2, arg_47_1)

				return
			end
		end

		return
	end
end

_SimpleEncoder = _StructPackEncoder

local var_0_46 = var_0_1.WIRETYPE_VARINT
local var_0_47 = var_0_34

_SignedVarintSize = var_0_10015

local var_0_48 = var_12(var_0_46, var_0_47, var_0_10015)

_SimpleEncoder = Int32Encoder

local var_0_49 = var_0_1.WIRETYPE_VARINT
local var_0_50 = var_0_36

_SignedVarintSize64 = var_0_10015

local var_0_51 = var_12(var_0_49, var_0_50, var_0_10015)

Int32Encoder = Int64Encoder
_SimpleEncoder = EnumEncoder

local var_0_52 = var_0_1.WIRETYPE_VARINT
local var_0_53 = var_0_33

_VarintSize = var_0_10015

local var_0_54 = var_12(var_0_52, var_0_53, var_0_10015)

_SimpleEncoder = UInt32Encoder

local var_0_55 = var_0_1.WIRETYPE_VARINT
local var_0_56 = var_0_35

_VarintSize64 = var_0_10015

local var_0_57 = var_12(var_0_55, var_0_56, var_0_10015)

_ModifiedEncoder = UInt64Encoder

local var_0_58 = var_0_1.WIRETYPE_VARINT
local var_0_59 = var_0_33

_VarintSize = var_0_10015

local var_0_60 = var_12(var_0_58, var_0_59, var_0_10015, var_0_1.ZigZagEncode32)

_ModifiedEncoder = SInt32Encoder

local var_0_61 = var_0_1.WIRETYPE_VARINT
local var_0_62 = var_0_35

_VarintSize64 = var_0_10015

local var_0_63 = var_12(var_0_61, var_0_62, var_0_10015, var_0_1.ZigZagEncode64)

_StructPackEncoder = SInt64Encoder

local var_0_64 = var_12(var_0_1.WIRETYPE_FIXED32, 4, var_0_10000.byte("I"))

_StructPackEncoder = Fixed32Encoder

local var_0_65 = var_12(var_0_1.WIRETYPE_FIXED64, 8, var_0_10000.byte("Q"))

_StructPackEncoder = Fixed64Encoder

local var_0_66 = var_12(var_0_1.WIRETYPE_FIXED32, 4, var_0_10000.byte("i"))

_StructPackEncoder = SFixed32Encoder

local var_0_67 = var_12(var_0_1.WIRETYPE_FIXED64, 8, var_0_10000.byte("q"))

_StructPackEncoder = SFixed64Encoder

local var_0_68 = var_12(var_0_1.WIRETYPE_FIXED32, 4, var_0_10000.byte("f"))

_StructPackEncoder = FloatEncoder

local var_0_69 = var_12(var_0_1.WIRETYPE_FIXED64, 8, var_0_10000.byte("d"))
local var_0_70 = DoubleEncoder

local function var_0_71(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = "\x00"
	local var_48_1 = "\x01"

	if arg_48_2 then
		TagBytes = var_1_10005
		var_1_10005 = var_1_10005(arg_48_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)

		local var_48_2 = var_0_33

		return function(arg_49_0, arg_49_1)
			arg_49_0(var_1_10005)
			var_48_2(arg_49_0, #arg_49_1)

			for iter_49_0, iter_49_1 in var_0_10002(arg_49_1) do
				if iter_49_1 then
					arg_49_0(var_48_1)
				else
					arg_49_0(var_48_0)
				end
			end

			return
		end
	elseif arg_48_1 then
		TagBytes = var_1_10005
		var_1_10005 = var_1_10005(arg_48_0, var_0_1.WIRETYPE_VARINT)

		return function(arg_50_0, arg_50_1)
			for iter_50_0, iter_50_1 in var_0_10002(arg_50_1) do
				arg_50_0(var_1_10005)

				if iter_50_1 then
					arg_50_0(var_48_1)
				else
					arg_50_0(var_48_0)
				end
			end

			return
		end
	else
		TagBytes = var_1_10005

		local var_48_3 = var_1_10005(arg_48_0, var_0_1.WIRETYPE_VARINT)

		return function(arg_51_0, arg_51_1)
			arg_51_0(var_48_3)

			if arg_51_1 then
				return arg_51_0(var_48_1)
			end

			return arg_51_0(var_48_0)
		end
	end

	return
end

local var_0_72 = BoolEncoder

local function var_0_73(arg_52_0, arg_52_1, arg_52_2)
	TagBytes = var_1_10003

	local var_52_0 = var_1_10003(arg_52_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)
	local var_52_1 = var_0_33

	var_0_10003(not arg_52_2)

	if arg_52_1 then
		return function(arg_53_0, arg_53_1)
			for iter_53_0, iter_53_1 in var_0_10002(arg_53_1) do
				arg_53_0(var_52_0)
				var_52_1(arg_53_0, #iter_53_1)
				arg_53_0(iter_53_1)
			end

			return
		end
	else
		return function(arg_54_0, arg_54_1)
			arg_54_0(var_52_0)
			var_52_1(arg_54_0, #arg_54_1)

			return arg_54_0(arg_54_1)
		end
	end

	return
end

local var_0_74 = StringEncoder

local function var_0_75(arg_55_0, arg_55_1, arg_55_2)
	TagBytes = var_1_10003

	local var_55_0 = var_1_10003(arg_55_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)
	local var_55_1 = var_0_33

	var_0_10003(not arg_55_2)

	if arg_55_1 then
		return function(arg_56_0, arg_56_1)
			for iter_56_0, iter_56_1 in var_0_10002(arg_56_1) do
				arg_56_0(var_55_0)
				var_55_1(arg_56_0, #iter_56_1)
				arg_56_0(iter_56_1)
			end

			return
		end
	else
		return function(arg_57_0, arg_57_1)
			arg_57_0(var_55_0)
			var_55_1(arg_57_0, #arg_57_1)

			return arg_57_0(arg_57_1)
		end
	end

	return
end

local var_0_76 = BytesEncoder

local function var_0_77(arg_58_0, arg_58_1, arg_58_2)
	TagBytes = var_1_10003

	local var_58_0 = var_1_10003(arg_58_0, var_0_1.WIRETYPE_LENGTH_DELIMITED)
	local var_58_1 = var_0_33

	var_0_10003(not arg_58_2)

	if arg_58_1 then
		return function(arg_59_0, arg_59_1)
			for iter_59_0, iter_59_1 in var_0_10002(arg_59_1) do
				arg_59_0(var_58_0)
				var_58_1(arg_59_0, iter_59_1:ByteSize())
				iter_59_1:_InternalSerialize(arg_59_0)
			end

			return
		end
	else
		return function(arg_60_0, arg_60_1)
			arg_60_0(var_58_0)
			var_58_1(arg_60_0, arg_60_1:ByteSize())

			return arg_60_1:_InternalSerialize(arg_60_0)
		end
	end

	return
end

local var_0_78 = MessageEncoder

return

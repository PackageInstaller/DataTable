string = var_0_10000
table = var_0_10001
assert = var_0_10002
ipairs = var_0_10003
error = var_0_10004
print = var_0_10005
require = var_0_10006

local var_0_0 = var_0_10006("pb")

require = var_0_10007

local var_0_1 = var_0_10007("encoder")

require = var_8

local var_0_2 = var_8("wire_format")

module = var_9

var_9("decoder")

local var_0_3 = var_0_0.varint_decoder
local var_0_4 = var_0_0.signed_varint_decoder
local var_0_5 = var_0_0.varint_decoder
local var_0_6 = var_0_0.signed_varint_decoder
local var_0_7 = var_0_0.varint_decoder64
local var_0_8 = var_0_0.signed_varint_decoder64
local var_0_9 = var_0_0.read_tag
local var_0_10 = ReadTag

local function var_0_11(arg_1_0, arg_1_1)
	return function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		if arg_2_2 then
			local var_2_0 = var_0_3

			return function(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
				local var_3_0

				if arg_3_4[arg_2_3] == nil then
					var_3_0 = arg_2_4(arg_3_3)
					arg_3_4[arg_2_3] = var_3_0
				end

				local var_3_1
				local var_3_2, var_3_3 = var_2_0(arg_3_0, arg_3_1)

				arg_3_1 = var_3_3

				if arg_3_2 < var_3_2 + arg_3_1 then
					var_0_10004("Truncated message.")
				end

				local var_3_4

				while arg_3_1 < var_6 do
					local var_3_5

					var_3_5, arg_3_1 = arg_1_1(arg_3_0, arg_3_1)
					var_3_0[#var_3_0 + 1] = var_3_5
				end

				if var_6 < arg_3_1 then
					var_3_0:remove(#var_3_0)
					var_0_10004("Packed element was truncated.")
				end

				return arg_3_1
			end
		elseif arg_2_1 then
			local var_2_1 = #var_0_1.TagBytes(arg_2_0, arg_1_0)
			local var_2_2 = var_0_10000.sub

			return function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
				local var_4_0

				if arg_4_4[arg_2_3] == nil then
					var_4_0 = arg_2_4(arg_4_3)
					arg_4_4[arg_2_3] = var_4_0
				end

				while true do
					local var_4_1, var_4_2 = arg_1_1(arg_4_0, arg_4_1)

					var_4_0:append(var_4_1)

					arg_4_1 = var_4_2 + var_2_1

					if var_2_2(arg_4_0, var_4_2 + 1, arg_4_1) ~= var_0 or arg_4_2 <= var_4_2 then
						if arg_4_2 < var_4_2 then
							var_0_10004("Truncated message.")
						end

						return var_4_2
					end
				end

				return
			end
		else
			return function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
				arg_5_4[arg_2_3], arg_5_1 = arg_1_1(arg_5_0, arg_5_1)

				if arg_5_2 < arg_5_1 then
					arg_5_4[arg_2_3] = nil

					var_0_10004("Truncated message.")
				end

				return arg_5_1
			end
		end

		return
	end
end

local function var_0_12(arg_6_0, arg_6_1, arg_6_2)
	local function var_6_0(arg_7_0, arg_7_1)
		local var_7_0, var_7_1 = arg_6_1(arg_7_0, arg_7_1)

		return arg_6_2(var_7_0), var_7_1
	end

	return var_0_11(arg_6_0, var_6_0)
end

local function var_0_13(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = var_0_0.struct_unpack

	local function var_8_1(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_1 + arg_8_1

		return var_8_0(arg_8_2, arg_9_0, arg_9_1), var_9_0
	end

	local var_8_2 = InnerDecode
	local var_8_3 = var_0_11
	local var_8_4 = arg_8_0

	InnerDecode = var_1_10007

	return var_8_3(var_8_4, var_1_10007)
end

local function var_0_14(arg_10_0)
	return arg_10_0 ~= 0
end

local var_0_15 = var_0_11(var_0_2.WIRETYPE_VARINT, var_0_6)

Int32Decoder = Int32Decoder

local var_0_16 = EnumDecoder
local var_0_17 = var_0_11(var_0_2.WIRETYPE_VARINT, var_0_8)
local var_0_18 = Int64Decoder
local var_0_19 = var_0_11(var_0_2.WIRETYPE_VARINT, var_0_5)
local var_0_20 = UInt32Decoder
local var_0_21 = var_0_11(var_0_2.WIRETYPE_VARINT, var_0_7)
local var_0_22 = UInt64Decoder
local var_0_23 = var_0_12(var_0_2.WIRETYPE_VARINT, var_0_5, var_0_2.ZigZagDecode32)
local var_0_24 = SInt32Decoder
local var_0_25 = var_0_12(var_0_2.WIRETYPE_VARINT, var_0_7, var_0_2.ZigZagDecode64)
local var_0_26 = SInt64Decoder
local var_0_27 = var_0_13(var_0_2.WIRETYPE_FIXED32, 4, var_0_10000.byte("I"))
local var_0_28 = Fixed32Decoder
local var_0_29 = var_0_13(var_0_2.WIRETYPE_FIXED64, 8, var_0_10000.byte("Q"))
local var_0_30 = Fixed64Decoder
local var_0_31 = var_0_13(var_0_2.WIRETYPE_FIXED32, 4, var_0_10000.byte("i"))
local var_0_32 = SFixed32Decoder
local var_0_33 = var_0_13(var_0_2.WIRETYPE_FIXED64, 8, var_0_10000.byte("q"))
local var_0_34 = SFixed64Decoder
local var_0_35 = var_0_13(var_0_2.WIRETYPE_FIXED32, 4, var_0_10000.byte("f"))
local var_0_36 = FloatDecoder
local var_0_37 = var_0_13(var_0_2.WIRETYPE_FIXED64, 8, var_0_10000.byte("d"))
local var_0_38 = DoubleDecoder
local var_0_39 = var_0_12(var_0_2.WIRETYPE_VARINT, var_0_3, var_0_14)
local var_0_40 = BoolDecoder

local function var_0_41(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = var_0_3
	local var_11_1 = var_0_10000.sub

	var_0_10002(not arg_11_2)

	if arg_11_1 then
		local var_11_2 = #var_0_1.TagBytes(arg_11_0, var_0_2.WIRETYPE_LENGTH_DELIMITED)

		return function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
			local var_12_0

			if arg_12_4[arg_11_3] == nil then
				var_12_0 = arg_11_4(arg_12_3)
				arg_12_4[arg_11_3] = var_12_0
			end

			while true do
				local var_12_1
				local var_12_2
				local var_12_3, var_12_4 = var_11_0(arg_12_0, arg_12_1)

				if arg_12_2 < var_12_4 + var_12_3 then
					var_0_10004("Truncated string.")
				end

				var_12_0:append(var_11_1(arg_12_0, arg_12_1 + 1, var_7))

				arg_12_1 = var_7 + var_11_2

				if var_11_1(arg_12_0, var_7 + 1, arg_12_1) ~= var_0 or var_7 == arg_12_2 then
					return var_7
				end
			end

			return
		end
	else
		return function(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
			local var_13_0
			local var_13_1
			local var_13_2, var_13_3 = var_11_0(arg_13_0, arg_13_1)

			if arg_13_2 < var_13_3 + var_13_2 then
				var_0_10004("Truncated string.")
			end

			arg_13_4[arg_11_3] = var_11_1(arg_13_0, arg_13_1 + 1, var_6)

			return var_6
		end
	end

	return
end

local var_0_42 = StringDecoder

local function var_0_43(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = var_0_3
	local var_14_1 = var_0_10000.sub

	var_0_10002(not arg_14_2)

	if arg_14_1 then
		local var_14_2 = #var_0_1.TagBytes(arg_14_0, var_0_2.WIRETYPE_LENGTH_DELIMITED)

		return function(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
			local var_15_0

			if arg_15_4[arg_14_3] == nil then
				var_15_0 = arg_14_4(arg_15_3)
				arg_15_4[arg_14_3] = var_15_0
			end

			while true do
				local var_15_1
				local var_15_2
				local var_15_3, var_15_4 = var_14_0(arg_15_0, arg_15_1)

				if arg_15_2 < var_15_4 + var_15_3 then
					var_0_10004("Truncated string.")
				end

				var_15_0:append(var_14_1(arg_15_0, arg_15_1 + 1, var_7))

				arg_15_1 = var_7 + var_14_2

				if var_14_1(arg_15_0, var_7 + 1, arg_15_1) ~= var_0 or var_7 == arg_15_2 then
					return var_7
				end
			end

			return
		end
	else
		return function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
			local var_16_0
			local var_16_1
			local var_16_2, var_16_3 = var_14_0(arg_16_0, arg_16_1)

			if arg_16_2 < var_16_3 + var_16_2 then
				var_0_10004("Truncated string.")
			end

			arg_16_4[arg_14_3] = var_14_1(arg_16_0, arg_16_1 + 1, var_6)

			return var_6
		end
	end

	return
end

local var_0_44 = BytesDecoder

local function var_0_45(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = var_0_3
	local var_17_1 = var_0_10000.sub

	var_0_10002(not arg_17_2)

	if arg_17_1 then
		local var_17_2 = #var_0_1.TagBytes(arg_17_0, var_0_2.WIRETYPE_LENGTH_DELIMITED)

		return function(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
			local var_18_0

			if arg_18_4[arg_17_3] == nil then
				var_18_0 = arg_17_4(arg_18_3)
				arg_18_4[arg_17_3] = var_18_0
			end

			while true do
				local var_18_1
				local var_18_2
				local var_18_3, var_18_4 = var_17_0(arg_18_0, arg_18_1)

				if arg_18_2 < var_18_4 + var_18_3 then
					var_0_10004("Truncated message.")
				end

				local var_18_5 = var_18_0:add()

				if var_8._InternalParse(var_18_5, arg_18_0, arg_18_1, var_7) ~= var_7 then
					var_0_10004("Unexpected end-group tag.")
				end

				arg_18_1 = var_7 + var_17_2

				if var_17_1(arg_18_0, var_7 + 1, arg_18_1) ~= var_0 or var_7 == arg_18_2 then
					return var_7
				end
			end

			return
		end
	else
		return function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
			local var_19_0

			if arg_19_4[arg_17_3] == nil then
				var_19_0 = arg_17_4(arg_19_3)
				arg_19_4[arg_17_3] = var_19_0
			end

			local var_19_1
			local var_19_2
			local var_19_3, var_19_4 = var_17_0(arg_19_0, arg_19_1)

			if arg_19_2 < var_19_4 + var_19_3 then
				var_0_10004("Truncated message.")
			end

			if var_19_0:_InternalParse(arg_19_0, arg_19_1, var_7) ~= var_7 then
				var_0_10004("Unexpected end-group tag.")
			end

			return var_7
		end
	end

	return
end

local var_0_46 = MessageDecoder

local function var_0_47(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0
	local var_20_1

	var_20_1, arg_20_1 = var_0_3(arg_20_0, arg_20_1)

	return arg_20_1
end

local var_0_48 = _SkipVarint

local function var_0_49(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_2 < arg_21_1 + 8 then
		var_0_10004("Truncated message.")
	end

	return arg_21_1
end

local var_0_50 = _SkipFixed64

local function var_0_51(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0
	local var_22_1, var_22_2 = var_0_3(arg_22_0, arg_22_1)

	if arg_22_2 < var_22_2 + var_22_1 then
		var_0_10004("Truncated message.")
	end

	return arg_22_1
end

local var_0_52 = _SkipLengthDelimited

local function var_0_53(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 < arg_23_1 + 4 then
		var_0_10004("Truncated message.")
	end

	return arg_23_1
end

local var_0_54 = _SkipFixed32

local function var_0_55(arg_24_0, arg_24_1, arg_24_2)
	var_0_10004("Tag had invalid wire type.")

	return
end

local var_0_56 = _RaiseInvalidWireType

local function var_0_57()
	local var_25_0 = {}

	_SkipVarint = var_1_10001
	var_25_0[1] = var_1_10001
	_SkipFixed64 = var_1_10001
	var_25_0[2] = var_1_10001
	_SkipLengthDelimited = var_1_10001
	var_25_0[3] = var_1_10001
	_SkipGroup = var_1_10001
	var_25_0[4] = var_1_10001
	_EndGroup = var_1_10001
	var_25_0[5] = var_1_10001
	_SkipFixed32 = var_1_10001
	var_25_0[6] = var_1_10001
	_RaiseInvalidWireType = var_1_10001
	var_25_0[7] = var_1_10001
	_RaiseInvalidWireType = var_1_10001
	var_25_0[8] = var_1_10001

	local var_25_1 = WIRETYPE_TO_SKIPPER
	local var_25_2 = var_0_10000.byte
	local var_25_3 = var_0_10000.sub

	return function(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
		local var_26_0 = var_25_2(var_25_3(arg_26_3, 1, 1)) % 8 + 1

		WIRETYPE_TO_SKIPPER = var_2_10005

		return var_2_10005[var_26_0](arg_26_0, arg_26_1, arg_26_2)
	end
end

_FieldSkipper = _FieldSkipper

local var_0_58 = var_19()
local var_0_59 = SkipField

return

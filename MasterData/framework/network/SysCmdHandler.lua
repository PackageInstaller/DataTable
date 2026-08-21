module("framework.network.SysCmdHandler", package.seeall)

local var_0_0 = class("SysCmdHandler")
local var_0_1 = 256
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6

local function var_0_7(arg_1_0, arg_1_1)
	local var_1_0 = string.byte(arg_1_0, arg_1_1)
	local var_1_1 = string.byte(arg_1_0, arg_1_1 + 1)
	local var_1_2 = var_1_0 * var_0_1 + var_1_1
	local var_1_3 = string.sub(arg_1_0, arg_1_1 + 2, arg_1_1 + 2 + var_1_2 - 1)

	return arg_1_1 + 2 + var_1_2, var_1_3
end

local function var_0_8(arg_2_0, arg_2_1)
	local var_2_0 = 0

	for iter_2_0 = arg_2_1, arg_2_1 + 8 - 1 do
		var_2_0 = var_2_0 * var_0_1 + string.byte(arg_2_0, iter_2_0)
	end

	return arg_2_1 + 8, var_2_0
end

local function var_0_9(arg_3_0, arg_3_1)
	return arg_3_1 + 1, string.byte(arg_3_0, arg_3_1) ~= 0
end

local function var_0_10(arg_4_0)
	local var_4_0 = #arg_4_0
	local var_4_1 = math.floor(var_4_0 / var_0_1)
	local var_4_2 = math.floor(var_4_0 % var_0_1)

	return string.char(var_4_1) .. string.char(var_4_2) .. arg_4_0
end

local function var_0_11(arg_5_0)
	return string.char(arg_5_0)
end

local function var_0_12(arg_6_0)
	return var_0_10(arg_6_0.account) .. var_0_10(arg_6_0.password) .. var_0_11(arg_6_0.connectWay)
end

local function var_0_13(arg_7_0)
	return (var_0_11(arg_7_0.downTag))
end

local function var_0_14(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = 1
	local var_8_2, var_8_3 = var_0_7(arg_8_0, var_8_1)
	local var_8_4, var_8_5 = var_0_8(arg_8_0, var_8_2)

	var_8_0.reason = var_8_3
	var_8_0.userId = var_8_5

	return var_8_0
end

local function var_0_15(arg_9_0)
	local var_9_0 = {}
	local var_9_1 = 1
	local var_9_2, var_9_3 = var_0_7(arg_9_0, var_9_1)

	var_9_0.reason = var_9_3

	return var_9_0
end

local function var_0_16(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = 1
	local var_10_2, var_10_3 = var_0_9(arg_10_0, var_10_1)

	var_10_0.canGet = var_10_3

	return var_10_0
end

local function var_0_17(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = 1
	local var_11_2, var_11_3 = var_0_7(arg_11_0, var_11_1)

	var_11_0.reason = var_11_3

	return var_11_0
end

local var_0_18 = {
	var_0_12,
	[3] = var_0_13
}
local var_0_19 = {
	var_0_14,
	var_0_15,
	var_0_16,
	var_0_17
}
local var_0_20 = {}

var_0_20[1] = "LoginResponse"
var_0_20[2] = "LeaveResponse"
var_0_20[3] = "GetLostCmdRespResponse"
var_0_20[4] = "ForceLogoutResponse"
var_0_20[5] = "GetLostCmdRespResponseStartTag"

function var_0_0.GetSendMsg(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return (var_0_18[arg_12_1](arg_12_2))
end

function var_0_0.GetReceiveMsg(arg_13_0, arg_13_1, arg_13_2)
	if var_0_19[arg_13_1] then
		arg_13_2 = var_0_19[arg_13_1](arg_13_2)
	end

	return var_0_20[arg_13_1], arg_13_2
end

return var_0_0

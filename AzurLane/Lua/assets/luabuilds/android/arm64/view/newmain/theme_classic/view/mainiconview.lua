class = var_0_10000

local var_0_0 = "MainIconView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.MainBaseView"))
local var_0_2 = 1
local var_0_3 = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, nil)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject

	local var_1_0 = {}
	local var_1_1 = var_0_2

	MainSpineIcon = var_4
	var_1_0[var_1_1] = var_4.New(arg_1_1)

	local var_1_2 = var_0_3

	MainEducateCharIcon = var_4
	var_1_0[var_1_2] = var_4.New(arg_1_1)
	arg_1_0.iconList = var_1_0

	return
end

function var_0_1.GetIconType(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	VirtualEducateCharShip = var_1_10005

	if var_1_10002(var_2_0, var_1_10005) then
		return var_0_3
	else
		return var_0_2
	end

	return
end

function var_0_1.Init(arg_3_0, arg_3_1)
	arg_3_0.ship = arg_3_1

	if arg_3_0.iconInstance then
		local var_3_0 = arg_3_0.iconInstance

		var_2.Unload(var_3_0)

		arg_3_0.iconInstance = nil
	end

	local var_3_1 = arg_3_0:GetIconType(arg_3_1)

	arg_3_0.iconInstance = arg_3_0.iconList[var_3_1]

	local var_3_2 = arg_3_0.iconInstance

	var_3.Load(var_3_2, arg_3_1:getPrefab())

	return
end

function var_0_1.Refresh(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getPrefab()
	local var_4_1 = arg_4_0:GetIconType(arg_4_1)

	if arg_4_0.iconList[var_4_1] ~= arg_4_0.iconInstance or arg_4_0.name ~= var_4_0 then
		arg_4_0:Init(arg_4_1)
	elseif arg_4_0.iconInstance then
		local var_4_2 = arg_4_0.iconInstance

		var_4.Resume(var_4_2)
	end

	arg_4_0.ship = arg_4_1

	return
end

function var_0_1.Disable(arg_5_0)
	if arg_5_0.iconInstance then
		local var_5_0 = arg_5_0.iconInstance

		var_1.Pause(var_5_0)
	end

	return
end

function var_0_1.IsLoading(arg_6_0)
	if arg_6_0.iconInstance then
		local var_6_0 = arg_6_0.iconInstance

		return var_1.IsLoading(var_6_0)
	end

	return false
end

function var_0_1.GetDirection(arg_7_0)
	Vector2 = var_1_10001

	return var_1_10001(0, 1)
end

function var_0_1.Dispose(arg_8_0)
	var_0_1.super.Dispose(arg_8_0)

	ipairs = var_1

	for iter_8_0, iter_8_1 in var_1(arg_8_0.iconList) do
		iter_8_1:Dispose()
	end

	arg_8_0.iconList = nil
	arg_8_0.iconInstance = nil

	return
end

return var_0_1

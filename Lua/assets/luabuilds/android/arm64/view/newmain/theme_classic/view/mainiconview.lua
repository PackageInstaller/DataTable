local var_0_0 = class("MainIconView", import("...base.MainBaseView"))
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, nil)

	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0.iconList = {
		[var_0_1] = MainSpineIcon.New(arg_1_1),
		[var_0_2] = MainEducateCharIcon.New(arg_1_1)
	}

	return
end

function var_0_0.GetIconType(arg_2_0, arg_2_1)
	if isa(arg_2_1, VirtualEducateCharShip) then
		return var_0_2
	else
		return var_0_1
	end

	return
end

function var_0_0.Init(arg_3_0, arg_3_1)
	arg_3_0.ship = arg_3_1

	if arg_3_0.iconInstance then
		arg_3_0.iconInstance:Unload()

		arg_3_0.iconInstance = nil
	end

	arg_3_0.iconInstance = arg_3_0.iconList[arg_3_0:GetIconType(arg_3_1)]

	arg_3_0.iconInstance:Load(arg_3_1:getPrefab())

	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	if arg_4_0.iconList[arg_4_0:GetIconType(arg_4_1)] ~= arg_4_0.iconInstance or arg_4_0.ship:getPrefab() ~= arg_4_1:getPrefab() then
		arg_4_0:Init(arg_4_1)
	elseif arg_4_0.iconInstance then
		arg_4_0.iconInstance:Resume()
	end

	arg_4_0.ship = arg_4_1

	return
end

function var_0_0.Disable(arg_5_0)
	if arg_5_0.iconInstance then
		arg_5_0.iconInstance:Pause()
	end

	return
end

function var_0_0.IsLoading(arg_6_0)
	if arg_6_0.iconInstance then
		return arg_6_0.iconInstance:IsLoading()
	end

	return false
end

function var_0_0.GetDirection(arg_7_0)
	return Vector2(0, 1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.iconList) do
		iter_8_1:Dispose()
	end

	arg_8_0.iconList = nil
	arg_8_0.iconInstance = nil

	return
end

return var_0_0

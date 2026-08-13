class = var_0_10000

local var_0_0 = "NcShowHud"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetAgent().gameObject
	local var_1_1 = var_1.GetComponent

	typeof = var_1_10003
	WorldObjectItem = var_1_10004

	local var_1_2 = var_1_1(var_1_0, var_1_10003(var_1_10004))
	local var_1_3 = arg_1_0:GetAgent().transform
	local var_1_4 = var_1_2.id
	local var_1_5 = var_1_2.type
	local var_1_6 = arg_1_0:GetBoolArg("show")
	local var_1_7 = arg_1_0:GetStringArg("viewLuaName")

	if var_1_6 then
		local var_1_8 = arg_1_0:GetStringArg("uiLuaName")

		var_1_10009 = arg_1_0

		local var_1_9 = arg_1_0.GetStringArg(var_1_10009, "positionX")

		var_1_10009 = arg_1_0:GetStringArg("positionY")
		var_1_10011 = arg_1_0

		local var_1_10 = arg_1_0.GetStringArg(var_1_10011, "param1")

		var_1_10011 = arg_1_0:GetStringArg("param2")

		local var_1_11 = arg_1_0:GetStringArg("param3")
		local var_1_12 = arg_1_0
		local var_1_13 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10015

		local var_1_14 = var_1_10015.SHOW_HUD
		local var_1_15 = {}

		tonumber = var_1_10017
		var_1_15.id = var_1_10017(var_1_4)
		tonumber = var_17
		var_1_15.type = var_17(var_1_5)
		var_1_15.unitTransform = var_1_3
		var_1_15.viewLuaName = var_1_7
		var_1_15.uiLuaName = var_1_8
		tonumber = var_17
		var_1_15.positionX = var_17(var_1_9)
		tonumber = var_17
		var_1_15.positionY = var_17(var_1_10009)
		var_1_15.param1 = var_1_10
		var_1_15.param2 = var_1_10011
		var_1_15.param3 = var_1_11

		var_1_13(var_1_12, var_1_14, var_1_15)
	else
		local var_1_16 = arg_1_0
		local var_1_17 = arg_1_0.SendEvent

		ISLAND_EVT = var_1_10009

		local var_1_18 = var_1_10009.HIDE_HUD
		local var_1_19 = {}

		tonumber = var_1_10011
		var_1_19.id = var_1_10011(var_1_4)
		tonumber = var_11
		var_1_19.type = var_11(var_1_5)
		var_1_19.viewLuaName = var_1_7

		var_1_17(var_1_16, var_1_18, var_1_19)
	end

	arg_1_0:EndAction()

	return
end

return var_0_1

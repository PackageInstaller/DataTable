class = var_0_10000

local var_0_0 = "WorldPreCombatMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OnSwitchShip = "WorldPreCombatMediator.OnSwitchShip"
var_0_1.OnMapOp = "WorldPreCombatMediator.OnMapOp"
var_0_1.OnAuto = "WorldPreCombatMediator.OnAuto"
var_0_1.OnSubAuto = "WorldPreCombatMediator.OnSubAuto"
var_0_1.OnStartBattle = "WorldPreCombatMediator.OnStartBattle"
var_0_1.OnOpenSublayer = "OpenSublayer"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnSwitchShip, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		nowWorld = var_2_10004

		local var_2_0 = var_2_10004()
		local var_2_1 = var_4.GetFleet(var_2_0, arg_2_1)

		var_5.SwitchShip(var_2_1, arg_2_2, arg_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.OnAuto, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.onAutoBtn(var_3_0, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.OnSubAuto, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.onSubAuto(var_4_0, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.OnMapOp, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.WORLD_MAP_OP, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.OnStartBattle, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_6_2.damageLevel
		local var_6_1 = arg_6_3

		if var_6_0 > arg_6_3.GetLimitDamageLevel(var_6_1) then
			pg = var_6_0

			local var_6_2 = var_6_0.MsgboxMgr.GetInstance()
			local var_6_3 = var_4.ShowMsgBox

			var_6_1 = {
				hideYes = true
			}
			i18n = var_2_10007
			var_6_1.content = var_2_10007("world_low_morale")

			var_6_3(var_6_2, var_6_1)
		else
			local var_6_4 = arg_1_0
			local var_6_5 = var_4.sendNotification

			GAME = var_6_1

			local var_6_6 = var_6_1.BEGIN_STAGE
			local var_6_7 = {}

			SYSTEM_WORLD = var_2_10008
			var_6_7.system = var_2_10008
			var_6_7.stageId = arg_6_1

			local var_6_8

			if not arg_6_3:GetHP() or not (arg_6_3:GetHP() / arg_6_3:GetMaxHP()) then
				var_6_8 = nil
			end

			var_6_7.hpRate = var_6_8

			var_6_5(var_6_4, var_6_6, var_6_7)
		end

		return
	end)
	arg_1_0:bind(var_0_1.OnOpenSublayer, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		local var_7_0 = arg_1_0

		var_4.addSubLayers(var_7_0, arg_7_1, arg_7_2, arg_7_3)

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setPlayerInfo

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_2 = var_3(var_4)

	var_1_1(var_1_0, var_3.getRawData(var_1_2))

	return
end

function var_0_1.onAutoBtn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.isOn
	local var_8_1 = arg_8_1.toggle
	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.sendNotification

	GAME = var_1_10006

	local var_8_4 = var_1_10006.AUTO_BOT
	local var_8_5 = {
		isActiveBot = var_8_0,
		toggle = var_8_1
	}

	SYSTEM_WORLD = var_1_10008
	var_8_5.system = var_1_10008

	var_8_3(var_8_2, var_8_4, var_8_5)

	return
end

function var_0_1.onSubAuto(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.isOn
	local var_9_1 = arg_9_1.toggle
	local var_9_2 = arg_9_1.system
	local var_9_3 = arg_9_0
	local var_9_4 = arg_9_0.sendNotification

	GAME = var_1_10007

	local var_9_5 = var_1_10007.AUTO_SUB
	local var_9_6 = {
		isActiveSub = var_9_0,
		toggle = var_9_1
	}

	SYSTEM_WORLD = var_1_10009
	var_9_6.system = var_1_10009

	var_9_4(var_9_3, var_9_5, var_9_6)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	PlayerProxy = var_1_10002
	var_10_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_10_0[2] = var_2.WORLD_MAP_OP_DONE

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.getBody(var_11_1)

	PlayerProxy = var_11_1

	local var_11_4

	if var_11_0 == var_11_1.UPDATED then
		local var_11_3 = arg_11_0.viewComponent

		var_11_4 = var_11_4.setPlayerInfo
		getProxy = var_1_10006
		PlayerProxy = var_1_10007

		local var_11_5 = var_1_10006(var_1_10007)

		var_11_4(var_11_3, var_6.getRawData(var_11_5))
	else
		GAME = var_11_4

		if var_11_0 == var_11_4.WORLD_MAP_OP_DONE then
			-- block empty
		end
	end

	return
end

return var_0_1

local var_0_0 = class("WorldPreCombatMediator", import("..base.ContextMediator"))

var_0_0.OnSwitchShip = "WorldPreCombatMediator.OnSwitchShip"
var_0_0.OnMapOp = "WorldPreCombatMediator.OnMapOp"
var_0_0.OnAuto = "WorldPreCombatMediator.OnAuto"
var_0_0.OnSubAuto = "WorldPreCombatMediator.OnSubAuto"
var_0_0.OnStartBattle = "WorldPreCombatMediator.OnStartBattle"
var_0_0.OnOpenSublayer = "OpenSublayer"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OnSwitchShip, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		nowWorld():GetFleet(arg_2_1):SwitchShip(arg_2_2, arg_2_3)

		return
	end)
	arg_1_0:bind(var_0_0.OnAuto, function(arg_3_0, arg_3_1)
		arg_1_0:onAutoBtn(arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_0.OnSubAuto, function(arg_4_0, arg_4_1)
		arg_1_0:onSubAuto(arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_0.OnMapOp, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.WORLD_MAP_OP, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_0.OnStartBattle, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0

		if arg_6_2.damageLevel > arg_6_3:GetLimitDamageLevel() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				content = i18n("world_low_morale")
			})

			goto label_6_0

			var_6_0 = arg_1_0
		end

		do
			local var_6_2 = GAME.BEGIN_STAGE
			local var_6_3 = {
				system = SYSTEM_WORLD,
				stageId = arg_6_1
			}

			var_6_3.hpRate = arg_6_3:GetHP() and arg_6_3:GetHP() / arg_6_3:GetMaxHP() or nil

			var_6_1(var_6_0, var_6_2, var_6_3)
		end

		::label_6_0::

		return
	end)
	arg_1_0:bind(var_0_0.OnOpenSublayer, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		arg_1_0:addSubLayers(arg_7_1, arg_7_2, arg_7_3)

		return
	end)
	arg_1_0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())

	return
end

function var_0_0.onAutoBtn(arg_8_0, arg_8_1)
	arg_8_0:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_8_1.isOn,
		toggle = arg_8_1.toggle,
		system = SYSTEM_WORLD
	})

	return
end

function var_0_0.onSubAuto(arg_9_0, arg_9_1)
	arg_9_0:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_9_1.isOn,
		toggle = arg_9_1.toggle,
		system = SYSTEM_WORLD
	})

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
	return {
		PlayerProxy.UPDATED,
		GAME.WORLD_MAP_OP_DONE
	}
end

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == PlayerProxy.UPDATED then
		arg_11_0.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	elseif var_11_0 == GAME.WORLD_MAP_OP_DONE then
		-- block empty
	end

	return
end

return var_0_0

local WorldPreCombatMediator = class("WorldPreCombatMediator", import("..base.ContextMediator"))

WorldPreCombatMediator.OnSwitchShip = "WorldPreCombatMediator.OnSwitchShip"
WorldPreCombatMediator.OnMapOp = "WorldPreCombatMediator.OnMapOp"
WorldPreCombatMediator.OnAuto = "WorldPreCombatMediator.OnAuto"
WorldPreCombatMediator.OnSubAuto = "WorldPreCombatMediator.OnSubAuto"
WorldPreCombatMediator.OnStartBattle = "WorldPreCombatMediator.OnStartBattle"
WorldPreCombatMediator.OnOpenSublayer = "OpenSublayer"

function WorldPreCombatMediator:register()
	self:bind(WorldPreCombatMediator.OnSwitchShip, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		nowWorld():GetFleet(arg_2_1):SwitchShip(arg_2_2, arg_2_3)

		return
	end)
	self:bind(WorldPreCombatMediator.OnAuto, function(arg_3_0, arg_3_1)
		self:onAutoBtn(arg_3_1)

		return
	end)
	self:bind(WorldPreCombatMediator.OnSubAuto, function(arg_4_0, arg_4_1)
		self:onSubAuto(arg_4_1)

		return
	end)
	self:bind(WorldPreCombatMediator.OnMapOp, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.WORLD_MAP_OP, arg_5_1)

		return
	end)
	self:bind(WorldPreCombatMediator.OnStartBattle, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		if arg_6_2.damageLevel > arg_6_3:GetLimitDamageLevel() then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				hideYes = true,
				content = i18n("world_low_morale")
			})
		else
			local var_6_0 = GAME.BEGIN_STAGE
			local var_6_1 = {
				system = SYSTEM_WORLD,
				stageId = arg_6_1
			}

			var_6_1.hpRate = arg_6_3:GetHP() and arg_6_3:GetHP() / arg_6_3:GetMaxHP() or nil

			self:sendNotification(var_6_0, var_6_1)
		end

		return
	end)
	self:bind(WorldPreCombatMediator.OnOpenSublayer, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		self:addSubLayers(arg_7_1, arg_7_2, arg_7_3)

		return
	end)
	self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())

	return
end

function WorldPreCombatMediator:onAutoBtn(arg_8_1)
	self:sendNotification(GAME.AUTO_BOT, {
		isActiveBot = arg_8_1.isOn,
		toggle = arg_8_1.toggle,
		system = SYSTEM_WORLD
	})

	return
end

function WorldPreCombatMediator:onSubAuto(arg_9_1)
	self:sendNotification(GAME.AUTO_SUB, {
		isActiveSub = arg_9_1.isOn,
		toggle = arg_9_1.toggle,
		system = SYSTEM_WORLD
	})

	return
end

function WorldPreCombatMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.WORLD_MAP_OP_DONE
	}
end

function WorldPreCombatMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayerInfo(getProxy(PlayerProxy):getRawData())
	elseif var_11_0 == GAME.WORLD_MAP_OP_DONE then
		-- block empty
	end

	return
end

return WorldPreCombatMediator

local RebelService = class("RebelService")

function RebelService:ctor()
	self._rebelData = nil
	self._rebelAppear = false

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EVENT, self._onModuleEvent, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_ENTER, self._onModuleEnter, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_REENTER_DUNGEON_STAGE_AFTER_BATTLE, self._onDungeonBattleEnd, self)
end

function RebelService:_onDungeonBattleEnd()
	local var_2_0 = g.core.model.User.rebelData:getNewestRebelElem()
	local var_2_1

	if var_2_0 and g.core.model.User.rebelData:isTodayNotify() then
		g.core.module.ModuleManager:pushPopup((require("app.view.base.function.DungeonFindHostPop").new(var_2_0)))

		var_2_1 = g.core.model.User.goldSavingData:getHasNewGameId()
	end

	if not g.core.model.User.goldSavingData:isIgnoreTodayTip() and var_2_1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.function.GoldSavingTickPop").new({
			id = var_2_1
		}), {
			blackOpacity = 0
		})
	end
end

function RebelService:reset()
	self._rebelData = nil
	self._rebelAppear = false
end

function RebelService:_onModuleEnter(arg_4_1, arg_4_2)
	if arg_4_2 == g.view.entrance.DUNGEON_STAGE and self._rebelData then
		self:_notifyRebel()

		self._rebelData = nil
	end
end

function RebelService:_onModuleEvent(arg_5_1, arg_5_2)
	if not self._rebelAppear then
		return
	end

	local var_5_0 = {
		...
	}

	if arg_5_2 == "rebel_appear_pop_cancel_ok" then
		if var_5_0[1] and var_5_0[1].name == g.core.event.enum.EVENT_NET_S2C_REBEL_NOTIFYCREATE then
			g.core.module.ModuleManager:pushModule(g.view.entrance.REBEL, var_5_0[1].rebel)
		end
	elseif arg_5_2 == "rebel_appear_pop_cancel" then
		self._rebelAppear = false
	end
end

function RebelService:_onRebelNotify(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.rebel then
		for iter_6_0, iter_6_1 in ipairs(arg_6_3.rebel) do
			if g.core.config.rebel_info.get(iter_6_1.base_id).type == g.core.const.RebelConst.REBEL_TYPE.DUNGEON_TRIGGER then
				self._rebelData = iter_6_1
			end
		end
	end
end

function RebelService:_onDungeonBlitzFinish(arg_7_1)
	if self._rebelData then
		self:_notifyRebel()

		self._rebelData = nil
	end
end

function RebelService:_notifyRebel(arg_8_1)
	arg_8_1 = arg_8_1 or self._rebelData

	local var_8_0 = g.core.config.rebel_info.get(arg_8_1.base_id)

	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.REBEL_MAIN) then
		self._rebelAppear = true

		local var_8_1 = {
			title = g.core.lang:get(1164),
			text = g.core.lang:get(1166, {
				color = "#" .. g.core.common.Color.qualityEx[var_8_0.quality],
				name = var_8_0.name,
				level = arg_8_1.level
			}),
			text_ok = g.core.lang:get(1167),
			text_cancel = g.core.lang:get(1165),
			info = {
				name = g.core.event.enum.EVENT_NET_S2C_REBEL_NOTIFYCREATE,
				rebel = arg_8_1
			}
		}
	end
end

return RebelService
